using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Threading.Tasks;
using BenchmarkDotNet.Attributes;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using Microsoft.EntityFrameworkCore.Storage;
using Npgsql;

namespace Test
{
    [MemoryDiagnoser]
    public class MultipleQueriesBenchmark
    {
        private const string ConnectionString = "Host=localhost;Username=test;Password=test;Database=techempower;Max Auto Prepare=10;Auto Prepare Min Usages=5";

        private readonly Random _random = new();

        // [Params(1, 5, 10, 15, 20)]
        [Params(10)]
        public int QueryCount { get; set; } = 10;

        #region Raw

        [Benchmark]
        public async Task<WorldRaw[]> Raw()
        {
            var result = new WorldRaw[QueryCount];

            using var conn = new NpgsqlConnection(ConnectionString);
            await conn.OpenAsync();

            using var cmd = new NpgsqlCommand("SELECT id, randomnumber FROM world WHERE id = $1", conn);
            var parameter = new NpgsqlParameter<int> { TypedValue = _random.Next(1, 10001) };

            cmd.Parameters.Add(parameter);

            for (int i = 0; i < result.Length; i++)
            {
                using var rdr = await cmd.ExecuteReaderAsync(System.Data.CommandBehavior.SingleRow);
                await rdr.ReadAsync();

                result[i] = new WorldRaw
                {
                    Id = rdr.GetInt32(0),
                    RandomNumber = rdr.GetInt32(1)
                };

                parameter.TypedValue = _random.Next(1, 10001);
            }

            return result;
        }

        [StructLayout(LayoutKind.Sequential, Size = 8)]
        public struct WorldRaw
        {
            public int Id { get; set; }

            public int RandomNumber { get; set; }
        }

        #endregion
    }
}
