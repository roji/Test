using System;
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking.Internal;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Infrastructure.Internal;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using Microsoft.EntityFrameworkCore.Query;
using Microsoft.EntityFrameworkCore.Query.Internal;
using Microsoft.EntityFrameworkCore.Query.SqlExpressions;
using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.Extensions.Caching.Memory;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Linq.Expressions;
using System.Linq.Expressions;
using System.Reflection;
using System.Reflection;
using System.Runtime.CompilerServices;

#nullable disable
public static class EFPrecompiledQueryBootstrapper
{
    private static readonly MethodInfo DbSetMethod = typeof(DbContext).GetMethod(nameof(DbContext.Set), Array.Empty<Type>())!;
    public static void Bootstrap(DbContext context, ConcurrentDictionary<object, Func<DbContext, Delegate>> factories)
    {
        var model = context.Model;
        var dbSetToQueryRootReplacer = new DbSetToQueryRootReplacer(model);
        // Query from /home/roji/projects/test/Program.cs:38,4
        {
            Expression query = static (DbContext context, string __name_0) => context.Set<Blog>().Where((b) => b.Name == __name_0);
            query = dbSetToQueryRootReplacer.Visit(((LambdaExpression)query).Body);
            var cacheKey = new RelationalCompiledQueryCacheKey(new CompiledQueryCacheKey(query, model, QueryTrackingBehavior.TrackAll, false), false, null, false);
            factories[cacheKey] = context =>
            {
                var relationalModel = model.GetRelationalModel();
                var relationalTypeMappingSource = context.GetService<IRelationalTypeMappingSource>();
                var materializerLiftableConstantContext = new RelationalMaterializerLiftableConstantContext(context.GetService<ShapedQueryCompilingExpressionVisitorDependencies>(), context.GetService<RelationalShapedQueryCompilingExpressionVisitorDependencies>());
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
                sqlTree1.PopulateClauses(new TableExpressionBase[] { new TableExpression("b", "Blogs", null, relationalModel.FindTable("Blogs", null)) }, new SqlBinaryExpression(ExpressionType.Equal, new ConcreteColumnExpression("Name", new TableReferenceExpression(sqlTree1, "b"), typeof(string), relationalTypeMappingSource.FindMapping(typeof(string), "nvarchar(max)", false, true, null, false, false, null, null), true), new SqlParameterExpression(Expression.Parameter(typeof(string), "__name_0"), relationalTypeMappingSource.FindMapping(typeof(string), "nvarchar(max)", false, true, null, false, false, null, null)), typeof(bool), relationalTypeMappingSource.FindMapping(typeof(bool), "bit", false, false, null, false, false, null, null)), null, null, new SqlExpression[] { }, null, new OrderingExpression[] { }, false, new ProjectionExpression[] { new ProjectionExpression(new ConcreteColumnExpression("Id", new TableReferenceExpression(sqlTree1, "b"), typeof(int), relationalTypeMappingSource.FindMapping(typeof(int), "int", false, false, null, false, false, null, null), false), "Id"), new ProjectionExpression(new ConcreteColumnExpression("Name", new TableReferenceExpression(sqlTree1, "b"), typeof(string), relationalTypeMappingSource.FindMapping(typeof(string), "nvarchar(max)", false, true, null, false, false, null, null), true), "Name") }, new HashSet<string>()
                { });
                var relationalCommandCache = new RelationalCommandCache(dependencies.MemoryCache, relationalDependencies.QuerySqlGeneratorFactory, relationalDependencies.RelationalParameterBasedSqlProcessorFactory, sqlTree1, false);
                var emptyValueBuffer = ValueBuffer.Empty;
                var blogEntityType = dependencies.Model.FindEntityType("Blog");
                var blogKey = blogEntityType.FindPrimaryKey();
                return (QueryContext queryContext) => SingleQueryingEnumerable.Create((RelationalQueryContext)queryContext, relationalCommandCache, null, (QueryContext queryContext, DbDataReader dataReader, ResultContext resultContext, SingleQueryResultCoordinator resultCoordinator) =>
                {
                    IEntityType entityType1;
                    bool hasNullKey1;
                    var materializationContext1 = new MaterializationContext(in emptyValueBuffer, queryContext.Context);
                    Blog instance1 = null;
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
                            var shadowValueBuffer1 = emptyValueBuffer;
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
                                instance1 = null;
                            }

                            entry1 = entityType1 == default(IEntityType) ? default : queryContext.StartTracking(entityType1, instance1, shadowValueBuffer1);
                        }
                    }

                    var entity = instance1;
                    return entity;
                }, typeof(BlogContext), false, false, true);
            };
        }

        Console.WriteLine("Bootstrapped EF precompiled queries");
    }

    [ModuleInitializer]
    public static void Register() => PrecompiledQueryFactoryRegistry.RegisterBootstrapper(typeof(BlogContext), Bootstrap);
    class DbSetToQueryRootReplacer : ExpressionVisitor
    {
        private readonly IModel _model;
        public DbSetToQueryRootReplacer(IModel model) => _model = model;
        protected override Expression VisitMethodCall(MethodCallExpression node)
        {
            // TODO: SQL query
            // TODO: STET
            var method = node.Method;
            if (method.IsGenericMethod && method.GetGenericMethodDefinition() == DbSetMethod)
            {
                var entityType = _model.FindEntityType(method.GetGenericArguments()[0])!;
                return new EntityQueryRootExpression(entityType);
            }

            return base.VisitMethodCall(node);
        }
    }
}