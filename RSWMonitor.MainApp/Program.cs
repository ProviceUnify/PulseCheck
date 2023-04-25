using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using RSWMonitor.MainApp.Data;

namespace RSWMonitor.MainApp
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");

            builder.Configuration.AddJsonFile("healthcheck-settings.json"); // ������������� ������������ ������������ �����������
            int health_check_pollingRate = builder.Configuration.GetSection("HealthChecksUI").GetValue<int>("PollingRate");

            builder.Services.AddDbContext<ApplicationDbContext>(options =>
                options.UseSqlServer(connectionString));
            builder.Services.ConfigureApplicationCookie(options => {
                options.Cookie.Name = "AspNetCore.Identity.Application";
                options.ExpireTimeSpan = TimeSpan.FromHours(16);
                options.SlidingExpiration = true;
            });
            builder.Services.AddDatabaseDeveloperPageExceptionFilter();
            builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true)
            .AddRoles<IdentityRole>()
            .AddEntityFrameworkStores<ApplicationDbContext>(); //�����������
            builder.Services.AddRazorPages();

            builder.Services.AddControllers().AddNewtonsoftJson();

            builder.Services.AddHealthChecksUI(settings => { settings.SetEvaluationTimeInSeconds(health_check_pollingRate); }).AddSqlServerStorage(connectionString); // UI ������ ��������
            //builder.Services.AddHealthChecksUI(settings => { settings.SetEvaluationTimeInSeconds(health_check_pollingRate); }).AddInMemoryStorage(); // UI ������ ��������
            builder.Services.AddAuthorization(options => {
                options.AddPolicy("Admins", policy => { policy.RequireRole("User manager"); policy.RequireRole("Health manager"); });
                //options.AddPolicy("Admins", policy => policy.RequireRole("User manager", "Health manager"));
                options.AddPolicy("HealthManagers", policy => policy.RequireRole("Health manager"));
                options.AddPolicy("UserManagers", policy => policy.RequireRole("User manager"));
            });

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

            try
            {
                app.MapHealthChecksUI(settings =>
                {
                    settings.AddCustomStylesheet("wwwroot\\css\\healthcheck_custom_style.css");
                    settings.AsideMenuOpened = false;
                }
                ); // �������� ������ � HC ����� /healthchecks-ui
            }
            catch { }

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