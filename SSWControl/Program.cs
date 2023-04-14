using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using SSWControl.Data;


internal class Program
{
    private static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);
        // Add services to the container.
        var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
        builder.Services.AddDbContext<ApplicationDbContext>(options =>
            options.UseSqlServer(connectionString));
        builder.Services.AddDatabaseDeveloperPageExceptionFilter();

        builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true)
            .AddEntityFrameworkStores<ApplicationDbContext>(); //авторизация
        builder.Services.AddRazorPages();
        builder.Services.AddHealthChecksUI().AddInMemoryStorage(); // UI чекера здоровья

        var app = builder.Build();

        // Configure the HTTP request pipeline.
        if (app.Environment.IsDevelopment())
        {
            app.UseMigrationsEndPoint();
        }
        else
        {
            app.UseExceptionHandler("/Error");
            // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
            app.UseHsts();
        }

        app.UseHttpsRedirection();
        app.UseStaticFiles();
        app.UseRouting();
        app.MapHealthChecksUI(settings =>
            {
                settings.AddCustomStylesheet("wwwroot\\css\\healthcheck_custom_style.css");
                settings.AsideMenuOpened = false;
            }
        ); // включает доступ к HC через /healthchecks-ui
        app.UseAuthentication();
        app.UseAuthorization();
        app.MapRazorPages();
        app.Run();

    }
}