using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;

Console.WriteLine("Hello world");

_ = GetMembersInHierarchy(typeof(string));

static IEnumerable<MemberInfo> GetMembersInHierarchy(
    [DynamicallyAccessedMembers(
        DynamicallyAccessedMemberTypes.PublicProperties
        | DynamicallyAccessedMemberTypes.NonPublicProperties
        | DynamicallyAccessedMemberTypes.PublicFields
        | DynamicallyAccessedMemberTypes.NonPublicFields)]
    Type type)
{
    var currentType = type;

    do
    {
        // Do the whole hierarchy for properties first since looking for fields is slower.
        foreach (var propertyInfo in currentType.GetRuntimeProperties().Where(pi => !(pi.GetMethod ?? pi.SetMethod)!.IsStatic))
        {
            yield return propertyInfo;
        }

        foreach (var fieldInfo in currentType.GetRuntimeFields().Where(f => !f.IsStatic))
        {
            yield return fieldInfo;
        }

        currentType = currentType.BaseType;
    }
    while (currentType != null);
}
