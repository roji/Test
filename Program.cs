using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Azure.Cosmos;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

await using var context = new BlogContext();
await context.Database.EnsureDeletedAsync();
await context.Database.EnsureCreatedAsync();

context.Blogs.Add(new Blog
{
    Id = 1,
    PartitionKey = "pk1",
    Name = "foo"
});
await context.SaveChangesAsync();

_ = await context.Blogs.ToListAsync();

public class BlogContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseCosmos(
                "https://localhost:8081",
                // Windows emulator (Parallels Desktop):
                // "https://192.168.64.6:8081",
                "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==",
                "Test",
                o => o.HttpClientFactory(() => new HttpClient(
                        new HttpClientHandler
                        {
                            ServerCertificateCustomValidationCallback =
                                HttpClientHandler.DangerousAcceptAnyServerCertificateValidator
                        }))
                    .ConnectionMode(ConnectionMode.Gateway))
            .LogTo(Console.WriteLine, LogLevel.Information)
            .EnableSensitiveDataLogging();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Blog>()
            .ToContainer("test")
            .HasPartitionKey(b => b.PartitionKey);
    }
}

public class Blog
{
    public int Id { get; set; }
    public string PartitionKey { get; set; }

    public string Name { get; set; }
}
