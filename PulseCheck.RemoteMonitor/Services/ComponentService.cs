using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using PulseCheck.RemoteMonitor.Controllers;
using PulseCheck.RemoteMonitor.Models;
using System.Diagnostics;
using System.ServiceProcess;

namespace PulseCheck.RemoteMonitor.Services
{
    [NonController]
    public class ComponentService : Controller
    {
        private enum componentTypes : byte
        {
            MSSQL = 1,
            SERVICE,
            PROCESS,
            URL,
            MYSQL
        }

        private readonly UserManager<IdentityUser> _userManager;
        private readonly ILogger<Controller> _logger;
        private readonly HealthChecksDBContext _healthChecksDBContext;
        Component? component = null;

        private readonly string NLogControlFailedPhrase = "User ID \"{0}\" failed attempting to control component ID {1}";
        private readonly string ControlFailedNotInRolePhrase = "You are not in a neccessary role for control this component";
        private readonly string ControlFailedNotSupportedPhrase = "This component does not support control operations";
        private readonly string ControlFailedProcessNotStartedPhrase = "Something went wrong: process not started";
        private readonly string ControlFailedProcessNotStoppedPhrase = "Something went wrong: process not stopped";
        private readonly string ControlFailedServiceNotStartedPhrase = "Something went wrong: service not started";
        private readonly string ControlFailedServiceNotStoppedPhrase = "Something went wrong: service not stopped";

        public ComponentService(UserManager<IdentityUser> userManager, ILogger<Controller> logger, HealthChecksDBContext healthChecksDBContext)
        {
            _userManager = userManager;
            _logger = logger;
            _healthChecksDBContext = healthChecksDBContext;
        }

        private async Task<bool> IsUserCanControlThisComponent(string userId, Component component)
        {
            bool userCanControlComponent = false;
            IdentityUser user = await _userManager.FindByIdAsync(userId);
            var componentRoles = component.ComponentRoletags;
            var userRoles = await _userManager.GetRolesAsync(user);
            foreach (var role in userRoles)
            {
                if (componentRoles.Contains(role))
                {
                    userCanControlComponent = true;
                }
            }
            if (userCanControlComponent)
            {
                return userCanControlComponent;
            }
            _logger.LogError(7151, NLogControlFailedPhrase, userId, component.Id);
            return userCanControlComponent;
        }


        public async Task<IActionResult> StartComponent(ControlParams controlParams)
        {
            try
            {
                component = ReturnComponentByID(controlParams.id);
                if (!await IsUserCanControlThisComponent(controlParams.userId, component))
                {
                    return BadRequest(Json(new { value = ControlFailedNotInRolePhrase }));
                }
                switch (controlParams.type)
                {
                    case (byte)componentTypes.PROCESS:
                        return StartProgram(component);
                    case (byte)componentTypes.SERVICE:
                        return StartWindowsService(component, controlParams);
                    default:
                        return BadRequest(Json(new { value = ControlFailedNotSupportedPhrase }));
                }
            }
            catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }
        }

        public async Task<IActionResult> StopComponent(ControlParams controlParams)
        {
            try
            {
                component = ReturnComponentByID(controlParams.id);
                if (!await IsUserCanControlThisComponent(controlParams.userId, component))
                {
                    return BadRequest(Json(new { value = ControlFailedNotInRolePhrase }));
                }
                switch (controlParams.type)
                {
                    case (byte)componentTypes.PROCESS:
                        return StopProgram(component);
                    case (byte)componentTypes.SERVICE:
                        return StopWindowsService(component, controlParams);
                    default:
                        return BadRequest(Json(new { value = ControlFailedNotSupportedPhrase }));
                }
            }
            catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }
        }

        public async Task<IActionResult> RestartComponent(ControlParams controlParams)
        {
            try
            {
                component = ReturnComponentByID(controlParams.id);
                if (!await IsUserCanControlThisComponent(controlParams.userId, component))
                {
                    return BadRequest(Json(new { value = ControlFailedNotInRolePhrase }));
                }
                switch (controlParams.type)
                {
                    case (byte)componentTypes.PROCESS:
                        StopProgram(component);
                        return StartProgram(component);
                    case (byte)componentTypes.SERVICE:
                        StopWindowsService(component, controlParams);
                        return StartWindowsService(component, controlParams);
                    default:
                        return BadRequest(Json(new { value = ControlFailedNotSupportedPhrase }));
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private IActionResult StartProgram(Component component)
        {
            try
            {
                var process = new Process();
                string processName = Path.GetFileNameWithoutExtension(component.ComponentTargetInfo);
                if (Process.GetProcessesByName(processName).Length == 0)
                {
                    process.StartInfo.FileName = component.ComponentTargetInfo;
                    process.Start();

                    if (Process.GetProcessesByName(processName).Length == 0) return BadRequest(Json(new { value = ControlFailedProcessNotStartedPhrase }));
                    return Ok();
                }
                return Ok();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private IActionResult StopProgram(Component component)
        {
            try
            {
                string processName = Path.GetFileNameWithoutExtension(component.ComponentTargetInfo);
                Process[] process = Process.GetProcessesByName(processName);
                if (process.Length > 0)
                {
                    process.First().Kill();
                    process.First().WaitForExit();
                    if (Process.GetProcessesByName(processName).Length == 0) return Ok();
                    return BadRequest(Json(new { value = ControlFailedProcessNotStoppedPhrase }));
                }
                return Ok();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Interoperability", "CA1416:Validate platform compatibility", Justification = "<Pending>")]
        private IActionResult StartWindowsService(Component component, ControlParams controlParams)
        {
            try
            {
                var service = new ServiceController();
                service.ServiceName = component.ComponentTargetInfo;
                service.MachineName = new Uri(controlParams.url).GetComponents(UriComponents.Host, UriFormat.UriEscaped);
                if (service.Status == ServiceControllerStatus.Stopped)
                {
                    service.Start();
                    service.WaitForStatus(ServiceControllerStatus.Running);
                    _logger.LogWarning(7151, $"Is running? {service.Status == ServiceControllerStatus.Running}. Is pending start? {service.Status == ServiceControllerStatus.StartPending}");
                    if (service.Status == ServiceControllerStatus.Running || service.Status == ServiceControllerStatus.StartPending) return Ok();
                    return BadRequest(Json(new { value = ControlFailedServiceNotStartedPhrase }));
                }
                return Ok();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Interoperability", "CA1416:Validate platform compatibility", Justification = "<Pending>")]
        private IActionResult StopWindowsService(Component component, ControlParams controlParams)
        {
            try
            {
                var service = new ServiceController();
                service.ServiceName = component.ComponentTargetInfo;
                service.MachineName = new Uri(controlParams.url).GetComponents(UriComponents.Host, UriFormat.UriEscaped);
                if (service.Status == ServiceControllerStatus.Running)
                {
                    service.Stop();
                    service.WaitForStatus(ServiceControllerStatus.Stopped);
                    _logger.LogWarning(7151, $"Is stopped? {service.Status == ServiceControllerStatus.Stopped}. Is pending stop? {service.Status == ServiceControllerStatus.StopPending}");
                    if (service.Status == ServiceControllerStatus.Stopped || service.Status == ServiceControllerStatus.StopPending) return Ok();
                    return BadRequest(Json(new { value = ControlFailedServiceNotStoppedPhrase }));
                }
                return Ok();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private Component ReturnComponentByID(int id)
        {
            return _healthChecksDBContext.Components.Where(c => c.Id == id).First();
        }
    }
}
