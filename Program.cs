using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

await using var ctx = new SchoolContext();
await ctx.Database.EnsureDeletedAsync();
await ctx.Database.EnsureCreatedAsync();

ctx.Database.ExecuteSqlRaw(@"
CREATE TYPE [dbo].[IntWhereClauses] AS TABLE(
	[ParameterIndex] [int] NOT NULL,
	[ParameterName] [nvarchar](75) NULL,
	[Operator] [nvarchar](8) NOT NULL,
	[ParameterValue] [int] NULL
)");

// ctx.Database.ExecuteSqlRaw(@"
// CREATE PROC [dbo].[School_GetList]
// AS
// BEGIN
// 	DECLARE		@sql nvarchar(MAX),
// 				@nl char(2) = char(13)+char(10)
//
// 	SELECT @sql =
// 		'SELECT
// 		 t.[Id], t.[Name]
// 		 FROM dbo.School t
// 		 WHERE 1=1 ' + @nl
//
// 	EXEC sp_executesql @sql
// END");

ctx.Database.ExecuteSqlRaw(@"
/* function used in stored procedure */
CREATE FUNCTION [dbo].[GenerateParametersForIntegers]
(
    @list AS dbo.IntWhereClauses READONLY
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @retVal NVARCHAR(MAX)
	DECLARE @nl CHAR(2) = CHAR(13) + CHAR(10)

	SELECT @retVal = COALESCE(@retVal + N', @p' + CONVERT(VARCHAR(11), ParameterIndex) + N' INT = ' + CAST(ParameterValue AS NVARCHAR(75))
    , N'@p' + CONVERT(VARCHAR(11), ParameterIndex) + N' INT = ' + CAST(ParameterValue AS NVARCHAR(75)))
	FROM @list

	return @retVal
END");

ctx.Database.ExecuteSqlRaw(@"
/* function used in stored procedure */
CREATE FUNCTION [dbo].[GenerateWhereClauseForIntegers]
(
    @list AS dbo.IntWhereClauses READONLY
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @retVal NVARCHAR(MAX)
	DECLARE @nl CHAR(2) = CHAR(13) + CHAR(10)

	SELECT @retVal = COALESCE(@retVal + N'AND ' + QUOTENAME(ParameterName)
    + N' ' + Operator + N' @p' + CONVERT(VARCHAR(11), ParameterIndex) + N' ', QUOTENAME(ParameterName)
    + N' ' + Operator + N' @p' + CONVERT(VARCHAR(11), ParameterIndex) + N' ')
	FROM @list

	return @retVal
END
");

ctx.Database.ExecuteSqlRaw(@"
CREATE PROC [dbo].[School_GetList] (
	@IntWhereClauses IntWhereClauses READONLY
	,@debug bit = 0)
AS
BEGIN
	DECLARE		@sql nvarchar(MAX),
				@paramlist nvarchar(max),
				@nl char(2) = char(13)+char(10),
				@paramValues nvarchar(max)

	select @paramValues = N'AND ' + dbo.GenerateWhereClauseForIntegers(@IntWhereClauses)

	SELECT @sql =
		'SELECT
		 t.[Id], t.[Name]
		 FROM dbo.School t
		 WHERE 1=1 ' + @nl + @paramValues

	select @paramList = dbo.GenerateParametersForIntegers(@IntWhereClauses)

	IF (@debug = 1)
	BEGIN
		PRINT @sql
		PRINT @paramList
	END

	EXEC sp_executesql @sql, @paramlist

END");

List<IParameter> parameters = new List<IParameter>();

parameters.Add(new UrlParameter() { ParameterName = "Id", Operator = ">=", ParameterType = typeof(int), ParameterValue = "1" });
parameters.Add(new UrlParameter() { ParameterName = "Id", Operator = "<=", ParameterType = typeof(int), ParameterValue = "5" });

List<SqlParameter> p = GetListParameters(parameters);
var p2 = p.Single();

p2.SqlDbType = SqlDbType.Structured;

var filterParameter = new SqlParameter("IntWhereClauses", SqlDbType.Structured) { Value = dataTable };
var result = ctx.School.FromSqlRaw("EXEC School_GetList @IntWhereClauses", p2).ToList();
Console.WriteLine(result.Count);

List<SqlParameter> GetListParameters(List<IParameter> parameters)
{
    List<SqlParameter> returnParams = new();

    returnParams.Add(GenerateParameter("IntWhereClauses", typeof(int), parameters.FindAll(c => c.ParameterType == typeof(int)), 1));

    return returnParams;
}

SqlParameter GenerateParameter(string typeName, Type parameterType, List<IParameter> parameters, int autoIncrementSeed)
{
    var dt = new DataTable();

    dt.Columns.Add("ParameterIndex", typeof(int));
    dt.Columns.Add("ParameterName", typeof(string));
    dt.Columns.Add("Operator", typeof(string));
    dt.Columns.Add("ParameterValue", parameterType);

    foreach (IParameter param in parameters)
    {
        DataRow dr = dt.NewRow();
        dr["ParameterIndex"] = autoIncrementSeed++;
        dr["ParameterName"] = param.ParameterName;
        dr["Operator"] = param.Operator;
        dr["ParameterValue"] = param.ParameterValue;
        dt.Rows.Add(dr);
    }

    return new SqlParameter($"@{typeName}", dt)
    {
        SqlDbType = SqlDbType.Structured,
        TypeName = $"[dbo].[{typeName}]",
        Direction = ParameterDirection.Input,
    };
}

public class SchoolContext : DbContext
{
    public DbSet<School> School { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .LogTo(Console.WriteLine, LogLevel.Information)
            .EnableSensitiveDataLogging();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
        => modelBuilder.Entity<School>().HasData(new School { Id = 1, Name = "Foo" });
}

public class School
{
    public int Id { get; set; }
    public string Name { get; set; }
}

public interface IParameter
{
    public string ParameterName { get; set; }
    public string ParameterValue { get; set; }
    public Type ParameterType { get; set; }
    public string Operator { get; set; }
}

public class UrlParameter : IParameter
{
    public string ParameterName { get; set; }
    public string ParameterValue { get; set; }
    public Type ParameterType { get; set; }
    public string Operator { get; set; }
}
