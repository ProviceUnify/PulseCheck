using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RSWMonitor.MainApp.Data;
using RSWMonitor.MainApp.Models;
using System.Linq;

namespace RSWMonitor.MainApp.Controllers
{
    [Route("ManageRemoteMonitors/{action=Index}/{parameter?}")]
    [Authorize(Policy = "HealthManagers")]
    public class ManageRemoteMonitorsController : Controller
    {
        private readonly HealthChecksDbContext _context;
        public ManageRemoteMonitorsController(HealthChecksDbContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            var configuration = new Configurations()
            {
                Uri = "t",
                Name = "t"
            };
            _context.Configurations.Add(configuration);
            _context.SaveChanges();
            configuration = _context.Configurations.Where(c => c.Name == "t").FirstOrDefault();

            _context.Configurations.Remove(configuration);
            _context.SaveChanges();
            return View();
        }
    }
}
