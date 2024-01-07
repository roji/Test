using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.EntityFrameworkCore.Migrations.Design;
using Microsoft.EntityFrameworkCore.Query.Internal;
using Microsoft.EntityFrameworkCore.SqlServer.Design.Internal;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using static System.Linq.Expressions.Expression;

await using var ctx = new BlogContext();

// ctx.Blogs.Add(new Blog { Name = "FooBlog", Posts = new List<Post> { new() { Title = "Post1" }, new() { Title = "Post2" }}});
// ctx.Blogs.Add(new Blog { Name = "BarBlog", Posts = new List<Post> { new() { Title = "Post3" } }});
// await ctx.SaveChangesAsync();

// Check if the current assembly contains the InterceptsLocationAttribute; if not, we perform pre-compilation.
// (note that it's a file-scoped type, so complicated to look up)
if (!Assembly.GetExecutingAssembly().GetTypes().Any(t => t.Name.Contains("InterceptsLocationAttribute")))
{
    Console.WriteLine("[InterceptsLocation] not found, going into pre-compilation...");
    var services = new ServiceCollection()
        .AddEntityFrameworkDesignTimeServices()
        .AddDbContextDesignTimeServices(ctx);
    var npgsqlDesignTimeServices = new SqlServerDesignTimeServices();
    npgsqlDesignTimeServices.ConfigureDesignTimeServices(services);
    var serviceProvider = services.BuildServiceProvider();
    var precompiledQueriesCodeGenerator = serviceProvider.GetRequiredService<IPrecompiledQueryCodeGenerator>();
    await precompiledQueriesCodeGenerator.GeneratePrecompiledQueries("/Users/roji/projects/test/Test.csproj", ctx, outputDir: "/Users/roji/projects/test");
    return;
}

Console.WriteLine("[InterceptsLocation] found, executing query...");

await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

// Query with a captured variable
var name = "foo";
_ = ctx.Blogs.Where(b => b.Name == name).ToList();

// Query projecting out an anonymous type (generic interceptor):
_ = ctx.Blogs.Select(b => new { b.Id, b.Name }).ToList();

// Queries that cannot be intercepted (property access directly inside foreach):
foreach (var blog in ctx.Blogs)
{
    Console.WriteLine(blog.Id);
}
await foreach (var blog in ctx.Blogs)
{
    Console.WriteLine(blog.Id);
}

public class BlogContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .LogTo(Console.WriteLine, new[] { CoreEventId.QueryCompilationStarting, RelationalEventId.CommandExecuted })
            .EnableSensitiveDataLogging();
}

public class Blog
{
    public int Id { get; set; }
    public string? Name { get; set; }

    public List<Post> Posts { get; set; }
}

public class Post
{
    public int Id { get; set; }
    public string Title { get; set; }

    public Blog Blog { get; set; }
}
