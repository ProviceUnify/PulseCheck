using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using SSWControl.Data;

public class HCUI_Entries 
{
    public string Name { get; set; }
    public string Uri { get; set; }
}

public class HCUI
{
    public List<HCUI_Entries> HealthChecks = new List<HCUI_Entries>();
    public string? PollingRate = "10";

}
public class HC_Settings
{
    public HCUI? HealthChecksUI;
}
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
        builder.Services.AddControllers().AddNewtonsoftJson();
        builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true)
            .AddEntityFrameworkStores<ApplicationDbContext>(); //авторизация
        builder.Services.AddRazorPages();
        builder.Services.AddHealthChecksUI(settings => { settings.SetEvaluationTimeInSeconds(HC_pollingRate); }).AddInMemoryStorage(); // UI чекера здоровья

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

        // эксперименты с записью в json
        StreamReader r = new StreamReader("healthcheck-settings.json");
        var json = r.ReadToEnd();
        r.Close();
        HC_Settings ser = JsonConvert.DeserializeObject<HC_Settings>(json);
        ser.HealthChecksUI.HealthChecks.Add(new HCUI_Entries { Name = "ttt", Uri = "uuu"});
        ser.HealthChecksUI.HealthChecks.Add(new HCUI_Entries { Name = "zzz", Uri = "yyy"});
        ser.HealthChecksUI.PollingRate = "43";

        json = JsonConvert.SerializeObject(ser);
        JsonSerializer serializer = new JsonSerializer();
        serializer.Formatting = Formatting.Indented;
        using (StreamWriter sw = new StreamWriter("healthcheck-settings.json"))
        using (JsonWriter writer = new JsonTextWriter(sw))
        {
            serializer.Serialize(writer, ser);
        }

        app.Run();
    }
}