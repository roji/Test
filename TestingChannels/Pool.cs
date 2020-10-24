using System;
using System.Diagnostics;
using System.Threading;
using System.Threading.Channels;
using System.Threading.Tasks;
using Npgsql;

namespace TestingChannels
{
    class Pool
    {
        static readonly SingleThreadSynchronizationContext SingleThreadSynchronizationContext = new SingleThreadSynchronizationContext("NpgsqlRemainingAsyncSendWorker");

        readonly ChannelReader<PooledObject> reader;
        readonly ChannelWriter<PooledObject> writer;

        readonly PooledObject[] objects;

        volatile int _numObjects;

        public Pool()
        {
            var channel = Channel.CreateUnbounded<PooledObject>();

            reader = channel.Reader;
            writer = channel.Writer;

            objects = new PooledObject[5];
            for (var i = 0; i < objects.Length; i++)
            {
                objects[i] = new PooledObject();
                writer.TryWrite(objects[i]);
            }
        }

        public async ValueTask<PooledObject> Rent(bool async)
        {
            while (true)
            {
                if (reader.TryRead(out var readPooledObject))
                    return readPooledObject;

                if (async)
                    return await reader.ReadAsync();

                using (SingleThreadSynchronizationContext.Enter())
                {
                    // Issue 1:
                    // The following uses AsTask(), which still causes some callback code to be executed on the TP,
                    // regardless of the synchronization context. This is why the starvation occurs.
                    return reader.ReadAsync().AsTask().GetAwaiter().GetResult();

                    // The following is logically the same as the above, but has no dependency on the TP - this solves
                    // the starvation.
                    var mre = new ManualResetEventSlim();
                    reader.WaitToReadAsync().GetAwaiter().OnCompleted(() => mre.Set());
                    mre.Wait();
                }
            }
        }

        public void Return(PooledObject pooledObject)
        {
            pooledObject.ReturnDate = DateTime.UtcNow;
            writer.TryWrite(pooledObject);
        }
    }
}
