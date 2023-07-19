﻿using System;
using System.Collections.Generic;

namespace RSWMonitor.MainApp.Models
{
    public partial class AspNetRole
    {
        public string Id { get; set; } = null!;
        public string? Name { get; set; }
        public string? NormalizedName { get; set; }
        public string? ConcurrencyStamp { get; set; }
        public bool IsRemovable { get; set; }
    }
}
