USE [master]
GO
/****** Object:  Database [HealthChecksDB]    Script Date: 14.05.2023 21:11:15 ******/
CREATE DATABASE [HealthChecksDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HealthChecksDB', FILENAME = N'F:\SQL2019\SQLServer\MSSQL15.MSSQLSERVER\MSSQL\DATA\HealthChecksDB.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HealthChecksDB_log', FILENAME = N'F:\SQL2019\SQLServer\MSSQL15.MSSQLSERVER\MSSQL\DATA\HealthChecksDB_log.ldf' , SIZE = 270336KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [HealthChecksDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HealthChecksDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HealthChecksDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HealthChecksDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HealthChecksDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HealthChecksDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HealthChecksDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [HealthChecksDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HealthChecksDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HealthChecksDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HealthChecksDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HealthChecksDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HealthChecksDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HealthChecksDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HealthChecksDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HealthChecksDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HealthChecksDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HealthChecksDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HealthChecksDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HealthChecksDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HealthChecksDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HealthChecksDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HealthChecksDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [HealthChecksDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HealthChecksDB] SET RECOVERY FULL 
GO
ALTER DATABASE [HealthChecksDB] SET  MULTI_USER 
GO
ALTER DATABASE [HealthChecksDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HealthChecksDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HealthChecksDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HealthChecksDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HealthChecksDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HealthChecksDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HealthChecksDB', N'ON'
GO
ALTER DATABASE [HealthChecksDB] SET QUERY_STORE = OFF
GO
USE [HealthChecksDB]
GO
/****** Object:  User [NT AUTHORITY\СИСТЕМА]    Script Date: 14.05.2023 21:11:15 ******/
CREATE USER [NT AUTHORITY\СИСТЕМА] FOR LOGIN [NT AUTHORITY\СИСТЕМА] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [IIS APPPOOL\Core600]    Script Date: 14.05.2023 21:11:15 ******/
CREATE USER [IIS APPPOOL\Core600] FOR LOGIN [IIS APPPOOL\Core600] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [NT AUTHORITY\СИСТЕМА]
GO
ALTER ROLE [db_datareader] ADD MEMBER [NT AUTHORITY\СИСТЕМА]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [NT AUTHORITY\СИСТЕМА]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [IIS APPPOOL\Core600]
GO
ALTER ROLE [db_datareader] ADD MEMBER [IIS APPPOOL\Core600]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [IIS APPPOOL\Core600]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Components]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Components](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComponentTypesId] [int] NOT NULL,
	[ConfigurationId] [int] NOT NULL,
	[ComponentName] [nvarchar](500) NOT NULL,
	[ComponentQuery] [nvarchar](500) NOT NULL,
	[ComponentRoletags] [nvarchar](500) NULL,
	[ComponentHasControls] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComponentTypes]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComponentTypes](
	[ComponentTypesId] [int] NOT NULL,
	[ComponentTypesName] [nvarchar](500) NULL,
 CONSTRAINT [PK_ComponentTypes] PRIMARY KEY CLUSTERED 
(
	[ComponentTypesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Configurations]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Configurations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Uri] [nvarchar](500) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[DiscoveryService] [nvarchar](100) NULL,
 CONSTRAINT [PK_Configurations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Executions]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Executions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NOT NULL,
	[OnStateFrom] [datetime2](7) NOT NULL,
	[LastExecuted] [datetime2](7) NOT NULL,
	[Uri] [nvarchar](500) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[DiscoveryService] [nvarchar](50) NULL,
 CONSTRAINT [PK_Executions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Failures]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Failures](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HealthCheckName] [nvarchar](500) NOT NULL,
	[LastNotified] [datetime2](7) NOT NULL,
	[IsUpAndRunning] [bit] NOT NULL,
 CONSTRAINT [PK_Failures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthCheckExecutionEntries]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthCheckExecutionEntries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[Status] [int] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Duration] [time](7) NOT NULL,
	[HealthCheckExecutionId] [int] NULL,
	[Tags] [nvarchar](max) NULL,
 CONSTRAINT [PK_HealthCheckExecutionEntries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthCheckExecutionHistories]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthCheckExecutionHistories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[On] [datetime2](7) NOT NULL,
	[HealthCheckExecutionId] [int] NULL,
 CONSTRAINT [PK_HealthCheckExecutionHistories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthCheckUserActionLogs]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthCheckUserActionLogs](
	[UserActionEntryId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ActionDetails] [nvarchar](500) NOT NULL,
	[UserActionId] [int] NOT NULL,
	[Datetime] [datetime2](7) NULL,
 CONSTRAINT [PK_HealthCheckUserActionLogs] PRIMARY KEY CLUSTERED 
(
	[UserActionEntryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HealthStatuses]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HealthStatuses](
	[StatusId] [int] NOT NULL,
	[StatusName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Statuses] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserActions]    Script Date: 14.05.2023 21:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserActions](
	[UserActionId] [int] IDENTITY(1,1) NOT NULL,
	[UserActionName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_UserActions] PRIMARY KEY CLUSTERED 
(
	[UserActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_HealthCheckExecutionEntries_HealthCheckExecutionId]    Script Date: 14.05.2023 21:11:15 ******/
CREATE NONCLUSTERED INDEX [IX_HealthCheckExecutionEntries_HealthCheckExecutionId] ON [dbo].[HealthCheckExecutionEntries]
(
	[HealthCheckExecutionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HealthCheckExecutionHistories_HealthCheckExecutionId]    Script Date: 14.05.2023 21:11:15 ******/
CREATE NONCLUSTERED INDEX [IX_HealthCheckExecutionHistories_HealthCheckExecutionId] ON [dbo].[HealthCheckExecutionHistories]
(
	[HealthCheckExecutionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Components] ADD  DEFAULT ((1)) FOR [ComponentTypesId]
GO
ALTER TABLE [dbo].[Components] ADD  DEFAULT ((0)) FOR [ComponentHasControls]
GO
ALTER TABLE [dbo].[Components]  WITH CHECK ADD  CONSTRAINT [FK_Components_ComponentTypes] FOREIGN KEY([ComponentTypesId])
REFERENCES [dbo].[ComponentTypes] ([ComponentTypesId])
GO
ALTER TABLE [dbo].[Components] CHECK CONSTRAINT [FK_Components_ComponentTypes]
GO
ALTER TABLE [dbo].[Components]  WITH CHECK ADD  CONSTRAINT [FK_Components_Configurations] FOREIGN KEY([ConfigurationId])
REFERENCES [dbo].[Configurations] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Components] CHECK CONSTRAINT [FK_Components_Configurations]
GO
ALTER TABLE [dbo].[HealthCheckExecutionEntries]  WITH CHECK ADD  CONSTRAINT [FK_HealthCheckExecutionEntries_Executions_HealthCheckExecutionId] FOREIGN KEY([HealthCheckExecutionId])
REFERENCES [dbo].[Executions] ([Id])
GO
ALTER TABLE [dbo].[HealthCheckExecutionEntries] CHECK CONSTRAINT [FK_HealthCheckExecutionEntries_Executions_HealthCheckExecutionId]
GO
ALTER TABLE [dbo].[HealthCheckExecutionHistories]  WITH CHECK ADD  CONSTRAINT [FK_HealthCheckExecutionHistories_Executions_HealthCheckExecutionId] FOREIGN KEY([HealthCheckExecutionId])
REFERENCES [dbo].[Executions] ([Id])
GO
ALTER TABLE [dbo].[HealthCheckExecutionHistories] CHECK CONSTRAINT [FK_HealthCheckExecutionHistories_Executions_HealthCheckExecutionId]
GO
ALTER TABLE [dbo].[HealthCheckExecutionHistories]  WITH CHECK ADD  CONSTRAINT [FK_HealthCheckExecutionHistories_Statuses] FOREIGN KEY([Status])
REFERENCES [dbo].[HealthStatuses] ([StatusId])
GO
ALTER TABLE [dbo].[HealthCheckExecutionHistories] CHECK CONSTRAINT [FK_HealthCheckExecutionHistories_Statuses]
GO
ALTER TABLE [dbo].[HealthCheckUserActionLogs]  WITH CHECK ADD  CONSTRAINT [FK_HealthCheckUserActionLogs_HealthCheckUserActionLogs] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[HealthCheckUserActionLogs] CHECK CONSTRAINT [FK_HealthCheckUserActionLogs_HealthCheckUserActionLogs]
GO
ALTER TABLE [dbo].[HealthCheckUserActionLogs]  WITH CHECK ADD  CONSTRAINT [FK_HealthCheckUserActionLogs_UserActions] FOREIGN KEY([UserActionId])
REFERENCES [dbo].[UserActions] ([UserActionId])
GO
ALTER TABLE [dbo].[HealthCheckUserActionLogs] CHECK CONSTRAINT [FK_HealthCheckUserActionLogs_UserActions]
GO
USE [master]
GO
ALTER DATABASE [HealthChecksDB] SET  READ_WRITE 
GO
