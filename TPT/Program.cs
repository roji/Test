using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;

await using var ctx = new UserContext();
await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

// Insert some data

var jane = new User { Name = "Jane" };
var john = new ExternalUser { Name = "John", ExternalCompany = "foo" };

var football = new Group { Name = "Football", Users = new List<User> { jane, john} };
var movies = new Group { Name = "Movies", Users = new List<User> { jane } };

ctx.AddRange(jane, john, football, movies);
await ctx.SaveChangesAsync();

// Query!
var users = await ctx.Set<ExternalUser>().Where(u => u.ExternalCompany == "foo").ToListAsync();
foreach (var user in users)
{
    Console.WriteLine("User: " + user.Name);
}

public class UserContext : DbContext
{
    public DbSet<User> Users { get; set; }
    public DbSet<Group> Groups { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678")
            .LogTo(Console.WriteLine, new[] { RelationalEventId.CommandExecuted })
            .EnableSensitiveDataLogging();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<ExternalUser>();
        modelBuilder.Entity<TimeRestrictedUser>();
    }
}

public class User
{
    public int Id { get; set; }
    public string Name { get; set; }

    public ICollection<Group> Groups { get; set; }
}

public class ExternalUser : User
{
    public string ExternalCompany { get; set; }
}

public class TimeRestrictedUser : User
{
    public DateTime StartTime { get; set; }
    public DateTime EndTime { get; set; }
}

public class Group
{
    public int Id { get; set; }
    public string Name { get; set; }

    public ICollection<User> Users { get; set; }
}
