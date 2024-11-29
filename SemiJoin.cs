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
    public static IEnumerable<TOuter> SemiJoin<TOuter, TInner, TKey>(
        this IEnumerable<TOuter> outer,
        IEnumerable<TInner> inner,
        Func<TOuter, TKey> outerKeySelector,
        Func<TInner, TKey> innerKeySelector)
        => SemiJoin(outer, inner, outerKeySelector, innerKeySelector, comparer: null);

    public static IEnumerable<TOuter> SemiJoin<TOuter, TInner, TKey>(
        this IEnumerable<TOuter> outer,
        IEnumerable<TInner> inner,
        Func<TOuter, TKey> outerKeySelector,
        Func<TInner, TKey> innerKeySelector,
        IEqualityComparer<TKey>? comparer)
        => SemiJoinIterator(outer, inner, outerKeySelector, innerKeySelector, comparer);

    private static IEnumerable<TOuter> SemiJoinIterator<TOuter, TInner, TKey>(
        IEnumerable<TOuter> outer,
        IEnumerable<TInner> inner,
        Func<TOuter, TKey> outerKeySelector,
        Func<TInner, TKey> innerKeySelector,
        IEqualityComparer<TKey>? comparer)
    {
        using (IEnumerator<TOuter> e = outer.GetEnumerator())
        {
            if (e.MoveNext())
            {
                HashSet<TKey> innerKeys = new HashSet<TKey>(comparer);
                foreach (TInner i in inner)
                {
                    innerKeys.Add(innerKeySelector(i));
                }

                if (innerKeys.Count != 0)
                {
                    do
                    {
                        TOuter item = e.Current;
                        if (innerKeys.Contains(outerKeySelector(item)))
                        {
                            yield return item;
                        }
                    }
                    while (e.MoveNext());
                }
            }
        }
    }

    // Lookup-based implementation: unsurprisingly much worse than the above HashSet-based one
    // private static IEnumerable<TOuter> SemiJoinIterator<TOuter, TInner, TKey>(
    //     IEnumerable<TOuter> outer,
    //     IEnumerable<TInner> inner,
    //     Func<TOuter, TKey> outerKeySelector,
    //     Func<TInner, TKey> innerKeySelector,
    //     IEqualityComparer<TKey>? comparer)
    // {
    //     using (IEnumerator<TOuter> e = outer.GetEnumerator())
    //     {
    //         if (e.MoveNext())
    //         {
    //             Lookup<TKey, TInner> lookup = Lookup<TKey, TInner>.CreateForJoin(inner, innerKeySelector, comparer);
    //             if (lookup.Count != 0)
    //             {
    //                 do
    //                 {
    //                     TOuter item = e.Current;
    //                     Grouping<TKey, TInner>? g = lookup.GetGrouping(outerKeySelector(item), create: false);
    //                     if (g is not null)
    //                     {
    //                         int count = g._count;
    //                         for (int i = 0; i != count; ++i)
    //                         {
    //                             yield return item;
    //                         }
    //                     }
    //                 }
    //                 while (e.MoveNext());
    //             }
    //         }
    //     }
    // }
}
