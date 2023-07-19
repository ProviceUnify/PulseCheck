using Microsoft.AspNetCore.Identity;

namespace RSWMonitor.MainApp.Models
{
    public class UsersAndRolesViewModel
    {
        public List<IdentityUser>? users;
        public List<AspNetRole>? roles;
    }
}
