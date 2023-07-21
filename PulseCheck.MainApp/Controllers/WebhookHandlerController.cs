using Microsoft.AspNetCore.Mvc;

namespace PulseCheck.MainApp.Controllers
{
    public class WebhookHandlerController : Controller
    {
        [HttpPost("/webhook")]
        public async Task<IActionResult> WebhookNotifier()
        {
            // potential point of resolving problem with hostory log

            var payload = await new StreamReader(HttpContext.Request.Body).ReadToEndAsync();
            return Ok();
        }
    }
}
