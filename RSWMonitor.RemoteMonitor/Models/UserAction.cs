using System;
using System.Collections.Generic;

namespace RSWMonitor.RemoteMonitor.Models
{
    public partial class UserAction
    {
        public UserAction()
        {
            HealthCheckUserActionLogs = new HashSet<HealthCheckUserActionLog>();
        }

        public int UserActionId { get; set; }
        public string UserActionName { get; set; } = null!;

        public virtual ICollection<HealthCheckUserActionLog> HealthCheckUserActionLogs { get; set; }
    }
}
