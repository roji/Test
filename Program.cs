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

// await ctx.Blogs.ApplyDeleteAsync();

await ctx.Blogs.ExecuteUpdateAsync(o => o.SetProperty(p => ((IDeletable)p).IsDeleted, p => true));

public static class Foo
{
    public static Task<int> ApplyDeleteAsync<T>(this IQueryable<T> queryable) where T : IDeletable
    {
        return queryable.ExecuteUpdateAsync(o => o.SetProperty(p => p.IsDeleted, p => true));
    }
}

public class BlogContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .LogTo(Console.WriteLine, LogLevel.Information)
            .EnableSensitiveDataLogging();
}

public class Blog : IDeletable
{
    public int Id { get; set; }
    public required string Name { get; set; }
    public bool IsDeleted { get; set; }
}

public interface IDeletable
{
    bool IsDeleted { get; }
}
