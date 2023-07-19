using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using RSWMonitor.RemoteMonitor.Models;
using System.ServiceProcess;

namespace RSWMonitor.RemoteMonitor.Controllers
{
    [NonController]
    public class ConfigurationLoaderController : Controller
    {
        private HealthChecksDBContext DbContext;
        public ConfigurationLoaderController(HealthChecksDBContext _DbContext)
        {
            DbContext = _DbContext;
        }

        public WebApplicationBuilder Load(WebApplicationBuilder builder, int ConfigurationId)
        {
            Configuration? configuration = DbContext.Configurations.Where(m => m.Id == ConfigurationId).Include(m => m.Components).First();
            var builderAddHealthCheck = builder.Services.AddHealthChecks();
            if (configuration?.Components.Count > 0)
            {
                foreach (var component in configuration.Components)
                {
                    List<string>? roleTags = JsonConvert.DeserializeObject<List<string>>(component.ComponentRoletags);



                    switch (component.ComponentTypesId)
                    {
                        case 1:
                            builderAddHealthCheck.AddSqlServer(component.ComponentFullPathToExe, "SELECT 1", name: component.ComponentName, tags: roleTags, failureStatus: Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus.Unhealthy); // wrong name of prop
                            break;
                        case 2:
                            builderAddHealthCheck.AddWindowsServiceHealthCheck(component.ComponentQuery, s => s.Status == ServiceControllerStatus.Running, name: component.ComponentName, tags: roleTags);
                            break;
                        case 3:
                            // process name for health check; full path with .exe for controls
                            builderAddHealthCheck.AddProcessHealthCheck(component.ComponentQuery, p => p.Length > 0, component.ComponentName, tags: roleTags);
                            break;
                        case 4:
                            builderAddHealthCheck.AddUrlGroup(new Uri(component.ComponentQuery), component.ComponentName, tags: roleTags, timeout: TimeSpan.FromSeconds(30));
                            break;
                        case 5:
                            builderAddHealthCheck.AddMySql(component.ComponentFullPathToExe, component.ComponentName, tags: roleTags);
                            break;
                        case 6:
                            // implement custom health check dll
                            break;
                        default:

                            break;
                    }
                }
            }
            else
            {
                builderAddHealthCheck.AddProcessHealthCheck("You are the best captain on the planet. I'm not even squidding", p => p.Length > 0, "<no components were specified>", Microsoft.Extensions.Diagnostics.HealthChecks.HealthStatus.Degraded);
            }
            return builder;
        }
    }
}
