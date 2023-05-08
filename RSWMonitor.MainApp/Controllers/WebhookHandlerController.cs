using Microsoft.AspNetCore.Mvc;

namespace RSWMonitor.MainApp.Controllers
{
    public class WebhookHandlerController : Controller
    {
        [HttpPost("/webhook")]
        public async Task<IActionResult> WebhookNotifier()
        {
            var payload = await new StreamReader(HttpContext.Request.Body).ReadToEndAsync();
            return Ok();
        }
    }
}
