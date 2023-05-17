﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace RSWMonitor.RemoteMonitor.Models
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
        public string Uri { get; set; }
        public string Name { get; set; }
        public string DiscoveryService { get; set; }

        public virtual ICollection<HealthCheckExecutionEntry> HealthCheckExecutionEntries { get; set; }
        public virtual ICollection<HealthCheckExecutionHistory> HealthCheckExecutionHistories { get; set; }
    }
}