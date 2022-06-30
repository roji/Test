extern alias MySysTx;

using System;
using System.Threading.Tasks;
// using System.Transactions;
// using System.Transactions;
using Dapper;
using Microsoft.Data.SqlClient;
using MySysTx::System.Transactions;
// using CommittableTransaction = MySystemTransactions::System.Transactions.CommittableTransaction;


//
// const string ConnectionString =
//     "Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0";
//
// using (var scope = new TransactionScope())
// {
//     var conn1 = new SqlConnection(ConnectionString);
//     conn1.Open();
//
//     var conn2 = new SqlConnection(ConnectionString);
//     conn2.Open();
//
//     Console.WriteLine("Escalated, press any key to complete");
//     Console.ReadLine();
//
//     scope.Complete();
// }

var tx = new CommittableTransaction();

var rmGuid = Guid.Parse("ceb6c6b2-7fbf-43e3-ab81-8cb67ccd0b8e");
tx.EnlistDurable(rmGuid, new DurableResourceManager(), EnlistmentOptions.None);

class DurableResourceManager : IEnlistmentNotification
{
    public void Prepare(PreparingEnlistment preparingEnlistment)
    {
        Console.WriteLine("Preparing");
        preparingEnlistment.Prepared();
    }

    public void Commit(Enlistment enlistment)
    {
        Console.WriteLine("Committing");
        enlistment.Done();
    }

    public void Rollback(Enlistment enlistment)
    {
        Console.WriteLine("Rolling back");
        enlistment.Done();
    }

    public void InDoubt(Enlistment enlistment)
    {
        Console.WriteLine("In doubt");
        enlistment.Done();
    }
}
