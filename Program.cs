using System;
using System.Data;
using System.Threading.Tasks;
using Dapper;
using Microsoft.Data.SqlClient;
using Npgsql;
using NpgsqlTypes;

await using var conn = new SqlConnection("Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false");
await conn.OpenAsync();

var cmd = conn.CreateCommand();
cmd.CommandText = @"
DROP TABLE IF EXISTS Blogs;
CREATE TABLE Blogs
(
    Id int IDENTITY PRIMARY KEY,
    Title VARCHAR(MAX)
)";
cmd.ExecuteNonQuery();

cmd.CommandText = @"
CREATE OR ALTER PROCEDURE Blogs_Insert(@id int OUT, @title varchar(max))
AS BEGIN
    INSERT INTO [Blogs] ([Title]) VALUES (@title);
    SELECT @id = 8;
END;";
cmd.ExecuteNonQuery();

cmd.CommandText = "EXEC Blogs_Insert @Id OUTPUT, 'foo'";
var idParam = new SqlParameter("Id", SqlDbType.Int)
{
    Direction = ParameterDirection.Output
};
cmd.Parameters.Add(idParam);

cmd.Parameters.AddWithValue("title", "foo");
cmd.ExecuteNonQuery();

Console.WriteLine("ID: " + idParam.Value);
