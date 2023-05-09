using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Logging;

BenchmarkRunner.Run<Benchmark>();

public class Benchmark
{
    private const string LocalhostConnectionString =
        @"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false";

    private const string RemoteConnectionString =
        @"Server=192.168.2.103;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false";

    private PooledDbContextFactory<BlogContext> _contextFactory;
    
    [GlobalSetup]
    public async Task Setup()
    {
        var builder = new DbContextOptionsBuilder<BlogContext>();
        builder.UseSqlServer(LocalhostConnectionString);
        _contextFactory = new PooledDbContextFactory<BlogContext>(builder.Options);

        using var ctx = _contextFactory.CreateDbContext();
        await ctx.Database.EnsureDeletedAsync();
        await ctx.Database.EnsureCreatedAsync();
    }
    
    [Benchmark]
    public async Task Insert_four_rows()
    {
        using var ctx = _contextFactory.CreateDbContext();
        
        for (var i = 0; i < 4; i++)
        {
            var blog = new Blog
            {
                Name = "Foo" + i
            };
        
            ctx.Blogs.Add(blog);
        }
        
        await ctx.SaveChangesAsync();
    }
}

public class BlogContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }
    
    public BlogContext(DbContextOptions options) : base(options) {}
}

public class Blog
{
    public int Id { get; set; }
    public string Name { get; set; }
}
