using System;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace TestingChannels
{
    class Program
    {
        static Pool pool;

        static async Task Main(string[] args)
        {
            // Console.WriteLine($"PID: {Process.GetCurrentProcess().Id} (for dotnet counters), press enter to start...");
            // Console.ReadLine();

            pool = new Pool();

            // await Task.WhenAll(Enumerable.Range(0, 1000).Select(x => NpgsqlIssue(x)));
            await Task.WhenAll(Enumerable.Range(0, 1000).Select(x => Task.Run(() => NpgsqlIssue(x))));
        }

        static async Task NpgsqlIssue(int i)
        {
            // The steps are:
            // 1. Rent from the pool asynchronously
            // 2. Do some async work (so we move to the thread pool)
            // 3. Attempt to rent synchronously

            // Issue 2:
            // Uncommenting the following lines causes starvation regardless Issue 1 (AsTask fix)
            // This is "normal", and is a result of a thundering herd effect, coupled with mixing sync and async.

            // Console.WriteLine($"Starting async rent {i} {ThreadInfo()}");
            // var obj = await pool.Rent(true);
            //
            // Console.WriteLine($"Returning {i} {ThreadInfo()}");
            // pool.Return(obj);
            // Console.WriteLine($"First return successful {i} {ThreadInfo()}");

            Console.WriteLine($"Starting sync rent {i} {ThreadInfo()}");
            var obj2 = await pool.Rent(false); // Making rent async fixes
            Console.WriteLine($"Sync rent successful {i} {ThreadInfo()}");

            pool.Return(obj2);

            static string ThreadInfo() =>
                $"(T{Thread.CurrentThread.ManagedThreadId}, TP={Thread.CurrentThread.IsThreadPoolThread})";
        }

        /*
        // Deadlocks
        static async Task Test(int i)
        {
            // Now we're running on the thread from the threadpool
            await Task.Delay(100);

            var async = i % 2 == 0;
            var start = DateTime.UtcNow;
            var obj = await pool.Rent(async);
            obj.RentDate = DateTime.UtcNow;
            if (obj.ReturnDate.HasValue)
                Console.WriteLine($"There was a {(obj.RentDate - obj.ReturnDate.Value).TotalMilliseconds}ms delay between obj return and rent");
            var rent = (obj.RentDate - start).TotalMilliseconds;

            // Queing some async operation
            await Task.Delay(100);

            var beforeReturn = DateTime.UtcNow;
            pool.Return(obj);
            var afterReturn = (DateTime.UtcNow - beforeReturn).TotalMilliseconds;

            //Console.WriteLine($"Done. Rent took {rent}ms, return took {afterReturn}ms");
        }
        */
    }
}
