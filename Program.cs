using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

await using var context = new BlogContext();
// await context.Database.EnsureDeletedAsync();
// await context.Database.EnsureCreatedAsync();

var maxCount = 23;

var digests = await context.Users
    .OrderBy(u => u.TimeCreatedUtc)
    .Take(maxCount)
    .Select(u => new DailyDigest
    {
        User = u,
    })
    .ToListAsync();

foreach (var digest in digests)
{
    context.DailyDigests.Add(digest);
}

// for (var i = 0; i < 23; i++)
// {
//     context.DailyDigests.Add(new() { UserId = "7be85f63-8392-4d25-85af-817400ac4a0d" });
// }

await context.SaveChangesAsync();

public class BlogContext : DbContext
{
    public DbSet<User> Users => Set<User>();
    public DbSet<DailyDigest> DailyDigests => Set<DailyDigest>();

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            // .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .UseSqlServer(@"Server=localhost;Database=Issue29502;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .LogTo(Console.WriteLine, LogLevel.Information)
            .EnableSensitiveDataLogging();
}

public class User
{
    public string Id { get; set; } = null!;
    public DateTime TimeCreatedUtc { get; set; }
    public ICollection<DailyDigest> DailyDigests { get; set; } = null!;
}

public class DailyDigest
{
    public int Id { get; set; }
    public User? User { get; set; }
}
