using Microsoft.AspNetCore.Identity;

namespace RSWMonitor.RemoteMonitor.Models
{
    public class UsersAndRolesViewModel
    {
        public List<IdentityUser>? users;
        public List<IdentityRole>? roles;
    }
}
