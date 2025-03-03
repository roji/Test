using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using DotNet.Testcontainers.Builders;
using Pinecone;
using PineconeIntegrationTests.Support.TestContainer;

// Initialize a client.
// API key is required, but the value does not matter.
// When starting without indexes, disable TLS and
// provide the host and port of the Pinecone Local instance.

var container = new PineconeBuilder().Build();
await container.StartAsync();

var url = container.Uri;

var pc = new PineconeClient(
    "foo",
    new ClientOptions
    {
        BaseUrl = container.Uri.ToString(),
        IsTlsEnabled = false
    }
);
// Create an index
var indexName = "example-index3";
// await pc.DeleteIndexAsync(indexName);
await pc.CreateIndexAsync(new CreateIndexRequest
{
    Name = indexName,
    Dimension = 2,
    Metric = CreateIndexRequestMetric.Cosine,
    Spec = new ServerlessIndexSpec
    {
        Serverless = new ServerlessSpec
        {
            Cloud = ServerlessSpecCloud.Aws,
            Region = "us-east-1",
        }
    },
    DeletionProtection = DeletionProtection.Disabled,
});
//Describe the index
var indexDescription = await pc.DescribeIndexAsync(indexName);
Console.WriteLine(indexDescription);
// Target the index
var index = pc.Index(indexName);
// Upsert records into the index
await index.UpsertAsync(new UpsertRequest()
{
    Namespace = "example-namespace",
    Vectors = new List<Vector>
    {
        new Vector
        {
            Id = "vec1",
            Values = new ReadOnlyMemory<float>([1.0f, -2.5f]),
            Metadata = new Metadata {
                ["genre"] = new("drama"),
            },
        },
        new Vector
        {
            Id = "vec2",
            Values = new ReadOnlyMemory<float>([3.0f, -2.0f]),
            Metadata = new Metadata {
                ["genre"] = new("documentary"),
            },
        },
        new Vector
        {
            Id = "vec3",
            Values = new ReadOnlyMemory<float>([0.5f, -1.5f]),
            Metadata = new Metadata {
                ["genre"] = new("documentary"),
            }
        }
    }
});

// // Check the number of records in the index
// var indexStatsResponse = await index.DescribeIndexStatsAsync(new DescribeIndexStatsRequest());
// Console.WriteLine(indexStatsResponse);
// // Query the index with a metadata filter
// var queryResponse = await index.QueryAsync(new QueryRequest
// {
//     Vector = new ReadOnlyMemory<float>([3.0f, -2.0f]),
//     TopK = 1,
//     Namespace = "example-namespace",
//     Filter = new Metadata
//     {
//         ["genre"] = new Metadata
//         {
//             ["$eq"] = "documentary",
//         }
//     },
// });
// Console.WriteLine(queryResponse);
// // Delete the index
// await pc.DeleteIndexAsync(indexName);
//
//
//
//
//
//
// // Values taken from https://docs.pinecone.io/guides/operations/local-development
// // const string Image = "ghcr.io/pinecone-io/pinecone-local:latest";
// // const ushort HttpPort = 5080;
// // const string Host = "localhost";
//
// // var container = new ContainerBuilder()
// //     .WithImage(Image)
// //     .WithPortBinding(HttpPort, assignRandomHostPort: true)
// //     .WithEnvironment("PINECONE_HOST", "localhost")
// //     .WithEnvironment("PORT", HttpPort.ToString())
// //     .Build();
//
// var container = new PineconeBuilder().Build();
// await container.StartAsync();
//
// await Task.Delay(TimeSpan.FromSeconds(3)); // add some artificial delay
//
// // string url = $"http://{container.Hostname}:{container.GetMappedPublicPort(HttpPort)}";
// // Console.WriteLine($"Using URL: '{url}'");
//
// // var pc = new PineconeClient("pclocal",
// //     new ClientOptions
// //     {
// //         BaseUrl = url,
// //         IsTlsEnabled = false
// //     }
// // );
// var pc = new PineconeClient("pclocal", new() { BaseUrl = container.Uri.ToString(), IsTlsEnabled = false });
//
// await pc.ListCollectionsAsync();
//
// var collectionModel = await pc.CreateCollectionAsync(new CreateCollectionRequest
// {
//     Name = "example-collection",
//     Source = "example-index",
// });
