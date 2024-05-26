using System;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Azure.Identity;
using Dapper;
using Microsoft.Azure.Cosmos;
using Microsoft.Azure.Cosmos.Linq;
using Microsoft.Data.SqlClient;
using Npgsql;
using NpgsqlTypes;

CosmosClient client = new(
    "https://192.168.64.6:8081/",
    "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==",
    new CosmosClientOptions
    {
        HttpClientFactory = () => new HttpClient(
            new HttpClientHandler
            {
                ServerCertificateCustomValidationCallback =
                    HttpClientHandler.DangerousAcceptAnyServerCertificateValidator
            }),
        ConnectionMode = ConnectionMode.Gateway
    });

Database database = client.GetDatabase("Northwind");
Container container = database.GetContainer("NorthwindContext");

// string[] ids = ["Foo", "Bar"];
// Console.WriteLine(container.GetItemLinqQueryable<Customer>()
//     .Where(c => new[] { "Foo", "Bar" }.Contains(c.CustomerID))
//     .ToString());

var customers = container.GetItemLinqQueryable<Customer>(allowSynchronousQueryExecution: true)
    .Where(c => c.CustomerID == "ALFKI")
    .ToList();

foreach (var customer in customers)
{
    Console.WriteLine(customer.CustomerID);
}

// using FeedIterator<Customer> setIterator = container.GetItemLinqQueryable<Customer>()
//     .Where(c => c.CustomerID == "ALFKI")
//     .ToFeedIterator();
//
// var response = await setIterator.ReadNextAsync();
// Console.WriteLine(response.Count);

public class Customer
{
    public string CustomerID { get; set; } = null!;
    public int[] Ints { get; set; } = null!;
}

