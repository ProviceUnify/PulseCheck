using System;
using System.Collections.Generic;

namespace PulseCheck.MainApp.Models
{
    public partial class ComponentType
    {
        public ComponentType()
        {
            Components = new HashSet<Component>();
        }

        public int ComponentTypesId { get; set; }
        public string? ComponentTypesName { get; set; }

        public virtual ICollection<Component> Components { get; set; }
    }
}
