using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;

namespace Test
{
    public class Program
    {
        [Benchmark]
        public void Foo()
        {
        }

        static void Main(string[] args) => BenchmarkRunner.Run<Program>();
    }
}
