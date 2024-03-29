﻿using System;
using System.Collections.Generic;

namespace PulseCheck.RemoteMonitor.Models
{
    public partial class HealthCheckExecutionHistory
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public int Status { get; set; }
        public DateTime On { get; set; }
        public int? HealthCheckExecutionId { get; set; }

        public virtual Execution? HealthCheckExecution { get; set; }
        public virtual HealthStatus StatusNavigation { get; set; } = null!;
    }
}
