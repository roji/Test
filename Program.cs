using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Logging;

await using var context = new BlogContext();
await context.Database.EnsureDeletedAsync();
await context.Database.EnsureCreatedAsync();

context.Blogs.Add(new Blog { Name = "Blog1" });
context.Blogs.Add(new Blog { Name = "Blog2" });
await context.SaveChangesAsync();

var blogs = await context.Blogs.Where(b => b.Name.StartsWith("Blog")).ToListAsync();

foreach (var blog in blogs)
{
    Console.WriteLine($"Blog found, Id={blog.Id}");
}

public class BlogContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer("Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .LogTo(Console.WriteLine, [CoreEventId.QueryCompilationStarting, RelationalEventId.CommandExecuted])
            .EnableSensitiveDataLogging();
}

public class Blog
{
    public int Id { get; set; }
    public required string Name { get; set; }
}
