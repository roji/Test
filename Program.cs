using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
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

var result = ctx.School.FromSqlRaw("EXEC School_GetList").ToList();
Console.WriteLine(result.Count);

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
