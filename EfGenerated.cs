using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.CompilerServices;

// ReSharper disable once CheckNamespace
namespace Microsoft.EntityFrameworkCore.Aot.Generated;

static class Interceptors
{
    [InterceptsLocation("/Users/roji/projects/test/Program.cs", 15, 15)]
    public static IQueryable<Blog> Where_Program_20_15(this IQueryable<Blog> source, Expression<Func<Blog, bool>> predicate)
    {
        var fakeQueryable = new FakeQueryable<Blog>();

        var binary1 = (BinaryExpression)predicate.Body;
        var right1 = (MemberExpression)binary1.Right;

        // This interprets when run under NativeAOT, otherwise will get properly compiled/JITted
        // (good since this will get reused every time the query runs).
        // In the future, [UnsafeAccessor] may evolve to support unspeakable types (to access the DisplayClass)
        // (https://github.com/dotnet/runtime/issues/81741#issuecomment-1421056437)
        _parameterExtractor12345 ??= Expression.Lambda<Func<object?>>(Expression.Convert(right1, typeof(object)))
            .Compile();

        fakeQueryable.Parameters["s"] = _parameterExtractor12345.Invoke();

        return fakeQueryable;
    }

    [InterceptsLocation("/Users/roji/projects/test/Program.cs", 15, 39)]
    public static List<Blog> ToList(this IEnumerable<Blog> source)
    {
        var parameters = ((FakeQueryable<Blog>)source).Parameters;

        Console.WriteLine($"Executing intercepted precompiled query. Parameter value for 's' is {parameters["s"]}");

        // TODO: Actually execute the query with the parameters
        return new List<Blog>();
    }

    private static Func<object?>? _parameterExtractor12345;
}

class FakeQueryable<T> : IQueryable<T>
{
    // Can even generate a dedicated type per query - but code size bloat?
    public Dictionary<string, object?> Parameters { get; } = new();

    public IEnumerator<T> GetEnumerator()
        => throw new NotImplementedException();

    IEnumerator IEnumerable.GetEnumerator()
        => throw new NotImplementedException();

    public Type ElementType => throw new NotImplementedException();
    public Expression Expression => throw new NotImplementedException();
    public IQueryProvider Provider => throw new NotImplementedException();
}
