using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query.SqlExpressions;
using Microsoft.Extensions.Logging;

#nullable enable

await using var ctx = new BlogContext();
await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

var ids = new [] { Guid.NewGuid(), Guid.NewGuid() };
var customers = ctx.Customers.Where(c => ctx.AsQueryable(ids).Contains(c.CustomerId)).ToList();

public class BlogContext : DbContext
{
    public DbSet<Customer> Customers { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .LogTo(Console.WriteLine, LogLevel.Information)
            .EnableSensitiveDataLogging();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ConfigureDbFunctions();
    }

    [Keyless]
    private class StringSplitResult
    {
        public string Value { get; set; }
    }

    [DbFunction(IsBuiltIn = true, Name = "STRING_SPLIT")]
    private IQueryable<StringSplitResult> Split(string source, string separator)
        => FromExpression(() => Split(source, separator));

    public IQueryable<Guid> AsQueryable(IEnumerable<Guid> source)
        => Split(string.Join(",", source.Select(x => Convert.ToString(x))), ",")
            .Select(s => DbFunctionExtensions.ToGuid(s.Value)!.Value);
}

public class Customer
{
    public Guid CustomerId { get; set; }
}

public static class DbFunctionExtensions
{
    public static Guid? ToGuid(string value) => throw new NotImplementedException();

    public static void ConfigureDbFunctions(this ModelBuilder modelBuilder)
    {
        var type = typeof(DbFunctionExtensions);

        modelBuilder.HasDbFunction(type.GetMethod(nameof(ToGuid))!)
            .HasTranslation(t => new SqlFunctionExpression(
                functionName: "CONVERT",
                arguments: new[] { new SqlFragmentExpression("UNIQUEIDENTIFIER"), t[0] },
                nullable: true,
                argumentsPropagateNullability: new[] { false, true },
                typeof(Guid?),
                typeMapping: null))
            .IsBuiltIn();
    }
}
