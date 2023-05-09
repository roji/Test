using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;

await using var ctx = new BlogContext();
await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

for (var i = 0; i < 4; i++)
{
    ctx.Blogs.Add(new Blog
    {
        Name = "MyBlog" + i
    });
}
await ctx.SaveChangesAsync();

// await foreach (var blog in ctx.Blogs)
// {
//     ctx.Remove(blog);
// }
// await ctx.SaveChangesAsync();

// await ctx.Blogs
//     .Where(b => b.Posts.Any(p => p.Title == "foo"))
//     .ExecuteDeleteAsync();

// await ctx.Blogs
//     .Where(b => b.Rating < 3)
//     .ExecuteUpdateAsync(setters => setters
//         .SetProperty(b => b.Name, "bar")
//         .SetProperty(b => b.Rating, b => b.Rating + 1));

var blog = await ctx.Blogs.SingleAsync(b => b.Name == "foo");
ctx.Remove(blog);
await ctx.SaveChangesAsync();

await ctx.Blogs.Where(b => b.Name == "foo").ExecuteDeleteAsync();

public class BlogContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .LogTo(Console.WriteLine, new[]
            {
                RelationalEventId.TransactionCommitted,
                RelationalEventId.TransactionStarted,
                RelationalEventId.CommandExecuted
            })
            .EnableSensitiveDataLogging();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Blog>().Property(b => b.Id).UseHiLo();
    }
}

public class Blog
{
    public int Id { get; set; }
    public string Name { get; set; }
    public int Rating { get; set; }
    
    public List<Post> Posts { get; set; }
}

public class Post
{
    public int Id { get; set; }
    public string Title { get; set; }
    
    public int BlogId { get; set; }
}
