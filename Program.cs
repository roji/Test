using System;
using System.Threading;
using System.Threading.Tasks;

namespace Test
{
    class Program
    {
        Task Foo(CancellationToken cancellationToken = default)
            => Bar();

        Task Bar(CancellationToken cancellationToken = default)
            => Task.Delay(1, cancellationToken);
    }
}
