using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

await using var ctx = new BlogContext();
await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

ctx.Customers.Add(new Customer { Name = "foo" });
await ctx.SaveChangesAsync();

var customers = await ctx.Customers.FromSql($"SELECT * FROM Customers").ToListAsync();
Console.WriteLine(customers[0].Name);

public class BlogContext : DbContext
{
    public DbSet<Customer> Customers { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .LogTo(Console.WriteLine, LogLevel.Information)
            .EnableSensitiveDataLogging();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Customer>()
            .OwnsOne(c => c.Address/*, b => b.ToJson()*/);
    }
}

public class Customer
{
    public int Id { get; set; }
    public string Name { get; set; }

    public Address Address { get; set; }
}

public class Address
{
    public Address(string street, string city, string postcode, string country)
    {
        Street = street;
        City = city;
        Postcode = postcode;
        Country = country;
    }

    public string Street { get; set; }
    public string City { get; set; }
    public string Postcode { get; set; }
    public string Country { get; set; }
}
