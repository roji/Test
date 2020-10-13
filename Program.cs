using System;
using System.Threading.Tasks;
using Dapper;
using Npgsql;
using NpgsqlTypes;

namespace Test
{
    public class Program
    {
        static async Task Main(string[] args)
        {
            await using var connection = new NpgsqlConnection("Host=localhost;Username=test;Password=test");
            await connection.OpenAsync();
        }
    }
}
