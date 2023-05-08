using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Newtonsoft.Json;
using RSWMonitor.RemoteMonitor.Models;
using System.ServiceProcess;

namespace RSWMonitor.RemoteMonitor.Controllers
{
    [NonController]
    public class LoadConfigurationController : Controller
    {
        public WebApplicationBuilder Load(WebApplicationBuilder builder, int ConfigurationId, HealthChecksDBContext DbContext)
        {
            Configuration configuration = DbContext.Configurations.Where(m => m.Id == ConfigurationId).Include(m => m.Components).FirstOrDefault();
            var builderAddHealthCheck = builder.Services.AddHealthChecks();
            if (configuration?.Components.Count > 0)
            {
                foreach (var component in configuration.Components)
                {
                    List<string> roleTags = JsonConvert.DeserializeObject<List<string>>(component.ComponentRoletags);

                    switch (component.ComponentTypesId)
                    {
                        case 1:
                            builderAddHealthCheck.AddSqlServer(component.ComponentQuery, "SELECT 1", name: component.ComponentName, tags: roleTags);
                            break;
                        case 2:
                            builderAddHealthCheck.AddWindowsServiceHealthCheck(component.ComponentQuery, s => s.Status == ServiceControllerStatus.Running, name: component.ComponentName, tags: roleTags);
                            break;
                        case 3:
                            builderAddHealthCheck.AddProcessHealthCheck(component.ComponentQuery, p => p.Length > 0, component.ComponentName, tags: roleTags);
                            break;
                        case 4:
                            builderAddHealthCheck.AddUrlGroup(new Uri(component.ComponentQuery), component.ComponentName, tags: roleTags, timeout: TimeSpan.FromSeconds(30));
                            break;
                        case 5:
                            // implement custom health check dll
                            break;
                        default:

                            break;
                    }
                }
            }
            else
            {
                builderAddHealthCheck.AddProcessHealthCheck("You are the best captain on the planet. I'm not even squidding", p => p.Length > 0, "<no components were specified>", HealthStatus.Degraded);
            }
            //builder.Services.AddHealthChecks().AddProcessHealthCheck("mspaint", predicate: p => p.Length > 0, tags: new[] { "KSD", "EOL" });

            return builder;
        }
    }
}
