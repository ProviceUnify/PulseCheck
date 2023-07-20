using System;
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

        public virtual DbSet<AspNetRole> AspNetRoles { get; set; } = null!;
        public virtual DbSet<AspNetRoleClaim> AspNetRoleClaims { get; set; } = null!;
        public virtual DbSet<AspNetUser> AspNetUsers { get; set; } = null!;
        public virtual DbSet<AspNetUserClaim> AspNetUserClaims { get; set; } = null!;
        public virtual DbSet<AspNetUserLogin> AspNetUserLogins { get; set; } = null!;
        public virtual DbSet<AspNetUserRole> AspNetUserRoles { get; set; } = null!;
        public virtual DbSet<AspNetUserToken> AspNetUserTokens { get; set; } = null!;
        public virtual DbSet<Component> Components { get; set; } = null!;
        public virtual DbSet<ComponentType> ComponentTypes { get; set; } = null!;
        public virtual DbSet<Configuration> Configurations { get; set; } = null!;
        public virtual DbSet<Execution> Executions { get; set; } = null!;
        public virtual DbSet<Failure> Failures { get; set; } = null!;
        public virtual DbSet<HealthCheckExecutionEntry> HealthCheckExecutionEntries { get; set; } = null!;
        public virtual DbSet<HealthCheckExecutionHistory> HealthCheckExecutionHistories { get; set; } = null!;
        public virtual DbSet<HealthCheckUserActionLog> HealthCheckUserActionLogs { get; set; } = null!;
        public virtual DbSet<HealthStatus> HealthStatuses { get; set; } = null!;
        public virtual DbSet<UserAction> UserActions { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Name=ConnectionStrings:HealthChecksDBString");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AspNetRole>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.Id).HasMaxLength(450);

                entity.Property(e => e.Name).HasMaxLength(256);

                entity.Property(e => e.NormalizedName).HasMaxLength(256);
            });

            modelBuilder.Entity<AspNetRoleClaim>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.RoleId).HasMaxLength(450);
            });

            modelBuilder.Entity<AspNetUser>(entity =>
            {
                entity.Property(e => e.Email).HasMaxLength(256);

                entity.Property(e => e.NormalizedEmail).HasMaxLength(256);

                entity.Property(e => e.NormalizedUserName).HasMaxLength(256);

                entity.Property(e => e.UserName).HasMaxLength(256);
            });

            modelBuilder.Entity<AspNetUserClaim>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.UserId).HasMaxLength(450);
            });

            modelBuilder.Entity<AspNetUserLogin>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.LoginProvider).HasMaxLength(128);

                entity.Property(e => e.ProviderKey).HasMaxLength(128);

                entity.Property(e => e.UserId).HasMaxLength(450);
            });

            modelBuilder.Entity<AspNetUserRole>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.RoleId).HasMaxLength(450);

                entity.Property(e => e.UserId).HasMaxLength(450);
            });

            modelBuilder.Entity<AspNetUserToken>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.LoginProvider).HasMaxLength(128);

                entity.Property(e => e.Name).HasMaxLength(128);

                entity.Property(e => e.UserId).HasMaxLength(450);
            });

            modelBuilder.Entity<Component>(entity =>
            {
                entity.Property(e => e.ComponentName).HasMaxLength(500);

                entity.Property(e => e.ComponentRoletags).HasMaxLength(500);

                entity.Property(e => e.ComponentTargetInfo).HasMaxLength(500);

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

            modelBuilder.Entity<HealthCheckUserActionLog>(entity =>
            {
                entity.HasKey(e => e.UserActionEntryId);

                entity.Property(e => e.ActionDetails).HasMaxLength(500);

                entity.Property(e => e.UserId).HasMaxLength(450);

                entity.HasOne(d => d.UserAction)
                    .WithMany(p => p.HealthCheckUserActionLogs)
                    .HasForeignKey(d => d.UserActionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_HealthCheckUserActionLogs_UserActions");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.HealthCheckUserActionLogs)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_HealthCheckUserActionLogs_HealthCheckUserActionLogs");
            });

            modelBuilder.Entity<HealthStatus>(entity =>
            {
                entity.HasKey(e => e.StatusId)
                    .HasName("PK_Statuses");

                entity.Property(e => e.StatusId).ValueGeneratedNever();

                entity.Property(e => e.StatusName).HasMaxLength(50);
            });

            modelBuilder.Entity<UserAction>(entity =>
            {
                entity.Property(e => e.UserActionName).HasMaxLength(50);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
