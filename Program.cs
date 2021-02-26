using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Diagnostics;
using System.Runtime.Serialization;
using System.Threading.Tasks;
using BenchmarkDotNet.Running;
using JetBrains.Profiler.Api;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.Extensions.Logging;
using Test;

#pragma warning disable EF1001

public class Program
{
    private const int Iterations = 10000;

    public static async Task Main(string[] args)
    {
        var benchmark = new FortunesBenchmark();
        await benchmark.Setup();
        await benchmark.Raw();
        await benchmark.Raw();

        // BenchmarkRunner.Run<Benchmark>();

        // await RunDotMemory();
    }

    static async Task RunDotMemory()
    {
        var benchmark = new FortunesBenchmark();
        await benchmark.Setup();

        // Warmup
        for (var i = 0; i < 1000; i++)
            await benchmark.Raw();

        MemoryProfiler.CollectAllocations(true);
        MemoryProfiler.GetSnapshot();

        var sw = Stopwatch.StartNew();

        for (var i = 0; i < Iterations; i++)
            await benchmark.Raw();

        MemoryProfiler.GetSnapshot();

        Console.WriteLine($"Completed {Iterations} iterations in {sw.ElapsedMilliseconds}ms");
    }
}


