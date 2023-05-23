using HealthChecks.UI.Client;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI.V4.Pages.Account.Manage.Internal;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Hosting.WindowsServices;
using RSWMonitor.RemoteMonitor.Controllers;
using RSWMonitor.RemoteMonitor.Data;
using RSWMonitor.RemoteMonitor.Models;
using System.ServiceProcess;

namespace RSWMonitor.RemoteMonitor
{
    public class Program
    {
        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureServices((hostContext, services) =>
                {
                    // ������������ ��������
                    services.AddDbContext<HealthChecksDBContext>(options =>
                        options.UseSqlServer(hostContext.Configuration.GetConnectionString("HealthChecksDBString")));
                    //services.AddControllersWithViews();
                });


        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            try
            {
                throw new Exception();
            } catch (Exception ex)
            {
                builder = WebApplication.CreateBuilder(args);
            }
            var host = CreateHostBuilder(args).Build();

            // �������� ������ �� ���������� ������������
            using var scope = host.Services.CreateScope();
            var services = scope.ServiceProvider;
            var healthChecksDbContext = services.GetRequiredService<HealthChecksDBContext>();
            // Add services to the container.

            var HealthChecksDBString = builder.Configuration.GetConnectionString("HealthChecksDBString") ?? throw new InvalidOperationException("Connection string 'HealthChecksDBString' not found.");
            var AspDBConnectionString = builder.Configuration.GetConnectionString("AspDBConnectionString") ?? throw new InvalidOperationException("Connection string 'AspDBConnectionString' not found.");
            builder.Services.AddDbContext<ApplicationDbContext>(options =>
                options.UseSqlServer(AspDBConnectionString));
            builder.Services.AddDbContext<HealthChecksDBContext>(options =>
                options.UseSqlServer(HealthChecksDBString)/*, ServiceLifetime.Singleton*/);
            builder.Services.AddDatabaseDeveloperPageExceptionFilter();
            builder.Services.AddControllers();
            builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = false)
            .AddRoles<IdentityRole>()
            .AddEntityFrameworkStores<ApplicationDbContext>();
            int thisRemoteMonitorConfigurationId = builder.Configuration.GetValue<int>("ConfigurationID");

            LoadConfigurationController loadConfiguration = new();
            builder = loadConfiguration.Load(builder, thisRemoteMonitorConfigurationId, healthChecksDbContext);

            var app = builder.Build();

            app.UseExceptionHandler(
                new ExceptionHandlerOptions()
                {
                    AllowStatusCode404Response = true, // important!
                    ExceptionHandlingPath = "/error"
                }
            );

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

            //app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            //app.UseAuthentication();
            //app.UseAuthorization();

            app.MapHealthChecks("/health", new HealthCheckOptions
            {
                ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse,
                ResultStatusCodes =
                {
                    [Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus.Healthy] = StatusCodes.Status200OK,
                    [Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus.Unhealthy] = StatusCodes.Status400BadRequest
                }
            });

            //app.MapRazorPages();
            app.MapControllerRoute(
                name: "default",
                pattern: "{controller}/{action}/{id?}"
            );
            app.Run();
        }
    }
}