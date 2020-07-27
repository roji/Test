using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace EFGames
{
    class Program
    {
        static async Task Main(string[] args)
        {
            await using var ctx = new BlogContext();
            await ctx.Database.EnsureDeletedAsync();
            await ctx.Database.EnsureCreatedAsync();
        }
    }

    public class BlogContext : DbContext
    {
        public DbSet<Blog> Blogs { get; set; }

        static ILoggerFactory ContextLoggerFactory
            => LoggerFactory.Create(b => b.AddConsole().AddFilter("", LogLevel.Information));

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            => optionsBuilder
                //.UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0")
                //.UseSqlite("Filename=:memory:")
                .UseNpgsql(@"Host=localhost;Username=test;Password=test")
                .EnableSensitiveDataLogging()
                .UseLoggerFactory(ContextLoggerFactory);

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
        }
    }

    public class Blog
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
