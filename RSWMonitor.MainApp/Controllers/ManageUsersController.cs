using k8s.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using RSWMonitor.MainApp.Models;

namespace RSWMonitor.MainApp.Controllers
{
    [Route("ManageUsers/{action=Index}/{parameter?}")]
    [Authorize]
    public class ManageUsers : Controller
    {
        private readonly RoleManager<IdentityRole> roleManager;
        private readonly UserManager<IdentityUser> userManager;
        public ManageUsers(RoleManager<IdentityRole> _roleManager, UserManager<IdentityUser> _userManager)
        {
            roleManager = _roleManager;
            userManager = _userManager;
        }
        public async Task<IActionResult> Index()
        {

            UsersAndRoles usersAndRoles = new UsersAndRoles();
            var roles = roleManager.Roles.ToList();
            var users = userManager.Users.ToList();
            
            usersAndRoles.roles = roles;
            usersAndRoles.users = users;
            return View(usersAndRoles);
        }
        public async Task<IActionResult> CreateRole()
        {
            //await roleManager.CreateAsync(new IdentityRole("User manager"));
            //await roleManager.CreateAsync(new IdentityRole("Health manager"));

            return View();
        }
    }
}
