using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

await using var context = new BlogContext();
await context.Database.EnsureDeletedAsync();
await context.Database.EnsureCreatedAsync();

var blog = new Blog { Name = "Foo" };
context.Blogs.Add(blog);
context.SaveChanges();

blog.Name = "Bar";

context.ChangeTracker.DetectChanges();

context.SaveChanges();

Console.WriteLine("Done");

public class BlogContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            //.UseSqlite("Filename=:memory:")
            // .UseNpgsql(@"Host=localhost;Username=test;Password=test")
            .LogTo(Console.WriteLine, LogLevel.Information)
            .EnableSensitiveDataLogging();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Blog>().Property(b => b.Computed).HasComputedColumnSql("8");
    }
}

public class Blog
{
    public int Id { get; set; }
    public string Name { get; set; }
    public int Computed { get; set; }
}
