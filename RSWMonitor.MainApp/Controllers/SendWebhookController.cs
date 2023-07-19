using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using NuGet.Protocol;
using RSWMonitor.MainApp.Models;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;

namespace RSWMonitor.MainApp.Controllers
{
    [Authorize(Policy = "HealthManagers")]
    public class SendWebhookController : Controller
    {
        private readonly HealthChecksDBContext HealthChecksDbContext;
        private readonly AddEntryToUserActionHistoryController addEntry;
        private readonly UserManager<IdentityUser> _userManager;
        private static readonly HttpClient client = new HttpClient();

        public SendWebhookController(HealthChecksDBContext HCContext, UserManager<IdentityUser> userManager)
        {
            HealthChecksDbContext = HCContext;
            _userManager = userManager;
            addEntry = new AddEntryToUserActionHistoryController(HealthChecksDbContext, _userManager);
        }
        public async Task<IActionResult> SendWebhook(string url, int id, int action, string query, int type)
        {
            //String address = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.PathBase}"; // get global url (https://localhost...)
            try
            {
                var userId = User.Identities.First().Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier")!.Value;
                var currentComponent = HealthChecksDbContext.Components.Where(c => c.Id == id).FirstOrDefault();
                var content = new StringContent($@"{{
                'url': '{url}',
                'id': '{id}',
                'action': '{action}',
                'userId': '{userId}',
                'type': '{type}'
                }}", Encoding.UTF8, "application/json"); // setting data string

                // TODO remote component restart
                var response = await client.PostAsync(new Uri($"{url}"), content); //sending

                if ((int)response.StatusCode == 200)
                {
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

                    await addEntry.Add(User, performedActionId, $"The component \"{currentComponent?.ComponentName}\" {performedAction}!");

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
