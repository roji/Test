using System;
using System.Threading.Tasks;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.Editing;

var workspace = new AdhocWorkspace();
var syntaxGenerator = SyntaxGenerator.GetGenerator(workspace, LanguageNames.CSharp);
