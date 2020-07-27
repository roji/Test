using System;
using SystemData;
using SqlClient;

namespace Test
{
    class Program
    {
        static void Main(string[] args)
        {
            var tx = new SqlTransaction();
            tx.Save("foo");

            var dbTransaction = (DbTransaction)tx;
            dbTransaction.Save("bar");
        }
    }
}
