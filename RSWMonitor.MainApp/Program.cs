using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using RSWMonitor.MainApp.Data;
using RSWMonitor.MainApp.Models;

namespace RSWMonitor.MainApp
{
    public class Program
    {
        // Программа пишется в спешке, поэтому никаких комментов
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            var AspDBConnectionString = builder.Configuration.GetConnectionString("AspDBConnectionString") ?? throw new InvalidOperationException("Connection string 'AspDBConnectionString' not found."); // ASP.NET default database
            var HealthChecksDBString = builder.Configuration.GetConnectionString("HealthChecksDBString") ?? throw new InvalidOperationException("Connection string 'HealthChecksDBString' not found."); // HealthChecks database

            // HealthChecks polling rate parameter
            builder.Configuration.AddJsonFile("healthcheck-settings.json");
            int health_check_pollingRate = builder.Configuration.GetSection("HealthChecksUI").GetValue<int>("PollingRate");

            builder.Services.AddDbContext<ApplicationDbContext>(options =>
                options.UseSqlServer(AspDBConnectionString));
            builder.Services.AddDbContext<HealthChecksDBContext>(options =>
                options.UseSqlServer(HealthChecksDBString), ServiceLifetime.Singleton);

            // Web session timeout (16h OR 1 session)
            builder.Services.ConfigureApplicationCookie(options => {
                options.Cookie.Name = "AspNetCore.Identity.Application";
                options.ExpireTimeSpan = TimeSpan.FromHours(16);
                options.SlidingExpiration = true;
            });

            builder.Services.AddDatabaseDeveloperPageExceptionFilter();
            builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true)
            .AddRoles<IdentityRole>()
            .AddEntityFrameworkStores<ApplicationDbContext>();
            builder.Services.AddRazorPages();
            builder.Services.AddControllers().AddNewtonsoftJson();


            builder.Services.AddHealthChecksUI(settings => {
                settings.SetEvaluationTimeInSeconds(health_check_pollingRate);
                settings.DisableDatabaseMigrations();
                settings.MaximumHistoryEntriesPerEndpoint(50);
                settings.AddWebhookNotification("webhook1", "/webhook", "{ message: \"Configuration [[LIVENESS]]: [[FAILURE]] - Description: [[DESCRIPTIONS]]\"}", "{message: \"[[LIVENESS]] is Ok\"}");
                settings.SetMinimumSecondsBetweenFailureNotifications(10);

            }).AddSqlServerStorage(HealthChecksDBString);
            //builder.Services.AddHealthChecksUI(settings => { settings.SetEvaluationTimeInSeconds(health_check_pollingRate); }).AddInMemoryStorage();
            
            // Setting policies
            builder.Services.AddAuthorization(options => {
                options.AddPolicy("Admins", policy => { policy.RequireRole("User manager"); policy.RequireRole("Health manager"); });
                //options.AddPolicy("Admins", policy => policy.RequireRole("User manager", "Health manager"));
                options.AddPolicy("HealthManagers", policy => policy.RequireRole("Health manager"));
                options.AddPolicy("UserManagers", policy => policy.RequireRole("User manager"));
            });

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            // Setting additional parameters for HealthChecksUI page
            try
            {
                app.MapHealthChecksUI(settings =>
                {
                    settings.AddCustomStylesheet("wwwroot\\css\\healthcheck_custom_style.css");
                    settings.AsideMenuOpened = false;
                }
                );
            }
            catch { }


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
            app.UseAuthentication();
            app.UseAuthorization();
            app.MapRazorPages();
            app.MapControllerRoute(
                name: "default",
                pattern: "{controller}/{action}/{id?}"
            );
            app.Run();
        }
    }
}

// https://www.telerik.com/blogs/checking-health-aspnet-core-apis