using System;
using System.Collections.Generic;

namespace PulseCheck.MainApp.Models
{
    public partial class HealthCheckExecutionEntry
    {
        public int Id { get; set; }
        public string Name { get; set; } = null!;
        public int Status { get; set; }
        public string? Description { get; set; }
        public TimeSpan Duration { get; set; }
        public int? HealthCheckExecutionId { get; set; }
        public string? Tags { get; set; }

        public virtual Execution? HealthCheckExecution { get; set; }
    }
}
