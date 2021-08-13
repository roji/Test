using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Azure.Cosmos;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

await using var ctx = new BlogContext();

await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

ctx.Blogs.Add(new Blog
{
    Id = 1,
    Name = "Blogs1",
    Author = new Author
    {
        FirstName = "Shay",
        LastName = "Rojansky"
    },
    Posts = new List<Post>
    {
        new() { Title = "Post1" },
        new() { Title = "Post2" }
    }
});
await ctx.SaveChangesAsync();

var blog = ctx.Blogs
    .Where(b => b.Author.FirstName == "Shay")
    .Single();

Console.WriteLine(blog.Posts[1].Title);

public class BlogContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }

    static ILoggerFactory ContextLoggerFactory
        => LoggerFactory.Create(b => b.AddConsole().AddFilter("", LogLevel.Information));

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder
            // .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0")
            .UseCosmos(
                "https://localhost:8081",
                "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==",
                "Test",
                o => o
                    .ConnectionMode(ConnectionMode.Gateway)
                    .HttpClientFactory(() =>
                    {
                        HttpMessageHandler httpMessageHandler = new HttpClientHandler()
                        {
                            ServerCertificateCustomValidationCallback =
                                HttpClientHandler.DangerousAcceptAnyServerCertificateValidator
                        };

                        return new HttpClient(httpMessageHandler);
                    }))
            .EnableSensitiveDataLogging()
            .UseLoggerFactory(ContextLoggerFactory);
    }
}

public class Blog
{
    public int Id { get; set; }
    public string Name { get; set; }

    public Author Author { get; set; }
    public List<Post> Posts { get; set; }
}

public class Author
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
}

public class Post
{
    public string Title { get; set; }

    public Blog Blog { get; set; }
}
