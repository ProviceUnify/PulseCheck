using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using RSWMonitor.MainApp.Data;
using RSWMonitor.MainApp.Models;

namespace RSWMonitor.MainApp.Controllers
{
    [Route("ManageRemoteMonitors/{action=Index}/{top?}")]
    [Authorize(Policy = "HealthManagers")]
    public class ManageRemoteMonitorsController : Controller
    {
        private readonly HealthChecksDbContext HealthChecksDbContext;
        public ManageRemoteMonitorsController(HealthChecksDbContext context)
        {
            HealthChecksDbContext = context;
        }
        
        public async Task<IActionResult> Index(int top = 3)
        {
            Configurations configurations = new Configurations();
            var result = HealthChecksDbContext.Configurations.Take(top);
            //HCDbContext.Configurations?.Add(configuration);
            //HCDbContext.SaveChanges();
            //configuration = HCDbContext.Configurations?.Where(c => c.Name == "t").FirstOrDefault();

            //HCDbContext.Configurations?.Remove(configuration!);
            //HCDbContext.SaveChanges();
            return View();
        }
    }
}
