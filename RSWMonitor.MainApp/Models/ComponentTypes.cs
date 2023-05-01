using System;
using System.Collections.Generic;

namespace RSWMonitor.MainApp.Models
{
    public partial class ComponentTypes
    {
        public ComponentTypes()
        {
            Components = new HashSet<Component>();
        }

        public int ComponentTypesId { get; set; }
        public string? ComponentTypesName { get; set; }

        public virtual ICollection<Component> Components { get; set; }
    }
}
