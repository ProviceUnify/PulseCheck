using System;
using System.Collections.Generic;

namespace RSWMonitor.RemoteMonitor.Models
{
    public partial class Component
    {
        public int Id { get; set; }
        public int ComponentTypesId { get; set; }
        public int ConfigurationId { get; set; }
        public string ComponentName { get; set; } = null!;
        public string ComponentQuery { get; set; } = null!;
        public string? ComponentRoletags { get; set; }
        public bool ComponentHasControls { get; set; }

        public virtual ComponentType ComponentTypes { get; set; } = null!;
        public virtual Configuration Configuration { get; set; } = null!;
    }
}
