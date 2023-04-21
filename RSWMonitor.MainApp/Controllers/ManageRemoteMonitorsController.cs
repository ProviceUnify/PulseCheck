using Microsoft.AspNetCore.Mvc;

namespace RSWMonitor.MainApp.Controllers
{
    public class ManageRemoteMonitorsController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
