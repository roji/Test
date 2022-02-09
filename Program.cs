using System;
using System.Threading.Tasks;
using Dapper;
using Microsoft.Data.SqlClient;
using Npgsql;
using NpgsqlTypes;

await using var conn = new SqlConnection("Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false");
await conn.OpenAsync();


