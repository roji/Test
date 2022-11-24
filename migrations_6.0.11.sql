IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF SCHEMA_ID(N'Person') IS NULL EXEC(N'CREATE SCHEMA [Person];');
GO

IF SCHEMA_ID(N'Production') IS NULL EXEC(N'CREATE SCHEMA [Production];');
GO

IF SCHEMA_ID(N'Sales') IS NULL EXEC(N'CREATE SCHEMA [Sales];');
GO

IF SCHEMA_ID(N'HumanResources') IS NULL EXEC(N'CREATE SCHEMA [HumanResources];');
GO

IF SCHEMA_ID(N'Purchasing') IS NULL EXEC(N'CREATE SCHEMA [Purchasing];');
GO

CREATE TABLE [Person].[AddressType] (
    [AddressTypeID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_AddressType] PRIMARY KEY ([AddressTypeID])
);
DECLARE @description AS sql_variant;
SET @description = N'Types of addresses stored in the Address table. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'AddressType';
SET @description = N'Primary key for AddressType records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'AddressType', 'COLUMN', N'AddressTypeID';
SET @description = N'Address type description. For example, Billing, Home, or Shipping.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'AddressType', 'COLUMN', N'Name';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'AddressType', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'AddressType', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [AWBuildVersion] (
    [SystemInformationID] tinyint NOT NULL IDENTITY,
    [Database Version] nvarchar(25) NOT NULL,
    [VersionDate] datetime NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_AWBuildVersion_SystemInformationID] PRIMARY KEY ([SystemInformationID])
);
DECLARE @defaultSchema AS sysname;
SET @defaultSchema = SCHEMA_NAME();
DECLARE @description AS sql_variant;
SET @description = N'Current version number of the AdventureWorks 2016 sample database. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'AWBuildVersion';
SET @description = N'Primary key for AWBuildVersion records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'AWBuildVersion', 'COLUMN', N'SystemInformationID';
SET @description = N'Version number of the database in 9.yy.mm.dd.00 format.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'AWBuildVersion', 'COLUMN', N'Database Version';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'AWBuildVersion', 'COLUMN', N'VersionDate';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'AWBuildVersion', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[BusinessEntity] (
    [BusinessEntityID] int NOT NULL IDENTITY,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_BusinessEntity] PRIMARY KEY ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Source of the ID that connects vendors, customers, and employees with address and contact information.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntity';
SET @description = N'Primary key for all customers, vendors, and employees.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntity', 'COLUMN', N'BusinessEntityID';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntity', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntity', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[ContactType] (
    [ContactTypeID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ContactType] PRIMARY KEY ([ContactTypeID])
);
DECLARE @description AS sql_variant;
SET @description = N'Lookup table containing the types of business entity contacts.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'ContactType';
SET @description = N'Primary key for ContactType records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'ContactType', 'COLUMN', N'ContactTypeID';
SET @description = N'Contact type description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'ContactType', 'COLUMN', N'Name';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'ContactType', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[CountryRegion] (
    [CountryRegionCode] nvarchar(3) NOT NULL,
    [Name] nvarchar(50) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_CountryRegion_CountryRegionCode] PRIMARY KEY ([CountryRegionCode])
);
DECLARE @description AS sql_variant;
SET @description = N'Lookup table containing the ISO standard codes for countries and regions.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'CountryRegion';
SET @description = N'ISO standard code for countries and regions.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'CountryRegion', 'COLUMN', N'CountryRegionCode';
SET @description = N'Country or region name.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'CountryRegion', 'COLUMN', N'Name';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'CountryRegion', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[CreditCard] (
    [CreditCardID] int NOT NULL IDENTITY,
    [CardType] nvarchar(50) NOT NULL,
    [CardNumber] nvarchar(25) NOT NULL,
    [ExpMonth] tinyint NOT NULL,
    [ExpYear] smallint NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_CreditCard] PRIMARY KEY ([CreditCardID])
);
DECLARE @description AS sql_variant;
SET @description = N'Customer credit card information.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CreditCard';
SET @description = N'Primary key for CreditCard records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CreditCard', 'COLUMN', N'CreditCardID';
SET @description = N'Credit card name.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CreditCard', 'COLUMN', N'CardType';
SET @description = N'Credit card number.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CreditCard', 'COLUMN', N'CardNumber';
SET @description = N'Credit card expiration month.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CreditCard', 'COLUMN', N'ExpMonth';
SET @description = N'Credit card expiration year.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CreditCard', 'COLUMN', N'ExpYear';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CreditCard', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[Culture] (
    [CultureID] nchar(6) NOT NULL,
    [Name] nvarchar(50) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Culture] PRIMARY KEY ([CultureID])
);
DECLARE @description AS sql_variant;
SET @description = N'Lookup table containing the languages in which some AdventureWorks data is stored.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Culture';
SET @description = N'Primary key for Culture records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Culture', 'COLUMN', N'CultureID';
SET @description = N'Culture description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Culture', 'COLUMN', N'Name';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Culture', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[Currency] (
    [CurrencyCode] nchar(3) NOT NULL,
    [Name] nvarchar(50) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Currency_CurrencyCode] PRIMARY KEY ([CurrencyCode])
);
DECLARE @description AS sql_variant;
SET @description = N'Lookup table containing standard ISO currencies.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Currency';
SET @description = N'The ISO code for the Currency.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Currency', 'COLUMN', N'CurrencyCode';
SET @description = N'Currency name.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Currency', 'COLUMN', N'Name';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Currency', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [DatabaseLog] (
    [DatabaseLogID] int NOT NULL IDENTITY,
    [PostTime] datetime NOT NULL,
    [DatabaseUser] nvarchar(128) NOT NULL,
    [Event] nvarchar(128) NOT NULL,
    [Schema] nvarchar(128) NULL,
    [Object] nvarchar(128) NULL,
    [TSQL] nvarchar(4000) NOT NULL,
    [XmlEvent] nvarchar(4000) NOT NULL,
    CONSTRAINT [PK_DatabaseLog_DatabaseLogID] PRIMARY KEY NONCLUSTERED ([DatabaseLogID])
);
DECLARE @defaultSchema AS sysname;
SET @defaultSchema = SCHEMA_NAME();
DECLARE @description AS sql_variant;
SET @description = N'Audit table tracking all DDL changes made to the AdventureWorks database. Data is captured by the database trigger ddlDatabaseTriggerLog.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'DatabaseLog';
SET @description = N'Primary key for DatabaseLog records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'DatabaseLog', 'COLUMN', N'DatabaseLogID';
SET @description = N'The date and time the DDL change occurred.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'DatabaseLog', 'COLUMN', N'PostTime';
SET @description = N'The user who implemented the DDL change.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'DatabaseLog', 'COLUMN', N'DatabaseUser';
SET @description = N'The type of DDL statement that was executed.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'DatabaseLog', 'COLUMN', N'Event';
SET @description = N'The schema to which the changed object belongs.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'DatabaseLog', 'COLUMN', N'Schema';
SET @description = N'The object that was changed by the DDL statment.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'DatabaseLog', 'COLUMN', N'Object';
SET @description = N'The exact Transact-SQL statement that was executed.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'DatabaseLog', 'COLUMN', N'TSQL';
SET @description = N'The raw XML data generated by database trigger.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'DatabaseLog', 'COLUMN', N'XmlEvent';
GO

CREATE TABLE [HumanResources].[Department] (
    [DepartmentID] smallint NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [GroupName] nvarchar(50) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Department] PRIMARY KEY ([DepartmentID])
);
DECLARE @description AS sql_variant;
SET @description = N'Lookup table containing the departments within the Adventure Works Cycles company.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Department';
SET @description = N'Primary key for Department records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Department', 'COLUMN', N'DepartmentID';
SET @description = N'Name of the department.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Department', 'COLUMN', N'Name';
SET @description = N'Name of the group to which the department belongs.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Department', 'COLUMN', N'GroupName';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Department', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [ErrorLog] (
    [ErrorLogID] int NOT NULL IDENTITY,
    [ErrorTime] datetime NOT NULL DEFAULT ((getdate())),
    [UserName] nvarchar(128) NOT NULL,
    [ErrorNumber] int NOT NULL,
    [ErrorSeverity] int NULL,
    [ErrorState] int NULL,
    [ErrorProcedure] nvarchar(126) NULL,
    [ErrorLine] int NULL,
    [ErrorMessage] nvarchar(4000) NOT NULL,
    CONSTRAINT [PK_ErrorLog] PRIMARY KEY ([ErrorLogID])
);
DECLARE @defaultSchema AS sysname;
SET @defaultSchema = SCHEMA_NAME();
DECLARE @description AS sql_variant;
SET @description = N'Audit table tracking errors in the the AdventureWorks database that are caught by the CATCH block of a TRY...CATCH construct. Data is inserted by stored procedure dbo.uspLogError when it is executed from inside the CATCH block of a TRY...CATCH construct.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'ErrorLog';
SET @description = N'Primary key for ErrorLog records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'ErrorLog', 'COLUMN', N'ErrorLogID';
SET @description = N'The date and time at which the error occurred.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'ErrorLog', 'COLUMN', N'ErrorTime';
SET @description = N'The user who executed the batch in which the error occurred.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'ErrorLog', 'COLUMN', N'UserName';
SET @description = N'The error number of the error that occurred.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'ErrorLog', 'COLUMN', N'ErrorNumber';
SET @description = N'The severity of the error that occurred.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'ErrorLog', 'COLUMN', N'ErrorSeverity';
SET @description = N'The state number of the error that occurred.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'ErrorLog', 'COLUMN', N'ErrorState';
SET @description = N'The name of the stored procedure or trigger where the error occurred.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'ErrorLog', 'COLUMN', N'ErrorProcedure';
SET @description = N'The line number at which the error occurred.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'ErrorLog', 'COLUMN', N'ErrorLine';
SET @description = N'The message text of the error that occurred.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'ErrorLog', 'COLUMN', N'ErrorMessage';
GO

CREATE TABLE [Production].[Illustration] (
    [IllustrationID] int NOT NULL IDENTITY,
    [Diagram] nvarchar(4000) NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Illustration] PRIMARY KEY ([IllustrationID])
);
DECLARE @description AS sql_variant;
SET @description = N'Bicycle assembly diagrams.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Illustration';
SET @description = N'Primary key for Illustration records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Illustration', 'COLUMN', N'IllustrationID';
SET @description = N'Illustrations used in manufacturing instructions. Stored as XML.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Illustration', 'COLUMN', N'Diagram';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Illustration', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[Location] (
    [LocationID] smallint NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [CostRate] smallmoney NOT NULL DEFAULT (((0.00))),
    [Availability] decimal(8,2) NOT NULL DEFAULT (((0.00))),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Location] PRIMARY KEY ([LocationID])
);
DECLARE @description AS sql_variant;
SET @description = N'Product inventory and manufacturing locations.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Location';
SET @description = N'Primary key for Location records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Location', 'COLUMN', N'LocationID';
SET @description = N'Location description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Location', 'COLUMN', N'Name';
SET @description = N'Standard hourly cost of the manufacturing location.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Location', 'COLUMN', N'CostRate';
SET @description = N'Work capacity (in hours) of the manufacturing location.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Location', 'COLUMN', N'Availability';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Location', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[PhoneNumberType] (
    [PhoneNumberTypeID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_PhoneNumberType] PRIMARY KEY ([PhoneNumberTypeID])
);
DECLARE @description AS sql_variant;
SET @description = N'Type of phone number of a person.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'PhoneNumberType';
SET @description = N'Primary key for telephone number type records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'PhoneNumberType', 'COLUMN', N'PhoneNumberTypeID';
SET @description = N'Name of the telephone number type';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'PhoneNumberType', 'COLUMN', N'Name';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'PhoneNumberType', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductCategory] (
    [ProductCategoryID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductCategory] PRIMARY KEY ([ProductCategoryID])
);
DECLARE @description AS sql_variant;
SET @description = N'High-level product categorization.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductCategory';
SET @description = N'Primary key for ProductCategory records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductCategory', 'COLUMN', N'ProductCategoryID';
SET @description = N'Category description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductCategory', 'COLUMN', N'Name';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductCategory', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductCategory', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductDescription] (
    [ProductDescriptionID] int NOT NULL IDENTITY,
    [Description] nvarchar(400) NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductDescription] PRIMARY KEY ([ProductDescriptionID])
);
DECLARE @description AS sql_variant;
SET @description = N'Product descriptions in several languages.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductDescription';
SET @description = N'Primary key for ProductDescription records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductDescription', 'COLUMN', N'ProductDescriptionID';
SET @description = N'Description of the product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductDescription', 'COLUMN', N'Description';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductDescription', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductDescription', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductModel] (
    [ProductModelID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [CatalogDescription] nvarchar(4000) NULL,
    [Instructions] nvarchar(4000) NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductModel] PRIMARY KEY ([ProductModelID])
);
DECLARE @description AS sql_variant;
SET @description = N'Product model classification.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModel';
SET @description = N'Primary key for ProductModel records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'COLUMN', N'ProductModelID';
SET @description = N'Product model description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'COLUMN', N'Name';
SET @description = N'Detailed product catalog information in xml format.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'COLUMN', N'CatalogDescription';
SET @description = N'Manufacturing instructions in xml format.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'COLUMN', N'Instructions';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModel', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductPhoto] (
    [ProductPhotoID] int NOT NULL IDENTITY,
    [ThumbNailPhoto] varbinary(max) NULL,
    [ThumbnailPhotoFileName] nvarchar(50) NULL,
    [LargePhoto] varbinary(max) NULL,
    [LargePhotoFileName] nvarchar(50) NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductPhoto] PRIMARY KEY ([ProductPhotoID])
);
DECLARE @description AS sql_variant;
SET @description = N'Product images.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductPhoto';
SET @description = N'Primary key for ProductPhoto records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductPhoto', 'COLUMN', N'ProductPhotoID';
SET @description = N'Small image of the product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductPhoto', 'COLUMN', N'ThumbNailPhoto';
SET @description = N'Small image file name.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductPhoto', 'COLUMN', N'ThumbnailPhotoFileName';
SET @description = N'Large image of the product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductPhoto', 'COLUMN', N'LargePhoto';
SET @description = N'Large image file name.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductPhoto', 'COLUMN', N'LargePhotoFileName';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductPhoto', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[SalesReason] (
    [SalesReasonID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [ReasonType] nvarchar(50) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_SalesReason] PRIMARY KEY ([SalesReasonID])
);
DECLARE @description AS sql_variant;
SET @description = N'Lookup table of customer purchase reasons.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesReason';
SET @description = N'Primary key for SalesReason records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesReason', 'COLUMN', N'SalesReasonID';
SET @description = N'Sales reason description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesReason', 'COLUMN', N'Name';
SET @description = N'Category the sales reason belongs to.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesReason', 'COLUMN', N'ReasonType';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesReason', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ScrapReason] (
    [ScrapReasonID] smallint NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ScrapReason] PRIMARY KEY ([ScrapReasonID])
);
DECLARE @description AS sql_variant;
SET @description = N'Manufacturing failure reasons lookup table.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ScrapReason';
SET @description = N'Primary key for ScrapReason records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ScrapReason', 'COLUMN', N'ScrapReasonID';
SET @description = N'Failure description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ScrapReason', 'COLUMN', N'Name';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ScrapReason', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [HumanResources].[Shift] (
    [ShiftID] tinyint NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [StartTime] time NOT NULL,
    [EndTime] time NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Shift] PRIMARY KEY ([ShiftID])
);
DECLARE @description AS sql_variant;
SET @description = N'Work shift lookup table.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Shift';
SET @description = N'Primary key for Shift records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Shift', 'COLUMN', N'ShiftID';
SET @description = N'Shift description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Shift', 'COLUMN', N'Name';
SET @description = N'Shift start time.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Shift', 'COLUMN', N'StartTime';
SET @description = N'Shift end time.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Shift', 'COLUMN', N'EndTime';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Shift', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Purchasing].[ShipMethod] (
    [ShipMethodID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [ShipBase] money NOT NULL DEFAULT (((0.00))),
    [ShipRate] money NOT NULL DEFAULT (((0.00))),
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ShipMethod] PRIMARY KEY ([ShipMethodID])
);
DECLARE @description AS sql_variant;
SET @description = N'Shipping company lookup table.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ShipMethod';
SET @description = N'Primary key for ShipMethod records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ShipMethod', 'COLUMN', N'ShipMethodID';
SET @description = N'Shipping company name.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ShipMethod', 'COLUMN', N'Name';
SET @description = N'Minimum shipping charge.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ShipMethod', 'COLUMN', N'ShipBase';
SET @description = N'Shipping charge per pound.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ShipMethod', 'COLUMN', N'ShipRate';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ShipMethod', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ShipMethod', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[SpecialOffer] (
    [SpecialOfferID] int NOT NULL IDENTITY,
    [Description] nvarchar(255) NOT NULL,
    [DiscountPct] smallmoney NOT NULL DEFAULT (((0.00))),
    [Type] nvarchar(50) NOT NULL,
    [Category] nvarchar(50) NOT NULL,
    [StartDate] datetime NOT NULL,
    [EndDate] datetime NOT NULL,
    [MinQty] int NOT NULL,
    [MaxQty] int NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_SpecialOffer] PRIMARY KEY ([SpecialOfferID])
);
DECLARE @description AS sql_variant;
SET @description = N'Sale discounts lookup table.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer';
SET @description = N'Primary key for SpecialOffer records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'COLUMN', N'SpecialOfferID';
SET @description = N'Discount description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'COLUMN', N'Description';
SET @description = N'Discount precentage.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'COLUMN', N'DiscountPct';
SET @description = N'Discount type category.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'COLUMN', N'Type';
SET @description = N'Group the discount applies to such as Reseller or Customer.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'COLUMN', N'Category';
SET @description = N'Discount start date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'COLUMN', N'StartDate';
SET @description = N'Discount end date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'COLUMN', N'EndDate';
SET @description = N'Minimum discount percent allowed.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'COLUMN', N'MinQty';
SET @description = N'Maximum discount percent allowed.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'COLUMN', N'MaxQty';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOffer', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[TransactionHistoryArchive] (
    [TransactionID] int NOT NULL,
    [ProductID] int NOT NULL,
    [ReferenceOrderID] int NOT NULL,
    [ReferenceOrderLineID] int NOT NULL,
    [TransactionDate] datetime NOT NULL DEFAULT ((getdate())),
    [TransactionType] nchar(1) NOT NULL,
    [Quantity] int NOT NULL,
    [ActualCost] money NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_TransactionHistoryArchive_TransactionID] PRIMARY KEY ([TransactionID])
);
DECLARE @description AS sql_variant;
SET @description = N'Transactions for previous years.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive';
SET @description = N'Primary key for TransactionHistoryArchive records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'COLUMN', N'TransactionID';
SET @description = N'Product identification number. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'COLUMN', N'ProductID';
SET @description = N'Purchase order, sales order, or work order identification number.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'COLUMN', N'ReferenceOrderID';
SET @description = N'Line number associated with the purchase order, sales order, or work order.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'COLUMN', N'ReferenceOrderLineID';
SET @description = N'Date and time of the transaction.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'COLUMN', N'TransactionDate';
SET @description = N'W = Work Order, S = Sales Order, P = Purchase Order';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'COLUMN', N'TransactionType';
SET @description = N'Product quantity.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'COLUMN', N'Quantity';
SET @description = N'Product cost.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'COLUMN', N'ActualCost';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistoryArchive', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[UnitMeasure] (
    [UnitMeasureCode] nchar(3) NOT NULL,
    [Name] nvarchar(50) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_UnitMeasure_UnitMeasureCode] PRIMARY KEY ([UnitMeasureCode])
);
DECLARE @description AS sql_variant;
SET @description = N'Unit of measure lookup table.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'UnitMeasure';
SET @description = N'Primary key.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'UnitMeasure', 'COLUMN', N'UnitMeasureCode';
SET @description = N'Unit of measure description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'UnitMeasure', 'COLUMN', N'Name';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'UnitMeasure', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[Person] (
    [BusinessEntityID] int NOT NULL,
    [PersonType] nchar(2) NOT NULL,
    [NameStyle] bit NOT NULL,
    [Title] nvarchar(8) NULL,
    [FirstName] nvarchar(50) NOT NULL,
    [MiddleName] nvarchar(50) NULL,
    [LastName] nvarchar(50) NOT NULL,
    [Suffix] nvarchar(10) NULL,
    [EmailPromotion] int NOT NULL,
    [AdditionalContactInfo] nvarchar(4000) NULL,
    [Demographics] nvarchar(4000) NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Person_BusinessEntityID] PRIMARY KEY ([BusinessEntityID]),
    CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Human beings involved with AdventureWorks: employees, customer contacts, and vendor contacts.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person';
SET @description = N'Primary key for Person records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'BusinessEntityID';
SET @description = N'Primary type of person: SC = Store Contact, IN = Individual (retail) customer, SP = Sales person, EM = Employee (non-sales), VC = Vendor contact, GC = General contact';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'PersonType';
SET @description = N'0 = The data in FirstName and LastName are stored in western style (first name, last name) order.  1 = Eastern style (last name, first name) order.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'NameStyle';
SET @description = N'A courtesy title. For example, Mr. or Ms.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'Title';
SET @description = N'First name of the person.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'FirstName';
SET @description = N'Middle name or middle initial of the person.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'MiddleName';
SET @description = N'Last name of the person.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'LastName';
SET @description = N'Surname suffix. For example, Sr. or Jr.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'Suffix';
SET @description = N'0 = Contact does not wish to receive e-mail promotions, 1 = Contact does wish to receive e-mail promotions from AdventureWorks, 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'EmailPromotion';
SET @description = N'Additional contact information about the person stored in xml format. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'AdditionalContactInfo';
SET @description = N'Personal information such as hobbies, and income collected from online shoppers. Used for sales analysis.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'Demographics';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Person', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Purchasing].[Vendor] (
    [BusinessEntityID] int NOT NULL,
    [AccountNumber] nvarchar(15) NOT NULL,
    [Name] nvarchar(50) NOT NULL,
    [CreditRating] tinyint NOT NULL,
    [PreferredVendorStatus] bit NOT NULL DEFAULT (((1))),
    [ActiveFlag] bit NOT NULL DEFAULT (((1))),
    [PurchasingWebServiceURL] nvarchar(1024) NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Vendor_BusinessEntityID] PRIMARY KEY ([BusinessEntityID]),
    CONSTRAINT [FK_Vendor_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Companies from whom Adventure Works Cycles purchases parts or other goods.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor';
SET @description = N'Primary key for Vendor records.  Foreign key to BusinessEntity.BusinessEntityID';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'COLUMN', N'BusinessEntityID';
SET @description = N'Vendor account (identification) number.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'COLUMN', N'AccountNumber';
SET @description = N'Company name.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'COLUMN', N'Name';
SET @description = N'1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'COLUMN', N'CreditRating';
SET @description = N'0 = Do not use if another vendor is available. 1 = Preferred over other vendors supplying the same product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'COLUMN', N'PreferredVendorStatus';
SET @description = N'0 = Vendor no longer used. 1 = Vendor is actively used.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'COLUMN', N'ActiveFlag';
SET @description = N'Vendor URL.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'COLUMN', N'PurchasingWebServiceURL';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'Vendor', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[SalesTerritory] (
    [TerritoryID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [CountryRegionCode] nvarchar(3) NOT NULL,
    [Group] nvarchar(50) NOT NULL,
    [SalesYTD] money NOT NULL DEFAULT (((0.00))),
    [SalesLastYear] money NOT NULL DEFAULT (((0.00))),
    [CostYTD] money NOT NULL DEFAULT (((0.00))),
    [CostLastYear] money NOT NULL DEFAULT (((0.00))),
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY ([TerritoryID]),
    CONSTRAINT [FK_SalesTerritory_CountryRegion_CountryRegionCode] FOREIGN KEY ([CountryRegionCode]) REFERENCES [Person].[CountryRegion] ([CountryRegionCode])
);
DECLARE @description AS sql_variant;
SET @description = N'Sales territory lookup table.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory';
SET @description = N'Primary key for SalesTerritory records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'COLUMN', N'TerritoryID';
SET @description = N'Sales territory description';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'COLUMN', N'Name';
SET @description = N'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'COLUMN', N'CountryRegionCode';
SET @description = N'Geographic area to which the sales territory belong.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'COLUMN', N'Group';
SET @description = N'Sales in the territory year to date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'COLUMN', N'SalesYTD';
SET @description = N'Sales in the territory the previous year.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'COLUMN', N'SalesLastYear';
SET @description = N'Business costs in the territory year to date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'COLUMN', N'CostYTD';
SET @description = N'Business costs in the territory the previous year.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'COLUMN', N'CostLastYear';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritory', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[CountryRegionCurrency] (
    [CountryRegionCode] nvarchar(3) NOT NULL,
    [CurrencyCode] nchar(3) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode] PRIMARY KEY ([CountryRegionCode], [CurrencyCode]),
    CONSTRAINT [FK_CountryRegionCurrency_CountryRegion_CountryRegionCode] FOREIGN KEY ([CountryRegionCode]) REFERENCES [Person].[CountryRegion] ([CountryRegionCode]),
    CONSTRAINT [FK_CountryRegionCurrency_Currency_CurrencyCode] FOREIGN KEY ([CurrencyCode]) REFERENCES [Sales].[Currency] ([CurrencyCode])
);
DECLARE @description AS sql_variant;
SET @description = N'Cross-reference table mapping ISO currency codes to a country or region.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CountryRegionCurrency';
SET @description = N'ISO code for countries and regions. Foreign key to CountryRegion.CountryRegionCode.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CountryRegionCurrency', 'COLUMN', N'CountryRegionCode';
SET @description = N'ISO standard currency code. Foreign key to Currency.CurrencyCode.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CountryRegionCurrency', 'COLUMN', N'CurrencyCode';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CountryRegionCurrency', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[CurrencyRate] (
    [CurrencyRateID] int NOT NULL IDENTITY,
    [CurrencyRateDate] datetime NOT NULL,
    [FromCurrencyCode] nchar(3) NOT NULL,
    [ToCurrencyCode] nchar(3) NOT NULL,
    [AverageRate] money NOT NULL,
    [EndOfDayRate] money NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_CurrencyRate] PRIMARY KEY ([CurrencyRateID]),
    CONSTRAINT [FK_CurrencyRate_Currency_FromCurrencyCode] FOREIGN KEY ([FromCurrencyCode]) REFERENCES [Sales].[Currency] ([CurrencyCode]),
    CONSTRAINT [FK_CurrencyRate_Currency_ToCurrencyCode] FOREIGN KEY ([ToCurrencyCode]) REFERENCES [Sales].[Currency] ([CurrencyCode])
);
DECLARE @description AS sql_variant;
SET @description = N'Currency exchange rates.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate';
SET @description = N'Primary key for CurrencyRate records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'COLUMN', N'CurrencyRateID';
SET @description = N'Date and time the exchange rate was obtained.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'COLUMN', N'CurrencyRateDate';
SET @description = N'Exchange rate was converted from this currency code.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'COLUMN', N'FromCurrencyCode';
SET @description = N'Exchange rate was converted to this currency code.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'COLUMN', N'ToCurrencyCode';
SET @description = N'Average exchange rate for the day.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'COLUMN', N'AverageRate';
SET @description = N'Final exchange rate for the day.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'COLUMN', N'EndOfDayRate';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'CurrencyRate', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductSubcategory] (
    [ProductSubcategoryID] int NOT NULL IDENTITY,
    [ProductCategoryID] int NOT NULL,
    [Name] nvarchar(50) NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductSubcategory] PRIMARY KEY ([ProductSubcategoryID]),
    CONSTRAINT [FK_ProductSubcategory_ProductCategory_ProductCategoryID] FOREIGN KEY ([ProductCategoryID]) REFERENCES [Production].[ProductCategory] ([ProductCategoryID])
);
DECLARE @description AS sql_variant;
SET @description = N'Product subcategories. See ProductCategory table.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory';
SET @description = N'Primary key for ProductSubcategory records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'COLUMN', N'ProductSubcategoryID';
SET @description = N'Product category identification number. Foreign key to ProductCategory.ProductCategoryID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'COLUMN', N'ProductCategoryID';
SET @description = N'Subcategory description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'COLUMN', N'Name';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductSubcategory', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductModelIllustration] (
    [ProductModelID] int NOT NULL,
    [IllustrationID] int NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductModelIllustration_ProductModelID_IllustrationID] PRIMARY KEY ([ProductModelID], [IllustrationID]),
    CONSTRAINT [FK_ProductModelIllustration_Illustration_IllustrationID] FOREIGN KEY ([IllustrationID]) REFERENCES [Production].[Illustration] ([IllustrationID]),
    CONSTRAINT [FK_ProductModelIllustration_ProductModel_ProductModelID] FOREIGN KEY ([ProductModelID]) REFERENCES [Production].[ProductModel] ([ProductModelID])
);
DECLARE @description AS sql_variant;
SET @description = N'Cross-reference table mapping product models and illustrations.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModelIllustration';
SET @description = N'Primary key. Foreign key to ProductModel.ProductModelID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModelIllustration', 'COLUMN', N'ProductModelID';
SET @description = N'Primary key. Foreign key to Illustration.IllustrationID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModelIllustration', 'COLUMN', N'IllustrationID';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModelIllustration', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductModelProductDescriptionCulture] (
    [ProductModelID] int NOT NULL,
    [ProductDescriptionID] int NOT NULL,
    [CultureID] nchar(6) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID] PRIMARY KEY ([ProductModelID], [ProductDescriptionID], [CultureID]),
    CONSTRAINT [FK_ProductModelProductDescriptionCulture_Culture_CultureID] FOREIGN KEY ([CultureID]) REFERENCES [Production].[Culture] ([CultureID]),
    CONSTRAINT [FK_ProductModelProductDescriptionCulture_ProductDescription_ProductDescriptionID] FOREIGN KEY ([ProductDescriptionID]) REFERENCES [Production].[ProductDescription] ([ProductDescriptionID]),
    CONSTRAINT [FK_ProductModelProductDescriptionCulture_ProductModel_ProductModelID] FOREIGN KEY ([ProductModelID]) REFERENCES [Production].[ProductModel] ([ProductModelID])
);
DECLARE @description AS sql_variant;
SET @description = N'Cross-reference table mapping product descriptions and the language the description is written in.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModelProductDescriptionCulture';
SET @description = N'Primary key. Foreign key to ProductModel.ProductModelID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModelProductDescriptionCulture', 'COLUMN', N'ProductModelID';
SET @description = N'Primary key. Foreign key to ProductDescription.ProductDescriptionID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModelProductDescriptionCulture', 'COLUMN', N'ProductDescriptionID';
SET @description = N'Culture identification number. Foreign key to Culture.CultureID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModelProductDescriptionCulture', 'COLUMN', N'CultureID';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductModelProductDescriptionCulture', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[BusinessEntityContact] (
    [BusinessEntityID] int NOT NULL,
    [PersonID] int NOT NULL,
    [ContactTypeID] int NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID] PRIMARY KEY ([BusinessEntityID], [PersonID], [ContactTypeID]),
    CONSTRAINT [FK_BusinessEntityContact_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID]),
    CONSTRAINT [FK_BusinessEntityContact_ContactType_ContactTypeID] FOREIGN KEY ([ContactTypeID]) REFERENCES [Person].[ContactType] ([ContactTypeID]),
    CONSTRAINT [FK_BusinessEntityContact_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person].[Person] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Cross-reference table mapping stores, vendors, and employees to people';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityContact';
SET @description = N'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityContact', 'COLUMN', N'BusinessEntityID';
SET @description = N'Primary key. Foreign key to Person.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityContact', 'COLUMN', N'PersonID';
SET @description = N'Primary key.  Foreign key to ContactType.ContactTypeID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityContact', 'COLUMN', N'ContactTypeID';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityContact', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityContact', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[EmailAddress] (
    [BusinessEntityID] int NOT NULL,
    [EmailAddressID] int NOT NULL IDENTITY,
    [EmailAddress] nvarchar(50) NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_EmailAddress_BusinessEntityID_EmailAddressID] PRIMARY KEY ([BusinessEntityID], [EmailAddressID]),
    CONSTRAINT [FK_EmailAddress_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Where to send a person email.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'EmailAddress';
SET @description = N'Primary key. Person associated with this email address.  Foreign key to Person.BusinessEntityID';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'EmailAddress', 'COLUMN', N'BusinessEntityID';
SET @description = N'Primary key. ID of this email address.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'EmailAddress', 'COLUMN', N'EmailAddressID';
SET @description = N'E-mail address for the person.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'EmailAddress', 'COLUMN', N'EmailAddress';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'EmailAddress', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'EmailAddress', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [HumanResources].[Employee] (
    [BusinessEntityID] int NOT NULL,
    [NationalIDNumber] nvarchar(15) NOT NULL,
    [LoginID] nvarchar(256) NOT NULL,
    [OrganizationLevel] smallint NULL,
    [JobTitle] nvarchar(50) NOT NULL,
    [BirthDate] date NOT NULL,
    [MaritalStatus] nchar(1) NOT NULL,
    [Gender] nchar(1) NOT NULL,
    [HireDate] date NOT NULL,
    [SalariedFlag] bit NOT NULL DEFAULT (((1))),
    [VacationHours] smallint NOT NULL,
    [SickLeaveHours] smallint NOT NULL,
    [CurrentFlag] bit NOT NULL DEFAULT (((1))),
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Employee_BusinessEntityID] PRIMARY KEY ([BusinessEntityID]),
    CONSTRAINT [FK_Employee_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Employee information such as salary, department, and title.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee';
SET @description = N'Primary key for Employee records.  Foreign key to BusinessEntity.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'BusinessEntityID';
SET @description = N'Unique national identification number such as a social security number.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'NationalIDNumber';
SET @description = N'Network login.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'LoginID';
SET @description = N'The depth of the employee in the corporate hierarchy.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'OrganizationLevel';
SET @description = N'Work title such as Buyer or Sales Representative.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'JobTitle';
SET @description = N'Date of birth.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'BirthDate';
SET @description = N'M = Married, S = Single';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'MaritalStatus';
SET @description = N'M = Male, F = Female';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'Gender';
SET @description = N'Employee hired on this date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'HireDate';
SET @description = N'Job classification. 0 = Hourly, not exempt from collective bargaining. 1 = Salaried, exempt from collective bargaining.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'SalariedFlag';
SET @description = N'Number of available vacation hours.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'VacationHours';
SET @description = N'Number of available sick leave hours.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'SickLeaveHours';
SET @description = N'0 = Inactive, 1 = Active';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'CurrentFlag';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'Employee', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[Password] (
    [BusinessEntityID] int NOT NULL,
    [PasswordHash] varchar(128) NOT NULL,
    [PasswordSalt] varchar(10) NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Password_BusinessEntityID] PRIMARY KEY ([BusinessEntityID]),
    CONSTRAINT [FK_Password_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'One way hashed authentication information';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Password';
SET @description = N'Password for the e-mail account.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Password', 'COLUMN', N'PasswordHash';
SET @description = N'Random value concatenated with the password string before the password is hashed.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Password', 'COLUMN', N'PasswordSalt';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Password', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Password', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[PersonCreditCard] (
    [BusinessEntityID] int NOT NULL,
    [CreditCardID] int NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_PersonCreditCard_BusinessEntityID_CreditCardID] PRIMARY KEY ([BusinessEntityID], [CreditCardID]),
    CONSTRAINT [FK_PersonCreditCard_CreditCard_CreditCardID] FOREIGN KEY ([CreditCardID]) REFERENCES [Sales].[CreditCard] ([CreditCardID]),
    CONSTRAINT [FK_PersonCreditCard_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Cross-reference table mapping people to their credit card information in the CreditCard table. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'PersonCreditCard';
SET @description = N'Business entity identification number. Foreign key to Person.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'PersonCreditCard', 'COLUMN', N'BusinessEntityID';
SET @description = N'Credit card identification number. Foreign key to CreditCard.CreditCardID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'PersonCreditCard', 'COLUMN', N'CreditCardID';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'PersonCreditCard', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[PersonPhone] (
    [BusinessEntityID] int NOT NULL,
    [PhoneNumber] nvarchar(25) NOT NULL,
    [PhoneNumberTypeID] int NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID] PRIMARY KEY ([BusinessEntityID], [PhoneNumber], [PhoneNumberTypeID]),
    CONSTRAINT [FK_PersonPhone_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID]),
    CONSTRAINT [FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID] FOREIGN KEY ([PhoneNumberTypeID]) REFERENCES [Person].[PhoneNumberType] ([PhoneNumberTypeID])
);
DECLARE @description AS sql_variant;
SET @description = N'Telephone number and type of a person.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'PersonPhone';
SET @description = N'Business entity identification number. Foreign key to Person.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'PersonPhone', 'COLUMN', N'BusinessEntityID';
SET @description = N'Telephone number identification number.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'PersonPhone', 'COLUMN', N'PhoneNumber';
SET @description = N'Kind of phone number. Foreign key to PhoneNumberType.PhoneNumberTypeID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'PersonPhone', 'COLUMN', N'PhoneNumberTypeID';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'PersonPhone', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[StateProvince] (
    [StateProvinceID] int NOT NULL IDENTITY,
    [StateProvinceCode] nchar(3) NOT NULL,
    [CountryRegionCode] nvarchar(3) NOT NULL,
    [IsOnlyStateProvinceFlag] bit NOT NULL DEFAULT (((1))),
    [Name] nvarchar(50) NOT NULL,
    [TerritoryID] int NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_StateProvince] PRIMARY KEY ([StateProvinceID]),
    CONSTRAINT [FK_StateProvince_CountryRegion_CountryRegionCode] FOREIGN KEY ([CountryRegionCode]) REFERENCES [Person].[CountryRegion] ([CountryRegionCode]),
    CONSTRAINT [FK_StateProvince_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
);
DECLARE @description AS sql_variant;
SET @description = N'State and province lookup table.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'StateProvince';
SET @description = N'Primary key for StateProvince records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'COLUMN', N'StateProvinceID';
SET @description = N'ISO standard state or province code.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'COLUMN', N'StateProvinceCode';
SET @description = N'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'COLUMN', N'CountryRegionCode';
SET @description = N'0 = StateProvinceCode exists. 1 = StateProvinceCode unavailable, using CountryRegionCode.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'COLUMN', N'IsOnlyStateProvinceFlag';
SET @description = N'State or province description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'COLUMN', N'Name';
SET @description = N'ID of the territory in which the state or province is located. Foreign key to SalesTerritory.SalesTerritoryID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'COLUMN', N'TerritoryID';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'StateProvince', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[Product] (
    [ProductID] int NOT NULL IDENTITY,
    [Name] nvarchar(50) NOT NULL,
    [ProductNumber] nvarchar(25) NOT NULL,
    [MakeFlag] bit NOT NULL DEFAULT (((1))),
    [FinishedGoodsFlag] bit NOT NULL DEFAULT (((1))),
    [Color] nvarchar(15) NULL,
    [SafetyStockLevel] smallint NOT NULL,
    [ReorderPoint] smallint NOT NULL,
    [StandardCost] money NOT NULL,
    [ListPrice] money NOT NULL,
    [Size] nvarchar(5) NULL,
    [SizeUnitMeasureCode] nchar(3) NULL,
    [WeightUnitMeasureCode] nchar(3) NULL,
    [Weight] decimal(8,2) NULL,
    [DaysToManufacture] int NOT NULL,
    [ProductLine] nchar(2) NULL,
    [Class] nchar(2) NULL,
    [Style] nchar(2) NULL,
    [ProductSubcategoryID] int NULL,
    [ProductModelID] int NULL,
    [SellStartDate] datetime NOT NULL,
    [SellEndDate] datetime NULL,
    [DiscontinuedDate] datetime NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Product] PRIMARY KEY ([ProductID]),
    CONSTRAINT [FK_Product_ProductModel_ProductModelID] FOREIGN KEY ([ProductModelID]) REFERENCES [Production].[ProductModel] ([ProductModelID]),
    CONSTRAINT [FK_Product_ProductSubcategory_ProductSubcategoryID] FOREIGN KEY ([ProductSubcategoryID]) REFERENCES [Production].[ProductSubcategory] ([ProductSubcategoryID]),
    CONSTRAINT [FK_Product_UnitMeasure_SizeUnitMeasureCode] FOREIGN KEY ([SizeUnitMeasureCode]) REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode]),
    CONSTRAINT [FK_Product_UnitMeasure_WeightUnitMeasureCode] FOREIGN KEY ([WeightUnitMeasureCode]) REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
);
DECLARE @description AS sql_variant;
SET @description = N'Products sold or used in the manfacturing of sold products.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product';
SET @description = N'Primary key for Product records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'ProductID';
SET @description = N'Name of the product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'Name';
SET @description = N'Unique product identification number.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'ProductNumber';
SET @description = N'0 = Product is purchased, 1 = Product is manufactured in-house.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'MakeFlag';
SET @description = N'0 = Product is not a salable item. 1 = Product is salable.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'FinishedGoodsFlag';
SET @description = N'Product color.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'Color';
SET @description = N'Minimum inventory quantity. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'SafetyStockLevel';
SET @description = N'Inventory level that triggers a purchase order or work order. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'ReorderPoint';
SET @description = N'Standard cost of the product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'StandardCost';
SET @description = N'Selling price.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'ListPrice';
SET @description = N'Product size.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'Size';
SET @description = N'Unit of measure for Size column.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'SizeUnitMeasureCode';
SET @description = N'Unit of measure for Weight column.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'WeightUnitMeasureCode';
SET @description = N'Product weight.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'Weight';
SET @description = N'Number of days required to manufacture the product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'DaysToManufacture';
SET @description = N'R = Road, M = Mountain, T = Touring, S = Standard';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'ProductLine';
SET @description = N'H = High, M = Medium, L = Low';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'Class';
SET @description = N'W = Womens, M = Mens, U = Universal';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'Style';
SET @description = N'Product is a member of this product subcategory. Foreign key to ProductSubCategory.ProductSubCategoryID. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'ProductSubcategoryID';
SET @description = N'Product is a member of this product model. Foreign key to ProductModel.ProductModelID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'ProductModelID';
SET @description = N'Date the product was available for sale.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'SellStartDate';
SET @description = N'Date the product was no longer available for sale.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'SellEndDate';
SET @description = N'Date the product was discontinued.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'DiscontinuedDate';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'Product', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [HumanResources].[EmployeeDepartmentHistory] (
    [BusinessEntityID] int NOT NULL,
    [DepartmentID] smallint NOT NULL,
    [ShiftID] tinyint NOT NULL,
    [StartDate] date NOT NULL,
    [EndDate] date NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID] PRIMARY KEY ([BusinessEntityID], [StartDate], [DepartmentID], [ShiftID]),
    CONSTRAINT [FK_EmployeeDepartmentHistory_Department_DepartmentID] FOREIGN KEY ([DepartmentID]) REFERENCES [HumanResources].[Department] ([DepartmentID]),
    CONSTRAINT [FK_EmployeeDepartmentHistory_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID]),
    CONSTRAINT [FK_EmployeeDepartmentHistory_Shift_ShiftID] FOREIGN KEY ([ShiftID]) REFERENCES [HumanResources].[Shift] ([ShiftID])
);
DECLARE @description AS sql_variant;
SET @description = N'Employee department transfers.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory';
SET @description = N'Employee identification number. Foreign key to Employee.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'COLUMN', N'BusinessEntityID';
SET @description = N'Department in which the employee worked including currently. Foreign key to Department.DepartmentID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'COLUMN', N'DepartmentID';
SET @description = N'Identifies which 8-hour shift the employee works. Foreign key to Shift.Shift.ID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'COLUMN', N'ShiftID';
SET @description = N'Date the employee started work in the department.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'COLUMN', N'StartDate';
SET @description = N'Date the employee left the department. NULL = Current department.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'COLUMN', N'EndDate';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeeDepartmentHistory', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [HumanResources].[EmployeePayHistory] (
    [BusinessEntityID] int NOT NULL,
    [RateChangeDate] datetime NOT NULL,
    [Rate] money NOT NULL,
    [PayFrequency] tinyint NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_EmployeePayHistory_BusinessEntityID_RateChangeDate] PRIMARY KEY ([BusinessEntityID], [RateChangeDate]),
    CONSTRAINT [FK_EmployeePayHistory_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Employee pay history.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory';
SET @description = N'Employee identification number. Foreign key to Employee.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory', 'COLUMN', N'BusinessEntityID';
SET @description = N'Date the change in pay is effective';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory', 'COLUMN', N'RateChangeDate';
SET @description = N'Salary hourly rate.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory', 'COLUMN', N'Rate';
SET @description = N'1 = Salary received monthly, 2 = Salary received biweekly';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory', 'COLUMN', N'PayFrequency';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'EmployeePayHistory', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [HumanResources].[JobCandidate] (
    [JobCandidateID] int NOT NULL IDENTITY,
    [BusinessEntityID] int NULL,
    [Resume] nvarchar(4000) NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_JobCandidate] PRIMARY KEY ([JobCandidateID]),
    CONSTRAINT [FK_JobCandidate_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Résumés submitted to Human Resources by job applicants.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate';
SET @description = N'Primary key for JobCandidate records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'COLUMN', N'JobCandidateID';
SET @description = N'Employee identification number if applicant was hired. Foreign key to Employee.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'COLUMN', N'BusinessEntityID';
SET @description = N'Résumé in XML format.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'COLUMN', N'Resume';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'HumanResources', 'TABLE', N'JobCandidate', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Purchasing].[PurchaseOrderHeader] (
    [PurchaseOrderID] int NOT NULL IDENTITY,
    [RevisionNumber] tinyint NOT NULL,
    [Status] tinyint NOT NULL DEFAULT (((1))),
    [EmployeeID] int NOT NULL,
    [VendorID] int NOT NULL,
    [ShipMethodID] int NOT NULL,
    [OrderDate] datetime NOT NULL DEFAULT ((getdate())),
    [ShipDate] datetime NULL,
    [SubTotal] money NOT NULL DEFAULT (((0.00))),
    [TaxAmt] money NOT NULL DEFAULT (((0.00))),
    [Freight] money NOT NULL DEFAULT (((0.00))),
    [TotalDue] AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))) PERSISTED,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_PurchaseOrderHeader_PurchaseOrderID] PRIMARY KEY ([PurchaseOrderID]),
    CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID]),
    CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY ([ShipMethodID]) REFERENCES [Purchasing].[ShipMethod] ([ShipMethodID]),
    CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID] FOREIGN KEY ([VendorID]) REFERENCES [Purchasing].[Vendor] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'General purchase order information. See PurchaseOrderDetail.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader';
SET @description = N'Primary key.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'PurchaseOrderID';
SET @description = N'Incremental number to track changes to the purchase order over time.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'RevisionNumber';
SET @description = N'Order current status. 1 = Pending; 2 = Approved; 3 = Rejected; 4 = Complete';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'Status';
SET @description = N'Employee who created the purchase order. Foreign key to Employee.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'EmployeeID';
SET @description = N'Vendor with whom the purchase order is placed. Foreign key to Vendor.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'VendorID';
SET @description = N'Shipping method. Foreign key to ShipMethod.ShipMethodID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'ShipMethodID';
SET @description = N'Purchase order creation date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'OrderDate';
SET @description = N'Estimated shipment date from the vendor.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'ShipDate';
SET @description = N'Purchase order subtotal. Computed as SUM(PurchaseOrderDetail.LineTotal)for the appropriate PurchaseOrderID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'SubTotal';
SET @description = N'Tax amount.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'TaxAmt';
SET @description = N'Shipping cost.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'Freight';
SET @description = N'Total due to vendor. Computed as Subtotal + TaxAmt + Freight.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'TotalDue';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderHeader', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[SalesPerson] (
    [BusinessEntityID] int NOT NULL,
    [TerritoryID] int NULL,
    [SalesQuota] money NULL,
    [Bonus] money NOT NULL DEFAULT (((0.00))),
    [CommissionPct] smallmoney NOT NULL DEFAULT (((0.00))),
    [SalesYTD] money NOT NULL DEFAULT (((0.00))),
    [SalesLastYear] money NOT NULL DEFAULT (((0.00))),
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_SalesPerson_BusinessEntityID] PRIMARY KEY ([BusinessEntityID]),
    CONSTRAINT [FK_SalesPerson_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID]),
    CONSTRAINT [FK_SalesPerson_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
);
DECLARE @description AS sql_variant;
SET @description = N'Sales representative current information.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson';
SET @description = N'Primary key for SalesPerson records. Foreign key to Employee.BusinessEntityID';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'COLUMN', N'BusinessEntityID';
SET @description = N'Territory currently assigned to. Foreign key to SalesTerritory.SalesTerritoryID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'COLUMN', N'TerritoryID';
SET @description = N'Projected yearly sales.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'COLUMN', N'SalesQuota';
SET @description = N'Bonus due if quota is met.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'COLUMN', N'Bonus';
SET @description = N'Commision percent received per sale.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'COLUMN', N'CommissionPct';
SET @description = N'Sales total year to date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'COLUMN', N'SalesYTD';
SET @description = N'Sales total of previous year.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'COLUMN', N'SalesLastYear';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPerson', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[Address] (
    [AddressID] int NOT NULL IDENTITY,
    [AddressLine1] nvarchar(60) NOT NULL,
    [AddressLine2] nvarchar(60) NULL,
    [City] nvarchar(30) NOT NULL,
    [StateProvinceID] int NOT NULL,
    [PostalCode] nvarchar(15) NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Address] PRIMARY KEY ([AddressID]),
    CONSTRAINT [FK_Address_StateProvince_StateProvinceID] FOREIGN KEY ([StateProvinceID]) REFERENCES [Person].[StateProvince] ([StateProvinceID])
);
DECLARE @description AS sql_variant;
SET @description = N'Street address information for customers, employees, and vendors.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Address';
SET @description = N'Primary key for Address records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Address', 'COLUMN', N'AddressID';
SET @description = N'First street address line.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Address', 'COLUMN', N'AddressLine1';
SET @description = N'Second street address line.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Address', 'COLUMN', N'AddressLine2';
SET @description = N'Name of the city.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Address', 'COLUMN', N'City';
SET @description = N'Unique identification number for the state or province. Foreign key to StateProvince table.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Address', 'COLUMN', N'StateProvinceID';
SET @description = N'Postal code for the street address.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Address', 'COLUMN', N'PostalCode';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Address', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'Address', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[SalesTaxRate] (
    [SalesTaxRateID] int NOT NULL IDENTITY,
    [StateProvinceID] int NOT NULL,
    [TaxType] tinyint NOT NULL,
    [TaxRate] smallmoney NOT NULL DEFAULT (((0.00))),
    [Name] nvarchar(50) NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_SalesTaxRate] PRIMARY KEY ([SalesTaxRateID]),
    CONSTRAINT [FK_SalesTaxRate_StateProvince_StateProvinceID] FOREIGN KEY ([StateProvinceID]) REFERENCES [Person].[StateProvince] ([StateProvinceID])
);
DECLARE @description AS sql_variant;
SET @description = N'Tax rate lookup table.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate';
SET @description = N'Primary key for SalesTaxRate records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'COLUMN', N'SalesTaxRateID';
SET @description = N'State, province, or country/region the sales tax applies to.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'COLUMN', N'StateProvinceID';
SET @description = N'1 = Tax applied to retail transactions, 2 = Tax applied to wholesale transactions, 3 = Tax applied to all sales (retail and wholesale) transactions.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'COLUMN', N'TaxType';
SET @description = N'Tax rate amount.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'COLUMN', N'TaxRate';
SET @description = N'Tax rate description.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'COLUMN', N'Name';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTaxRate', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[BillOfMaterials] (
    [BillOfMaterialsID] int NOT NULL IDENTITY,
    [ProductAssemblyID] int NULL,
    [ComponentID] int NOT NULL,
    [StartDate] datetime NOT NULL DEFAULT ((getdate())),
    [EndDate] datetime NULL,
    [UnitMeasureCode] nchar(3) NOT NULL,
    [BOMLevel] smallint NOT NULL,
    [PerAssemblyQty] decimal(8,2) NOT NULL DEFAULT (((1.00))),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_BillOfMaterials_BillOfMaterialsID] PRIMARY KEY NONCLUSTERED ([BillOfMaterialsID]),
    CONSTRAINT [FK_BillOfMaterials_Product_ComponentID] FOREIGN KEY ([ComponentID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_BillOfMaterials_Product_ProductAssemblyID] FOREIGN KEY ([ProductAssemblyID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_BillOfMaterials_UnitMeasure_UnitMeasureCode] FOREIGN KEY ([UnitMeasureCode]) REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
);
DECLARE @description AS sql_variant;
SET @description = N'Items required to make bicycles and bicycle subassemblies. It identifies the heirarchical relationship between a parent product and its components.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials';
SET @description = N'Primary key for BillOfMaterials records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'COLUMN', N'BillOfMaterialsID';
SET @description = N'Parent product identification number. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'COLUMN', N'ProductAssemblyID';
SET @description = N'Component identification number. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'COLUMN', N'ComponentID';
SET @description = N'Date the component started being used in the assembly item.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'COLUMN', N'StartDate';
SET @description = N'Date the component stopped being used in the assembly item.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'COLUMN', N'EndDate';
SET @description = N'Standard code identifying the unit of measure for the quantity.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'COLUMN', N'UnitMeasureCode';
SET @description = N'Indicates the depth the component is from its parent (AssemblyID).';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'COLUMN', N'BOMLevel';
SET @description = N'Quantity of the component needed to create the assembly.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'COLUMN', N'PerAssemblyQty';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'BillOfMaterials', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductCostHistory] (
    [ProductID] int NOT NULL,
    [StartDate] datetime NOT NULL,
    [EndDate] datetime NULL,
    [StandardCost] money NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductCostHistory_ProductID_StartDate] PRIMARY KEY ([ProductID], [StartDate]),
    CONSTRAINT [FK_ProductCostHistory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID])
);
DECLARE @description AS sql_variant;
SET @description = N'Changes in the cost of a product over time.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory';
SET @description = N'Product identification number. Foreign key to Product.ProductID';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory', 'COLUMN', N'ProductID';
SET @description = N'Product cost start date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory', 'COLUMN', N'StartDate';
SET @description = N'Product cost end date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory', 'COLUMN', N'EndDate';
SET @description = N'Standard cost of the product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory', 'COLUMN', N'StandardCost';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductCostHistory', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductInventory] (
    [ProductID] int NOT NULL,
    [LocationID] smallint NOT NULL,
    [Shelf] nvarchar(10) NOT NULL,
    [Bin] tinyint NOT NULL,
    [Quantity] smallint NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductInventory_ProductID_LocationID] PRIMARY KEY ([ProductID], [LocationID]),
    CONSTRAINT [FK_ProductInventory_Location_LocationID] FOREIGN KEY ([LocationID]) REFERENCES [Production].[Location] ([LocationID]),
    CONSTRAINT [FK_ProductInventory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID])
);
DECLARE @description AS sql_variant;
SET @description = N'Product inventory information.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductInventory';
SET @description = N'Product identification number. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'COLUMN', N'ProductID';
SET @description = N'Inventory location identification number. Foreign key to Location.LocationID. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'COLUMN', N'LocationID';
SET @description = N'Storage compartment within an inventory location.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'COLUMN', N'Shelf';
SET @description = N'Storage container on a shelf in an inventory location.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'COLUMN', N'Bin';
SET @description = N'Quantity of products in the inventory location.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'COLUMN', N'Quantity';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductInventory', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductListPriceHistory] (
    [ProductID] int NOT NULL,
    [StartDate] datetime NOT NULL,
    [EndDate] datetime NULL,
    [ListPrice] money NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductListPriceHistory_ProductID_StartDate] PRIMARY KEY ([ProductID], [StartDate]),
    CONSTRAINT [FK_ProductListPriceHistory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID])
);
DECLARE @description AS sql_variant;
SET @description = N'Changes in the list price of a product over time.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory';
SET @description = N'Product identification number. Foreign key to Product.ProductID';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory', 'COLUMN', N'ProductID';
SET @description = N'List price start date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory', 'COLUMN', N'StartDate';
SET @description = N'List price end date';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory', 'COLUMN', N'EndDate';
SET @description = N'Product list price.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory', 'COLUMN', N'ListPrice';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductListPriceHistory', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductProductPhoto] (
    [ProductID] int NOT NULL,
    [ProductPhotoID] int NOT NULL,
    [Primary] bit NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductProductPhoto_ProductID_ProductPhotoID] PRIMARY KEY NONCLUSTERED ([ProductID], [ProductPhotoID]),
    CONSTRAINT [FK_ProductProductPhoto_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_ProductProductPhoto_ProductPhoto_ProductPhotoID] FOREIGN KEY ([ProductPhotoID]) REFERENCES [Production].[ProductPhoto] ([ProductPhotoID])
);
DECLARE @description AS sql_variant;
SET @description = N'Cross-reference table mapping products and product photos.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto';
SET @description = N'Product identification number. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto', 'COLUMN', N'ProductID';
SET @description = N'Product photo identification number. Foreign key to ProductPhoto.ProductPhotoID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto', 'COLUMN', N'ProductPhotoID';
SET @description = N'0 = Photo is not the principal image. 1 = Photo is the principal image.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto', 'COLUMN', N'Primary';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductProductPhoto', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[ProductReview] (
    [ProductReviewID] int NOT NULL IDENTITY,
    [ProductID] int NOT NULL,
    [ReviewerName] nvarchar(50) NOT NULL,
    [ReviewDate] datetime NOT NULL DEFAULT ((getdate())),
    [EmailAddress] nvarchar(50) NOT NULL,
    [Rating] int NOT NULL,
    [Comments] nvarchar(3850) NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductReview] PRIMARY KEY ([ProductReviewID]),
    CONSTRAINT [FK_ProductReview_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID])
);
DECLARE @description AS sql_variant;
SET @description = N'Customer reviews of products they have purchased.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductReview';
SET @description = N'Primary key for ProductReview records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'COLUMN', N'ProductReviewID';
SET @description = N'Product identification number. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'COLUMN', N'ProductID';
SET @description = N'Name of the reviewer.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'COLUMN', N'ReviewerName';
SET @description = N'Date review was submitted.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'COLUMN', N'ReviewDate';
SET @description = N'Reviewer''s e-mail address.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'COLUMN', N'EmailAddress';
SET @description = N'Product rating given by the reviewer. Scale is 1 to 5 with 5 as the highest rating.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'COLUMN', N'Rating';
SET @description = N'Reviewer''s comments';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'COLUMN', N'Comments';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'ProductReview', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Purchasing].[ProductVendor] (
    [ProductID] int NOT NULL,
    [BusinessEntityID] int NOT NULL,
    [AverageLeadTime] int NOT NULL,
    [StandardPrice] money NOT NULL,
    [LastReceiptCost] money NULL,
    [LastReceiptDate] datetime NULL,
    [MinOrderQty] int NOT NULL,
    [MaxOrderQty] int NOT NULL,
    [OnOrderQty] int NULL,
    [UnitMeasureCode] nchar(3) NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ProductVendor_ProductID_BusinessEntityID] PRIMARY KEY ([ProductID], [BusinessEntityID]),
    CONSTRAINT [FK_ProductVendor_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_ProductVendor_UnitMeasure_UnitMeasureCode] FOREIGN KEY ([UnitMeasureCode]) REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode]),
    CONSTRAINT [FK_ProductVendor_Vendor_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Purchasing].[Vendor] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Cross-reference table mapping vendors with the products they supply.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor';
SET @description = N'Primary key. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'COLUMN', N'ProductID';
SET @description = N'Primary key. Foreign key to Vendor.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'COLUMN', N'BusinessEntityID';
SET @description = N'The average span of time (in days) between placing an order with the vendor and receiving the purchased product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'COLUMN', N'AverageLeadTime';
SET @description = N'The vendor''s usual selling price.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'COLUMN', N'StandardPrice';
SET @description = N'The selling price when last purchased.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'COLUMN', N'LastReceiptCost';
SET @description = N'Date the product was last received by the vendor.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'COLUMN', N'LastReceiptDate';
SET @description = N'The maximum quantity that should be ordered.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'COLUMN', N'MinOrderQty';
SET @description = N'The minimum quantity that should be ordered.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'COLUMN', N'MaxOrderQty';
SET @description = N'The quantity currently on order.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'COLUMN', N'OnOrderQty';
SET @description = N'The product''s unit of measure.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'COLUMN', N'UnitMeasureCode';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'ProductVendor', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[ShoppingCartItem] (
    [ShoppingCartItemID] int NOT NULL IDENTITY,
    [ShoppingCartID] nvarchar(50) NOT NULL,
    [Quantity] int NOT NULL DEFAULT (((1))),
    [ProductID] int NOT NULL,
    [DateCreated] datetime NOT NULL DEFAULT ((getdate())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_ShoppingCartItem] PRIMARY KEY ([ShoppingCartItemID]),
    CONSTRAINT [FK_ShoppingCartItem_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID])
);
DECLARE @description AS sql_variant;
SET @description = N'Contains online customer orders until the order is submitted or cancelled.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'ShoppingCartItem';
SET @description = N'Primary key for ShoppingCartItem records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'ShoppingCartItem', 'COLUMN', N'ShoppingCartItemID';
SET @description = N'Shopping cart identification number.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'ShoppingCartItem', 'COLUMN', N'ShoppingCartID';
SET @description = N'Product quantity ordered.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'ShoppingCartItem', 'COLUMN', N'Quantity';
SET @description = N'Product ordered. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'ShoppingCartItem', 'COLUMN', N'ProductID';
SET @description = N'Date the time the record was created.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'ShoppingCartItem', 'COLUMN', N'DateCreated';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'ShoppingCartItem', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[SpecialOfferProduct] (
    [SpecialOfferID] int NOT NULL,
    [ProductID] int NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_SpecialOfferProduct_SpecialOfferID_ProductID] PRIMARY KEY ([SpecialOfferID], [ProductID]),
    CONSTRAINT [FK_SpecialOfferProduct_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID] FOREIGN KEY ([SpecialOfferID]) REFERENCES [Sales].[SpecialOffer] ([SpecialOfferID])
);
DECLARE @description AS sql_variant;
SET @description = N'Cross-reference table mapping products to special offer discounts.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct';
SET @description = N'Primary key for SpecialOfferProduct records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'COLUMN', N'SpecialOfferID';
SET @description = N'Product identification number. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'COLUMN', N'ProductID';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SpecialOfferProduct', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[TransactionHistory] (
    [TransactionID] int NOT NULL IDENTITY,
    [ProductID] int NOT NULL,
    [ReferenceOrderID] int NOT NULL,
    [ReferenceOrderLineID] int NOT NULL,
    [TransactionDate] datetime NOT NULL DEFAULT ((getdate())),
    [TransactionType] nchar(1) NOT NULL,
    [Quantity] int NOT NULL,
    [ActualCost] money NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_TransactionHistory_TransactionID] PRIMARY KEY ([TransactionID]),
    CONSTRAINT [FK_TransactionHistory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID])
);
DECLARE @description AS sql_variant;
SET @description = N'Record of each purchase order, sales order, or work order transaction year to date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory';
SET @description = N'Primary key for TransactionHistory records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'COLUMN', N'TransactionID';
SET @description = N'Product identification number. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'COLUMN', N'ProductID';
SET @description = N'Purchase order, sales order, or work order identification number.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'COLUMN', N'ReferenceOrderID';
SET @description = N'Line number associated with the purchase order, sales order, or work order.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'COLUMN', N'ReferenceOrderLineID';
SET @description = N'Date and time of the transaction.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'COLUMN', N'TransactionDate';
SET @description = N'W = WorkOrder, S = SalesOrder, P = PurchaseOrder';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'COLUMN', N'TransactionType';
SET @description = N'Product quantity.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'COLUMN', N'Quantity';
SET @description = N'Product cost.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'COLUMN', N'ActualCost';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'TransactionHistory', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[WorkOrder] (
    [WorkOrderID] int NOT NULL IDENTITY,
    [ProductID] int NOT NULL,
    [OrderQty] int NOT NULL,
    [StockedQty] AS (isnull([OrderQty]-[ScrappedQty],(0))),
    [ScrappedQty] smallint NOT NULL,
    [StartDate] datetime NOT NULL,
    [EndDate] datetime NULL,
    [DueDate] datetime NOT NULL,
    [ScrapReasonID] smallint NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_WorkOrder] PRIMARY KEY ([WorkOrderID]),
    CONSTRAINT [FK_WorkOrder_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_WorkOrder_ScrapReason_ScrapReasonID] FOREIGN KEY ([ScrapReasonID]) REFERENCES [Production].[ScrapReason] ([ScrapReasonID])
);
DECLARE @description AS sql_variant;
SET @description = N'Manufacturing work orders.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrder';
SET @description = N'Primary key for WorkOrder records.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'COLUMN', N'WorkOrderID';
SET @description = N'Product identification number. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'COLUMN', N'ProductID';
SET @description = N'Product quantity to build.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'COLUMN', N'OrderQty';
SET @description = N'Quantity built and put in inventory.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'COLUMN', N'StockedQty';
SET @description = N'Quantity that failed inspection.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'COLUMN', N'ScrappedQty';
SET @description = N'Work order start date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'COLUMN', N'StartDate';
SET @description = N'Work order end date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'COLUMN', N'EndDate';
SET @description = N'Work order due date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'COLUMN', N'DueDate';
SET @description = N'Reason for inspection failure.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'COLUMN', N'ScrapReasonID';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrder', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Purchasing].[PurchaseOrderDetail] (
    [PurchaseOrderID] int NOT NULL,
    [PurchaseOrderDetailID] int NOT NULL IDENTITY,
    [DueDate] datetime NOT NULL,
    [OrderQty] smallint NOT NULL,
    [ProductID] int NOT NULL,
    [UnitPrice] money NOT NULL,
    [LineTotal] AS (isnull([OrderQty]*[UnitPrice],(0.00))),
    [ReceivedQty] decimal(8,2) NOT NULL,
    [RejectedQty] decimal(8,2) NOT NULL,
    [StockedQty] AS (isnull([ReceivedQty]-[RejectedQty],(0.00))),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID] PRIMARY KEY ([PurchaseOrderID], [PurchaseOrderDetailID]),
    CONSTRAINT [FK_PurchaseOrderDetail_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID] FOREIGN KEY ([PurchaseOrderID]) REFERENCES [Purchasing].[PurchaseOrderHeader] ([PurchaseOrderID])
);
DECLARE @description AS sql_variant;
SET @description = N'Individual products associated with a specific purchase order. See PurchaseOrderHeader.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail';
SET @description = N'Primary key. Foreign key to PurchaseOrderHeader.PurchaseOrderID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'COLUMN', N'PurchaseOrderID';
SET @description = N'Primary key. One line number per purchased product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'COLUMN', N'PurchaseOrderDetailID';
SET @description = N'Date the product is expected to be received.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'COLUMN', N'DueDate';
SET @description = N'Quantity ordered.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'COLUMN', N'OrderQty';
SET @description = N'Product identification number. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'COLUMN', N'ProductID';
SET @description = N'Vendor''s selling price of a single product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'COLUMN', N'UnitPrice';
SET @description = N'Per product subtotal. Computed as OrderQty * UnitPrice.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'COLUMN', N'LineTotal';
SET @description = N'Quantity actually received from the vendor.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'COLUMN', N'ReceivedQty';
SET @description = N'Quantity rejected during inspection.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'COLUMN', N'RejectedQty';
SET @description = N'Quantity accepted into inventory. Computed as ReceivedQty - RejectedQty.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'COLUMN', N'StockedQty';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Purchasing', 'TABLE', N'PurchaseOrderDetail', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[SalesPersonQuotaHistory] (
    [BusinessEntityID] int NOT NULL,
    [QuotaDate] datetime NOT NULL,
    [SalesQuota] money NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate] PRIMARY KEY ([BusinessEntityID], [QuotaDate]),
    CONSTRAINT [FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Sales performance tracking.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory';
SET @description = N'Sales person identification number. Foreign key to SalesPerson.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'COLUMN', N'BusinessEntityID';
SET @description = N'Sales quota date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'COLUMN', N'QuotaDate';
SET @description = N'Sales quota amount.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'COLUMN', N'SalesQuota';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesPersonQuotaHistory', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[SalesTerritoryHistory] (
    [BusinessEntityID] int NOT NULL,
    [TerritoryID] int NOT NULL,
    [StartDate] datetime NOT NULL,
    [EndDate] datetime NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID] PRIMARY KEY ([BusinessEntityID], [StartDate], [TerritoryID]),
    CONSTRAINT [FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Sales].[SalesPerson] ([BusinessEntityID]),
    CONSTRAINT [FK_SalesTerritoryHistory_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
);
DECLARE @description AS sql_variant;
SET @description = N'Sales representative transfers to other sales territories.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory';
SET @description = N'Primary key. The sales rep.  Foreign key to SalesPerson.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'COLUMN', N'BusinessEntityID';
SET @description = N'Primary key. Territory identification number. Foreign key to SalesTerritory.SalesTerritoryID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'COLUMN', N'TerritoryID';
SET @description = N'Primary key. Date the sales representive started work in the territory.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'COLUMN', N'StartDate';
SET @description = N'Date the sales representative left work in the territory.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'COLUMN', N'EndDate';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesTerritoryHistory', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[Store] (
    [BusinessEntityID] int NOT NULL,
    [Name] nvarchar(50) NOT NULL,
    [SalesPersonID] int NULL,
    [Demographics] nvarchar(4000) NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Store_BusinessEntityID] PRIMARY KEY ([BusinessEntityID]),
    CONSTRAINT [FK_Store_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID]),
    CONSTRAINT [FK_Store_SalesPerson_SalesPersonID] FOREIGN KEY ([SalesPersonID]) REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Customers (resellers) of Adventure Works products.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Store';
SET @description = N'Primary key. Foreign key to Customer.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'BusinessEntityID';
SET @description = N'Name of the store.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'Name';
SET @description = N'ID of the sales person assigned to the customer. Foreign key to SalesPerson.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'SalesPersonID';
SET @description = N'Demographic informationg about the store such as the number of employees, annual sales and store type.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'Demographics';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Store', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Person].[BusinessEntityAddress] (
    [BusinessEntityID] int NOT NULL,
    [AddressID] int NOT NULL,
    [AddressTypeID] int NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID] PRIMARY KEY ([BusinessEntityID], [AddressID], [AddressTypeID]),
    CONSTRAINT [FK_BusinessEntityAddress_Address_AddressID] FOREIGN KEY ([AddressID]) REFERENCES [Person].[Address] ([AddressID]),
    CONSTRAINT [FK_BusinessEntityAddress_AddressType_AddressTypeID] FOREIGN KEY ([AddressTypeID]) REFERENCES [Person].[AddressType] ([AddressTypeID]),
    CONSTRAINT [FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Cross-reference table mapping customers, vendors, and employees to their addresses.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityAddress';
SET @description = N'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityAddress', 'COLUMN', N'BusinessEntityID';
SET @description = N'Primary key. Foreign key to Address.AddressID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityAddress', 'COLUMN', N'AddressID';
SET @description = N'Primary key. Foreign key to AddressType.AddressTypeID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityAddress', 'COLUMN', N'AddressTypeID';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityAddress', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Person', 'TABLE', N'BusinessEntityAddress', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Production].[WorkOrderRouting] (
    [WorkOrderID] int NOT NULL,
    [ProductID] int NOT NULL,
    [OperationSequence] smallint NOT NULL,
    [LocationID] smallint NOT NULL,
    [ScheduledStartDate] datetime NOT NULL,
    [ScheduledEndDate] datetime NOT NULL,
    [ActualStartDate] datetime NULL,
    [ActualEndDate] datetime NULL,
    [ActualResourceHrs] decimal(9,4) NULL,
    [PlannedCost] money NOT NULL,
    [ActualCost] money NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence] PRIMARY KEY ([WorkOrderID], [ProductID], [OperationSequence]),
    CONSTRAINT [FK_WorkOrderRouting_Location_LocationID] FOREIGN KEY ([LocationID]) REFERENCES [Production].[Location] ([LocationID]),
    CONSTRAINT [FK_WorkOrderRouting_WorkOrder_WorkOrderID] FOREIGN KEY ([WorkOrderID]) REFERENCES [Production].[WorkOrder] ([WorkOrderID])
);
DECLARE @description AS sql_variant;
SET @description = N'Work order details.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting';
SET @description = N'Primary key. Foreign key to WorkOrder.WorkOrderID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'WorkOrderID';
SET @description = N'Primary key. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'ProductID';
SET @description = N'Primary key. Indicates the manufacturing process sequence.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'OperationSequence';
SET @description = N'Manufacturing location where the part is processed. Foreign key to Location.LocationID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'LocationID';
SET @description = N'Planned manufacturing start date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'ScheduledStartDate';
SET @description = N'Planned manufacturing end date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'ScheduledEndDate';
SET @description = N'Actual start date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'ActualStartDate';
SET @description = N'Actual end date.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'ActualEndDate';
SET @description = N'Number of manufacturing hours used.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'ActualResourceHrs';
SET @description = N'Estimated manufacturing cost.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'PlannedCost';
SET @description = N'Actual manufacturing cost.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'ActualCost';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Production', 'TABLE', N'WorkOrderRouting', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[Customer] (
    [CustomerID] int NOT NULL IDENTITY,
    [PersonID] int NULL,
    [StoreID] int NULL,
    [TerritoryID] int NULL,
    [AccountNumber] varchar(10) NOT NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_Customer] PRIMARY KEY ([CustomerID]),
    CONSTRAINT [FK_Customer_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person].[Person] ([BusinessEntityID]),
    CONSTRAINT [FK_Customer_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID]),
    CONSTRAINT [FK_Customer_Store_StoreID] FOREIGN KEY ([StoreID]) REFERENCES [Sales].[Store] ([BusinessEntityID])
);
DECLARE @description AS sql_variant;
SET @description = N'Current customer information. Also see the Person and Store tables.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Customer';
SET @description = N'Primary key.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'CustomerID';
SET @description = N'Foreign key to Person.BusinessEntityID';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'PersonID';
SET @description = N'Foreign key to Store.BusinessEntityID';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'StoreID';
SET @description = N'ID of the territory in which the customer is located. Foreign key to SalesTerritory.SalesTerritoryID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'TerritoryID';
SET @description = N'Unique number identifying the customer assigned by the accounting system.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'AccountNumber';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'Customer', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[SalesOrderHeader] (
    [SalesOrderID] int NOT NULL IDENTITY,
    [RevisionNumber] tinyint NOT NULL,
    [OrderDate] datetime NOT NULL DEFAULT ((getdate())),
    [DueDate] datetime NOT NULL,
    [ShipDate] datetime NULL,
    [Status] tinyint NOT NULL DEFAULT (((1))),
    [OnlineOrderFlag] bit NOT NULL DEFAULT (((1))),
    [SalesOrderNumber] AS (isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID]),N'*** ERROR ***')),
    [PurchaseOrderNumber] nvarchar(25) NULL,
    [AccountNumber] nvarchar(15) NULL,
    [CustomerID] int NOT NULL,
    [SalesPersonID] int NULL,
    [TerritoryID] int NULL,
    [BillToAddressID] int NOT NULL,
    [ShipToAddressID] int NOT NULL,
    [ShipMethodID] int NOT NULL,
    [CreditCardID] int NULL,
    [CreditCardApprovalCode] varchar(15) NULL,
    [CurrencyRateID] int NULL,
    [SubTotal] money NOT NULL DEFAULT (((0.00))),
    [TaxAmt] money NOT NULL DEFAULT (((0.00))),
    [Freight] money NOT NULL DEFAULT (((0.00))),
    [TotalDue] AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))),
    [Comment] nvarchar(128) NULL,
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_SalesOrderHeader_SalesOrderID] PRIMARY KEY ([SalesOrderID]),
    CONSTRAINT [FK_SalesOrderHeader_Address_BillToAddressID] FOREIGN KEY ([BillToAddressID]) REFERENCES [Person].[Address] ([AddressID]),
    CONSTRAINT [FK_SalesOrderHeader_Address_ShipToAddressID] FOREIGN KEY ([ShipToAddressID]) REFERENCES [Person].[Address] ([AddressID]),
    CONSTRAINT [FK_SalesOrderHeader_CreditCard_CreditCardID] FOREIGN KEY ([CreditCardID]) REFERENCES [Sales].[CreditCard] ([CreditCardID]),
    CONSTRAINT [FK_SalesOrderHeader_CurrencyRate_CurrencyRateID] FOREIGN KEY ([CurrencyRateID]) REFERENCES [Sales].[CurrencyRate] ([CurrencyRateID]),
    CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Sales].[Customer] ([CustomerID]),
    CONSTRAINT [FK_SalesOrderHeader_SalesPerson_SalesPersonID] FOREIGN KEY ([SalesPersonID]) REFERENCES [Sales].[SalesPerson] ([BusinessEntityID]),
    CONSTRAINT [FK_SalesOrderHeader_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID]),
    CONSTRAINT [FK_SalesOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY ([ShipMethodID]) REFERENCES [Purchasing].[ShipMethod] ([ShipMethodID])
);
DECLARE @description AS sql_variant;
SET @description = N'General sales order information.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader';
SET @description = N'Primary key.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'SalesOrderID';
SET @description = N'Incremental number to track changes to the sales order over time.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'RevisionNumber';
SET @description = N'Dates the sales order was created.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'OrderDate';
SET @description = N'Date the order is due to the customer.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'DueDate';
SET @description = N'Date the order was shipped to the customer.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'ShipDate';
SET @description = N'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'Status';
SET @description = N'0 = Order placed by sales person. 1 = Order placed online by customer.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'OnlineOrderFlag';
SET @description = N'Unique sales order identification number.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'SalesOrderNumber';
SET @description = N'Customer purchase order number reference. ';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'PurchaseOrderNumber';
SET @description = N'Financial accounting number reference.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'AccountNumber';
SET @description = N'Customer identification number. Foreign key to Customer.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'CustomerID';
SET @description = N'Sales person who created the sales order. Foreign key to SalesPerson.BusinessEntityID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'SalesPersonID';
SET @description = N'Territory in which the sale was made. Foreign key to SalesTerritory.SalesTerritoryID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'TerritoryID';
SET @description = N'Customer billing address. Foreign key to Address.AddressID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'BillToAddressID';
SET @description = N'Customer shipping address. Foreign key to Address.AddressID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'ShipToAddressID';
SET @description = N'Shipping method. Foreign key to ShipMethod.ShipMethodID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'ShipMethodID';
SET @description = N'Credit card identification number. Foreign key to CreditCard.CreditCardID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'CreditCardID';
SET @description = N'Approval code provided by the credit card company.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'CreditCardApprovalCode';
SET @description = N'Currency exchange rate used. Foreign key to CurrencyRate.CurrencyRateID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'CurrencyRateID';
SET @description = N'Sales subtotal. Computed as SUM(SalesOrderDetail.LineTotal)for the appropriate SalesOrderID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'SubTotal';
SET @description = N'Tax amount.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'TaxAmt';
SET @description = N'Shipping cost.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'Freight';
SET @description = N'Total due from customer. Computed as Subtotal + TaxAmt + Freight.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'TotalDue';
SET @description = N'Sales representative comments.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'Comment';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeader', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[SalesOrderDetail] (
    [SalesOrderID] int NOT NULL,
    [SalesOrderDetailID] int NOT NULL IDENTITY,
    [CarrierTrackingNumber] nvarchar(25) NULL,
    [OrderQty] smallint NOT NULL,
    [ProductID] int NOT NULL,
    [SpecialOfferID] int NOT NULL,
    [UnitPrice] money NOT NULL,
    [UnitPriceDiscount] money NOT NULL,
    [LineTotal] AS (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))),
    [rowguid] uniqueidentifier NOT NULL DEFAULT ((newid())),
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] PRIMARY KEY ([SalesOrderID], [SalesOrderDetailID]),
    CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID] FOREIGN KEY ([SalesOrderID]) REFERENCES [Sales].[SalesOrderHeader] ([SalesOrderID]) ON DELETE CASCADE,
    CONSTRAINT [FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID] FOREIGN KEY ([SpecialOfferID], [ProductID]) REFERENCES [Sales].[SpecialOfferProduct] ([SpecialOfferID], [ProductID])
);
DECLARE @description AS sql_variant;
SET @description = N'Individual products associated with a specific sales order. See SalesOrderHeader.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail';
SET @description = N'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'SalesOrderID';
SET @description = N'Primary key. One incremental unique number per product sold.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'SalesOrderDetailID';
SET @description = N'Shipment tracking number supplied by the shipper.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'CarrierTrackingNumber';
SET @description = N'Quantity ordered per product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'OrderQty';
SET @description = N'Product sold to customer. Foreign key to Product.ProductID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'ProductID';
SET @description = N'Promotional code. Foreign key to SpecialOffer.SpecialOfferID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'SpecialOfferID';
SET @description = N'Selling price of a single product.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'UnitPrice';
SET @description = N'Discount amount.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'UnitPriceDiscount';
SET @description = N'Per product subtotal. Computed as UnitPrice * (1 - UnitPriceDiscount) * OrderQty.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'LineTotal';
SET @description = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'rowguid';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderDetail', 'COLUMN', N'ModifiedDate';
GO

CREATE TABLE [Sales].[SalesOrderHeaderSalesReason] (
    [SalesOrderID] int NOT NULL,
    [SalesReasonID] int NOT NULL,
    [ModifiedDate] datetime NOT NULL DEFAULT ((getdate())),
    CONSTRAINT [PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID] PRIMARY KEY ([SalesOrderID], [SalesReasonID]),
    CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID] FOREIGN KEY ([SalesOrderID]) REFERENCES [Sales].[SalesOrderHeader] ([SalesOrderID]) ON DELETE CASCADE,
    CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID] FOREIGN KEY ([SalesReasonID]) REFERENCES [Sales].[SalesReason] ([SalesReasonID])
);
DECLARE @description AS sql_variant;
SET @description = N'Cross-reference table mapping sales orders to sales reason codes.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeaderSalesReason';
SET @description = N'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeaderSalesReason', 'COLUMN', N'SalesOrderID';
SET @description = N'Primary key. Foreign key to SalesReason.SalesReasonID.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeaderSalesReason', 'COLUMN', N'SalesReasonID';
SET @description = N'Date and time the record was last updated.';
EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', N'Sales', 'TABLE', N'SalesOrderHeaderSalesReason', 'COLUMN', N'ModifiedDate';
GO

CREATE UNIQUE INDEX [AK_Address_rowguid] ON [Person].[Address] ([rowguid]);
GO

CREATE UNIQUE INDEX [IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode] ON [Person].[Address] ([AddressLine1], [AddressLine2], [City], [StateProvinceID], [PostalCode]) WHERE [AddressLine2] IS NOT NULL;
GO

CREATE INDEX [IX_Address_StateProvinceID] ON [Person].[Address] ([StateProvinceID]);
GO

CREATE UNIQUE INDEX [AK_AddressType_Name] ON [Person].[AddressType] ([Name]);
GO

CREATE UNIQUE INDEX [AK_AddressType_rowguid] ON [Person].[AddressType] ([rowguid]);
GO

CREATE UNIQUE CLUSTERED INDEX [AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate] ON [Production].[BillOfMaterials] ([ProductAssemblyID], [ComponentID], [StartDate]);
GO

CREATE INDEX [IX_BillOfMaterials_ComponentID] ON [Production].[BillOfMaterials] ([ComponentID]);
GO

CREATE INDEX [IX_BillOfMaterials_UnitMeasureCode] ON [Production].[BillOfMaterials] ([UnitMeasureCode]);
GO

CREATE UNIQUE INDEX [AK_BusinessEntity_rowguid] ON [Person].[BusinessEntity] ([rowguid]);
GO

CREATE UNIQUE INDEX [AK_BusinessEntityAddress_rowguid] ON [Person].[BusinessEntityAddress] ([rowguid]);
GO

CREATE INDEX [IX_BusinessEntityAddress_AddressID] ON [Person].[BusinessEntityAddress] ([AddressID]);
GO

CREATE INDEX [IX_BusinessEntityAddress_AddressTypeID] ON [Person].[BusinessEntityAddress] ([AddressTypeID]);
GO

CREATE UNIQUE INDEX [AK_BusinessEntityContact_rowguid] ON [Person].[BusinessEntityContact] ([rowguid]);
GO

CREATE INDEX [IX_BusinessEntityContact_ContactTypeID] ON [Person].[BusinessEntityContact] ([ContactTypeID]);
GO

CREATE INDEX [IX_BusinessEntityContact_PersonID] ON [Person].[BusinessEntityContact] ([PersonID]);
GO

CREATE UNIQUE INDEX [AK_ContactType_Name] ON [Person].[ContactType] ([Name]);
GO

CREATE UNIQUE INDEX [AK_CountryRegion_Name] ON [Person].[CountryRegion] ([Name]);
GO

CREATE INDEX [IX_CountryRegionCurrency_CurrencyCode] ON [Sales].[CountryRegionCurrency] ([CurrencyCode]);
GO

CREATE UNIQUE INDEX [AK_CreditCard_CardNumber] ON [Sales].[CreditCard] ([CardNumber]);
GO

CREATE UNIQUE INDEX [AK_Culture_Name] ON [Production].[Culture] ([Name]);
GO

CREATE UNIQUE INDEX [AK_Currency_Name] ON [Sales].[Currency] ([Name]);
GO

CREATE UNIQUE INDEX [AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode] ON [Sales].[CurrencyRate] ([CurrencyRateDate], [FromCurrencyCode], [ToCurrencyCode]);
GO

CREATE INDEX [IX_CurrencyRate_FromCurrencyCode] ON [Sales].[CurrencyRate] ([FromCurrencyCode]);
GO

CREATE INDEX [IX_CurrencyRate_ToCurrencyCode] ON [Sales].[CurrencyRate] ([ToCurrencyCode]);
GO

CREATE UNIQUE INDEX [AK_Customer_AccountNumber] ON [Sales].[Customer] ([AccountNumber]);
GO

CREATE UNIQUE INDEX [AK_Customer_rowguid] ON [Sales].[Customer] ([rowguid]);
GO

CREATE INDEX [IX_Customer_PersonID] ON [Sales].[Customer] ([PersonID]);
GO

CREATE INDEX [IX_Customer_StoreID] ON [Sales].[Customer] ([StoreID]);
GO

CREATE INDEX [IX_Customer_TerritoryID] ON [Sales].[Customer] ([TerritoryID]);
GO

CREATE UNIQUE INDEX [AK_Department_Name] ON [HumanResources].[Department] ([Name]);
GO

CREATE INDEX [IX_EmailAddress_EmailAddress] ON [Person].[EmailAddress] ([EmailAddress]);
GO

CREATE UNIQUE INDEX [AK_Employee_LoginID] ON [HumanResources].[Employee] ([LoginID]);
GO

CREATE UNIQUE INDEX [AK_Employee_NationalIDNumber] ON [HumanResources].[Employee] ([NationalIDNumber]);
GO

CREATE UNIQUE INDEX [AK_Employee_rowguid] ON [HumanResources].[Employee] ([rowguid]);
GO

CREATE INDEX [IX_EmployeeDepartmentHistory_DepartmentID] ON [HumanResources].[EmployeeDepartmentHistory] ([DepartmentID]);
GO

CREATE INDEX [IX_EmployeeDepartmentHistory_ShiftID] ON [HumanResources].[EmployeeDepartmentHistory] ([ShiftID]);
GO

CREATE INDEX [IX_JobCandidate_BusinessEntityID] ON [HumanResources].[JobCandidate] ([BusinessEntityID]);
GO

CREATE UNIQUE INDEX [AK_Location_Name] ON [Production].[Location] ([Name]);
GO

CREATE UNIQUE INDEX [AK_Person_rowguid] ON [Person].[Person] ([rowguid]);
GO

CREATE INDEX [IX_Person_LastName_FirstName_MiddleName] ON [Person].[Person] ([LastName], [FirstName], [MiddleName]);
GO

CREATE INDEX [PXML_Person_AddContact] ON [Person].[Person] ([AdditionalContactInfo]);
GO

CREATE INDEX [PXML_Person_Demographics] ON [Person].[Person] ([Demographics]);
GO

CREATE INDEX [XMLPATH_Person_Demographics] ON [Person].[Person] ([Demographics]);
GO

CREATE INDEX [XMLPROPERTY_Person_Demographics] ON [Person].[Person] ([Demographics]);
GO

CREATE INDEX [XMLVALUE_Person_Demographics] ON [Person].[Person] ([Demographics]);
GO

CREATE INDEX [IX_PersonCreditCard_CreditCardID] ON [Sales].[PersonCreditCard] ([CreditCardID]);
GO

CREATE INDEX [IX_PersonPhone_PhoneNumber] ON [Person].[PersonPhone] ([PhoneNumber]);
GO

CREATE INDEX [IX_PersonPhone_PhoneNumberTypeID] ON [Person].[PersonPhone] ([PhoneNumberTypeID]);
GO

CREATE UNIQUE INDEX [AK_Product_Name] ON [Production].[Product] ([Name]);
GO

CREATE UNIQUE INDEX [AK_Product_ProductNumber] ON [Production].[Product] ([ProductNumber]);
GO

CREATE UNIQUE INDEX [AK_Product_rowguid] ON [Production].[Product] ([rowguid]);
GO

CREATE INDEX [IX_Product_ProductModelID] ON [Production].[Product] ([ProductModelID]);
GO

CREATE INDEX [IX_Product_ProductSubcategoryID] ON [Production].[Product] ([ProductSubcategoryID]);
GO

CREATE INDEX [IX_Product_SizeUnitMeasureCode] ON [Production].[Product] ([SizeUnitMeasureCode]);
GO

CREATE INDEX [IX_Product_WeightUnitMeasureCode] ON [Production].[Product] ([WeightUnitMeasureCode]);
GO

CREATE UNIQUE INDEX [AK_ProductCategory_Name] ON [Production].[ProductCategory] ([Name]);
GO

CREATE UNIQUE INDEX [AK_ProductCategory_rowguid] ON [Production].[ProductCategory] ([rowguid]);
GO

CREATE UNIQUE INDEX [AK_ProductDescription_rowguid] ON [Production].[ProductDescription] ([rowguid]);
GO

CREATE INDEX [IX_ProductInventory_LocationID] ON [Production].[ProductInventory] ([LocationID]);
GO

CREATE UNIQUE INDEX [AK_ProductModel_Name] ON [Production].[ProductModel] ([Name]);
GO

CREATE UNIQUE INDEX [AK_ProductModel_rowguid] ON [Production].[ProductModel] ([rowguid]);
GO

CREATE INDEX [PXML_ProductModel_CatalogDescription] ON [Production].[ProductModel] ([CatalogDescription]);
GO

CREATE INDEX [PXML_ProductModel_Instructions] ON [Production].[ProductModel] ([Instructions]);
GO

CREATE INDEX [IX_ProductModelIllustration_IllustrationID] ON [Production].[ProductModelIllustration] ([IllustrationID]);
GO

CREATE INDEX [IX_ProductModelProductDescriptionCulture_CultureID] ON [Production].[ProductModelProductDescriptionCulture] ([CultureID]);
GO

CREATE INDEX [IX_ProductModelProductDescriptionCulture_ProductDescriptionID] ON [Production].[ProductModelProductDescriptionCulture] ([ProductDescriptionID]);
GO

CREATE INDEX [IX_ProductProductPhoto_ProductPhotoID] ON [Production].[ProductProductPhoto] ([ProductPhotoID]);
GO

CREATE INDEX [IX_ProductReview_ProductID_Name] ON [Production].[ProductReview] ([ProductID], [ReviewerName]);
GO

CREATE UNIQUE INDEX [AK_ProductSubcategory_Name] ON [Production].[ProductSubcategory] ([Name]);
GO

CREATE UNIQUE INDEX [AK_ProductSubcategory_rowguid] ON [Production].[ProductSubcategory] ([rowguid]);
GO

CREATE INDEX [IX_ProductSubcategory_ProductCategoryID] ON [Production].[ProductSubcategory] ([ProductCategoryID]);
GO

CREATE INDEX [IX_ProductVendor_BusinessEntityID] ON [Purchasing].[ProductVendor] ([BusinessEntityID]);
GO

CREATE INDEX [IX_ProductVendor_UnitMeasureCode] ON [Purchasing].[ProductVendor] ([UnitMeasureCode]);
GO

CREATE INDEX [IX_PurchaseOrderDetail_ProductID] ON [Purchasing].[PurchaseOrderDetail] ([ProductID]);
GO

CREATE INDEX [IX_PurchaseOrderHeader_EmployeeID] ON [Purchasing].[PurchaseOrderHeader] ([EmployeeID]);
GO

CREATE INDEX [IX_PurchaseOrderHeader_ShipMethodID] ON [Purchasing].[PurchaseOrderHeader] ([ShipMethodID]);
GO

CREATE INDEX [IX_PurchaseOrderHeader_VendorID] ON [Purchasing].[PurchaseOrderHeader] ([VendorID]);
GO

CREATE UNIQUE INDEX [AK_SalesOrderDetail_rowguid] ON [Sales].[SalesOrderDetail] ([rowguid]);
GO

CREATE INDEX [IX_SalesOrderDetail_ProductID] ON [Sales].[SalesOrderDetail] ([ProductID]);
GO

CREATE INDEX [IX_SalesOrderDetail_SpecialOfferID_ProductID] ON [Sales].[SalesOrderDetail] ([SpecialOfferID], [ProductID]);
GO

CREATE UNIQUE INDEX [AK_SalesOrderHeader_rowguid] ON [Sales].[SalesOrderHeader] ([rowguid]);
GO

CREATE UNIQUE INDEX [AK_SalesOrderHeader_SalesOrderNumber] ON [Sales].[SalesOrderHeader] ([SalesOrderNumber]);
GO

CREATE INDEX [IX_SalesOrderHeader_BillToAddressID] ON [Sales].[SalesOrderHeader] ([BillToAddressID]);
GO

CREATE INDEX [IX_SalesOrderHeader_CreditCardID] ON [Sales].[SalesOrderHeader] ([CreditCardID]);
GO

CREATE INDEX [IX_SalesOrderHeader_CurrencyRateID] ON [Sales].[SalesOrderHeader] ([CurrencyRateID]);
GO

CREATE INDEX [IX_SalesOrderHeader_CustomerID] ON [Sales].[SalesOrderHeader] ([CustomerID]);
GO

CREATE INDEX [IX_SalesOrderHeader_SalesPersonID] ON [Sales].[SalesOrderHeader] ([SalesPersonID]);
GO

CREATE INDEX [IX_SalesOrderHeader_ShipMethodID] ON [Sales].[SalesOrderHeader] ([ShipMethodID]);
GO

CREATE INDEX [IX_SalesOrderHeader_ShipToAddressID] ON [Sales].[SalesOrderHeader] ([ShipToAddressID]);
GO

CREATE INDEX [IX_SalesOrderHeader_TerritoryID] ON [Sales].[SalesOrderHeader] ([TerritoryID]);
GO

CREATE INDEX [IX_SalesOrderHeaderSalesReason_SalesReasonID] ON [Sales].[SalesOrderHeaderSalesReason] ([SalesReasonID]);
GO

CREATE UNIQUE INDEX [AK_SalesPerson_rowguid] ON [Sales].[SalesPerson] ([rowguid]);
GO

CREATE INDEX [IX_SalesPerson_TerritoryID] ON [Sales].[SalesPerson] ([TerritoryID]);
GO

CREATE UNIQUE INDEX [AK_SalesPersonQuotaHistory_rowguid] ON [Sales].[SalesPersonQuotaHistory] ([rowguid]);
GO

CREATE UNIQUE INDEX [AK_SalesTaxRate_rowguid] ON [Sales].[SalesTaxRate] ([rowguid]);
GO

CREATE UNIQUE INDEX [AK_SalesTaxRate_StateProvinceID_TaxType] ON [Sales].[SalesTaxRate] ([StateProvinceID], [TaxType]);
GO

CREATE UNIQUE INDEX [AK_SalesTerritory_Name] ON [Sales].[SalesTerritory] ([Name]);
GO

CREATE UNIQUE INDEX [AK_SalesTerritory_rowguid] ON [Sales].[SalesTerritory] ([rowguid]);
GO

CREATE INDEX [IX_SalesTerritory_CountryRegionCode] ON [Sales].[SalesTerritory] ([CountryRegionCode]);
GO

CREATE UNIQUE INDEX [AK_SalesTerritoryHistory_rowguid] ON [Sales].[SalesTerritoryHistory] ([rowguid]);
GO

CREATE INDEX [IX_SalesTerritoryHistory_TerritoryID] ON [Sales].[SalesTerritoryHistory] ([TerritoryID]);
GO

CREATE UNIQUE INDEX [AK_ScrapReason_Name] ON [Production].[ScrapReason] ([Name]);
GO

CREATE UNIQUE INDEX [AK_Shift_Name] ON [HumanResources].[Shift] ([Name]);
GO

CREATE UNIQUE INDEX [AK_Shift_StartTime_EndTime] ON [HumanResources].[Shift] ([StartTime], [EndTime]);
GO

CREATE UNIQUE INDEX [AK_ShipMethod_Name] ON [Purchasing].[ShipMethod] ([Name]);
GO

CREATE UNIQUE INDEX [AK_ShipMethod_rowguid] ON [Purchasing].[ShipMethod] ([rowguid]);
GO

CREATE INDEX [IX_ShoppingCartItem_ProductID] ON [Sales].[ShoppingCartItem] ([ProductID]);
GO

CREATE INDEX [IX_ShoppingCartItem_ShoppingCartID_ProductID] ON [Sales].[ShoppingCartItem] ([ShoppingCartID], [ProductID]);
GO

CREATE UNIQUE INDEX [AK_SpecialOffer_rowguid] ON [Sales].[SpecialOffer] ([rowguid]);
GO

CREATE UNIQUE INDEX [AK_SpecialOfferProduct_rowguid] ON [Sales].[SpecialOfferProduct] ([rowguid]);
GO

CREATE INDEX [IX_SpecialOfferProduct_ProductID] ON [Sales].[SpecialOfferProduct] ([ProductID]);
GO

CREATE UNIQUE INDEX [AK_StateProvince_Name] ON [Person].[StateProvince] ([Name]);
GO

CREATE UNIQUE INDEX [AK_StateProvince_rowguid] ON [Person].[StateProvince] ([rowguid]);
GO

CREATE UNIQUE INDEX [AK_StateProvince_StateProvinceCode_CountryRegionCode] ON [Person].[StateProvince] ([StateProvinceCode], [CountryRegionCode]);
GO

CREATE INDEX [IX_StateProvince_CountryRegionCode] ON [Person].[StateProvince] ([CountryRegionCode]);
GO

CREATE INDEX [IX_StateProvince_TerritoryID] ON [Person].[StateProvince] ([TerritoryID]);
GO

CREATE UNIQUE INDEX [AK_Store_rowguid] ON [Sales].[Store] ([rowguid]);
GO

CREATE INDEX [IX_Store_SalesPersonID] ON [Sales].[Store] ([SalesPersonID]);
GO

CREATE INDEX [PXML_Store_Demographics] ON [Sales].[Store] ([Demographics]);
GO

CREATE INDEX [IX_TransactionHistory_ProductID] ON [Production].[TransactionHistory] ([ProductID]);
GO

CREATE INDEX [IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID] ON [Production].[TransactionHistory] ([ReferenceOrderID], [ReferenceOrderLineID]);
GO

CREATE INDEX [IX_TransactionHistoryArchive_ProductID] ON [Production].[TransactionHistoryArchive] ([ProductID]);
GO

CREATE INDEX [IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID] ON [Production].[TransactionHistoryArchive] ([ReferenceOrderID], [ReferenceOrderLineID]);
GO

CREATE UNIQUE INDEX [AK_UnitMeasure_Name] ON [Production].[UnitMeasure] ([Name]);
GO

CREATE UNIQUE INDEX [AK_Vendor_AccountNumber] ON [Purchasing].[Vendor] ([AccountNumber]);
GO

CREATE INDEX [IX_WorkOrder_ProductID] ON [Production].[WorkOrder] ([ProductID]);
GO

CREATE INDEX [IX_WorkOrder_ScrapReasonID] ON [Production].[WorkOrder] ([ScrapReasonID]);
GO

CREATE INDEX [IX_WorkOrderRouting_LocationID] ON [Production].[WorkOrderRouting] ([LocationID]);
GO

CREATE INDEX [IX_WorkOrderRouting_ProductID] ON [Production].[WorkOrderRouting] ([ProductID]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20221121180503_InitialMigration', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Person].[Address] ADD [AddressLine3] nvarchar(4000) NULL;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20221121180517_AddThirdAddressLine', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Person].[Address]') AND [c].[name] = N'AddressLine3');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Person].[Address] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [Person].[Address] DROP COLUMN [AddressLine3];
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20221121180753_RemoveThirdAddressLine', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Sales].[CreditCard] ADD [IsActive] bit NOT NULL DEFAULT CAST(0 AS bit);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20221121180819_AddCreditCardActiveFlag', N'6.0.0');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Production].[Product] ADD [Description] nvarchar(4000) NOT NULL DEFAULT N'';
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20221121180939_AddProductDescription', N'6.0.0');
GO

COMMIT;
GO

