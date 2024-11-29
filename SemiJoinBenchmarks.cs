using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq2;
using BenchmarkDotNet.Attributes;

namespace Test;

[MemoryDiagnoser]
public class SemiJoinBenchmarks
{
    // [Params(DataProfile.BestCase, DataProfile.WorstCase, DataProfile.Random, Priority = 1)]
    [Params(DataProfile.Random, Priority = 1)]
    public DataProfile DataProfile { get; set; }

    // [Params(1, 10, 100, 1000, Priority = 2)]
    // [Params(1, 10, 100, 1000, 10000, Priority = 1)]
    [Params(100, Priority = 2)]
    public int InnersPerOuter { get; set; }

    // [Params(1, 10, 100, 1000, Priority = 3)]
    // [Params(1, 10, 100, 1000, 10000, Priority = 2)]
    [Params(100, Priority = 3)]
    public int OuterCount { get; set; }

    private Outer[] _outers = null!;
    private Inner[] _inners = null!;

    private const int RandomSeed = 42;

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

    [GlobalSetup]
    public void Setup()
    {
        _outers = new Outer[OuterCount];
        _inners = new Inner[OuterCount * InnersPerOuter];

        for (var outerId = 0; outerId < OuterCount; outerId++)
        {
            _outers[outerId] = new Outer { Id = outerId, OuterPayload = $"Outer{outerId}" };
        }

        switch (DataProfile)
        {
            case DataProfile.WorstCase:
            {
                // Just lay out inners for all the outers right at the data start, so that Where/Any finds them right
                // away in its sequential scan
                for (var i = 0; i < OuterCount; i++)
                {
                    _inners[i] = new Inner { Id = i, OuterId = i, InnerPayload = $"Inner{i}" };
                }

                for (var i = OuterCount; i < OuterCount * InnersPerOuter; i++)
                {
                    _inners[i] = new Inner { Id = i, OuterId = int.MaxValue, InnerPayload = $"Inner{i}" };
                }

                break;
            }

            case DataProfile.BestCase:
            {
                // Just lay out inners for all the outers right at the data end, so that Where/Any has to go through
                // all the data in its sequential scan
                int i;
                for (i = 0; i < OuterCount * InnersPerOuter - OuterCount; i++)
                {
                    _inners[i] = new Inner { Id = i, OuterId = int.MaxValue, InnerPayload = $"Inner{i}" };
                }

                for (var outerId = 0; outerId < OuterCount; outerId++)
                {
                    _inners[i + outerId] = new Inner { Id = i, OuterId = outerId, InnerPayload = $"Inner{i}" };
                }

                break;
            }

            case DataProfile.Random:
                var remainingInners = new List<Inner>(OuterCount * InnersPerOuter);
                for (var i = 0; i < OuterCount; i++)
                {
                    for (var j = 0; j < InnersPerOuter; j++)
                    {
                        var innerId = i * j + j;
                        remainingInners.Add(new Inner { Id = innerId, OuterId = i, InnerPayload = $"Inner{innerId}" });
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

                break;
        }
    }

    [Benchmark]
    public int SemiJoin()
        => _outers.SemiJoin(_inners, o => o.Id, i => i.OuterId).Count();

    [Benchmark(Baseline = true)]
    public int Where_Any()
        => _outers.Where(o => _inners.Any(i => i.OuterId == o.Id)).Count();
}

public enum DataProfile { BestCase, WorstCase, Random }
