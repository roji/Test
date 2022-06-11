using System;
using System.Data.Odbc;
using System.Threading.Tasks;
using System.Transactions;
using Dapper;
using Microsoft.Data.SqlClient;
using Npgsql;
using NpgsqlTypes;

var longString = new string('x', 1025);

// var connString = $"Driver={{ODBC Driver 17 for SQL Server}};server=localhost;database=test;UID=SA;PWD=Abcd5678";
//var connString = $"Driver={{ODBC Driver 17 for SQL Server}};server={longString};database=test;UID=SA;PWD=Abcd5678";

// var connString = $"Driver={{PostgreSQL Unicode}};server=localhost;database=test;UID=test;PWD=test";
// var connString = $"Driver={{PostgreSQL Unicode}};server={longString};database=test;UID=test;PWD=test";

// var connString = $"Driver={{SQLite3 ODBC Driver}};server=localhost;database=test";
//var connString = $"Driver={{SQLite3 ODBC Driver}};server={longString};database={longString}";

// var connString = $"Driver={{MySQL ODBC 8.0 Unicode Driver}};server=localhost;database=test;UID=test;PWD=test";
var connString = $"Driver={{MySQL ODBC 8.0 Unicode Driver}};server={longString};database=test;UID=test;PWD=test";

var connection = new OdbcConnection(connString);
connection.Open();

using var command = new OdbcCommand("SELECT 1", connection);
Console.WriteLine(command.ExecuteScalar());

