using Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;

for (var i = 0; i < 10; i++)
{
    using var dbContext = new AdventureWorks2019Context();
    var migrator = dbContext.GetService<IMigrator>();
    _ = migrator.GenerateScript();
}
