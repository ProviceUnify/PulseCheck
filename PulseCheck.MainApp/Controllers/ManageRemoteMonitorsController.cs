using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using PulseCheck.MainApp.Models;
using PulseCheck.MainApp.Services;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.Json.Nodes;

namespace PulseCheck.MainApp.Controllers
{
    [Route("ManageRemoteMonitors/{action=Index}/{top?}")]
    [Authorize(Policy = "HealthManagers")]
    public class ManageRemoteMonitorsController : Controller
    {
        private readonly HealthChecksDBContext _healthChecksDbContext;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly AddEntryToUserActionHistoryService addEntry;
        private readonly WebhookSenderController _webhookSenderController;
        private static readonly HttpClient client = new HttpClient();
        public ManageRemoteMonitorsController(HealthChecksDBContext HCContext, RoleManager<IdentityRole> roleManager, UserManager<IdentityUser> userManager)
        {
            _healthChecksDbContext = HCContext;
            _roleManager = roleManager;
            _userManager = userManager;
            addEntry = new AddEntryToUserActionHistoryService(_healthChecksDbContext, _userManager);
            _webhookSenderController = new WebhookSenderController(_healthChecksDbContext, _userManager);
        }
        public async Task<IActionResult> Index(string failure = "")
        {
            List<Models.Configuration>? configurations = _healthChecksDbContext.Configurations?.Include(m => m.Components).ToList();
            // deleting predefined system roles from list
            List<ComponentType>? componentTypes = _healthChecksDbContext.ComponentTypes?.ToList();

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
                        string componentTargetInfo = formCollection[$"{{'prop':'component-targetInfo','row':{indexOfFormInput}}}"];
                        string componentRoletags = formCollection[$"{{'prop':'role','row':{indexOfFormInput}}}"];
                        int componentTypeId = Int32.Parse(formCollection[$"{{'prop':'component-type','row':{indexOfFormInput}}}"]);

                        bool componentHasControls = false;
                        try
                        {
                            componentHasControls = formCollection[$"{{'prop':'component-has-controls','row':{indexOfFormInput}}}"] == "on" ? true : false;
                        } catch
                        {
                            componentHasControls = false;
                        }
                        if (componentName == "" || componentTargetInfo == "" || componentRoletags == "")
                        {
                            return RedirectToAction("Index", routeValues: new { failure = $"Entered data of component was incorrect" });
                        }
                        List<string> rolesList;
                        try
                        {
                            rolesList = componentRoletags.Split(',').ToList();
                            componentRoletags = JsonConvert.SerializeObject(rolesList);

                        }
                        catch (Exception)
                        {

                            componentRoletags = JsonConvert.SerializeObject(new List<string>());
                        }

                        if (componentId < 0)
                            componentId = 0;
                        components.Add(new Component
                        {
                            Id = componentId,
                            ComponentName = componentName,
                            ComponentTargetInfo = componentTargetInfo,
                            ComponentTypesId = componentTypeId,
                            ComponentRoletags = componentRoletags,

                            ComponentHasControls = componentHasControls
                        });
                    }
                    catch (Exception)
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
                return RedirectToAction("Index", routeValues: new { failure = $"Entered data of configuration were incorrect" });
            }
            if (configurationBaseData.id < 0)
            {
                Models.Configuration configurations = new()
                {
                    Name = configurationBaseData.name,
                    Uri = configurationBaseData.uri,
                    Components = components

                };
                _healthChecksDbContext.Configurations.Add(configurations);
            }
            else
            {
                isUpdate = true;
                Models.Configuration? configurationToEdit = new();
                configurationToEdit = await _healthChecksDbContext.Configurations?.Where(c => c.Id == configurationBaseData.id).Include(m => m.Components).FirstOrDefaultAsync();
                configurationToEdit.Name = configurationBaseData.name;
                configurationToEdit.Uri = configurationBaseData.uri;
                configurationToEdit.Components = components;
            }
            await _healthChecksDbContext.SaveChangesAsync();
            if (isUpdate)
            {
                await addEntry.Add(User, 2, $"Configuration \"{configurationBaseData.name}\" with {componentsCount} component(s) was edited!");

            } else
            {
                await addEntry.Add(User, 1, $"New configuration \"{configurationBaseData.name}\" with {componentsCount} component(s) was added!");

            }
            await RestartConfiguration(configurationBaseData.uri, 3, configurationBaseData.id);
            return RedirectToAction("Index", routeValues: new { failure = "" });
        }

        [HttpPost]
        public async Task<IActionResult> RemoveConfiguration(int configurationId = -1)
        {
            try
            {
                if (configurationId >= 0)
                {
                    Configuration? configurationToDelete = new();
                    configurationToDelete = _healthChecksDbContext.Configurations?.Where(c => c.Id == configurationId).FirstOrDefault();
                    _healthChecksDbContext.Configurations?.Remove(configurationToDelete!);
                    await _healthChecksDbContext.SaveChangesAsync();
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

        private async Task<IActionResult> RestartConfiguration(string configurationUri, int action, int id)
        {
            configurationUri = configurationUri.Replace("/health", "/webhook");
            await _webhookSenderController.SendWebhook(configurationUri, action: action, userClaims: User, id: id);
            return Ok();
        }
    }
}
