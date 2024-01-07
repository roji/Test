using System;
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking.Internal;
using Microsoft.EntityFrameworkCore.ChangeTracking.Internal;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Infrastructure.Internal;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.EntityFrameworkCore.Query;
using Microsoft.EntityFrameworkCore.Query;
using Microsoft.EntityFrameworkCore.Query.Internal;
using Microsoft.EntityFrameworkCore.Query.Internal;
using Microsoft.EntityFrameworkCore.Query.SqlExpressions;
using Microsoft.EntityFrameworkCore.Storage;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Reflection;
using System.Runtime.CompilerServices;

#pragma warning disable EF1001
#nullable disable
namespace Microsoft.EntityFrameworkCore.GeneratedInterceptors
{
    file static class EntityFrameworkCoreInterceptors
    {
        [InterceptsLocation("/Users/roji/projects/test/Program.cs", 47, 15)]
        public static IQueryable<TSource> Query1_Where1<TSource>(this IQueryable<TSource> source, Expression<Func<TSource, bool>> predicate)
        {
            var dbContext = ((Internal.InternalDbSet<Blog>)source).DbContext;
            var precompiledQueryContext = new PrecompiledQueryContext<TSource>(dbContext);
            var queryContext = precompiledQueryContext.QueryContext;
            var binary1 = (BinaryExpression)predicate.Body;
            var member2 = (MemberExpression)binary1.Right;
            queryContext.AddParameter("__name_0", Expression.Lambda<Func<object>>(Expression.Convert(member2, typeof(object))).Compile(preferInterpretation: true).Invoke());
            return precompiledQueryContext;
        }

        [InterceptsLocation("/Users/roji/projects/test/Program.cs", 47, 42)]
        public static List<TSource> Query1_ToList2<TSource>(this IEnumerable<TSource> source)
        {
            var precompiledQueryContext = (PrecompiledQueryContext<TSource>)source;
            var queryContext = precompiledQueryContext.QueryContext;
            if (Query1_QueryingEnumerableFactory == null)
            {
                Query1_QueryingEnumerableFactory = Query1_GenerateQueryingEnumerable(precompiledQueryContext.DbContext, queryContext);
            }

            return ((IEnumerable<TSource>)Query1_QueryingEnumerableFactory(queryContext)).ToList();
        }

        private static Func<QueryContext, IQueryingEnumerable> Query1_GenerateQueryingEnumerable(DbContext dbContext, QueryContext queryContext)
        {
            var relationalModel = dbContext.Model.GetRelationalModel();
            var relationalTypeMappingSource = dbContext.GetService<IRelationalTypeMappingSource>();
            var materializerLiftableConstantContext = new RelationalMaterializerLiftableConstantContext(dbContext.GetService<ShapedQueryCompilingExpressionVisitorDependencies>(), dbContext.GetService<RelationalShapedQueryCompilingExpressionVisitorDependencies>());
            var dependencies = materializerLiftableConstantContext.Dependencies;
            var relationalDependencies = materializerLiftableConstantContext.RelationalDependencies;
            /*
Projection Mapping:
    EmptyProjectionMember -> Dictionary<IProperty, int> { [Property: Blog.Id (int) Required PK AfterSave:Throw ValueGenerated.OnAdd, 0], [Property: Blog.Name (string), 1] }
SELECT b.Id, b.Name
FROM Blogs AS b
WHERE b.Name == @__name_0
*/

            var sqlTree1 = new SelectExpression(null);
            sqlTree1.PopulateClauses(new TableExpressionBase[] { new TableExpression("b", "Blogs", null, relationalModel.FindTable("Blogs", null)) }, new SqlBinaryExpression(ExpressionType.Equal, new ConcreteColumnExpression("Name", new TableReferenceExpression(sqlTree1, "b"), typeof(string), relationalTypeMappingSource.FindMapping(typeof(string), "nvarchar(max)", false, true, null, false, false, null, null), true), new SqlParameterExpression("__name_0", typeof(string), relationalTypeMappingSource.FindMapping(typeof(string), "nvarchar(max)", false, true, null, false, false, null, null)), typeof(bool), relationalTypeMappingSource.FindMapping(typeof(bool), "bit", false, false, null, false, false, null, null)), null, null, new SqlExpression[] { }, null, new OrderingExpression[] { }, false, new ProjectionExpression[] { new ProjectionExpression(new ConcreteColumnExpression("Id", new TableReferenceExpression(sqlTree1, "b"), typeof(int), relationalTypeMappingSource.FindMapping(typeof(int), "int", false, false, null, false, false, null, null), false), "Id"), new ProjectionExpression(new ConcreteColumnExpression("Name", new TableReferenceExpression(sqlTree1, "b"), typeof(string), relationalTypeMappingSource.FindMapping(typeof(string), "nvarchar(max)", false, true, null, false, false, null, null), true), "Name") }, new HashSet<string>() { });
            var relationalCommandCache = new RelationalCommandCache(dependencies.MemoryCache, relationalDependencies.QuerySqlGeneratorFactory, relationalDependencies.RelationalParameterBasedSqlProcessorFactory, sqlTree1, false);
            var emptyValueBuffer = ValueBuffer.Empty;
            var blogEntityType = dependencies.Model.FindEntityType("Blog");
            var blogKey = blogEntityType.FindPrimaryKey();
            var emptySnapshot = Snapshot.Empty;
            return (queryContext) => SingleQueryingEnumerable.Create((RelationalQueryContext)queryContext, relationalCommandCache, null, (QueryContext queryContext, DbDataReader dataReader, ResultContext resultContext, SingleQueryResultCoordinator resultCoordinator) =>
            {
                IEntityType entityType1;
                bool hasNullKey1;
                var materializationContext1 = new MaterializationContext(in emptyValueBuffer, queryContext.Context);
                var instance1 = default(Blog);
                var entry1 = queryContext.TryGetEntry(blogKey, new object[] { dataReader.GetInt32(0) }, true, out hasNullKey1);
                if (!hasNullKey1)
                {
                    if (entry1 != default(InternalEntityEntry))
                    {
                        entityType1 = entry1.EntityType;
                        instance1 = (Blog)entry1.Entity;
                    }
                    else
                    {
                        var shadowSnapshot1 = emptySnapshot;
                        entityType1 = blogEntityType;
                        if (entityType1 == blogEntityType)
                        {
                            var instance = new Blog();
                            typeof(Blog).GetField("<Id>k__BackingField", BindingFlags.Instance | BindingFlags.NonPublic).SetValue(instance, dataReader.GetInt32(0));
                            typeof(Blog).GetField("<Name>k__BackingField", BindingFlags.Instance | BindingFlags.NonPublic).SetValue(instance, dataReader.IsDBNull(1) ? default : dataReader.GetString(1));
                            instance1 = instance;
                        }
                        else
                        {
                            instance1 = default;
                        }

                        entry1 = entityType1 == default(IEntityType) ? default : queryContext.StartTracking(entityType1, instance1, in shadowSnapshot1);
                    }
                }

                var entity = instance1;
                return entity;
            }, typeof(BlogContext), false, false, true);
        }

        private static Func<QueryContext, IQueryingEnumerable> Query1_QueryingEnumerableFactory;
        [InterceptsLocation("/Users/roji/projects/test/Program.cs", 50, 15)]
        public static IQueryable<TResult> Query2_Select1<TSource, TResult>(this IQueryable<TSource> source, Expression<Func<TSource, TResult>> selector)
        {
            var dbContext = ((Internal.InternalDbSet<Blog>)source).DbContext;
            var precompiledQueryContext = new PrecompiledQueryContext<TSource>(dbContext);
            return precompiledQueryContext.ChangeType<TResult>();
        }

        [InterceptsLocation("/Users/roji/projects/test/Program.cs", 50, 49)]
        public static List<TSource> Query2_ToList2<TSource>(this IEnumerable<TSource> source)
        {
            var precompiledQueryContext = (PrecompiledQueryContext<TSource>)source;
            var queryContext = precompiledQueryContext.QueryContext;
            if (Query2_QueryingEnumerableFactory == null)
            {
                Query2_QueryingEnumerableFactory = Query2_GenerateQueryingEnumerable(precompiledQueryContext.DbContext, queryContext);
            }

            return ((IEnumerable<TSource>)Query2_QueryingEnumerableFactory(queryContext)).ToList();
        }

        private static Func<QueryContext, IQueryingEnumerable> Query2_GenerateQueryingEnumerable(DbContext dbContext, QueryContext queryContext)
        {
            var relationalModel = dbContext.Model.GetRelationalModel();
            var relationalTypeMappingSource = dbContext.GetService<IRelationalTypeMappingSource>();
            var materializerLiftableConstantContext = new RelationalMaterializerLiftableConstantContext(dbContext.GetService<ShapedQueryCompilingExpressionVisitorDependencies>(), dbContext.GetService<RelationalShapedQueryCompilingExpressionVisitorDependencies>());
            var relationalDependencies = materializerLiftableConstantContext.RelationalDependencies;
            /*
Projection Mapping:
    Id -> 0
    Name -> 1
SELECT b.Id, b.Name
FROM Blogs AS b
*/

            var sqlTree1 = new SelectExpression(null);
            sqlTree1.PopulateClauses(new TableExpressionBase[] { new TableExpression("b", "Blogs", null, relationalModel.FindTable("Blogs", null)) }, null, null, null, new SqlExpression[] { }, null, new OrderingExpression[] { }, false, new ProjectionExpression[] { new ProjectionExpression(new ConcreteColumnExpression("Id", new TableReferenceExpression(sqlTree1, "b"), typeof(int), relationalTypeMappingSource.FindMapping(typeof(int), "int", false, false, null, false, false, null, null), false), "Id"), new ProjectionExpression(new ConcreteColumnExpression("Name", new TableReferenceExpression(sqlTree1, "b"), typeof(string), relationalTypeMappingSource.FindMapping(typeof(string), "nvarchar(max)", false, true, null, false, false, null, null), true), "Name") }, new HashSet<string>() { });
            var relationalCommandCache = new RelationalCommandCache(materializerLiftableConstantContext.Dependencies.MemoryCache, relationalDependencies.QuerySqlGeneratorFactory, relationalDependencies.RelationalParameterBasedSqlProcessorFactory, sqlTree1, false);
            return (queryContext) => SingleQueryingEnumerable.Create((RelationalQueryContext)queryContext, relationalCommandCache, null, (QueryContext queryContext, DbDataReader dataReader, ResultContext resultContext, SingleQueryResultCoordinator resultCoordinator) =>
            {
                var value1 = (int?)dataReader.GetInt32(0);
                var value2 = dataReader.IsDBNull(1) ? default : dataReader.GetString(1);
                return new
                {
                    Id = (int)value1,
                    Name = value2
                };
            }, typeof(BlogContext), false, false, true);
        }

        private static Func<QueryContext, IQueryingEnumerable> Query2_QueryingEnumerableFactory;
    }
}

namespace System.Runtime.CompilerServices
{
    [AttributeUsage(AttributeTargets.Method, AllowMultiple = true)]
    file sealed class InterceptsLocationAttribute : Attribute
    {
        public InterceptsLocationAttribute(string filePath, int line, int column)
        {
        }
    }
}