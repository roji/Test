using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;

BenchmarkRunner.Run<Benchmark>();

public class Benchmark
{
    [Benchmark]
    public void Foo()
    {
    }
}
