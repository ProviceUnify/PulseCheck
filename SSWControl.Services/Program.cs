using HealthChecks.UI.Client;
using Microsoft.AspNetCore.Authentication.Certificate;
using Microsoft.AspNetCore.Diagnostics.HealthChecks;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using SSWControl.Services.Data;
using SSWControl.Services.HealthChecks;
using System.ServiceProcess;

var builder = WebApplication.CreateBuilder(args);

//services.AddHealthChecks()
//  .AddSqlServer(Configuration["ConnectionString"]) // Your database connection string
//  .AddDiskStorageHealthCheck(s => s.AddDrive("C:\\", 1024)) // 1024 MB (1 GB) free minimum
//  .AddProcessAllocatedMemoryHealthCheck(512) // 512 MB max allocated memory
//  .AddProcessHealthCheck("ProcessName", p => p.Length > 0) // check if process is running
//  .AddWindowsServiceHealthCheck("someservice", s => s.Status == ServiceControllerStatus.Running); // check if a windows service is running


// Add services to the container.
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));
builder.Services.AddDatabaseDeveloperPageExceptionFilter();
//builder.Services.AddAuthentication(CertificateAuthenticationDefaults.AuthenticationScheme)
//    .AddCertificate(options =>
//    {
//        options.AllowedCertificateTypes = CertificateTypes.All;
//    });

builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true)
    .AddEntityFrameworkStores<ApplicationDbContext>();
builder.Services.AddRazorPages();
builder.Services.AddHealthChecks().AddUrlGroup(new Uri("https://vk.com"), "VK");
builder.Services.AddHealthChecks().AddWindowsServiceHealthCheck("Rockstar Service", predicate: s => s.Status == ServiceControllerStatus.Running);
builder.Services.AddHealthChecks().AddProcessHealthCheck("CalculatorApp", predicate: p => p.Length > 0);
builder.Services.AddHealthChecks().AddCheck<CheckByHttpRequest>("test1");
//builder.Services.AddHealthChecks().AddCheck<CheckByOtherHttpRequest>("test2");


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
app.UseAuthentication();
app.UseAuthorization();
//app.MapControllers();
app.MapHealthChecks("/health", new HealthCheckOptions()
{
    ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse
});
app.MapRazorPages();

app.Run();
