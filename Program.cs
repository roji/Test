using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking.Internal;

namespace EFGames
{
    class Program
    {
        static async Task Main(string[] args)
        {
            await using var ctx = new BlogContext();
            await ctx.Database.EnsureDeletedAsync();
            await ctx.Database.EnsureCreatedAsync();

            IStateManager stateManager;
        }
    }

    public class BlogContext : DbContext
    {
        public DbSet<Blog> Blogs { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            => optionsBuilder.UseSqlite("Filename=:memory:");
    }

    public class Blog
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
