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
        private Configurations configurations = new Configurations();
        public ManageRemoteMonitorsController(HealthChecksDbContext context)
        {
            HealthChecksDbContext = context;
        }

        //[HttpPost]
        public async Task<IActionResult> Index(int top = 50)
        {
            List<Configurations> Configurations = HealthChecksDbContext.Configurations.Take(top).ToList();
            //HCDbContext.Configurations?.Add(configuration);
            //HCDbContext.SaveChanges();
            //configuration = HCDbContext.Configurations?.Where(c => c.Name == "t").FirstOrDefault();

            //HCDbContext.Configurations?.Remove(configuration!);
            //HCDbContext.SaveChanges();
            return View(Configurations);
        }

        [HttpPost]
        public async Task<RedirectToActionResult> AddConfiguration(IFormCollection formCollection)
        {

            Configurations configurationToRemove = HealthChecksDbContext.Configurations.Where(c => c.Name == formCollection["uri"].ToString()).FirstOrDefault();
            HealthChecksDbContext.Configurations.Remove(configurationToRemove);
            HealthChecksDbContext.SaveChanges();
            //await Index();
            return RedirectToAction("Index");
            //return View("Index");
        }
    }
}
