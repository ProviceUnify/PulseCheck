using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Text;

namespace RSWMonitor.MainApp.Controllers
{

    public class SendWebhookController : Controller
    {
        private static readonly HttpClient client = new HttpClient();
        public async Task<IActionResult> SendWebhook(string url, int id, int action, string query, int type)
        {
            //String address = $"{this.Request.Scheme}://{this.Request.Host}{this.Request.PathBase}"; // get global url (https://localhost...)
            try
            {
                var content = new StringContent($@"{{
                'url': '{ url }',
                'id': '{ id }',
                'action': '{ action }',
                'query': '{ query }',
                'type': '{ type }'
                }}", Encoding.UTF8, "application/json"); // setting data string
                var response = await client.PostAsync(new Uri($"{url}"), content); //sending
                var responseString = await response.Content.ReadAsStringAsync(); // response
                if (!((int)response.StatusCode == 200))
                {
                    return BadRequest(Json(new { value = response.ReasonPhrase }));
                }
                return Ok();

            } catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }

        }
    }
}
