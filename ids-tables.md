# Customizing IdentityServer4 SQL Server Table Names & Schema

When using SQL Server to maintain your configuration and operational store for IdentityServer4, it's fairly simple to tell IdentityServer to use a specific custom schema and custom table names.  The process is similar to the way one [configures ASP.NET Core Identity to use custom table names](https://browninglogic.com/2018/12/20/customizing-the-asp-net-core-identity-table-names-and-primary-key-type/).

## Rename Existing Or Create New?
If you update the table names & schema in your IdentityServer configuration and run an EF migration, it will create new tables, rather than renaming your old tables.  However, if you manually rename your existing tables and update the IdentityServer configuration to point to the renamed tables, then it will work without running any migrations because IdentityServer knows where to find the necessary tables.

With this in mind, it comes down to preference: Would you rather start over with new tables or rename your existing tables?
* If you're just getting started (and thus don't have any configuration yet) or if you have no problem with re-populating your existing configuration, then just delete your old IdentityServer tables, update your IdentityServer table configuration, and run an EF migration to create the new tables.
* If you've go configuration data in your existing tables that you don't want to re-populate, then just rename your existing tables to whatever you want them to be and update your IdentityServer table configuration accordingly.  This way IdentityServer will know where to find your tables and there's no need to run any migrations.

There is a third option: You could extend IdentityServer's built-in PersistedGrantDbContext and ConfigurationDbContext, update the schema within OnModelCreating (in the same way as you would do for [ASP.NET Core Identity](https://browninglogic.com/2018/12/20/customizing-the-asp-net-core-identity-table-names-and-primary-key-type/)), and then run your migrations to create or update your existing tables.  This is technically the "proper" way to do it, but my personal opinion is that this is more trouble than it's worth because:
* Both of the aforementioned alternatives work just fine and are much quicker to implement.
* This involves having to specify the same table names and schemas in two different places (IdentityServer configuration and OnModelCreating).  I'd rather not repeat myself if I don't have to.

## Updating Your IdentityServer Table Configuration
The operational store options and the configuration store options provide entries to specify "DefaultSchema", as well as one option for each IdentityServer table name.  Thus all you need to do is specify your DefaultSchema once and specify Table.Name for each table.  Consider the following example, where I'm specifying "IdentityServer" as the schema and renaming each table to be singular.
```csharp
// Configure SQL Server peristed grant store, schema, and table names
.AddOperationalStore(options => {
    options.ConfigureDbContext = builder => builder.UseSqlServer(generalConfig.ConnectionString, sqlOptions => sqlOptions.MigrationsAssembly(migrationsAssembly));
    options.DefaultSchema = "IdentityServer";
    options.DeviceFlowCodes.Name = "DeviceCode";
    options.PersistedGrants.Name = "PersistedGrant";
})
// Configure SQL Server configuration store, schema, and table names
.AddConfigurationStore(options => {
    options.ConfigureDbContext = builder => builder.UseSqlServer(generalConfig.ConnectionString, sqlOptions => sqlOptions.MigrationsAssembly(migrationsAssembly));
    options.DefaultSchema = "IdentityServer";
    options.ApiClaim.Name = "ApiClaim";
    options.ApiResourceProperty.Name = "ApiProperty";
    options.ApiResource.Name = "ApiResource";
    options.ApiScopeClaim.Name = "ApiScopeClaim";
    options.ApiScope.Name = "ApiScope";
    options.ApiSecret.Name = "ApiSecret";
    options.ClientClaim.Name = "ClientClaim";
    options.ClientCorsOrigin.Name = "ClientCorsOrigin";
    options.ClientGrantType.Name = "ClientGrantType";
    options.ClientIdPRestriction.Name = "ClientIdpRestriction";
    options.ClientPostLogoutRedirectUri.Name = "ClientPostLogoutRedirectUri";
    options.ClientProperty.Name = "ClientProperty";
    options.ClientRedirectUri.Name = "ClientRedirectUri";
    options.Client.Name = "Client";
    options.ClientScopes.Name = "ClientScope";
    options.ClientSecret.Name = "ClientSecret";
    options.IdentityClaim.Name = "IdentityClaim";
    options.IdentityResourceProperty.Name = "IdentityProperty";
    options.IdentityResource.Name = "IdentityResource";
})
```
## Option 1: Creating New Tables Via EF Migration
If you don't care about keeping your old tables, then just run an EF migration to create new IdentityServer tables.  Then you can either start from scratch or restore your existing data to your new tables.  Assuming you're using the Dotnet CLI, just run the following:
```
dotnet ef migrations add IdentityServerCustomTableMigration -c PersistedGrantDbContext
dotnet ef migrations add IdentityServerCustomTableMigration -c ConfigurationDbContext
dotnet ef database update -c PersistedGrantDbContext
dotnet ef database update -c ConfigurationDbContext
```
## Option 2: Renaming Existing Tables
If you prefer to reuse your existing tables, then just rename the tables manually and change their schema accordingly.  Double check that your IdentityServer table configuration matches the name and schema of your renamed tables.  There's no need to perform a migration if you're taking this route.  Just launch your IdentityServer instance and it should work.
## Example Source
You can view the full source code for the project that I'm using as an example [here](https://github.com/pfbrowning/identityserver4-quicker-quickstart-sql)