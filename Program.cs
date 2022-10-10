using System;
using System.Threading.Tasks;
using System.Transactions;
using Microsoft.Data.SqlClient;

using (var scope = new TransactionScope())
{
    using var conn1 = new SqlConnection("Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false");
    conn1.Open();
    conn1.Close();

    using var conn2 = new SqlConnection("Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false");
    conn2.Open();
    conn2.Close();

    scope.Complete();
}


