using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace SSWControl.Monitor.Controllers
{
    [Route("AddHealthCheckEntry/{action}/{id?}")]
    public class AddHealthCheckEntryController : Controller
    {
        public IActionResult Index()
        {
            

            //services.AddHealthChecks();
            //var serviceProvider = services.BuildServiceProvider();
            //var builder = serviceProvider.GetService<IHealthChecksBuilder>();


            //builder.AddCheck("MyDynamicCheck", () =>
            //{
            //    // Perform the health check logic
            //    return HealthCheckResult.Healthy();
            //});

            //services.AddSingleton<IHealthCheck>(sp =>
            //{
            //    var check = sp.GetService<HealthCheckResult>();
            //    return new HealthCheckRegistration(
            //        "MyDynamicCheck",
            //        check,
            //        failureStatus: HealthStatus.Degraded,
            //        tags: new[] { "mytag" }); ;
            //});


            return View();
        }
    }
}
