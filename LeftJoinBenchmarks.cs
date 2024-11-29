using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using BenchmarkDotNet.Attributes;

namespace Test;

[MemoryDiagnoser]
public class LeftJoinBenchmarks
{
    [Params(1, 10, 100, 1000, Priority = 1)]
    // [Params(1, Priority = 1)]
    public int InnersPerOuter { get; set; }

    [Params(1, 10, 100, 1000, Priority = 2)]
    // [Params(1, Priority = 2)]
    public int OuterCount { get; set; }

    private Outer[] _outers = null!;
    private Inner[] _inners = null!;

    class Outer
    {
        public int Id { get; set; }
        public string? OuterPayload { get; set; }
    }

    class Inner
    {
        public int Id { get; set; }
        public int OuterId { get; set; }
        public string? InnerPayload { get; set; }
    }

    private const int RandomSeed = 42;

    [GlobalSetup]
    public void Setup()
    {
        _outers = new Outer[OuterCount];
        _inners = new Inner[OuterCount * InnersPerOuter];

        var remainingInners = new List<Inner>(OuterCount * InnersPerOuter);
        for (var outerId = 0; outerId < OuterCount; outerId++)
        {
            _outers[outerId] = new Outer { Id = outerId, OuterPayload = $"Outer{outerId}" };

            for (var j = 0; j < InnersPerOuter; j++)
            {
                var innerId = outerId * j + j;
                remainingInners.Add(new Inner { Id = innerId, OuterId = outerId, InnerPayload = $"Inner{innerId}" });
            }
        }

        var random = new Random(RandomSeed);

        for (var i = 0; i < _inners.Length; i++)
        {
            var j = random.Next(0, remainingInners.Count);
            _inners[i] = remainingInners[j];
            remainingInners.RemoveAt(j);
        }

        Debug.Assert(remainingInners.Count == 0);
    }

    [Benchmark]
    public int LeftJoin()
        => _outers.LeftJoin(_inners, o => o.Id, i => i.OuterId, (o, i) => new { o.OuterPayload, i?.InnerPayload }).Count();

    [Benchmark(Baseline = true)]
    public int GroupJoin_SelectMany()
        => _outers
            .GroupJoin(_inners, o => o.Id, i => i.OuterId, (o, inners) => new { Outer = o, Inners = inners })
            .SelectMany(
                joinedSet => joinedSet.Inners.DefaultIfEmpty(),
                (o, i) => new
                {
                    o.Outer.OuterPayload,
                    i?.InnerPayload
                })
            .Count();
}
