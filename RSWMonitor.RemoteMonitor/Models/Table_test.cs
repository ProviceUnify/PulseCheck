using System.ComponentModel.DataAnnotations;

namespace RSWMonitor.RemoteMonitor.Models
{
    public class Table_test
    {
        [Key]
        public int Id { get; set; }
        public int ConfigurationId { get; set; }
        public int ConfigurationTypesId { get; set; }
        public string? Uri { get; set; }
        public string? Name { get; set; }
    }
}
