using Microsoft.AspNetCore.Identity;

namespace PulseCheck.RemoteMonitor.Models
{
    public class UsersAndRolesViewModel
    {
        public List<IdentityUser>? users;
        public List<IdentityRole>? roles;
    }
}
