using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Build.Locator;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.Editing;
using Microsoft.CodeAnalysis.Formatting;
using Microsoft.CodeAnalysis.MSBuild;
using Microsoft.CodeAnalysis.Simplification;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.EntityFrameworkCore.Migrations.Design;
using Microsoft.EntityFrameworkCore.Query.Internal;
using Microsoft.EntityFrameworkCore.SqlServer.Design.Internal;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using static System.Linq.Expressions.Expression;

await using var ctx = new BlogContext();

//await ctx.Database.EnsureDeletedAsync();
//await ctx.Database.EnsureCreatedAsync();

// ctx.Blogs.Add(new Blog { Name = "FooBlog", Posts = new List<Post> { new() { Title = "Post1" }, new() { Title = "Post2" }}});
// ctx.Blogs.Add(new Blog { Name = "BarBlog", Posts = new List<Post> { new() { Title = "Post3" } }});
// await ctx.SaveChangesAsync();

// Check if the current assembly contains the InterceptsLocationAttribute; if not, we perform pre-compilation.
// (note that it's a file-scoped type, so complicated to look up)
if (!Assembly.GetExecutingAssembly().GetTypes().Any(t => t.Name.Contains("InterceptsLocationAttribute")))
{
    await GeneratePrecompiledQueries("/Users/roji/projects/test/Test.csproj", ctx, "/Users/roji/projects/test", new());
}

Console.WriteLine("[InterceptsLocation] found, executing query...");

var name = "foo";
_ = ctx.Blogs.Where(b => b.Name == name).ToList();

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

public class BlogContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .LogTo(Console.WriteLine, new[] { CoreEventId.QueryCompilationStarting, RelationalEventId.CommandExecuted })
            .EnableSensitiveDataLogging();
}

public class Blog
{
    public int Id { get; set; }
    public string? Name { get; set; }

    public List<Post> Posts { get; set; }
}

public class Post
{
    public int Id { get; set; }
    public string Title { get; set; }

    public Blog Blog { get; set; }
}

