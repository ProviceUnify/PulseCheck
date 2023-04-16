using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authorization;
using k8s.KubeConfigModels;

namespace SSWControl.Monitor.Controllers
{
    [Route("AddClaimToCurrentUser/{action}/{id?}")]
    [Authorize(Policy = "PromotedUsers")]
    public class AddClaimToCurrentUserController : Controller
    {
        public async Task<string> Index()
        {
            var serviceProvider = HttpContext.RequestServices;
            var roleManager = serviceProvider.GetService<RoleManager<IdentityRole>>(); // менеджер ролей
            var userManager = serviceProvider.GetService<UserManager<IdentityUser>>(); // менеджер пользователей
            var userFromDB = await userManager.FindByNameAsync(User.Identity.Name); // получить текущего пользователя

            // добавление роли в БД
            var TheRole = new IdentityRole("promoted");
            var result = await roleManager.CreateAsync(TheRole);

            // присвоение (удаление) пользователя к (из) роли
            result = await userManager.AddToRoleAsync(userFromDB, TheRole.Name);
            //result = await userManager.RemoveFromRoleAsync(userFromDB, TheRole.Name);
            userManager.UpdateAsync(userFromDB); // хз

            //string s;
            //await _userManager.RemoveClaimAsync(userFromDB, new Claim(ClaimTypes.Role, "promoted"));
            //var q1 = _userManager.GetClaimsAsync(userFromDB);
            //await _userManager.AddClaimAsync(userFromDB, new Claim(ClaimTypes.Role, "promoted"));
            //q1 = _userManager.GetClaimsAsync(userFromDB);
            //await _userManager.RemoveClaimAsync(userFromDB, new Claim(ClaimTypes.Role, "promoted"));
            //q1 = _userManager.GetClaimsAsync(userFromDB);
            //s = User.HasClaim(ClaimTypes.Role, "promoted").ToString();

            //var user = await _userManager.GetUserAsync(User);
            //var userId = user.Id;
            //user = await _userManager.FindByIdAsync(userId.ToString());
            //var claim = new Claim(ClaimTypes.Role, "promoted");
            //var addResult = _userManager.AddClaimAsync(user, claim);

            //identity.AddClaim(new Claim(ClaimTypes.Role, "promoted"));
            //var userManager = System.Web.HttpContext.Current.GetOwinContext().GetUserManager<ApplicationUserManager>();

            return "<_<";
        }
    }
}
