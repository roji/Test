using System;
using SqlClient;

namespace Test
{
    class Program
    {
        static void Main(string[] args)
        {
            var tx = new SqlTransaction();
            tx.Save("foo");
        }
    }
}
