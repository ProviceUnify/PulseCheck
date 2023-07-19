using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using RSWMonitor.MainApp.Models;
using System.Security.Claims;

namespace RSWMonitor.MainApp.Services
{
    [NonController]
    public class AddEntryToUserActionHistoryService : Controller
    {
        private readonly HealthChecksDBContext _healthChecksDbContext;
        private readonly UserManager<IdentityUser> _userManager;
        public AddEntryToUserActionHistoryService(HealthChecksDBContext HCContext, UserManager<IdentityUser> userManager)
        {
            _healthChecksDbContext = HCContext;
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
                    await _healthChecksDbContext.HealthCheckUserActionLogs.AddAsync(newAction);
                }
                catch (Exception ex) { }
            }
            catch (Exception ex)
            {

            }
            _healthChecksDbContext.SaveChanges();
            return Ok();
        }
    }
}
