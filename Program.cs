using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Pgvector;
using Pgvector.EntityFrameworkCore;

await using var ctx = new BlogContext();
await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

ctx.Items.Add(new Item { Embedding = new Vector(new float[] { 1, 1, 1 }) });
await ctx.SaveChangesAsync();

var embedding = new Vector(new float[] { 1, 1, 1 });
var items = await ctx.Items.OrderBy(x => x.Embedding!.L2Distance(embedding)).Take(5).ToListAsync();

public class BlogContext : DbContext
{
    public DbSet<Item> Items { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseNpgsql("Host=localhost;Username=test;Password=test", o => o.UseVector())
            .LogTo(Console.WriteLine, LogLevel.Information)
            .EnableSensitiveDataLogging();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.HasPostgresExtension("vector");
    }
}

public class Item
{
    public int Id { get; set; }

    [Column(TypeName = "vector(3)")]
    public Vector? Embedding { get; set; }
}
