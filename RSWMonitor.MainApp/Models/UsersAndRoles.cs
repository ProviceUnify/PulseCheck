using Microsoft.AspNetCore.Identity;

namespace RSWMonitor.MainApp.Models
{
    public class UsersAndRoles
    {
        public List<IdentityUser>? users;
        public List<IdentityRole>? roles;
    }
}
