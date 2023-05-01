using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using RSWMonitor.RemoteMonitor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RSWMonitor.RemoteMonitor.Data
{
    public class HealthChecksDbContext : DbContext
    {
        public HealthChecksDbContext(DbContextOptions<HealthChecksDbContext> options) : base(options)
        {

        }
        public DbSet<Table_test>? Table_test { get; set; }
    }
}
