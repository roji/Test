using System;
using System.IO;
using Microsoft.Data.Sqlite;

Console.WriteLine(Directory.GetCurrentDirectory());
await using var connection = new SqliteConnection("Data Source=:memory:");
connection.Open();
connection.LoadExtension("vec0");

using var command = connection.CreateCommand();
command.CommandText = "SELECT vec_version()";
Console.WriteLine($"sqlite_vec version: {command.ExecuteScalar()}");
