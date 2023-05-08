using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using RSWMonitor.MainApp.Models;
using System.Data;

namespace RSWMonitor.MainApp.Controllers
{
    [Route("History/{action=Index}/{top?}")]
    [Authorize(Policy = "HealthManagers")]
    public class HistoryController : Controller
    {
        private readonly HealthChecksDBContext HealthChecksDbContext;

        //private Models.Configuration configurations = new();
        //private ConfigurationTypes configurationTypes = new ConfigurationTypes();
        public HistoryController(HealthChecksDBContext HCContext)
        {
            HealthChecksDbContext = HCContext;
        }
        public IActionResult Index()
        {
            Dictionary<int, string> foundConfigurations = new Dictionary<int, string>();
            foreach (var item in HealthChecksDbContext.Executions.ToList())
            {
                var t = HealthChecksDbContext.Configurations.Where(s => s.Name == item.Name && s.Uri == item.Uri);
                foundConfigurations.Add(t.First().Id, t.First().Name);
            }
            var history = HealthChecksDbContext.Executions.Include(s => s.HealthCheckExecutionHistories).ToList();
            ViewBag.Statuses = HealthChecksDbContext.HealthStatuses.ToList();
            ViewData.Add(new KeyValuePair<string, object?>("foundConfigurations", foundConfigurations));
            return View(history);
        }
    }
}
