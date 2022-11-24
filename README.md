# EfCoreMigrationsBenchmark

Entity Framework Core 7 is slower than Entity Framework Core 6 when executing migrations. This benchmark, which requires a SQL Server instance running locally (though it's just a matter of changing the connection string), creates an AdventureWorks like database and applies just 5 migrations to it. Entity Framework Core 7 is up to 3 times slower according to these results:

|         Method |  Runtime |        Mean |     Error |    StdDev |
|--------------- |--------- |------------:|----------:|----------:|
|      Migration | .NET 6.0 |   467.22 ms |  7.899 ms | 28.819 ms |
| GenerateScript | .NET 6.0 |    83.00 ms |  0.531 ms |  1.902 ms |
|      Migration | .NET 7.0 | 1,304.72 ms | 10.119 ms | 36.918 ms |
| GenerateScript | .NET 7.0 |   953.80 ms |  4.492 ms | 16.101 ms |

The GenerateScript benchmark is just limited to building the SQL files themselves, without applying them to the database, and the overhead is clearly visible there.