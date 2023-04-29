using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using RSWMonitor.MainApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RSWMonitor.MainApp.Data
{
    public class HealthChecksDbContext : DbContext
    {
        public HealthChecksDbContext(DbContextOptions<HealthChecksDbContext> options) : base(options)
        {

        }
        public DbSet<Configurations>? Configurations { get; set; }
        public DbSet<ConfigurationTypes>? ConfigurationTypes { get; set; }
    }
}
