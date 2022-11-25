using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

using (var context = new ReproDbContext())
{
    context.Database.Migrate();

    var parent = new Parent() { Name = "parent" };
    context.Add(parent);
    context.SaveChanges();

    var child = new Child() { ParentId = parent.ParentId, Name = "child" };
    context.Add(child);
    context.SaveChanges();

    context.Remove(parent);
    context.SaveChanges();
}

class Parent
{
    public Guid ParentId { get; set; }
    public string Name { get; set; }
}

class Child
{
    public Guid ChildId { get; set; }
    public Guid ParentId { get; set; }
    public Parent Parent { get; set; }
    public string Name { get; set; }
}

class ReproDbContext : DbContext
{
    public DbSet<Parent> Parents { get; set; }
    public DbSet<Child> Children { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        var parentBuilder = modelBuilder.Entity<Parent>();
        parentBuilder.ToTable(nameof(Parent));
        parentBuilder.HasKey(p => p.ParentId);
        parentBuilder.Property(p => p.ParentId).HasDefaultValueSql("NEWSEQUENTIALID()");
        parentBuilder.Property(p => p.Name).IsRequired();

        parentBuilder.DeleteUsingStoredProcedure(
            "DeleteParent",
            sp =>
            {
                sp.HasOriginalValueParameter(p => p.ParentId);
                sp.HasRowsAffectedReturnValue();
            });

        var childBuilder = modelBuilder.Entity<Child>();
        childBuilder.ToTable(nameof(Child));
        childBuilder.HasKey(c => c.ChildId);
        childBuilder.Property(c => c.ChildId).HasDefaultValueSql("NEWSEQUENTIALID()");
        childBuilder.Property(c => c.Name).IsRequired();
        childBuilder.HasOne(c => c.Parent).WithMany().HasForeignKey(c => c.ParentId);
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder
            .UseSqlServer(@"Server=localhost;Database=test;User=SA;Password=Abcd5678;Connect Timeout=60;ConnectRetryCount=0;Encrypt=false")
            .LogTo(Console.WriteLine, LogLevel.Information)
            .EnableSensitiveDataLogging();
    }
}
