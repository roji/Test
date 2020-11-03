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
var john = new User { Name = "John" };

var football = new Group { Name = "Football" };
var movies = new Group { Name = "Movies" };

var membership1 = new Membership { User = jane, Group = football };
var membership2 = new Membership { User = john, Group = football };
var membership3 = new Membership { User = jane, Group = movies };

ctx.AddRange(jane, john, football, movies, membership1, membership2, membership3);
await ctx.SaveChangesAsync();

// Query!

var users = await ctx.Users.Where(u => u.Memberships.Any(m => m.Group.Name == "Movies")).ToListAsync();
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
}

public class User
{
    public int Id { get; set; }
    public string Name { get; set; }

    public ICollection<Membership> Memberships { get; set; }
}

public class Group
{
    public int Id { get; set; }
    public string Name { get; set; }

    public ICollection<Membership> Memberships { get; set; }
}

public class Membership
{
    public int Id { get; set; }
    public User User { get; set; }
    public Group Group { get; set; }
}
