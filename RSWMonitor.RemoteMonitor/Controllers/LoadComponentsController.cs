using Microsoft.AspNetCore.Mvc;
using RSWMonitor.RemoteMonitor.Data;
using RSWMonitor.RemoteMonitor.Models;

namespace RSWMonitor.RemoteMonitor.Controllers
{
    [NonController]
    public class LoadComponentsController : Controller
    {
        private readonly HealthChecksDbContext HealthChecksDbContext;
        public LoadComponentsController(HealthChecksDbContext healthChecksDbContext)
        {
            HealthChecksDbContext = healthChecksDbContext;
        }

        //    public List<Table_test> Index()
        //    {
        //List<Table_test>? test_table = HealthChecksDbContext.Test_table?.ToList();
        //        return test_table;
        //    }
        //}
    }
}
