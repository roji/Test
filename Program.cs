using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

await using var ctx = new BlogContext();
await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

_ = ctx.Model.FindEntityType(typeof(Blog)).FindProperty("DateTimeOffset").GetValueComparer();

Console.WriteLine("Hello world");

public class BlogContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseInMemoryDatabase("foo");
}

public class Blog
{
    public int Id { get; set; }
    public string Name { get; set; }
    public DateTimeOffset DateTimeOffset { get; set; }
}
