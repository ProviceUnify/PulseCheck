﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace PulseCheck.MainApp.Models
{
    public partial class HealthStatus
    {
        public HealthStatus()
        {
            HealthCheckExecutionHistories = new HashSet<HealthCheckExecutionHistory>();
        }

        public int StatusId { get; set; }
        public string StatusName { get; set; }

        public virtual ICollection<HealthCheckExecutionHistory> HealthCheckExecutionHistories { get; set; }
    }
}