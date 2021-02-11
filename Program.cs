using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics;
using System.Runtime.Serialization;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.Extensions.Logging;

#pragma warning disable EF1001

public class Program
{
    private const int Iterations = 30000;

    private static DbContextPool<ApplicationDbContext> _contextPool;

    public static async Task Main(string[] args)
    {
        var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();

        optionsBuilder.UseNpgsql(@"Host=localhost;Username=test;Password=test",
            o => o.ExecutionStrategy(d => new NonRetryingExecutionStrategy(d)));
        var options = optionsBuilder.Options;
        _contextPool = new DbContextPool<ApplicationDbContext>(options);

        // await using var ctx = new ApplicationDbContext(options);
        // await ctx.Database.EnsureDeletedAsync();
        // await ctx.Database.EnsureCreatedAsync();

        Console.WriteLine("About to start, press any key...");
        Console.ReadKey();
        Console.WriteLine("Starting run...");

        var sw = Stopwatch.StartNew();

        for (var i = 0; i < Iterations; i++)
        {
            await LoadFortunesRows();
        }

        Console.WriteLine($"Completed {Iterations} iterations in {sw.ElapsedMilliseconds}ms");
    }

    private static readonly Func<ApplicationDbContext, IAsyncEnumerable<Fortune>> _fortunesQuery
        = EF.CompileAsyncQuery((ApplicationDbContext context) => context.Fortune);

    public static async Task<IEnumerable<Fortune>> LoadFortunesRows()
    {
        var result = new List<Fortune>();

        var poolable = _contextPool.Rent();
        poolable.SetLease(new DbContextLease(_contextPool, standalone: true));

        using var dbContext = (ApplicationDbContext)poolable;

        try
        {
            await foreach (var fortune in _fortunesQuery(dbContext))
            {
                result.Add(fortune);
            }
        }
        finally
        {
            _contextPool.Return(dbContext);
        }

        result.Add(new Fortune { Message = "Additional fortune added at request time." });

        result.Sort();

        return result;
    }
}

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions options)
        : base(options)
    {
        ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;
        ChangeTracker.AutoDetectChangesEnabled = false;
    }

    public DbSet<Fortune> Fortune { get; set; }

    // static ILoggerFactory ContextLoggerFactory
    //     => LoggerFactory.Create(b => b.AddConsole().AddFilter("", LogLevel.Information));

    // protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    //     => optionsBuilder
    //         .UseNpgsql(@"Host=localhost;Username=test;Password=test",
    //             o => o.ExecutionStrategy(d => new NonRetryingExecutionStrategy(d)));
            // .EnableSensitiveDataLogging()
            // .UseLoggerFactory(ContextLoggerFactory);
}

[Table("fortune")]
public class Fortune : IComparable<Fortune>, IComparable
{
    [Column("id")]
    public int Id { get; set; }

    [NotMapped]
    [IgnoreDataMember]
    public int _Id { get; set; }

    [Column("message")]
    [StringLength(2048)]
    [IgnoreDataMember]
    public string Message { get; set; }

    public int CompareTo(object obj)
    {
        return CompareTo((Fortune)obj);
    }

    public int CompareTo(Fortune other)
    {
        return String.CompareOrdinal(Message, other.Message);
    }
}
