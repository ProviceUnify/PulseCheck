using System;
using System.Collections.Generic;

namespace PulseCheck.RemoteMonitor.Models
{
    public partial class HealthStatus
    {
        public HealthStatus()
        {
            HealthCheckExecutionHistories = new HashSet<HealthCheckExecutionHistory>();
        }

        public int StatusId { get; set; }
        public string StatusName { get; set; } = null!;

        public virtual ICollection<HealthCheckExecutionHistory> HealthCheckExecutionHistories { get; set; }
    }
}
