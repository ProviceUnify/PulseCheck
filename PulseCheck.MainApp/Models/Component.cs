using System;
using System.Collections.Generic;

namespace PulseCheck.MainApp.Models
{
    public partial class Component
    {
        public int Id { get; set; }
        public int ComponentTypesId { get; set; }
        public int ConfigurationId { get; set; }
        public string ComponentName { get; set; } = null!;
        public string? ComponentRoletags { get; set; }
        public bool ComponentHasControls { get; set; }
        public string? ComponentTargetInfo { get; set; }

        public virtual ComponentType ComponentTypes { get; set; } = null!;
        public virtual Configuration Configuration { get; set; } = null!;
    }
}
