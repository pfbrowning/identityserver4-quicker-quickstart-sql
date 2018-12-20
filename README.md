# IdentityServer4 Quicker Quickstart SQL

## Introduction
This project is a copy of the [IdentityServer4 Quicker Quickstart](https://github.com/pfbrowning/identityserver4-quicker-quickstart) with the following features & modifications:
* IdentityServer4 Configuration & Persisted Grant stores via SQL Server
    * Custom schema & table names for the IdentityServer tables
* ASP.NET Core Identity
    * Custom schema & table names for the ASP.NET Core Identity tables
    * Integer primary key (rather than GUID) for the ASP.NET Core Identity user table

## Usage
1. Install the .NET Core 2.2 SDK if you haven't already.
2. Clone the repo.
3. Install dependencies with `dotnet restore`
4. Set up the SQL Server instance and database that you want to use and update the ConnectionString in appsettings.json accordingly.
5. Initialize the database by running the following EF migrations:
```
dotnet ef migrations add InitialIdentityServerMigration -c PersistedGrantDbContext
dotnet ef migrations add InitialIdentityServerMigration -c ConfigurationDbContext
dotnet ef migrations add InitialIdentityServerMigration -c ApplicationDbContext
dotnet ef database update -c PersistedGrantDbContext
dotnet ef database update -c ConfigurationDbContext
dotnet ef database update -c ApplicationDbContext
```
5. If you want to use 'local login' to log in with a basic ASP.NET Core Identity test user, then run 'init_alice_and_bob.sql' in the 'Scripts' folder
to initialize the 'alice' and 'bob' test users (both use a password of 'Password123!').  Alternatively you can use the external login or create your own ASP.NET Core Identity users to test with.
6. If you want to use a working test configuration for IdentityServer clients, resources, etc, then run 'init_identityserver_config.sql' in the 'Scripts' folder.  Alternatively you can set up your own IdentityServer configuration if you prefer.
7. Run the application as you normally would - either with `dotnet build` & `dotnet run` or with the VS / VS Code debugger