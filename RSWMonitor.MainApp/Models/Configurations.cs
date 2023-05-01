using System.ComponentModel.DataAnnotations;
namespace RSWMonitor.MainApp.Models
{
    public class Configurations
    {
        public int Id { get; set; }
        public string? Uri { get; set; }
        public string? Name { get; set; }
    }
}
