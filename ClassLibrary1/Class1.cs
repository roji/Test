using Npgsql;

public static class Test
{
    public static void Run(string connectionString)
    {
        var dataSourceBuilder = new NpgsqlDataSourceBuilder(connectionString);
        var dataSource = dataSourceBuilder.Build();
        dataSource.Dispose();
    }
}
