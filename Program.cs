using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics.Tracing;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Transactions;
using Microsoft.Data.SqlClient;

class Program
{
    private static volatile int _failed;
    private static object FailureLock = new();

    // Adding "max pool size=1000;" to the connection string seems to trigger the problem less often
    const string ConnectionString = @"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false";

    public static async Task Main()
    {
        // using (new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
        // {
        //     await using (var dbConn = new SqlConnection(ConnectionString))
        //     {
        //         await dbConn.OpenAsync();
        //
        //         await using (var command1 = new SqlCommand("SELECT COUNT(*) FROM sys.dm_tran_active_transactions", dbConn))
        //         {
        //             await command1.ExecuteScalarAsync();
        //         }
        //     }
        // }

        // Fails
        // await Task.WhenAll(Enumerable.Range(0, 10).Select(_ => Task.Run(async () =>
        // {
        //     for (var i = 0; i < 1_000_000; i++)
        //     {
        //         using (new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
        //         {
        //             await using (var dbConn = new SqlConnection(ConnectionString))
        //             {
        //                 await dbConn.OpenAsync();
        //
        //                 await using (var command1 =
        //                              new SqlCommand("SELECT COUNT(*) FROM sys.dm_tran_active_transactions", dbConn))
        //                 {
        //                     await command1.ExecuteScalarAsync();
        //                 }
        //             }
        //
        //             await using (var dbConn = new SqlConnection(ConnectionString))
        //             {
        //                 await dbConn.OpenAsync();
        //
        //                 await using (var command1 =
        //                              new SqlCommand("SELECT COUNT(*) FROM sys.dm_tran_active_transactions", dbConn))
        //                 {
        //                     await command1.ExecuteScalarAsync();
        //                 }
        //             }
        //         }
        //     }
        // })));

await Task.WhenAll(Enumerable.Range(0, 10).Select(_ => Task.Run(() =>
{
    for (var i = 0; i < 1_000_000; i++)
    {
        using var scope = new TransactionScope(TransactionScopeAsyncFlowOption.Enabled);
        using var dbConn = new SqlConnection(ConnectionString);
        dbConn.Open();

        using var command = new SqlCommand("SELECT COUNT(*) FROM sys.dm_tran_active_transactions", dbConn);
        command.ExecuteScalar();
    }
})));



        using var listener = new SqlClientListener();

        var tasks = Enumerable.Range(0, 100000).ToList().Select(PerformTransactionWithQuery);
        await Task.WhenAll(tasks);
    }

    static async Task PerformTransactionWithQuery(int num)
    {
        var transactionId = 0;
        try
        {
            using (new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
            {
                transactionId = Transaction.Current!.GetHashCode();

                var query = "SELECT COUNT(*) FROM sys.dm_tran_active_transactions";

                if (_failed == 1)
                    return;

                // SqlConnection.AsyncLocalHack.Value = false;

                await using (var dbConn = new SqlConnection(ConnectionString))
                {
                    await dbConn.OpenAsync();

                    await using (var command1 = new SqlCommand(query, dbConn))
                    {
                        await command1.ExecuteScalarAsync();
                    }
                } // Connection is disposed (and thus closed)

                if (_failed == 1)
                    return;

                // SqlConnection.AsyncLocalHack.Value = true;

                await using (var dbConn = new SqlConnection(ConnectionString))
                {
                    // Reopening the connection triggers the following error:
                    // System.Transactions.TransactionAbortedException: The transaction has aborted.
                    //
                    // NB. Using a single connection and opening it once does NOT trigger the error
                    await dbConn.OpenAsync();

                    await using (var command2 = new SqlCommand(query, dbConn))
                    {
                        await command2.ExecuteScalarAsync();
                    }
                } // Connection is disposed (and thus closed)

                //Do not complete transaction
            }
        }
        catch (Exception e)
        {
            _failed = 1;

            lock (FailureLock)
            {
                // Console.WriteLine($"Failed in iteration {num}, transaction is {transactionId}. Phase is {SqlConnection.AsyncLocalHack.Value}");
                Console.WriteLine($"Failed in iteration {num}, transaction is {transactionId}.");
                Console.WriteLine(e);

                File.Delete("/tmp/foo.log");
                File.WriteAllLines("/tmp/foo.log", SqlClientListener.Messages.Select(o => o.ToString())!);

                Environment.Exit(1);
            }
        }
    }

    public class SqlClientListener : EventListener
    {
        public static ConcurrentQueue<object> Messages = new();

        protected override void OnEventSourceCreated(EventSource eventSource)
        {
            // Only enable events from SqlClientEventSource.
            if (eventSource.Name.Equals("Microsoft.Data.SqlClient.EventSource"))
            {
                // Use EventKeyWord 2 to capture basic application flow events.
                // See the above table for all available keywords.

                // EnableEvents(eventSource, EventLevel.Verbose, (EventKeywords)2);
                EnableEvents(eventSource, EventLevel.Verbose, (EventKeywords)32);
            }
        }

        // This callback runs whenever an event is written by SqlClientEventSource.
        // Event data is accessed through the EventWrittenEventArgs parameter.
        protected override void OnEventWritten(EventWrittenEventArgs eventData)
        {
            // Print event data.
            // Console.WriteLine(eventData.Payload![0]);
            Messages.Enqueue(eventData.Payload![0]!);
        }
    }
}
