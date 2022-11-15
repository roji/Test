using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

await using var ctx = new MyDbContext();
await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

await using (MyDbContext dbContext = new())
{
    await dbContext.Database.EnsureDeletedAsync();
    await dbContext.Database.EnsureCreatedAsync();
}

await using (MyDbContext dbContext = new())
{
    Book book = new () { Number = 3, Title = "Book3" };
    dbContext.Add(book);

    await dbContext.SaveChangesAsync();
}

await using (MyDbContext dbContext = new())
{
    BookStore store = new() { Name = "MainBookStore" };
    dbContext.Add(store);

    dbContext.AddRange(new List<Book>()
    {
        new Book() { Number = 1, Title = "Book1" },
        new Book() { Number = 2, Title = "Book2" },
        new Book() { Number = 3, Title = "Book3" },
        new Book() { Number = 4, Title = "Book4" }
    });

    try
    {
        await dbContext.SaveChangesAsync();
    }
    catch (DbUpdateException ex) when (ex.InnerException is SqlException sqlException && sqlException.Number == 2601)
    {
        Console.WriteLine($"SqlException: {sqlException.Message}");
        Console.WriteLine($"Duplicates: {string.Join(", ", ex.Entries.Select(e => e.Entity.ToString()).ToArray())}");
    }
}

public class MyDbContext : DbContext
{
    public DbSet<BookStore> BookStores { get; set; }
    public DbSet<Book> Books { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            //.UseSqlite("Filename=:memory:")
            // .UseNpgsql(@"Host=localhost;Username=test;Password=test")
            .LogTo(Console.WriteLine, LogLevel.Information)
            .EnableSensitiveDataLogging();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<BookStore>();
        modelBuilder.Entity<Book>(b =>
        {
            b.HasIndex(book => book.Number).IsUnique();
        });
    }
}

public sealed class BookStore
{
    public int Id { get; set; }
    public string? Name { get; set; }

    public override string ToString()
        => $"{nameof(BookStore)}: {Name}";
}

public sealed class Book
{
    public int Id { get; set; }
    public int Number { get; set; }
    public string? Title { get; set; }
    public int? BookStoreId { get; set; }
    public BookStore? BookStore { get; set; }

    public override string ToString()
        => $"{nameof(Book)}: #{Number} - {Title}";
}
