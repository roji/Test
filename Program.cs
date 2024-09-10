using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Azure.Cosmos;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ValueGeneration;
using Microsoft.Extensions.Logging;

await using var context = new BlogContext();
await context.Database.EnsureDeletedAsync();
await context.Database.EnsureCreatedAsync();

context.Sessions.Add(new Session
{
    Id = new Guid("a456bf06-89c3-458d-93d8-ce21eeb1790b"),
    PartitionKey = "pk1",
    Name = "foo",
});
await context.SaveChangesAsync();

_ = await context.Sessions.ToListAsync();

public class BlogContext : DbContext
{
    public DbSet<Session> Sessions { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseCosmos(
                "https://192.168.64.6:8081",
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
        modelBuilder.Entity<Session>()
            .ToContainer("test")
            .HasPartitionKey(b => b.PartitionKey)
            // .HasPartitionKey(b => new { b.TenantId, b.UserId, b.SessionId })
            .Property(s => s.Id).HasValueGenerator<GuidValueGenerator>();
    }
}

public class Session
{
    public Guid Id { get; set; }

    public string PartitionKey { get; set; }
    // public string TenantId { get; set; } = null!;
    // public Guid UserId { get; set; }
    // public int SessionId { get; set; }

    public string Name { get; set; }

    public List<Post> Posts { get; set; }
}

public class Post
{
    public int Id { get; set; }
    public string Title { get; set; }
    public Session Session { get; set; }
}
