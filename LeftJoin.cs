using System;
using System.Collections.Generic;
using System.Linq2;
using System.Threading.Tasks;
using Dapper;
using Microsoft.Data.SqlClient;
using Npgsql;
using NpgsqlTypes;

public static partial class Enumerable2
{
    public static IEnumerable<TResult> LeftJoin<TOuter, TInner, TKey, TResult>(
        this IEnumerable<TOuter> outer,
        IEnumerable<TInner> inner,
        Func<TOuter, TKey> outerKeySelector,
        Func<TInner, TKey> innerKeySelector,
        Func<TOuter, TInner?, TResult> resultSelector)
        => LeftJoin(outer, inner, outerKeySelector, innerKeySelector, resultSelector, comparer: null);

    public static IEnumerable<TResult> LeftJoin<TOuter, TInner, TKey, TResult>(
        this IEnumerable<TOuter> outer,
        IEnumerable<TInner> inner,
        Func<TOuter, TKey> outerKeySelector,
        Func<TInner, TKey> innerKeySelector,
        Func<TOuter, TInner?, TResult> resultSelector,
        IEqualityComparer<TKey>? comparer)
    {
        return LeftJoinIterator(outer, inner, outerKeySelector, innerKeySelector, resultSelector, comparer);
    }

    private static IEnumerable<TResult> LeftJoinIterator<TOuter, TInner, TKey, TResult>(IEnumerable<TOuter> outer,
        IEnumerable<TInner> inner, Func<TOuter, TKey> outerKeySelector, Func<TInner, TKey> innerKeySelector,
        Func<TOuter, TInner?, TResult> resultSelector, IEqualityComparer<TKey>? comparer)
    {
        using (IEnumerator<TOuter> e = outer.GetEnumerator())
        {
            if (e.MoveNext())
            {
                Lookup<TKey, TInner> innerLookup =
                    Lookup<TKey, TInner>.CreateForJoin(inner, innerKeySelector, comparer);
                do
                {
                    TOuter item = e.Current;
                    Grouping<TKey, TInner>? g = innerLookup.GetGrouping(outerKeySelector(item), create: false);
                    if (g is null)
                    {
                        yield return resultSelector(item, default);
                    }
                    else
                    {
                        int count = g._count;
                        TInner[] elements = g._elements;
                        for (int i = 0; i != count; ++i)
                        {
                            yield return resultSelector(item, elements[i]);
                        }
                    }
                } while (e.MoveNext());
            }
        }
    }
}
