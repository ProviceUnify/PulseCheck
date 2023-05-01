using System;
using System.Collections.Generic;

namespace RSWMonitor.MainApp.Models
{
    public partial class Component
    {
        public int Id { get; set; }
        public int ComponentTypesId { get; set; }
        public int ConfigurationId { get; set; }
        public string ComponentName { get; set; } = null!;
        public string ComponentSignature { get; set; } = null!;
        public string? ComponentRoletags { get; set; }

        public virtual ComponentTypes ComponentTypes { get; set; } = null!;
        public virtual Configurations Configuration { get; set; } = null!;
    }
}
