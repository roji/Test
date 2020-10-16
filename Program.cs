using System;
using System.Threading.Tasks;
using Dapper;
using Npgsql;
using NpgsqlTypes;

await using var connection = new NpgsqlConnection("Host=localhost;Username=test;Password=test");
await connection.OpenAsync();
