using System;
using System.Threading.Tasks;
using Dapper;
using Microsoft.Data.SqlClient;
using Npgsql;
using NpgsqlTypes;

await using var connection = new SqlConnection("Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false");
await connection.OpenAsync();

// var builder = new NpgsqlDataSourceBuilder("Host=localhost;Username=test;Password=test");
// await using var dataSource = builder.Build();
// await using var connection = await dataSource.OpenConnectionAsync();

