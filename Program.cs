using System;
using System.Threading.Tasks;
using Dapper;
using Microsoft.Data.SqlClient;
using Npgsql;
using NpgsqlTypes;

// await using var connection = new SqlConnection("Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0");
await using var connection = new NpgsqlConnection("Host=localhost;Username=test;Password=test");
await connection.OpenAsync();
