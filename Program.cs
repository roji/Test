using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Npgsql;
using OpenTelemetry;
using OpenTelemetry.Trace;

await using var ctx = new BlogContext();
await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

using var tracerProvider = Sdk.CreateTracerProviderBuilder()
    .AddNpgsql()
    .AddEntityFrameworkCoreInstrumentation() // This causes problem with AddNpgsql
    .AddConsoleExporter()
    .Build();

Console.WriteLine($"*** Before: {Activity.Current?.Id}");
using var context = new BlogContext();
_ = context.Blogs.Any();
_ = await context.Blogs.AnyAsync();
Console.WriteLine($"*** After: {Activity.Current?.Id}");

// Console.WriteLine($"*** Before: {Activity.Current?.Id}");
// await using var connection = new NpgsqlConnection("Host=localhost;Username=test;Password=test");
// await connection.OpenAsync();
// await using (var command = new NpgsqlCommand("SELECT 1", connection))
// {
//     // Console.WriteLine("Query: " + await command.ExecuteScalarAsync());
//     Console.WriteLine("Query: " + command.ExecuteScalar());
// }
// Console.WriteLine($"*** After: {Activity.Current?.Id}");



public class BlogContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            // .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false");
            .UseNpgsql(@"Host=localhost;Username=test;Password=test");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
    }
}

public class Blog
{
    public int Id { get; set; }
    public string Name { get; set; }
}
