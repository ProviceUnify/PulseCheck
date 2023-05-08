using IdentityModel.OidcClient;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RSWMonitor.MainApp.Models;

namespace RSWMonitor.MainApp.Controllers
{
    [Route("ManageUsers/{action=Index}/{parameter?}")]
    [Authorize(Policy = "UserManagers")]
    public class ManageUsers : Controller
    {
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly SignInManager<IdentityUser> _signInManager;

        public ManageUsers(RoleManager<IdentityRole> roleManager, UserManager<IdentityUser> userManager, SignInManager<IdentityUser> signInManager)
        {
            _roleManager = roleManager;
            _userManager = userManager;
            _signInManager = signInManager;
        }
        public async Task<IActionResult> Index()
        {
            //await _roleManager.CreateAsync(new IdentityRole("Health manager"));
            //await _roleManager.CreateAsync(new IdentityRole("User manager"));
            UsersAndRolesViewModel usersAndRoles = new();
            var roles = await _roleManager.Roles.ToListAsync();
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
                } else if (isChecked)
                {
                    await _userManager.AddToRoleAsync(user, value);
                } else
                {
                    await _userManager.RemoveFromRoleAsync(user, value);
                }
                await _userManager.UpdateAsync(user);
            
                if (user.UserName == currentUser.UserName)
                {
                    await _signInManager.RefreshSignInAsync(currentUser);
                }

                //ApplicationUserManager.IsInRoleAsync(TKey userId, string role) // get user roles from db

                return Ok();
            } catch (Exception ex)
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
                return Ok();
            } catch (Exception ex)
            {
                return BadRequest(Json(new { value = ex.Message }));
            }
        }
        public async Task<IActionResult> RemoveRole(string roleName)
        {
            IdentityRole roleToDelete = await _roleManager.FindByNameAsync(roleName);
            var result = await _roleManager.DeleteAsync(roleToDelete);
            if (result.Succeeded)
            {
                return Ok();
            } else
            {
                return BadRequest(Json(new { value = result.Errors.First().Description }));
            }
        }
    }
}
