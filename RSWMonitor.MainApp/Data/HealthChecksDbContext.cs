﻿using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace RSWMonitor.MainApp.Models
{
    public partial class HealthChecksDBContext : DbContext
    {
        public HealthChecksDBContext()
        {
        }

        public HealthChecksDBContext(DbContextOptions<HealthChecksDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Component> Components { get; set; } = null!;
        public virtual DbSet<ComponentType> ComponentTypes { get; set; } = null!;
        public virtual DbSet<Configuration> Configurations { get; set; } = null!;
        public virtual DbSet<Execution> Executions { get; set; } = null!;
        public virtual DbSet<Failure> Failures { get; set; } = null!;
        public virtual DbSet<HealthCheckExecutionEntry> HealthCheckExecutionEntries { get; set; } = null!;
        public virtual DbSet<HealthCheckExecutionHistory> HealthCheckExecutionHistories { get; set; } = null!;
        public virtual DbSet<HealthStatus> HealthStatuses { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Name=HealthChecksDBString");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Component>(entity =>
            {
                entity.Property(e => e.ComponentName).HasMaxLength(500);

                entity.Property(e => e.ComponentQuery).HasMaxLength(500);

                entity.Property(e => e.ComponentRoletags).HasMaxLength(500);

                entity.Property(e => e.ComponentTypesId).HasDefaultValueSql("((1))");

                entity.HasOne(d => d.ComponentTypes)
                    .WithMany(p => p.Components)
                    .HasForeignKey(d => d.ComponentTypesId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Components_ComponentTypes");

                entity.HasOne(d => d.Configuration)
                    .WithMany(p => p.Components)
                    .HasForeignKey(d => d.ConfigurationId)
                    .HasConstraintName("FK_Components_Configurations");
            });

            modelBuilder.Entity<ComponentType>(entity =>
            {
                entity.HasKey(e => e.ComponentTypesId);

                entity.Property(e => e.ComponentTypesId).ValueGeneratedNever();

                entity.Property(e => e.ComponentTypesName).HasMaxLength(500);
            });

            modelBuilder.Entity<Configuration>(entity =>
            {
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

                entity.HasOne(d => d.StatusNavigation)
                    .WithMany(p => p.HealthCheckExecutionHistories)
                    .HasForeignKey(d => d.Status)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_HealthCheckExecutionHistories_Statuses");
            });

            modelBuilder.Entity<HealthStatus>(entity =>
            {
                entity.HasKey(e => e.StatusId)
                    .HasName("PK_Statuses");

                entity.Property(e => e.StatusId).ValueGeneratedNever();

                entity.Property(e => e.StatusName).HasMaxLength(50);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
