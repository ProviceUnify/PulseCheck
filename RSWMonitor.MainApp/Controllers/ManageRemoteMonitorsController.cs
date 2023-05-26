using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using RSWMonitor.MainApp.Models;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.Json.Nodes;

namespace RSWMonitor.MainApp.Controllers
{
    [Route("ManageRemoteMonitors/{action=Index}/{top?}")]
    [Authorize(Policy = "HealthManagers")]
    public class ManageRemoteMonitorsController : Controller
    {
        private readonly HealthChecksDBContext HealthChecksDbContext;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly AddEntryToUserActionHistoryController addEntry;
        private static readonly HttpClient client = new HttpClient();
        public ManageRemoteMonitorsController(HealthChecksDBContext HCContext, RoleManager<IdentityRole> roleManager, UserManager<IdentityUser> userManager)
        {
            HealthChecksDbContext = HCContext;
            _roleManager = roleManager;
            _userManager = userManager;
            addEntry = new AddEntryToUserActionHistoryController(HealthChecksDbContext, _userManager);
        }
        public async Task<IActionResult> Index(string failure = "")
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
            }
            catch { }

            ViewBag.ComponentTypes = componentTypes;
            ViewBag.failure = failure;

            return View(configurations);
        }

        [HttpPost]
        public async Task<RedirectToActionResult> AddConfiguration(IFormCollection formCollection)
        {
            bool isUpdate = false;
            int componentsCount = Int32.Parse(formCollection["components-count"]);
            List<Component> components = new();
            var configurationBaseData = new
            {
                id = Int32.Parse(formCollection["configuration-db-id"]),
                name = formCollection["configuration-name"],
                uri = formCollection["configuration-uri"]
            };

            try
            {
                for (int i = 0; i < componentsCount; i++)
                {
                    try
                    {
                        int indexOfFormInput = i + 1;
                        int componentId = Int32.Parse(formCollection[$"component-db-id-row-{indexOfFormInput}"]);
                        string componentName = formCollection[$"{{'prop':'component-name','row':{indexOfFormInput}}}"];
                        string componentQuery = formCollection[$"{{'prop':'component-query','row':{indexOfFormInput}}}"];
                        string componentRoletags = formCollection[$"{{'prop':'role','row':{indexOfFormInput}}}"];
                        int componentTypeId = Int32.Parse(formCollection[$"{{'prop':'component-type','row':{indexOfFormInput}}}"]);
                        componentQuery = componentQuery.Replace("\\","/");
                        string componentFullpathToExe = componentQuery;
                        componentQuery = Path.GetFileNameWithoutExtension(componentFullpathToExe);

                        bool componentHasControls = false;
                        try
                        {
                            componentHasControls = formCollection[$"{{'prop':'component-has-controls','row':{indexOfFormInput}}}"] == "on" ? true : false;
                        } catch
                        {
                            componentHasControls = false;
                        }
                        if (componentName == "" || componentQuery == "" || componentRoletags == "")
                        {
                            return RedirectToAction("Index", routeValues: new { failure = $"Entered data of component was incorrect" });
                        }
                        List<string> rolesList;
                        try
                        {
                            rolesList = componentRoletags.Split(',').ToList();
                            componentRoletags = JsonConvert.SerializeObject(rolesList);

                        }
                        catch (Exception ex)
                        {

                            componentRoletags = JsonConvert.SerializeObject(new List<string>());
                        }

                        if (componentId < 0)
                            componentId = 0;
                        components.Add(new Component
                        {
                            Id = componentId,
                            ComponentName = componentName,
                            ComponentQuery = componentQuery,
                            ComponentTypesId = componentTypeId,
                            ComponentRoletags = componentRoletags,
                            ComponentFullPathToExe = componentFullpathToExe,

                            ComponentHasControls = componentHasControls
                        });
                    }
                    catch (Exception ex)
                    {
                        componentsCount += 1;
                        continue;
                    }
                }
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", routeValues: new { failure = $"{ex.Message}" });
            }

            if (configurationBaseData.name == "" && configurationBaseData.uri == "")
            {
                return RedirectToAction("Index", routeValues: new { failure = $"Entered data of configuration was incorrect" });
            }
            if (configurationBaseData.id < 0)
            {
                Models.Configuration configurations = new()
                {
                    Name = configurationBaseData.name,
                    Uri = configurationBaseData.uri,
                    Components = components

                };
                HealthChecksDbContext.Configurations.Add(configurations);
            }
            else
            {
                isUpdate = true;
                Models.Configuration? configurationToEdit = new();
                configurationToEdit = await HealthChecksDbContext.Configurations?.Where(c => c.Id == configurationBaseData.id).Include(m => m.Components).FirstOrDefaultAsync();
                configurationToEdit.Name = configurationBaseData.name;
                configurationToEdit.Uri = configurationBaseData.uri;
                configurationToEdit.Components = components;
            }
            await HealthChecksDbContext.SaveChangesAsync();
            if (isUpdate)
            {
                await addEntry.Add(User, 2, $"Configuration \"{configurationBaseData.name}\" with {componentsCount} component(s) was edited!");

            } else
            {
                await addEntry.Add(User, 1, $"New configuration \"{configurationBaseData.name}\" with {componentsCount} component(s) was added!");

            }
            return RedirectToAction("Index", routeValues: new { failure = "" });
        }

        [HttpPost]
        public async Task<IActionResult> RemoveConfiguration(int configurationId = -1)
        {
            try
            {
                if (configurationId >= 0)
                {
                    Models.Configuration? configurationToDelete = new();
                    configurationToDelete = HealthChecksDbContext.Configurations?.Where(c => c.Id == configurationId).FirstOrDefault();
                    HealthChecksDbContext.Configurations?.Remove(configurationToDelete!);
                    await HealthChecksDbContext.SaveChangesAsync();
                    await addEntry.Add(User, 3, $"Configuration \"{configurationToDelete.Name}\" was removed!");
                    return Ok();
                    //return RedirectToAction("Index");
                }
                else
                {
                    return BadRequest(Json(new { value = "Role name is empty!" }));
                }
            }
            catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }
        }
    }
}
