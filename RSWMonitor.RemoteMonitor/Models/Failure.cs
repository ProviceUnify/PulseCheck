using System;
using System.Collections.Generic;

namespace RSWMonitor.RemoteMonitor.Models
{
    public partial class Failure
    {
        public int Id { get; set; }
        public string HealthCheckName { get; set; } = null!;
        public DateTime LastNotified { get; set; }
        public bool IsUpAndRunning { get; set; }
    }
}
