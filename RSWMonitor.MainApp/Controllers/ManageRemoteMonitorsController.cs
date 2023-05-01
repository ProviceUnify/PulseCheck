using IdentityModel.OidcClient;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using RSWMonitor.MainApp.Data;
using RSWMonitor.MainApp.Models;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Xml.Linq;

namespace RSWMonitor.MainApp.Controllers
{
    [Route("ManageRemoteMonitors/{action=Index}/{top?}")]
    [Authorize(Policy = "HealthManagers")]
    public class ManageRemoteMonitorsController : Controller
    {
        private readonly HealthChecksDbContext HealthChecksDbContext;
        private readonly RoleManager<IdentityRole> _roleManager;

        private Configurations configurations = new Configurations();
        //private ConfigurationTypes configurationTypes = new ConfigurationTypes();
        public ManageRemoteMonitorsController(HealthChecksDbContext HCContext, RoleManager<IdentityRole> roleManager)
        {
            HealthChecksDbContext = HCContext;
            _roleManager = roleManager;
        }
        public async Task<IActionResult> Index(string failure = "", int top = 50)
        {
            List<Configurations>? configurations = HealthChecksDbContext.Configurations?.Include(m => m.Components).ToList();

            // deleting predefined system roles from list
            List<ComponentTypes>? componentTypes = HealthChecksDbContext.ComponentTypes?.ToList();
            
            try
            {
                List<IdentityRole> Roles = await _roleManager.Roles.ToListAsync();
                var healthManagerRoleToDelete = await _roleManager.FindByNameAsync("Health manager");
                var userManagerRoleToDelete = await _roleManager.FindByNameAsync("User manager");
                Roles.Remove(healthManagerRoleToDelete);
                Roles.Remove(userManagerRoleToDelete);
                ViewBag.Roles = Roles;
            } catch { }

            ViewBag.ComponentTypes = componentTypes;
            ViewBag.failure = failure;

            return View(configurations);
        }

        [HttpPost]
        public async Task<RedirectToActionResult> AddConfiguration(IFormCollection formCollection)
        {
            List<string> selectedRoles = new List<string>();
            var formCollectionKeys = formCollection.Keys;
            foreach (var item in formCollectionKeys)
            {
                if (item.Contains("role-"))
                {
                    selectedRoles.Add((formCollection[item].ToString().Length < 8) ? formCollection[item].ToString() : formCollection[item].ToString()[..8]);
                }
            }
            
            var configurationProperties = new {
                id = Int32.Parse(formCollection["configuration-db-id"]),
                name = formCollection["configuration-name"],
                uri = formCollection["configuration-uri"],
                type = Int32.Parse(formCollection["configuration-type"]),
                hasControls = (formCollection["configuration-has-controls"] == "true" ? true : false),
                selectedRoles = selectedRoles
            };

            if (!(configurationProperties.name != "" && configurationProperties.uri != "" && configurationProperties.selectedRoles.Count > 0)) {
                return RedirectToAction("Index", routeValues: new { failure = $"Some of entered data was incorrect" });
            }
            var configurationRoles = JsonConvert.SerializeObject(selectedRoles);
            if (configurationProperties.id < 0)
            {
                Configurations configurations = new Configurations
                {
                    Name = configurationProperties.name,
                    Uri = configurationProperties.uri,
                    //HasControls = configurationProperties.hasControls,
                    //ConfigurationTypesId = configurationProperties.type,
                    //ConfigurationRoles = configurationRoles

                };
                HealthChecksDbContext.Configurations.Add(configurations);
            } else
            {
                Configurations? configurationToEdit = new Configurations();
                configurationToEdit = await HealthChecksDbContext.Configurations?.Where(c => c.Id == configurationProperties.id).FirstOrDefaultAsync();
                configurationToEdit.Name = configurationProperties.name;
                configurationToEdit.Uri = configurationProperties.uri;
                //configurationToEdit.HasControls = configurationProperties.hasControls;
                //configurationToEdit.ConfigurationTypesId = configurationProperties.type;
                //configurationToEdit.ConfigurationRoles = configurationRoles;
            }
            HealthChecksDbContext.SaveChanges();
            return RedirectToAction("Index", routeValues: new { failure = "" } );
        }

        [HttpPost]
        public IActionResult RemoveConfiguration(int configurationId = -1)
        {
            try
            {
                if (configurationId >= 0)
                {
                    Configurations? configurationToDelete = new Configurations();
                    configurationToDelete = HealthChecksDbContext.Configurations?.Where(c => c.Id == configurationId).FirstOrDefault();
                    HealthChecksDbContext.Configurations?.Remove(configurationToDelete!);
                    HealthChecksDbContext.SaveChanges();
                    return Ok();
                    //return RedirectToAction("Index");
                } else
                {
                    return BadRequest(Json(new { value = "Role name is empty!" }));
                }
            } catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }
        }
    }
}
