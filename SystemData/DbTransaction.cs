using System;

namespace SystemData
{
    public class DbTransaction
    {
        public virtual void Save(string savepointName)
        {
            Console.WriteLine("DbTransaction implementation called");
        }
    }
}
