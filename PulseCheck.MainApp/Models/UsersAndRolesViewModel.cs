using Microsoft.AspNetCore.Identity;

namespace PulseCheck.MainApp.Models
{
    public class UsersAndRolesViewModel
    {
        public List<IdentityUser>? users;
        public List<AspNetRole>? roles;
    }
}
