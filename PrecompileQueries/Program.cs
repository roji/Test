using Microsoft.Build.Locator;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.Editing;
using Microsoft.CodeAnalysis.Formatting;
using Microsoft.CodeAnalysis.MSBuild;
using Microsoft.CodeAnalysis.Simplification;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query.Internal;

Console.WriteLine("Start query precompilation...");

await using var context = new BlogContext();

await GeneratePrecompiledQueries("/Users/roji/projects/test/Test/Test.csproj", context, "/Users/roji/projects/test/Test", new());

async Task GeneratePrecompiledQueries(
    string projectFilePath,
    DbContext dbContext,
    string outputDir,
    List<PrecompiledQueryCodeGenerator.QueryPrecompilationError> precompilationErrors,
    CancellationToken cancellationToken = default)
{
    // https://gist.github.com/DustinCampbell/32cd69d04ea1c08a16ae5c4cd21dd3a3
    MSBuildLocator.RegisterDefaults();

    Console.Error.WriteLine("Loading project...");
    using var workspace = MSBuildWorkspace.Create();

    var project = await workspace.OpenProjectAsync(projectFilePath, cancellationToken: cancellationToken)
        .ConfigureAwait(false);

    if (!project.SupportsCompilation)
    {
        throw new NotSupportedException("The project does not support compilation");
    }

    Console.WriteLine("Compiling project...");
    var compilation = (await project.GetCompilationAsync(cancellationToken).ConfigureAwait(false))!;

    var errorDiagnostics = compilation.GetDiagnostics(cancellationToken).Where(d => d.Severity == DiagnosticSeverity.Error).ToArray();
    if (errorDiagnostics.Any())
    {
        Console.Error.WriteLine("Compilation failed with errors:");
        Console.Error.WriteLine();
        foreach (var diagnostic in errorDiagnostics)
        {
            Console.WriteLine(diagnostic);
        }

        Environment.Exit(1);
    }

    Console.WriteLine($"Compiled assembly {compilation.Assembly.Name}");

    var syntaxGenerator = SyntaxGenerator.GetGenerator(project);

    var precompiledCodeGenerator = new PrecompiledQueryCodeGenerator();
    var generatedFiles = precompiledCodeGenerator.GeneratePrecompiledQueries(
        compilation, syntaxGenerator, dbContext, precompilationErrors, additionalAssembly: null, cancellationToken);

    foreach (var generatedFile in generatedFiles)
    {
        // var document = project.AddDocument(OutputFileName, bootstrapperSyntaxRoot);

        // var generatedSource = (await generatedSyntaxTree.GetRootAsync(cancellationToken).ConfigureAwait(false))
            // .ToFullString();
        // var outputFilePath = Path.Combine(outputDir, OutputFileName);
        // File.WriteAllText(outputFilePath, bootstrapperText);

        var document = project.AddDocument("EfGeneratedInterceptors.cs", generatedFile.Code);

        // document = await ImportAdder.AddImportsAsync(document, options: null, cancellationToken).ConfigureAwait(false);
        // document = await ImportAdder.AddImportsFromSymbolAnnotationAsync(
        //     document, Simplifier.AddImportsAnnotation, cancellationToken: cancellationToken).ConfigureAwait(false);

        // document = await ImportAdder.AddImportsAsync(document, options: null, cancellationToken).ConfigureAwait(false);

        // Run the simplifier to e.g. get rid of unneeded parentheses
        var syntaxRootFoo = (await document.GetSyntaxRootAsync(cancellationToken).ConfigureAwait(false))!;
        var annotatedDocument = document.WithSyntaxRoot(syntaxRootFoo.WithAdditionalAnnotations(Simplifier.Annotation));
        document = await Simplifier.ReduceAsync(annotatedDocument, optionSet: null, cancellationToken).ConfigureAwait(false);

        // format any node with explicit formatter annotation
        // document = await Formatter.FormatAsync(document, Formatter.Annotation, cancellationToken: cancellationToken).ConfigureAwait(false);

        // format any elastic whitespace
        // document = await Formatter.FormatAsync(document, SyntaxAnnotation.ElasticAnnotation, cancellationToken: cancellationToken).ConfigureAwait(false);

        document = await Formatter.FormatAsync(document, options: null, cancellationToken).ConfigureAwait(false);

        // document = await CaseCorrector.CaseCorrectAsync(document, CaseCorrector.Annotation, cancellationToken).ConfigureAwait(false);


        var outputFilePath = Path.Combine(outputDir, "EfGeneratedInterceptors.cs");
        var finalSyntaxTree = (await document.GetSyntaxTreeAsync(cancellationToken).ConfigureAwait(false))!;
        var finalText = await finalSyntaxTree.GetTextAsync(cancellationToken).ConfigureAwait(false);
        File.WriteAllText(outputFilePath, finalText.ToString());

        // TODO: This is nicer - it adds the file to the project, but also adds a <Compile> node in the csproj for some reason.
        // var applied = workspace.TryApplyChanges(document.Project.Solution);
        // if (!applied)
        // {
        //     Console.WriteLine("Failed to apply changes to project");
        // }
    }

    // Console.WriteLine($"Query precompilation complete, processed {queriesPrecompiled} queries.");
    Console.WriteLine("Query precompilation complete.");
}
