using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PulseCheck.MainApp.Models;
using PulseCheck.MainApp.Services;

namespace PulseCheck.MainApp.Controllers
{
    [Route("ManageUsers/{action=Index}/{parameter?}")]
    [Authorize(Policy = "UserManagers")]
    public class ManageUsers : Controller
    {
        private readonly HealthChecksDBContext HealthChecksDbContext;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly SignInManager<IdentityUser> _signInManager;
        private readonly AddEntryToUserActionHistoryService addEntry;

        public ManageUsers(HealthChecksDBContext HCContext, RoleManager<IdentityRole> roleManager, UserManager<IdentityUser> userManager, SignInManager<IdentityUser> signInManager)
        {
            HealthChecksDbContext = HCContext;
            _roleManager = roleManager;
            _userManager = userManager;
            _signInManager = signInManager;
            addEntry = new AddEntryToUserActionHistoryService(HealthChecksDbContext, _userManager);
        }
        public async Task<IActionResult> Index()
        {
            UsersAndRolesViewModel usersAndRoles = new();
            var roles = await HealthChecksDbContext.AspNetRoles.OrderByDescending(k => k.IsRemovable).ToListAsync();
            var users = await _userManager.Users.ToListAsync();


            usersAndRoles.roles = roles;
            usersAndRoles.users = users;
            return View(usersAndRoles);
        }
        [HttpPost]
        public async Task<IActionResult> SaveUsersRoles(string name, string value, bool isChecked)
        {
            try
            {
                IdentityUser user = await _userManager.FindByNameAsync(name);
                IdentityUser currentUser = await _userManager.FindByNameAsync(User.Identity!.Name);
                if (value == "EmailConfirmed" && isChecked)
                {
                    user.EmailConfirmed = true;
                    await addEntry.Add(User, 10, $"Confirmation of new user: \"{user.UserName}\"!");
                }
                else if (isChecked)
                {
                    await _userManager.AddToRoleAsync(user, value);
                    await addEntry.Add(User, 9, $"Adding user \"{user.UserName}\" to role \"{value}\"!");
                }
                else
                {
                    await _userManager.RemoveFromRoleAsync(user, value);
                    await addEntry.Add(User, 9, $"Removing user \"{user.UserName}\" from role \"{value}\"!");
                }
                await _userManager.UpdateAsync(user);

                if (user.UserName == currentUser.UserName)
                {
                    await _signInManager.RefreshSignInAsync(currentUser);
                }

                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }
        }

        public async Task<IActionResult> CreateRole(string roleName)
        {
            try
            {
                if (string.IsNullOrEmpty(roleName))
                {
                    return BadRequest(Json(new { value = "Role name is empty!" }));
                }
                await _roleManager.CreateAsync(new IdentityRole(roleName));
                await addEntry.Add(User, 11, $"Adding new role: \"{roleName}\"!");
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }
        }
        public async Task<IActionResult> RemoveRole(string roleName)
        {
            if (!(bool)HealthChecksDbContext.AspNetRoles.Where(r => r.Name == roleName).FirstOrDefault().IsRemovable)
            {
                return BadRequest(Json(new { value = "Role not suppossed to be deleted" }));
            }
            IdentityRole roleToDelete = await _roleManager.FindByNameAsync(roleName);
            var result = await _roleManager.DeleteAsync(roleToDelete);
            if (result.Succeeded)
            {
                await addEntry.Add(User, 12, $"Removing role: \"{roleName}\"!");
                return Ok();
            }
            else
            {
                return BadRequest(Json(new { value = result.Errors.First().Description }));
            }
        }
    }
}
