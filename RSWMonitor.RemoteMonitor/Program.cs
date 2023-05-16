using HealthChecks.UI.Client;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
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
                    // Конфигурация сервисов
                    services.AddDbContext<HealthChecksDBContext>(options =>
                        options.UseSqlServer(hostContext.Configuration.GetConnectionString("HealthChecksDBString")));
                    //services.AddControllersWithViews();
                });


        public static void Main(string[] args)
        {
            var webApplicationOptions = new WebApplicationOptions() {
                ContentRootPath = AppContext.BaseDirectory,
                Args = args,
                ApplicationName = System.Diagnostics.Process.GetCurrentProcess().ProcessName
            };
            var builder = WebApplication.CreateBuilder(webApplicationOptions);
            builder.Host.UseWindowsService();
            var host = CreateHostBuilder(args).Build();

            // Получаем сервис из контейнера зависимостей
            using var scope = host.Services.CreateScope();
            var services = scope.ServiceProvider;
            var healthChecksDbContext = services.GetRequiredService<HealthChecksDBContext>();
            // Add services to the container.

            var HealthChecksDBString = builder.Configuration.GetConnectionString("HealthChecksDBString") ?? throw new InvalidOperationException("Connection string 'HealthChecksDBString' not found.");
            builder.Services.AddDbContext<HealthChecksDBContext>(options =>
                options.UseSqlServer(HealthChecksDBString));
            builder.Services.AddDatabaseDeveloperPageExceptionFilter();
            builder.Services.AddControllers();
            //builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true)
            //    .AddEntityFrameworkStores<ApplicationDbContext>();
            //builder.Services.AddRazorPages();
            int thisRemoteMonitorConfigurationId = builder.Configuration.GetValue<int>("ConfigurationID");
            //var t = healthChecksDbContext.Configurations.Where(m => m.Id == thisRemoteMonitorConfigurationId).Include(m => m.Components);

            LoadConfigurationController loadConfiguration = new();
            builder = loadConfiguration.Load(builder, thisRemoteMonitorConfigurationId, healthChecksDbContext);
            //var t = healthChecksDbContext.Table_test;
            //foreach (var elem in t)
            //{
            //    builder.Services.AddHealthChecks().AddUrlGroup(new Uri(elem.Uri), elem.Name);
            //}
            #region hc impementation
            //builder.Services.AddHealthChecks().AddUrlGroup(new Uri("https://vk.com"), "VK");
            //builder.Services.AddHealthChecks().AddWindowsServiceHealthCheck("Rockstar Service", name: "tt", predicate: s => s.Status == ServiceControllerStatus.Running);
            //builder.Services.AddHealthChecks().AddProcessHealthCheck("mspaint", predicate: p => p.Length > 0, tags: new[] { "KSD", "EOL" });
            //builder.Services.AddHealthChecks().AddCheck<CheckByHttpRequest>("test1");
            //services.AddHealthChecks()
            //  .AddSqlServer(Configuration["ConnectionString"]) // Your database connection string
            //  .AddDiskStorageHealthCheck(s => s.AddDrive("C:\\", 1024)) // 1024 MB (1 GB) free minimum
            //  .AddProcessAllocatedMemoryHealthCheck(512) // 512 MB max allocated memory
            //  .AddProcessHealthCheck("ProcessName", p => p.Length > 0) // check if process is running
            //  .AddWindowsServiceHealthCheck("someservice", s => s.Status == ServiceControllerStatus.Running); // check if a windows service is running
            #endregion

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

            //app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            //app.UseAuthentication();
            //app.UseAuthorization();

            app.MapHealthChecks("/health", new HealthCheckOptions
            {
                ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse,
                ResultStatusCodes = new Dictionary<HealthStatus, int>
        {
            {HealthStatus.Healthy, StatusCodes.Status200OK},
            {HealthStatus.Degraded, StatusCodes.Status500InternalServerError},
            {HealthStatus.Unhealthy, StatusCodes.Status503ServiceUnavailable},
        },
                Predicate = _ => true
                //ResultStatusCodes =
                //{
                //    [HealthStatus.Healthy] = StatusCodes.Status200OK,
                //    [HealthStatus.Degraded] = StatusCodes.Status500InternalServerError,
                //    [HealthStatus.Unhealthy] = StatusCodes.Status503ServiceUnavailable
                //},
                //AllowCachingResponses = false
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