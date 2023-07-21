using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using PulseCheck.RemoteMonitor.Models;
using PulseCheck.RemoteMonitor.Services;

namespace PulseCheck.RemoteMonitor.Controllers
{
    public class ControlParams
    {
        public string? url;
        public int id;
        public int action;
        public string? userId;
        public int type;
    }


    public class WebhookHandlerController : Controller
    {
        private enum componentActions : int
        {
            START,
            RESTART,
            STOP,
            APPLY
        }

        private readonly HealthChecksDBContext _healthChecksDbContext;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly ILogger<Controller> _logger;
        private readonly IConfiguration _configuration;
        private readonly IHostApplicationLifetime _hostApplicationLifetime;

        public WebhookHandlerController(HealthChecksDBContext HCContext, UserManager<IdentityUser> userManager, ILogger<Controller> logger, IHostApplicationLifetime appLifetime, IConfiguration configuration, IHostApplicationLifetime hostApplicationLifetime)
        {
            _healthChecksDbContext = HCContext;
            _userManager = userManager;
            _logger = logger;
            _configuration = configuration;
            _hostApplicationLifetime = hostApplicationLifetime;
        }

        enum MyEnum
        {

        }
        [HttpPost("/webhook")]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Interoperability", "CA1416:Validate platform compatibility", Justification = "<Pending>")]
        public async Task<IActionResult> HandleWebhook()
        {
            try
            {
                var payload = await new StreamReader(HttpContext.Request.Body).ReadToEndAsync();
                ControlParams? controlParams = JsonConvert.DeserializeObject<ControlParams>(payload);


                ComponentService componentService = new(_userManager, _logger, _healthChecksDbContext);
                ConfigurationService configurationService = new(_configuration, _logger, _hostApplicationLifetime);

                switch (controlParams.action)
                {
                    case (byte)componentActions.START:
                        return await componentService.StartComponent(controlParams);
                    case (byte)componentActions.RESTART:
                        return await componentService.RestartComponent(controlParams);
                    case (byte)componentActions.STOP:
                        return await componentService.StopComponent(controlParams);
                    case (byte)componentActions.APPLY:
                        return await configurationService.RestartConfiguration(controlParams);
                    default:
                        return BadRequest(Json(new { value = $"Requested unknown action" }));
                }
                #region outdated code
                //if (controlParams.action == 3)
                //{
                //    try
                //    {
                //        using IISSiteController.ISiteServices services = new IISSiteController.SiteServices();
                //        string siteName = _configuration.GetValue<String>("IISSiteName");
                //        _logger.LogInformation($"(Configuration ID: {controlParams.id}) applying settings for IIS site called as \"{siteName}\"...");
                //        Site site = services.GetSite(siteName);
                //        ApplicationLifetime.StopApplication();
                //        bool isRestarted = services.StartSite(siteName);
                //        _logger.LogInformation($"(Configuration ID: {controlParams.id}) was IIS site \"{siteName}\" restarted? {isRestarted}");
                //        #region outdated_code
                //        //bool running = services.SiteIsRunning(siteName);
                //        //_logger.LogInformation($"Configuration ID: {controlParams.id} is running? {running}");
                //        //services.StopSite(siteName);
                //        //bool stopped = services.SiteIsRunning(siteName);
                //        //_logger.LogInformation($"Configuration ID: {controlParams.id} is stopped? {stopped}");
                //        //Thread.Sleep(10000);
                //        //stopped = services.SiteIsRunning(siteName);
                //        //_logger.LogInformation($"Configuration ID: {controlParams.id} is stopped? {stopped}");

                //        //bool started = services.SiteIsRunning(siteName);
                //        //_logger.LogInformation($"Configuration ID: {controlParams.id} is started? {started}");
                //        #endregion
                //        return Ok();
                //    }
                //    catch (Exception ex)
                //    {
                //        _logger.LogError($"(Configuration ID: {controlParams.id}) applying settings error for IIS site got exception: {ex}");
                //        return BadRequest(Json(new { value = $"Unable apply settings for configuration: {ex.Message}" }));
                //    }

                //}
                ////foreach (var role in userRoles)
                ////{
                ////    if (componentRoles.Contains(role))
                ////    {
                ////        userCanControlComponent = true;
                ////    }
                ////}

                ////if (!userCanControlComponent)
                ////{
                ////    return BadRequest(Json(new { value = "You are not in neccessary role for control this component" }));
                ////}

                //string fullPath = currentComponent.ComponentFullPathToExe;
                //if (!currentComponent.ComponentHasControls)
                //{
                //    return BadRequest(Json(new { value = "Not supported" }));
                //}
                //switch (controlParams.type)
                //{
                //    case (1):
                //        var DBService = new ServiceController();
                //        DBService.ServiceName = "MSSQLSERVER"; // TEMP unknown what service will be on prod
                //        //service.MachineName = new Uri(controlParams.url).GetComponents(UriComponents.Host, UriFormat.UriEscaped); // TODO try to use ip of component watcher to control remote DB
                //        if (controlParams.action == 0) // start
                //        {
                //            if (DBService.Status == ServiceControllerStatus.Stopped)
                //            {
                //                DBService.Start();
                //            }
                //        }
                //        else if (controlParams.action == 1) // restart
                //        {
                //            DBService.Stop();
                //            DBService.WaitForStatus(ServiceControllerStatus.Stopped);
                //            DBService.Start();
                //        }
                //        else if (controlParams.action == 2) // Stop
                //        {
                //            if (DBService.Status == ServiceControllerStatus.Running)
                //            {
                //                DBService.Stop();
                //            }
                //        }
                //        break;
                //    case (2):
                //        var service = new ServiceController();
                //        service.ServiceName = currentComponent.ComponentQuery;
                //        //service.MachineName = new Uri(controlParams.url).GetComponents(UriComponents.Host, UriFormat.UriEscaped); // TODO try to use ip of component watcher to control remote DB
                //        if (controlParams.action == 0) // start
                //        {
                //            if (service.Status == ServiceControllerStatus.Stopped)
                //            {
                //                service.Start();
                //            }
                //        }
                //        else if (controlParams.action == 1) // restart
                //        {
                //            service.Stop();
                //            service.WaitForStatus(ServiceControllerStatus.Stopped);
                //            service.Start();
                //        }
                //        else if (controlParams.action == 2) // Stop
                //        {
                //            if (service.Status == ServiceControllerStatus.Running)
                //            {
                //                service.Stop();
                //            }
                //        }
                //        break;
                //    case (3):
                //        if (controlParams.action == 0) // start
                //        {
                //            var process = new Process();
                //            //process.StartInfo.UseShellExecute = false;
                //            process.StartInfo.FileName = fullPath;
                //            process.Start();
                //        }
                //        else if (controlParams.action == 1) // restart
                //        {
                //            string processName = Path.GetFileNameWithoutExtension(fullPath);
                //            Process[] process = Process.GetProcessesByName(processName);
                //            if (process.Length > 0)
                //            {
                //                process.First().Kill();
                //                process.First().WaitForExit();
                //            }
                //            Process newProcess = new Process();
                //            newProcess.StartInfo.UseShellExecute = false;
                //            newProcess.StartInfo.FileName = fullPath;
                //            newProcess.Start();
                //        }
                //        else if (controlParams.action == 2) // stop
                //        {
                //            string processName = Path.GetFileNameWithoutExtension(fullPath);
                //            Process[] process = Process.GetProcessesByName(processName);
                //            if (process.Length > 0)
                //            {
                //                process.First().Kill();
                //                process.First().WaitForExit();
                //            }
                //        }
                //        break;
                //    case (4):
                //        return BadRequest(Json(new { value = "Not supported" }));
                //    default:
                //        return BadRequest(Json(new { value = "Not supported" }));
                //        //break;
                //}
                #endregion
            }
            catch (Exception ex)
            {
                _logger.LogError(7151, $"Exception: {ex}");
                return BadRequest(Json(new { value = ex }));
            }
        }
    }
}
