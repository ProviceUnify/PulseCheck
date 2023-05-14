using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using RSWMonitor.MainApp.Models;
using System.Security.Claims;

namespace RSWMonitor.MainApp.Controllers
{
    [NonController]
    public class AddEntryToUserActionHistoryController : Controller
    {
        private readonly HealthChecksDBContext HealthChecksDbContext;
        private readonly UserManager<IdentityUser> _userManager;
        public AddEntryToUserActionHistoryController(HealthChecksDBContext HCContext, UserManager<IdentityUser> userManager)
        {
            HealthChecksDbContext = HCContext;
            _userManager = userManager;
        }
        public async Task<IActionResult> Add(ClaimsPrincipal user, sbyte userAction, string actionDetails = "")
        {
            try
            {
                IdentityUser currentUser = await _userManager.FindByNameAsync(user.Identity!.Name);
                HealthCheckUserActionLog newAction = new HealthCheckUserActionLog
                {
                    UserId = currentUser.Id,
                    ActionDetails = actionDetails,
                    UserActionId = userAction,
                    Datetime = DateTime.UtcNow
                };
                try
                {
                    await HealthChecksDbContext.HealthCheckUserActionLogs.AddAsync(newAction);
                }
                catch (Exception ex) { }
            }
            catch (Exception ex)
            {

            }
            HealthChecksDbContext.SaveChanges();
            return Ok();
        }
    }
}
