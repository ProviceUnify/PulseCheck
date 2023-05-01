using System.ComponentModel.DataAnnotations;

namespace RSWMonitor.MainApp.Models
{
    public class ComponentTypes
    {
        [Key]
        public int ComponentTypesId { get; set; }
        public string? ComponentTypesName { get; set; }

    }
}