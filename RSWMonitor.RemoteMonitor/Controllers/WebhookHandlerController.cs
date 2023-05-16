using Azure;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Diagnostics;
using System.ServiceProcess;


namespace RSWMonitor.RemoteMonitor.Controllers
{
    class ControlParams
    {
        public string? url;
        public int id;
        public int action;
        public string? query;
        public int type;
    }
    public class WebhookHandlerController : Controller
    {
        [HttpPost("/webhook")]
        public async Task<IActionResult> WebhookNotifier()
        {
            try
            {
                var payload = await new StreamReader(HttpContext.Request.Body).ReadToEndAsync();
                ControlParams? controlParams = JsonConvert.DeserializeObject<ControlParams>(payload);
                var process = new Process();
                process.StartInfo.UseShellExecute = false;
                process.StartInfo.FileName = controlParams.query;
                //process.StartInfo.CreateNoWindow = true;
                process.Start();
                //var process = Process.GetProcessesByName(controlParams.query);
                //process.First().Kill();

                return Ok(controlParams.query);
            } catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }
            //Environment.Exit(1);
            //string serviceName = "RSWMonitor Service";
            
            //ServiceController serviceController = new ServiceController(serviceName);
            //int tickCount1 = Environment.TickCount;
            //int tickCount2 = Environment.TickCount;
            //TimeSpan timeout = TimeSpan.FromMilliseconds(1000);
            //serviceController.Stop();
            //serviceController.WaitForStatus(ServiceControllerStatus.Stopped, timeout);

            //timeout = TimeSpan.FromMilliseconds(1000 - (tickCount1 - tickCount2));
            //serviceController.Start();
            //serviceController.WaitForStatus(ServiceControllerStatus.Running, timeout);

        }
    }
}
