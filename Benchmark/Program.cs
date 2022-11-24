using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Engines;
using BenchmarkDotNet.Jobs;
using BenchmarkDotNet.Running;
using Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;

var summary = BenchmarkRunner.Run<MigrationTests>();

// [SimpleJob(RuntimeMoniker.Net60, launchCount: 3, targetCount: 50)]
// [SimpleJob(RuntimeMoniker.Net70, launchCount: 3, targetCount: 50)]
public class MigrationTests
{
    private readonly string filename = $"../../../../../../../../migrations_{Environment.Version}.sql";

    // [IterationSetup]
    public void RemoveDatabase()
    {
        using var dbContext = new AdventureWorks2019Context();
        dbContext.Database.EnsureDeleted();
        if (File.Exists(filename))
        {
            File.Delete(filename);
        }
    }

    // [Benchmark]
    public async Task Migration()
    {
        using var dbContext = new AdventureWorks2019Context();
        await dbContext.Database.MigrateAsync();
    }

    [Benchmark]
    public async Task GenerateScript()
    {
        using var dbContext = new AdventureWorks2019Context();
        var migrator = dbContext.GetService<IMigrator>();
        var sql = migrator.GenerateScript();
        // await File.WriteAllTextAsync(filename, sql);
    }
}