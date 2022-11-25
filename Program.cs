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

var c = new Course
{
};
ctx.Add(c);
ctx.SaveChanges();

var v1 = new Video
{
    CourseId = c.Id,
    Duration = TimeSpan.FromMinutes(32),
};
ctx.Add(v1);

var v2 = new Video
{
    CourseId = c.Id,
    Duration = TimeSpan.FromMinutes(50),
};
ctx.Add(v2);

ctx.SaveChanges();

var course = ctx.Courses
    .Select(c => new
    {
        TotalDuration = EF.Functions.Sum(c.Videos.Select(v => v.Duration)),
    }).FirstOrDefault();

public class BlogContext : DbContext
{
    public DbSet<Video> Videos { get; set; }
    public DbSet<Course> Courses { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseNpgsql(@"Host=localhost;Username=test;Password=test")
            .LogTo(Console.WriteLine, LogLevel.Information)
            .EnableSensitiveDataLogging();
}

public class Course
{
    public int Id { get; set; }
    public List<Video> Videos { get; set; }
}

public class Video
{
    public int Id { get; set; }
    public TimeSpan Duration { get; set; }
    public int CourseId { get; set; }
    public Course Course { get; set; }
}
