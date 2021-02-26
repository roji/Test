using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;
using System.Threading.Tasks;
using BenchmarkDotNet.Attributes;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using Microsoft.EntityFrameworkCore.Storage;
using Npgsql;

namespace Test
{
    [MemoryDiagnoser]
    public class FortunesBenchmark
    {
        private const string ConnectionString = "Host=localhost;Username=test;Password=test;Database=techempower;Max Auto Prepare=10;Auto Prepare Min Usages=5";

        #region Raw

        [Benchmark]
        public async Task<List<FortuneRaw>> Raw()
        {
            var result = new List<FortuneRaw>(20);

            using (var db = new NpgsqlConnection(ConnectionString))
            {
                await db.OpenAsync();

                using (var cmd = new NpgsqlCommand("SELECT id, message FROM fortune", db))
                using (var rdr = await cmd.ExecuteReaderAsync())
                {
                    while (await rdr.ReadAsync())
                    {
                        result.Add(new FortuneRaw
                        (
                            id:rdr.GetInt32(0),
                            message: rdr.GetString(1)
                        ));
                    }
                }
            }

            result.Add(new FortuneRaw(id: 0, message: "Additional fortune added at request time." ));
            result.Sort();

            return result;
        }

        public readonly struct FortuneRaw : IComparable<FortuneRaw>, IComparable
        {
            public FortuneRaw(int id, string message)
            {
                Id = id;
                Message = message;
            }

            public int Id { get; }

            public string Message { get; }

            public int CompareTo(object obj) => throw new InvalidOperationException("The non-generic CompareTo should not be used");

            // Performance critical, using culture insensitive comparison
            public int CompareTo(FortuneRaw other) => string.CompareOrdinal(Message, other.Message);
        }

        #endregion

        #region EF Core

        private static DbContextPool<FortunesContext> _contextPool;

        private static readonly Func<FortunesContext, IAsyncEnumerable<FortuneEF>> _fortunesQuery
            = EF.CompileAsyncQuery((FortunesContext context) => context.Fortune);

        [GlobalSetup(Target = nameof(EFCore))]
        public async Task Setup()
        {
            var optionsBuilder = new DbContextOptionsBuilder<FortunesContext>();

            optionsBuilder.UseNpgsql(
                ConnectionString,
                o => o.ExecutionStrategy(d => new NonRetryingExecutionStrategy(d)));
            var options = optionsBuilder.Options;
            _contextPool = new DbContextPool<FortunesContext>(options);

            using var ctx = new FortunesContext(options);
            await ctx.Database.EnsureDeletedAsync();
            await ctx.Database.EnsureCreatedAsync();
        }

        [Benchmark]
        public async Task<List<FortuneEF>> EFCore()
        {
            var result = new List<FortuneEF>();

            var poolable = _contextPool.Rent();
            poolable.SetLease(new DbContextLease(_contextPool, standalone: true));

            using var dbContext = (FortunesContext)poolable;

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

            result.Add(new FortuneEF { Message = "Additional fortune added at request time." });

            result.Sort();

            return result;
        }

        public class FortunesContext : DbContext
        {
            public FortunesContext(DbContextOptions options)
                : base(options)
            {
                ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;
                ChangeTracker.AutoDetectChangesEnabled = false;
            }

            public DbSet<FortuneEF> Fortune { get; set; }

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
        public class FortuneEF : IComparable<FortuneEF>, IComparable
        {
            [Column("id")]
            public int Id { get; set; }

            [NotMapped]
            [IgnoreDataMember]
            public int _Id { get; set; }

            [Column("message")]
            [StringLength(2048)]
            [IgnoreDataMember]
            [Required]
            public string Message { get; set; }

            public int CompareTo(object obj)
            {
                return CompareTo((FortuneEF)obj);
            }

            public int CompareTo(FortuneEF other)
            {
                return String.CompareOrdinal(Message, other.Message);
            }
        }

        #endregion EF Core
    }
}
