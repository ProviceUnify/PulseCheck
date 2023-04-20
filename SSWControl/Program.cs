using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using SSWControl.Data;
using SSWControl.Monitor;

internal class Program
{
    private static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);
        // Add services to the container.
        var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
        builder.Configuration.AddJsonFile("healthcheck-settings.json"); // настраиваемая конфигурация подключенных компонентов
        int HC_pollingRate = builder.Configuration.GetSection("HealthChecksUI").GetValue<int>("PollingRate");
        
        builder.Services.AddDbContext<ApplicationDbContext>(options =>
            options.UseSqlServer(connectionString));
        builder.Services.AddDatabaseDeveloperPageExceptionFilter();
        builder.Services.AddControllers();
        builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true)
            .AddRoles<IdentityRole>()
            .AddEntityFrameworkStores<ApplicationDbContext>(); //авторизация
        builder.Services.AddRazorPages();

        builder.Services.AddControllers().AddNewtonsoftJson();
        builder.Services.AddHealthChecksUI(settings => { settings.SetEvaluationTimeInSeconds(HC_pollingRate); }).AddInMemoryStorage(); // UI чекера здоровья
        builder.Services.AddAuthorization(options => {
            options.AddPolicy("Admins", policy => policy.RequireRole("user_manager", "health_manager"));
            options.AddPolicy("HealthManagers", policy => policy.RequireRole("health_manager"));
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
            ); // включает доступ к HC через /healthchecks-ui
        }
        catch { }
        app.UseAuthentication();
        app.UseAuthorization();
        app.MapRazorPages();

        app.MapControllerRoute(
            name: "default",
            pattern: "{controller}/{action}/{id?}");

        // эксперименты с записью в json
        StreamReader r = new StreamReader("healthcheck-settings.json");
        var json = r.ReadToEnd();
        r.Close();
        HealthChecksClass ser = JsonConvert.DeserializeObject<HealthChecksClass>(json);
        //ser.HealthChecksUI.HealthChecks.Add(new HealthCheckEntries { Name = "ttt", Uri = "uuu"});
        //ser.HealthChecksUI.HealthChecks.Add(new HealthCheckEntries { Name = "zzz", Uri = "yyy"});
        //ser.HealthChecksUI.PollingRate = "43";

        //json = JsonConvert.SerializeObject(ser);
        //JsonSerializer serializer = new JsonSerializer();
        //serializer.Formatting = Formatting.Indented;
        //using (StreamWriter sw = new StreamWriter("healthcheck-settings.json"))
        //using (JsonWriter writer = new JsonTextWriter(sw))
        //{
        //    serializer.Serialize(writer, ser);
        //}
        app.Run();

    }
}