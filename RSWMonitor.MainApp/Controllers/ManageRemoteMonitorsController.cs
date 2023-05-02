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
        private readonly HealthChecksDBContext HealthChecksDbContext;
        private readonly RoleManager<IdentityRole> _roleManager;

        private Models.Configuration configurations = new Models.Configuration();
        //private ConfigurationTypes configurationTypes = new ConfigurationTypes();
        public ManageRemoteMonitorsController(HealthChecksDBContext HCContext, RoleManager<IdentityRole> roleManager)
        {
            HealthChecksDbContext = HCContext;
            _roleManager = roleManager;
        }
        public async Task<IActionResult> Index(string failure = "", int top = 50)
        {
            List<Models.Configuration>? configurations = HealthChecksDbContext.Configurations?.Include(m => m.Components).ToList();

            // deleting predefined system roles from list
            List<ComponentType>? componentTypes = HealthChecksDbContext.ComponentTypes?.ToList();
            
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
            var jsonItem = new { prop = "", row = 0 };
            var formCollectionKeys = formCollection.Keys;
            var configurationBaseData = new
            {
                id = Int32.Parse(formCollection["configuration-db-id"]),
                name = formCollection["configuration-name"],
                uri = formCollection["configuration-uri"]
            };

            List<Component> components = new List<Component>();
            bool hasComponents;
            if (Int32.Parse(formCollection["components-count"]) > 0)
            {
                hasComponents = true;
                foreach (var item in formCollectionKeys)
                {
                    if (item.Contains("{'prop':"))
                    {
                        jsonItem = JsonConvert.DeserializeAnonymousType(item, jsonItem);
                        // TO DO: переделать всё к чертям

                        //var t = jsonItem.row;
                        //components.Insert(jsonItem.row, jsonItem.prop);
                        //components.Add();
                        //selectedRoles.Add((formCollection[item].ToString().Length < 8) ? formCollection[item].ToString() : formCollection[item].ToString()[..8]);
                    }
                }
                        return RedirectToAction("Index", routeValues: new { failure = "" });
            }
            //var configurationProperties = new {
            //    id = Int32.Parse(formCollection["configuration-db-id"]),
            //    name = formCollection["configuration-name"],
            //    uri = formCollection["configuration-uri"],
            //    type = Int32.Parse(formCollection["configuration-type"]),
            //    hasControls = (formCollection["configuration-has-controls"] == "true" ? true : false),
            //    selectedRoles = components
            //};

            if (!(configurationBaseData.name != "" && configurationBaseData.uri != "")) {
                return RedirectToAction("Index", routeValues: new { failure = $"Some of entered data was incorrect" });
            }
            var configurationRoles = JsonConvert.SerializeObject(components);
            if (configurationBaseData.id < 0)
            {
                Models.Configuration configurations = new Models.Configuration
                {
                    Name = configurationBaseData.name,
                    Uri = configurationBaseData.uri,
                    Components = components
                    //HasControls = configurationProperties.hasControls,
                    //ConfigurationTypesId = configurationProperties.type,
                    //ConfigurationRoles = configurationRoles

                };
                HealthChecksDbContext.Configurations.Add(configurations);
            } else
            {
                Models.Configuration? configurationToEdit = new Models.Configuration();
                configurationToEdit = await HealthChecksDbContext.Configurations?.Where(c => c.Id == configurationBaseData.id).FirstOrDefaultAsync();
                configurationToEdit.Name = configurationBaseData.name;
                configurationToEdit.Uri = configurationBaseData.uri;
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
                    Models.Configuration? configurationToDelete = new Models.Configuration();
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
