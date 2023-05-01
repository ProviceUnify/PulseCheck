using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using RSWMonitor.MainApp.Models;

namespace RSWMonitor.MainApp.Data
{
    public partial class HealthChecksDbContext : DbContext
    {
        public HealthChecksDbContext()
        {
        }

        public HealthChecksDbContext(DbContextOptions<HealthChecksDbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Component> Components { get; set; } = null!;
        public virtual DbSet<ComponentTypes> ComponentTypes { get; set; } = null!;
        public virtual DbSet<Configurations> Configurations { get; set; } = null!;
        public virtual DbSet<Execution> Executions { get; set; } = null!;
        public virtual DbSet<Failure> Failures { get; set; } = null!;
        public virtual DbSet<HealthCheckExecutionEntry> HealthCheckExecutionEntries { get; set; } = null!;
        public virtual DbSet<HealthCheckExecutionHistory> HealthCheckExecutionHistories { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=localhost;Database=HealthChecksDB;Trusted_Connection=True;MultipleActiveResultSets=true");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Component>(entity =>
            {
                entity.Property(e => e.ComponentName).HasMaxLength(500);

                entity.Property(e => e.ComponentRoletags).HasMaxLength(500);

                entity.Property(e => e.ComponentSignature).HasMaxLength(500);

                entity.Property(e => e.ComponentTypesId).HasDefaultValueSql("((1))");

                entity.HasOne(d => d.ComponentTypes)
                    .WithMany(p => p.Components)
                    .HasForeignKey(d => d.ComponentTypesId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Components_ComponentTypes");

                entity.HasOne(d => d.Configuration)
                    .WithMany(p => p.Components)
                    .HasForeignKey(d => d.ConfigurationId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Components_Configurations");
            });

            modelBuilder.Entity<ComponentTypes>(entity =>
            {
                entity.HasKey(e => e.ComponentTypesId);

                entity.Property(e => e.ComponentTypesId).ValueGeneratedNever();

                entity.Property(e => e.ComponentTypesName).HasMaxLength(500);
            });

            modelBuilder.Entity<Configurations>(entity =>
            {
                entity.HasIndex(e => e.Id, "IX_Configurations");

                entity.Property(e => e.DiscoveryService).HasMaxLength(100);

                entity.Property(e => e.Name).HasMaxLength(500);

                entity.Property(e => e.Uri).HasMaxLength(500);
            });

            modelBuilder.Entity<Execution>(entity =>
            {
                entity.Property(e => e.DiscoveryService).HasMaxLength(50);

                entity.Property(e => e.Name).HasMaxLength(500);

                entity.Property(e => e.Uri).HasMaxLength(500);
            });

            modelBuilder.Entity<Failure>(entity =>
            {
                entity.Property(e => e.HealthCheckName).HasMaxLength(500);
            });

            modelBuilder.Entity<HealthCheckExecutionEntry>(entity =>
            {
                entity.HasIndex(e => e.HealthCheckExecutionId, "IX_HealthCheckExecutionEntries_HealthCheckExecutionId");

                entity.Property(e => e.Name).HasMaxLength(500);

                entity.HasOne(d => d.HealthCheckExecution)
                    .WithMany(p => p.HealthCheckExecutionEntries)
                    .HasForeignKey(d => d.HealthCheckExecutionId);
            });

            modelBuilder.Entity<HealthCheckExecutionHistory>(entity =>
            {
                entity.HasIndex(e => e.HealthCheckExecutionId, "IX_HealthCheckExecutionHistories_HealthCheckExecutionId");

                entity.Property(e => e.Name).HasMaxLength(500);

                entity.HasOne(d => d.HealthCheckExecution)
                    .WithMany(p => p.HealthCheckExecutionHistories)
                    .HasForeignKey(d => d.HealthCheckExecutionId);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
