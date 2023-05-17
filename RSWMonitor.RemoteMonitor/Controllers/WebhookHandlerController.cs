using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Diagnostics;
using System.ServiceProcess;
using Microsoft.Win32.TaskScheduler;

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
                //string sch = "test";
                //TaskDefinition td = TaskService.Instance.NewTask();
                //td.RegistrationInfo.Author = "RSWM monitor";
                //td.RegistrationInfo.Description = "test start";
                //td.Actions.Add(new ExecAction("D:\\Program Files\\Audacity\\Audacity.exe"));
                ////TaskService.Instance.RootFolder.RegisterTaskDefinition(sch, td).Run();

                //var folder = TaskService.Instance.RootFolder.CreateFolder("Test123");
                //folder.RegisterTaskDefinition(sch, td, TaskCreation.CreateOrUpdate, "Provice", "41274Provice_PC").Run();
                //folder.DeleteFolder("Test123");

                var process = new Process();
                process.StartInfo.UseShellExecute = false;
                process.StartInfo.FileName = controlParams.query;
                process.Start();

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
