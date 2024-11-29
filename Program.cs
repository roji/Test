using System;
using System.Linq;
using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Configs;
using BenchmarkDotNet.Environments;
using BenchmarkDotNet.Jobs;
using BenchmarkDotNet.Reports;
using BenchmarkDotNet.Running;
using Perfolizer.Horology;
using Test;

//     DefaultConfig.Instance.WithSummaryStyle(SummaryStyle.Default.WithTimeUnit(TimeUnit.Microsecond)));

BenchmarkRunner.Run<LeftJoinBenchmarks>();

// var runner = new LeftJoinBenchmarks { OuterCount = 100, InnersPerOuter = 1000 };
// runner.Setup();
// runner.LeftJoin();
// runner.GroupJoin_SelectMany();

/////////////////////////////////////

// BenchmarkRunner.Run<SemiJoinBenchmarks>();

// var runner = new SemiJoinBenchmarks { OuterCount = 100, InnersPerOuter = 100, DataProfile = DataProfile.Random };
// runner.Setup();
// runner.Where_Any();
// runner.SemiJoin();



