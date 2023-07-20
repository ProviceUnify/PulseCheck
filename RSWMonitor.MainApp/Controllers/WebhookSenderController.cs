using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using NuGet.Protocol;
using RSWMonitor.MainApp.Models;
using RSWMonitor.MainApp.Services;
using System.Collections.Generic;
using System.Diagnostics;
using System.Security.Claims;
using System.Text;

namespace RSWMonitor.MainApp.Controllers
{
    [Authorize(Policy = "HealthManagers")]
    public class WebhookSenderController : Controller
    {
        private readonly HealthChecksDBContext _healthChecksDbContext;
        private readonly AddEntryToUserActionHistoryService _addEntry;
        private readonly UserManager<IdentityUser> _userManager;
        private static readonly HttpClient client = new HttpClient();

        public WebhookSenderController(HealthChecksDBContext HCContext, UserManager<IdentityUser> userManager)
        {
            _healthChecksDbContext = HCContext;
            _userManager = userManager;
            _addEntry = new AddEntryToUserActionHistoryService(_healthChecksDbContext, _userManager);
        }
        public async Task<IActionResult> SendWebhook(string url, int id = -1, int action = -1, string query = "", int type = -1, ClaimsPrincipal userClaims = null)
        {
            //String address = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.PathBase}"; // get global url (https://localhost...)
            try
            {
                var currentUser = User;
                string userId = "";
                if (currentUser == null)
                {
                    //userId = userClaims.Identities.First().Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier")!.Value;
                    currentUser = userClaims;

                } else
                {
                }
                    userId = currentUser.Identities.First().Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier")!.Value;
                //try
                //{
                //} catch (NullReferenceException ex)
                //{
                //    try
                //    {
                //    }
                //     catch
                //    {
                //        return BadRequest(Json(new { value = ex.Message }));
                //    }
                //}
                var currentComponent = _healthChecksDbContext.Components.Where(c => c.Id == id).FirstOrDefault();
                var content = new StringContent($@"{{
                'url': '{url}',
                'id': '{id}',
                'action': '{action}',
                'userId': '{userId}',
                'type': '{type}'
                }}", Encoding.UTF8, "application/json"); // setting data string

                var response = await client.PostAsync(new Uri($"{url}"), content); //sending

                if ((int)response.StatusCode == 200)
                {
                    if (action == 3) return Ok();
                    string performedAction = action switch
                    {
                        0 => "was started",
                        1 => "was restarted",
                        2 => "was stopped",
                        3 => "was changed",
                        _ => ""
                    };
                    sbyte performedActionId = action switch
                    {
                        0 => 6,
                        1 => 7,
                        2 => 8,
                        3 => 2,
                        _ => 2
                    };

                    await _addEntry.Add(currentUser, performedActionId, $"The component \"{currentComponent?.ComponentName}\" {performedAction}!");

                    return Ok();
                }

                try
                {
                    var responseObject = JsonConvert.DeserializeObject<Dictionary<String, Dictionary<String, Object>>>(response.Content.ReadAsStringAsync().Result);
                    var responseString = responseObject!["value"].Values.FirstOrDefault();
                    return BadRequest(Json(new { value = responseString }));

                } catch
                {
                    return BadRequest(Json(new { value = response.ReasonPhrase }));
                }

            } catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }

        }
    }
}
