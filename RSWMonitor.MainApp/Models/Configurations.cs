using System.ComponentModel.DataAnnotations;
namespace RSWMonitor.MainApp.Models
{
    public class Configurations
    {
        public int Id { get; set; }
        public string? Uri { get; set; }
        public string? Name { get; set; }
        public string? ConfigurationRoles { get; set; }
        public bool HasControls { get; set; }
        public int? ConfigurationTypesId { get; set; }
        public ConfigurationTypes? ConfigurationTypes { get; set; }
    }
    public class ConfigurationTypes
    {
        [Key]
        public int ConfigurationTypesId { get; set; }
        public string? ConfigurationTypesName { get; set; }
    }
}
