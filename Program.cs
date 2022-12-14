using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Linq.Expressions;
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

// await ctx.Database.EnsureDeletedAsync();
// await ctx.Database.EnsureCreatedAsync();
// ctx.Blogs.Add(new Blog { Name = "FooBlog", Posts = new List<Post> { new() { Title = "Post1" }, new() { Title = "Post2" }}});
// ctx.Blogs.Add(new Blog { Name = "BarBlog", Posts = new List<Post> { new() { Title = "Post3" } }});
// await ctx.SaveChangesAsync();

if (args.Length > 0 && args[0] == "regenerate")
{
    var services = new ServiceCollection()
        .AddEntityFrameworkDesignTimeServices()
        .AddDbContextDesignTimeServices(ctx);
    var npgsqlDesignTimeServices = new SqlServerDesignTimeServices();
    npgsqlDesignTimeServices.ConfigureDesignTimeServices(services);
    var serviceProvider = services.BuildServiceProvider();
    var precompiledQueriesCodeGenerator = serviceProvider.GetRequiredService<IPrecompiledQueryCodeGenerator>();
    await precompiledQueriesCodeGenerator.GeneratePrecompiledQueries("/home/roji/projects/test/Test.csproj", ctx, outputDir: "/home/roji/projects/test");
    return;
}

var name = "foo";
_ = ctx.Blogs.Where(b => b.Name == name).ToList();

// _ = ctx.Blogs.Include(b => b.Posts).ToList();
//
// _ = ctx.Blogs.Select(b => new { Id = b.Id, Name = b.Name }).ToList();

// FAILS
// _ = ctx.Blogs.Select(b => new { b.Id, b.Name }).ToList();

// _ = ctx.Blogs.Where(b => b.Name == ctx.Blogs.Single(b => b.Id == 3).Name).ToList();

// ctx.Blogs.Where(b => b.Name == "foo").ExecuteDelete();

// ctx.Blogs.Where(b => b.Name == "foo").ExecuteUpdate(s => s.SetProperty(b => b.Name, "bar"));

// await ctx.Blogs.Where(b => b.Name == "foo").ExecuteDeleteAsync();

// await ctx.Blogs.Where(b => b.Name == "foo").ExecuteDeleteAsync();

// var name = await ctx.Blogs.Where(b => b.Id == 1).SumAsync(b => b.Id);

// var blogs = ctx.Blogs.Include(b => b.Posts).AsSplitQuery().Where(b => b.Id == 1).ToList();
// foreach (var blog in blogs)
// {
//     Console.WriteLine($"Blog: {blog.Name}: [{string.Join(", ", blog.Posts.Select(p => p.Title))}]");
// }

// var name = ctx.Blogs.Where(b => b.Id == 1).Include(b => b.Posts).ToListAsync();

// var blogs = ctx.Blogs.Where(b => b.Id < 100).ToList();

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
