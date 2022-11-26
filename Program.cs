using System;
using System.Linq;
using System.Threading.Tasks;
using System.Transactions;
using Dapper;
using Microsoft.Data.SqlClient;
using Npgsql;
using NpgsqlTypes;

static async Task PerformTransactionWithQuery(int num)
{
    try
    {
        using (new TransactionScope(TransactionScopeAsyncFlowOption.Enabled))
        {
            // Adding "max pool size=1000;" to the connection string seems to trigger the problem less often
            string connStr = @"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false";

            var query = "SELECT COUNT(*) FROM sys.dm_tran_active_transactions";

            await using (var dbConn = new SqlConnection(connStr))
            {
                await dbConn.OpenAsync();

                await using (var command1 = new SqlCommand(query, dbConn))
                {
                    await command1.ExecuteScalarAsync();
                }
            } // Connection is disposed (and thus closed)

            await using (var dbConn = new SqlConnection(connStr))
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
        Console.WriteLine($"Failed {num}");
        Console.WriteLine(e);

        Environment.Exit(1);
    }
}

var tasks = Enumerable.Range(0, 100000).ToList().Select(PerformTransactionWithQuery);
await Task.WhenAll(tasks);
