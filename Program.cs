using System;
using System.Runtime.CompilerServices;
using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;

BenchmarkRunner.Run<Benchmark>();

public class Benchmark
{
    private static readonly bool BufferBoundsChecks = false;

    public double ReadDoubleWithoutBoundChecks()
    {
        if (BufferBoundsChecks)
        {
        }

        return 8;
    }

    public double ReadDoubleWithBoundChecks()
    {
        CheckBounds(sizeof(double));

        return 8;
    }

    public double ReadDoubleWithInlineBoundChecks()
    {
        if (BufferBoundsChecks)
        {
            throw new InvalidOperationException("There is not enough data left in the buffer.");
        }

        return 8;
    }

    void CheckBounds(int count)
    {
        if (BufferBoundsChecks)
            Core(count);

        [MethodImpl(MethodImplOptions.NoInlining)]
        void Core(int count)
        {
            if (count > 8)
                throw new InvalidOperationException("There is not enough data left in the buffer.");
        }
    }

    void CheckBoundsInlined(int count)
    {
        if (BufferBoundsChecks && count > 8)
            throw new InvalidOperationException("There is not enough data left in the buffer.");
    }
}
