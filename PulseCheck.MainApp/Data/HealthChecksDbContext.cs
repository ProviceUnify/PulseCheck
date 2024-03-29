﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using DocumentFormat.OpenXml.ExtendedProperties;
using Microsoft.AspNet.WebHooks.Utilities;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using Microsoft.AspNetCore.Identity;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace PulseCheck.MainApp.Models
{
    public partial class HealthChecksDBContext : DbContext
    {
        public HealthChecksDBContext()
        {
            //Database.EnsureCreated();
        }

        public HealthChecksDBContext(DbContextOptions<HealthChecksDBContext> options)
            : base(options)
        {
            //Database.EnsureDeleted();
            Database.EnsureCreated();
        }

        public virtual DbSet<AspNetRole> AspNetRoles { get; set; }
        public virtual DbSet<AspNetRoleClaim> AspNetRoleClaims { get; set; }
        public virtual DbSet<AspNetUser> AspNetUsers { get; set; }
        public virtual DbSet<AspNetUserClaim> AspNetUserClaims { get; set; }
        public virtual DbSet<AspNetUserLogin> AspNetUserLogins { get; set; }
        public virtual DbSet<AspNetUserRole> AspNetUserRoles { get; set; }
        public virtual DbSet<AspNetUserToken> AspNetUserTokens { get; set; }
        public virtual DbSet<Component> Components { get; set; }
        public virtual DbSet<ComponentType> ComponentTypes { get; set; }
        public virtual DbSet<Configuration> Configurations { get; set; }
        public virtual DbSet<Execution> Executions { get; set; }
        public virtual DbSet<Failure> Failures { get; set; }
        public virtual DbSet<HealthCheckExecutionEntry> HealthCheckExecutionEntries { get; set; }
        public virtual DbSet<HealthCheckExecutionHistory> HealthCheckExecutionHistories { get; set; }
        public virtual DbSet<HealthCheckUserActionLog> HealthCheckUserActionLogs { get; set; }
        public virtual DbSet<HealthStatus> HealthStatuses { get; set; }
        public virtual DbSet<UserAction> UserActions { get; set; }

        private string GeneratePasswordHash(string password)
        {
            byte[] salt;
            byte[] buffer2;
            if (password == null)
            {
                throw new ArgumentNullException("password");
            }
            using (Rfc2898DeriveBytes bytes = new Rfc2898DeriveBytes(password, 0x10, 0x3e8))
            {
                salt = bytes.Salt;
                buffer2 = bytes.GetBytes(0x20);
            }
            byte[] dst = new byte[0x31];
            Buffer.BlockCopy(salt, 0, dst, 1, 0x10);
            Buffer.BlockCopy(buffer2, 0, dst, 0x11, 0x20);
            return Convert.ToBase64String(dst);
            //// Generate a 128-bit salt using a sequence of
            //// cryptographically strong random bytes.
            //byte[] salt = RandomNumberGenerator.GetBytes(128 / 8); // divide by 8 to convert bits to bytes
            ////Console.WriteLine($"Salt: {Convert.ToBase64String(salt)}");

            //// derive a 256-bit subkey (use HMACSHA256 with 100,000 iterations)
            //string hashed = Convert.ToBase64String(KeyDerivation.Pbkdf2(
            //    password: password!,
            //    salt: salt,
            //    prf: KeyDerivationPrf.HMACSHA256,
            //    iterationCount: 100000,
            //    numBytesRequested: 256 / 8));

            //return hashed;
            ////Console.WriteLine($"Hashed: {hashed}");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AspNetRole>(entity =>
            {
                ////entity.HasNoKey();

                entity.Property(e => e.Id)
                    .IsRequired()
                    .HasMaxLength(450);

                entity.Property(e => e.IsRemovable)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.Name).HasMaxLength(256);

                entity.Property(e => e.NormalizedName).HasMaxLength(256);

                entity.HasData(
                    new AspNetRole
                    {
                        Id = "HEALTH00-0000-0000-0000-MANAGER00000",
                        Name = "Health manager",
                        NormalizedName = "HEALTH MANAGER",
                        ConcurrencyStamp = Guid.NewGuid().ToString(),
                        IsRemovable = false
                    },
                    new AspNetRole
                    {
                        Id = "USER0000-0000-0000-0000-MANAGER00000",
                        Name = "User manager",
                        NormalizedName = "USER MANAGER",
                        ConcurrencyStamp = Guid.NewGuid().ToString(),
                        IsRemovable = false
                    });
            });

            modelBuilder.Entity<AspNetRoleClaim>(entity =>
            {
                //entity.HasNoKey();

                entity.Property(e => e.RoleId)
                    .IsRequired()
                    .HasMaxLength(450);
            });

            modelBuilder.Entity<AspNetUser>(entity =>
            {
                entity.Property(e => e.Email).HasMaxLength(256);

                entity.Property(e => e.NormalizedEmail).HasMaxLength(256);

                entity.Property(e => e.NormalizedUserName).HasMaxLength(256);

                entity.Property(e => e.UserName).HasMaxLength(256);

                entity.HasData(new AspNetUser
                {
                    Id = "ADMIN000-ADMN-ADMN-ADMN-ADMIN0000000",
                    Email = "AdminHC@kamaz.ru",
                    UserName = "AdminHC@kamaz.ru",
                    NormalizedEmail = "ADMINHC@KAMAZ.RU",
                    NormalizedUserName = "ADMINHC@KAMAZ.RU",
                    SecurityStamp = "PELQERZXI7X6D4VZA2B5XFBQEWVNH3G5",
                    ConcurrencyStamp = Guid.NewGuid().ToString(),
                    EmailConfirmed = true,
                    PasswordHash = @"AQAAAAEAACcQAAAAEEssesxZjCEvoSn7DS44C+ndK2fgTOIpdKAPOP716N/pr5jP2/pgkTR0i3GLAsGcrA=="
                    // _#Health_#Check_#Admin_#001_#
                });
            });

            modelBuilder.Entity<AspNetUserClaim>(entity =>
            {
                //entity.HasNoKey();

                entity.Property(e => e.UserId)
                    .IsRequired()
                    .HasMaxLength(450);
            });

            modelBuilder.Entity<AspNetUserLogin>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.LoginProvider)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.ProviderKey)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.UserId)
                    .IsRequired()
                    .HasMaxLength(450);
            });

            modelBuilder.Entity<AspNetUserRole>(entity =>
            {
                //entity.HasNoKey();
                entity.HasKey(k => new { k.RoleId, k.UserId });

                entity.Property(e => e.RoleId)
                    .IsRequired()
                    .HasMaxLength(450);

                entity.Property(e => e.UserId)
                    .IsRequired()
                    .HasMaxLength(450);

                entity.HasData(
                    new AspNetUserRole
                    {
                        UserId = "ADMIN000-ADMN-ADMN-ADMN-ADMIN0000000",
                        RoleId = "HEALTH00-0000-0000-0000-MANAGER00000"
                    },
                    new AspNetUserRole
                    {
                        UserId = "ADMIN000-ADMN-ADMN-ADMN-ADMIN0000000",
                        RoleId = "USER0000-0000-0000-0000-MANAGER00000"
                    });
            });

            modelBuilder.Entity<AspNetUserToken>(entity =>
            {
                entity.HasNoKey();

                entity.Property(e => e.LoginProvider)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(128);

                entity.Property(e => e.UserId)
                    .IsRequired()
                    .HasMaxLength(450);
            });

            modelBuilder.Entity<Component>(entity =>
            {
                entity.Property(e => e.ComponentName)
                    .IsRequired()
                    .HasMaxLength(500);

                entity.Property(e => e.ComponentRoletags).HasMaxLength(500);

                entity.Property(e => e.ComponentTargetInfo).HasMaxLength(500);

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

                entity.HasData(
                    new ComponentType
                    {
                        ComponentTypesId = 1,
                        ComponentTypesName = "MSSQL"
                    },
                    new ComponentType
                    {
                        ComponentTypesId = 2,
                        ComponentTypesName = "Service"
                    },
                    new ComponentType
                    {
                        ComponentTypesId = 3,
                        ComponentTypesName = "Process"
                    },
                    new ComponentType
                    {
                        ComponentTypesId = 4,
                        ComponentTypesName = "URL"
                    },
                    new ComponentType
                    {
                        ComponentTypesId = 5,
                        ComponentTypesName = "MySQL"
                    }
                    );
            });

            modelBuilder.Entity<Configuration>(entity =>
            {
                entity.Property(e => e.DiscoveryService).HasMaxLength(100);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(500);

                entity.Property(e => e.Uri)
                    .IsRequired()
                    .HasMaxLength(500);
            });

            modelBuilder.Entity<Execution>(entity =>
            {
                entity.Property(e => e.DiscoveryService).HasMaxLength(50);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(500);

                entity.Property(e => e.Uri)
                    .IsRequired()
                    .HasMaxLength(500);
            });

            modelBuilder.Entity<Failure>(entity =>
            {
                entity.Property(e => e.HealthCheckName)
                    .IsRequired()
                    .HasMaxLength(500);
            });

            modelBuilder.Entity<HealthCheckExecutionEntry>(entity =>
            {
                entity.HasIndex(e => e.HealthCheckExecutionId, "IX_HealthCheckExecutionEntries_HealthCheckExecutionId");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(500);

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

                entity.Property(e => e.ActionDetails)
                    .IsRequired()
                    .HasMaxLength(500);

                entity.Property(e => e.UserId)
                    .IsRequired()
                    .HasMaxLength(450);

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

                entity.Property(e => e.StatusName)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<UserAction>(entity =>
            {
                entity.Property(e => e.UserActionName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasData(
                    new UserAction
                    {
                        UserActionId = 1,
                        UserActionName = "Configuration creation"
                    },
                    new UserAction
                    {
                        UserActionId = 2,
                        UserActionName = "Configuration edition"
                    },
                    new UserAction
                    {
                        UserActionId = 3,
                        UserActionName = "Configuration removing"
                    },
                    new UserAction
                    {
                        UserActionId = 4,
                        UserActionName = "Requesting healths status report"
                    },
                    new UserAction
                    {
                        UserActionId = 5,
                        UserActionName = "Requesting user actions report"
                    },
                    new UserAction
                    {
                        UserActionId = 6,
                        UserActionName = "Component starting"
                    },
                    new UserAction
                    {
                        UserActionId = 7,
                        UserActionName = "Component restarting"
                    },
                    new UserAction
                    {
                        UserActionId = 8,
                        UserActionName = "Component stopping"
                    },
                    new UserAction
                    {
                        UserActionId = 9,
                        UserActionName = "User role editing"
                    },
                    new UserAction
                    {
                        UserActionId = 10,
                        UserActionName = "User confirmation"
                    },
                    new UserAction
                    {
                        UserActionId = 11,
                        UserActionName = "Role adding"
                    },
                    new UserAction
                    {
                        UserActionId = 12,
                        UserActionName = "Role removing"
                    });
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}