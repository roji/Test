using System;
using SystemData;

namespace SqlClient
{
    public class SqlTransaction : DbTransaction
    {
        public void Save(string savepointName)
        {
            Console.WriteLine("SqlClient implementation called");
        }
    }
}
