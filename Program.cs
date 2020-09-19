using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore.Migrations.Design;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace EFGames
{
    class Program
    {
        static async Task Main(string[] args)
        {
            using var ctx = new BlogContext();

            var services = new ServiceCollection()
                .AddEntityFrameworkDesignTimeServices()
                .AddDbContextDesignTimeServices(ctx);
            var serviceProvider = services.BuildServiceProvider();
            var scaffolder = serviceProvider.GetRequiredService<IMigrationsScaffolder>();
            var migration = scaffolder.ScaffoldMigration(
                "MyMigration",
                "MyApp.Data");

            Console.WriteLine(migration.MigrationCode);
        }
    }

    public class BlogContext : DbContext
    {
        public DbSet<Blog> Blogs { get; set; }

        static ILoggerFactory ContextLoggerFactory
            => LoggerFactory.Create(b => b.AddConsole().AddFilter("", LogLevel.Information));

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            => optionsBuilder
                // .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0")
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
