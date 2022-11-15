using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

await using var ctx = new BlogContext();
await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

// This will work fine.
ctx.Add(new TestEntity {Property = "Value"});
await ctx.SaveChangesAsync();

Console.WriteLine("**************** About to error");

try
{
    // This will error and throw, because there is a unique index and we've already added one with this name.
    ctx.Add(new TestEntity {Property = "Value"});
    await ctx.SaveChangesAsync();
}
catch
{
    //  Swallow the exception - we just want to see the log output
}

public class BlogContext : DbContext
{
    public DbSet<TestEntity> TestEntities { get; set; } = null!;

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .UseLoggerFactory(_loggerFactory)
            .EnableSensitiveDataLogging();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<TestEntity>()
            .HasIndex(u => u.Property)
            .IsUnique();
    }

    private static readonly ILoggerFactory _loggerFactory = LoggerFactory.Create(logging => logging.AddConsole());
}

public class TestEntity
{
    public int Id { get; set; }
    public string Property { get; set; } = null!;
}
