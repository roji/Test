using System;
using System.Linq;
using Microsoft.Extensions.VectorData;
using Microsoft.SemanticKernel.Connectors.Postgres;
using Npgsql;

#pragma warning disable SKEXP0020
#pragma warning disable CS0618

var dataSourceBuilder = new NpgsqlDataSourceBuilder("Host=localhost;Username=test;Password=test");
dataSourceBuilder.UseVector();
await using var dataSource = dataSourceBuilder.Build();

await using (var command = dataSource.CreateCommand("CREATE EXTENSION IF NOT EXISTS vector"))
{
    await command.ExecuteNonQueryAsync();
    await dataSource.ReloadTypesAsync();
}

var store = new PostgresVectorStore(dataSource);
var collection = store.GetCollection<int, Product>("Products");

if (await collection.CollectionExistsAsync())
{
    await collection.DeleteCollectionAsync();
}
await collection.CreateCollectionAsync();

await collection.UpsertAsync(
    new()
    {
        Id = 1,
        SerialNo = 8,
        Name = "foo",
        Tags = ["x", "y"],
        Vector = new ReadOnlyMemory<float>([1, 2, 3])
    });

await collection.UpsertAsync(
    new()
    {
        Id = 2,
        SerialNo = 9,
        Name = "bar",
        Tags = ["x", "z"],
        Vector = new ReadOnlyMemory<float>([4, 5, 6])
    });

var results = await collection.VectorizedSearchAsync(
    new ReadOnlyMemory<float>([1, 2, 3]),
    new()
    {
        // NewFilter = r => r.SerialNo == 9,
        // NewFilter = r => r.SerialNo == 9 && r.Name == "bar",
        // NewFilter = r => r.SerialNo > 4,
        // NewFilter = r => r.Tags.Contains("x"),

        // Filter = new VectorSearchFilter().EqualTo("SerialNo", 9),
        // Filter = new VectorSearchFilter().AnyTagEqualTo("Tags", "z"),
        Top = 10
    });

await foreach (var result in results.Results)
{
    Console.WriteLine(result.Record.Name);
}

public class Product
{
    [VectorStoreRecordKey]
    public int Id { get; init; }

    [VectorStoreRecordVector(Dimensions: 3)]
    public ReadOnlyMemory<float>? Vector { get; set; }

    [VectorStoreRecordData(IsFilterable = true)]
    public int SerialNo { get; set; }

    [VectorStoreRecordData(IsFilterable = true)]
    public string? Name { get; set; }

    [VectorStoreRecordData(IsFilterable = true)]
    public required string[] Tags { get; set; }
}

