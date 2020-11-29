using System;
using System.Data.Entity;
using System.Threading.Tasks;
using Npgsql;
using NpgsqlTypes;

using var ctx = new BlogContext();
ctx.Database.Delete();
ctx.Database.Create();

class BlogContext : DbContext
{
    public BlogContext() : base("Host=localhost;Username=test;Password=test")
    {
    }

    public DbSet<Blog> Blogs { get; set; }

    protected override void OnModelCreating(DbModelBuilder modelBuilder)
    {
    }
}

public class Blog
{
    public int Id { get; set; }
    public string Name { get; set; }
}

class NpgsqlConfiguration : DbConfiguration
{
    public NpgsqlConfiguration()
    {
        SetProviderFactory("Npgsql", NpgsqlFactory.Instance);
        SetProviderServices("Npgsql", NpgsqlServices.Instance);
        SetDefaultConnectionFactory(new NpgsqlConnectionFactory());
    }
}
