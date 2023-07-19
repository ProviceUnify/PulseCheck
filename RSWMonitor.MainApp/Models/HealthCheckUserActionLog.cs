using System;
using System.Collections.Generic;

namespace RSWMonitor.MainApp.Models
{
    public partial class HealthCheckUserActionLog
    {
        public int UserActionEntryId { get; set; }
        public string UserId { get; set; } = null!;
        public string ActionDetails { get; set; } = null!;
        public int UserActionId { get; set; }
        public DateTime? Datetime { get; set; }

        public virtual AspNetUser User { get; set; } = null!;
        public virtual UserAction UserAction { get; set; } = null!;
    }
}
