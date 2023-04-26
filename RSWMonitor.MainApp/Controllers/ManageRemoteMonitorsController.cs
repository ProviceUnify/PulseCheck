using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using RSWMonitor.MainApp.Data;
using RSWMonitor.MainApp.Models;

namespace RSWMonitor.MainApp.Controllers
{
    [Route("ManageRemoteMonitors/{action=Index}/{parameter?}")]
    [Authorize(Policy = "HealthManagers")]
    public class ManageRemoteMonitorsController : Controller
    {
        private readonly HealthChecksDbContext HCDbContext;
        public ManageRemoteMonitorsController(HealthChecksDbContext context)
        {
            HCDbContext = context;
        }
        public IActionResult Index()
        {
            var configuration = new Configurations()
            {
                Uri = "t",
                Name = "t"
            };
            //HCDbContext.Configurations?.Add(configuration);
            //HCDbContext.SaveChanges();
            //configuration = HCDbContext.Configurations?.Where(c => c.Name == "t").FirstOrDefault();

            //HCDbContext.Configurations?.Remove(configuration!);
            //HCDbContext.SaveChanges();
            return View();
        }
    }
}
