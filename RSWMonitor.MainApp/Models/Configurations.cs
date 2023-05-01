using System;
using System.Collections.Generic;

namespace RSWMonitor.MainApp.Models
{
    public partial class Configurations
    {
        public Configurations()
        {
            Components = new HashSet<Component>();
        }

        public int Id { get; set; }
        public string Uri { get; set; } = null!;
        public string Name { get; set; } = null!;
        public string? DiscoveryService { get; set; }

        public virtual ICollection<Component> Components { get; set; }
    }
}
