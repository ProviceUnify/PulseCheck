using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Diagnostics;
using System.ServiceProcess;
using Microsoft.Win32.TaskScheduler;
using RSWMonitor.RemoteMonitor.Models;
using Microsoft.AspNetCore.Identity;
using System.Linq;
using AutoMapper;
using System.Runtime.InteropServices;

namespace RSWMonitor.RemoteMonitor.Controllers
{
    class ControlParams
    {
        public string? url;
        public int id;
        public int action;
        public string? userId;
        public int type;
    }

    public class WebhookHandlerController : Controller
    {
        private readonly HealthChecksDBContext HealthChecksDbContext;
        private readonly UserManager<IdentityUser> _userManager;
        public WebhookHandlerController(HealthChecksDBContext HCContext, UserManager<IdentityUser> userManager)
        {
            HealthChecksDbContext = HCContext;
            _userManager = userManager;
        }

        [HttpPost("/webhook")]
        public async Task<IActionResult> WebhookNotifier()
        {
            // TODO Add ability to self reload
            try
            {
                var payload = await new StreamReader(HttpContext.Request.Body).ReadToEndAsync();
                ControlParams? controlParams = JsonConvert.DeserializeObject<ControlParams>(payload);
                var currentComponent = HealthChecksDbContext.Components.Where(c => c.Id == controlParams.id).First();
                var user = await _userManager.FindByIdAsync(controlParams.userId);
                string componentRoles = currentComponent.ComponentRoletags;
                var userRoles = await _userManager.GetRolesAsync(user);
                bool userCanControlComponent = false;
                foreach (var role in userRoles)
                {
                    if (componentRoles.Contains(role))
                    {
                        userCanControlComponent = true;
                    }
                }

                if (!userCanControlComponent)
                {
                    return BadRequest(Json(new { value = "You are not in neccessary role for control this component" }));
                }

                string fullPath = currentComponent.ComponentFullPathToExe;
                if (!currentComponent.ComponentHasControls)
                {
                    return BadRequest(Json(new { value = "Not supported" }));
                }
                switch (controlParams.type)
                {
                    case (1):
                        var DBService = new ServiceController();
                        DBService.ServiceName = "MSSQLSERVER"; // TEMP unknown what service will be on prod
                        //service.MachineName = new Uri(controlParams.url).GetComponents(UriComponents.Host, UriFormat.UriEscaped); // TODO try to use ip of component watcher to control remote DB
                        if (controlParams.action == 0) // start
                        {
                            if (DBService.Status == ServiceControllerStatus.Stopped)
                            {
                                DBService.Start();
                            }
                        } else if (controlParams.action == 1) // restart
                        {
                            DBService.Stop();
                            DBService.WaitForStatus(ServiceControllerStatus.Stopped);
                            DBService.Start();
                        } else if (controlParams.action == 2) // Stop
                        {
                            if (DBService.Status == ServiceControllerStatus.Running)
                            {
                                DBService.Stop();
                            }
                        }
                            break;
                    case (2):
                        var service = new ServiceController();
                        service.ServiceName = currentComponent.ComponentQuery;
                        //service.MachineName = new Uri(controlParams.url).GetComponents(UriComponents.Host, UriFormat.UriEscaped); // TODO try to use ip of component watcher to control remote DB
                        if (controlParams.action == 0) // start
                        {
                            if (service.Status == ServiceControllerStatus.Stopped)
                            {
                                service.Start();
                            } 
                        }
                        else if (controlParams.action == 1) // restart
                        {
                            service.Stop();
                            service.WaitForStatus(ServiceControllerStatus.Stopped);
                            service.Start();
                        }
                        else if (controlParams.action == 2) // Stop
                        {
                            if (service.Status == ServiceControllerStatus.Running)
                            {
                                service.Stop();
                            }
                        }
                        break;
                    case (3):
                        if (controlParams.action == 0) // start
                        {
                            var process = new Process();
                            //process.StartInfo.UseShellExecute = false;
                            process.StartInfo.FileName = fullPath;
                            process.Start();
                        } else if (controlParams.action == 1) // restart
                        {
                            string processName = Path.GetFileNameWithoutExtension(fullPath);
                            Process[] process = Process.GetProcessesByName(processName);
                            if (process.Length > 0)
                            {
                                process.First().Kill();
                                process.First().WaitForExit();
                            }
                            Process newProcess = new Process();
                            newProcess.StartInfo.UseShellExecute = false;
                            newProcess.StartInfo.FileName = fullPath;
                            newProcess.Start();
                        } else if (controlParams.action == 2) // stop
                        {
                            string processName = Path.GetFileNameWithoutExtension(fullPath);
                            Process[] process = Process.GetProcessesByName(processName);
                            if (process.Length > 0)
                            {
                                process.First().Kill();
                                process.First().WaitForExit();
                            }
                        }
                        break;
                    case (4):
                        return BadRequest(Json(new { value = "Not supported" }));
                    default:
                        return BadRequest(Json(new { value = "Not supported" }));
                        //break;
                }


                return Ok(fullPath);
            } catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }
        }
    }
}
