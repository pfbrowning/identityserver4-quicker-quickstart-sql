# Customizing the ASP.NET Core Identity Table Names and Primary Key Type

ASP.NET Core Identity is a very useful tool which provides a simple interface for user management.  The default out-of-the-box implementation involves using Microsoft's default table names and using a string (which defaults to a guid) for primary keys.  If you don't like these defaults it's fairly simple to change the table names and schema and to use an auto-incrementing integer as a primary key.

This guide assumes that you already have ASP.NET Core Identity wired up within your application, but haven't entered any important data yet.  Changing the primary key type on existing tables requires the identity columns to be dropped and re-created.  For the sake of simplicity, this guide will take the route of deleting all of the existing tables and starting from scratch.  If you don't want to delete your existing tables and you don't care about changing your primary key type, then you can simply skip the primary key part and change the table names only.

I'm using an [IdentityServer quickstart implementation](https://github.com/pfbrowning/identityserver4-quicker-quickstart-sql) with ASP.NET Core Identity added manually via [this tutorial](https://www.scottbrady91.com/Identity-Server/Getting-Started-with-IdentityServer-4) as an example, but the process should be the same or very similar for any .NET Core 2.X application which uses ASP.NET Core Identity.

## Changing The Primary Key To An Integer
First we'll need to find the ASP.NET Core Identity registration.  In Startup.cs you should see a line which starts with `services.AddIdentity`.  We'll need to change three things here:
1. The first generic type that you see referenced will be either IdentityUser, ApplicationUser (which inherits from IdentityUser), or some other custom User class which also inherits from IdentityUser.  Regardless of whether you're using IdentityUser directly or inheriting from IdentityUser, change `IdentityUser` to `IdentityUser<int>`.
2. The second generic type should be IdentityRole.  Change `IdentityRole` to `IdentityRole<int>`.
3. Take a look at your DB Context class.  `ApplicationDbContext` should inherit from `IdentityDbContext` or `IdentityDbContext<ApplicationUser>`.  Change the IdentityDbContext superclass to `IdentityDbContext<ApplicationUser, IdentityRole<int>, int>`.  Obviously if you're using something other than `ApplicationUser` as your user type you'll want to fill that in accordingly.

In my application I was previously registering IdentityUser directly, but for the sake of consistency I created an ApplicationUser class which inherits from `IdentityUser<int>`:
```csharp
public class ApplicationUser : IdentityUser<int> {}
```
Then I changed my `services.AddIdentity` section in Startup.cs from this:
```csharp
services.AddIdentity<IdentityUser, IdentityRole>()
    .AddEntityFrameworkStores<ApplicationDbContext>();
```
To this
```csharp
services.AddIdentity<ApplicationUser, IdentityRole<int>>()
    .AddEntityFrameworkStores<ApplicationDbContext>();
```
I then changed my ApplicationDbContext class definition from this:
```csharp
public class ApplicationDbContext : IdentityDbContext
```
To this:
```csharp
public class ApplicationDbContext : IdentityDbContext<ApplicationUser, IdentityRole<int>, int>
```

The next step will be to update the database by running EF migrations, but since we'll need to do that after specifying our table names as well, we'll just do that once at the end.  If you don't care about changing table names, then feel free to skip to the EF Migrations section.

## Specifying Custom Table Names
Next we'll specify our desired table names and schema within the `OnModelCreating` handler of `ApplicationDbContext`.  If your ApplicationDbContext doesn't already override OnModelCreating, then simply create your own override following my example.  Any customizations that we want to make should happen after the call to `base.OnModelCreating(builder);`.  As you'll see below, I'm updating the schema of each table to "AspNetIdentity", making the table names singular, and removing their "AspNet" prefix.  Take note that I'm also specifying that these tables should use an int primary key: If you want to stick with string keys, omit the int specification.
```csharp
protected override void OnModelCreating(ModelBuilder builder)
{
    base.OnModelCreating(builder);
    string schema = "AspNetIdentity";

    builder.Entity<ApplicationUser>(entity =>
        {
            entity.ToTable(name:"User",schema: schema);
        });

        builder.Entity<IdentityRole<int>>(entity =>
        {
            entity.ToTable(name: "Role", schema: schema);
        });

        builder.Entity<IdentityUserClaim<int>>(entity =>
        {
            entity.ToTable("UserClaim", schema);
        });

        builder.Entity<IdentityUserLogin<int>>(entity =>
        {
            entity.ToTable("UserLogin", schema);
        });

        builder.Entity<IdentityRoleClaim<int>>(entity =>
        {
            entity.ToTable("RoleClaim", schema);
        });

        builder.Entity<IdentityUserRole<int>>(entity =>
        {
            entity.ToTable("UserRole", schema);
        });

        builder.Entity<IdentityUserToken<int>>(entity =>
        {
            entity.ToTable("UserToken", schema);
        });
}
```
You can see my full ApplicationDbContext.cs [here](https://github.com/pfbrowning/identityserver4-quicker-quickstart-sql/blob/master/ApplicationDbContext.cs).
## Updating Our Tables
If you're changing the primary key type on a set of existing tables, then you'll probably get an error stating that "To change the IDENTITY property of a column, the column needs to be dropped and recreated.".  The simplest way to get around this is to just delete your existing Identity tables and re-create your tables from scratch with an EF migration.

To create or update our tables, we'll just run an EF migration.  Assuming you're using the Dotnet CLI, just run the following.  If you're using a different name for your ASP.NET Core Identity DB Context, then you'll obviously want to update that accordingly.
```
dotnet ef migrations add AspNetTableCustomizations -c ApplicationDbContext
dotnet ef database update -c ApplicationDbContext
```