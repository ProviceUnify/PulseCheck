using System;
using System.Collections.Generic;

namespace RSWMonitor.MainApp.Models
{
    public partial class Execution
    {
        public Execution()
        {
            HealthCheckExecutionEntries = new HashSet<HealthCheckExecutionEntry>();
            HealthCheckExecutionHistories = new HashSet<HealthCheckExecutionHistory>();
        }

        public int Id { get; set; }
        public int Status { get; set; }
        public DateTime OnStateFrom { get; set; }
        public DateTime LastExecuted { get; set; }
        public string Uri { get; set; } = null!;
        public string Name { get; set; } = null!;
        public string? DiscoveryService { get; set; }

        public virtual ICollection<HealthCheckExecutionEntry> HealthCheckExecutionEntries { get; set; }
        public virtual ICollection<HealthCheckExecutionHistory> HealthCheckExecutionHistories { get; set; }
    }
}
