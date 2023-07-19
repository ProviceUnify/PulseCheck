USE [master]
GO
/****** Object:  Database [HealthChecksDB]    Script Date: 19.07.2023 15:42:30 ******/
CREATE DATABASE [HealthChecksDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HealthChecksDB', FILENAME = N'D:\Programs\MSSQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\HealthChecksDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HealthChecksDB_log', FILENAME = N'D:\Programs\MSSQL\MSSQL15.MSSQLSERVER\MSSQL\DATA\HealthChecksDB_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  User [PC_MainApp]    Script Date: 19.07.2023 15:42:31 ******/
CREATE USER [PC_MainApp] FOR LOGIN [PC_MainApp] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NT AUTHORITY\СИСТЕМА]    Script Date: 19.07.2023 15:42:31 ******/
CREATE USER [NT AUTHORITY\СИСТЕМА] FOR LOGIN [NT AUTHORITY\СИСТЕМА] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PC_MainApp]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [PC_MainApp]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [NT AUTHORITY\СИСТЕМА]
GO
ALTER ROLE [db_datareader] ADD MEMBER [NT AUTHORITY\СИСТЕМА]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [NT AUTHORITY\СИСТЕМА]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 19.07.2023 15:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[IsRemovable] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 19.07.2023 15:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[Components]    Script Date: 19.07.2023 15:42:31 ******/
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
	[ComponentFullPathToExe] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComponentTypes]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[Configurations]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[Executions]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[Failures]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[HealthCheckExecutionEntries]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[HealthCheckExecutionHistories]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[HealthCheckUserActionLogs]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[HealthStatuses]    Script Date: 19.07.2023 15:42:31 ******/
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
/****** Object:  Table [dbo].[UserActions]    Script Date: 19.07.2023 15:42:31 ******/
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
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp], [IsRemovable]) VALUES (N'28696cf8-1c95-4e88-a8bb-6f3f8ca41577', N'HOFFMAN', N'HOFFMAN', N'1ecaaf4c-d5b7-4ade-8331-7bef2d789979', 1)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp], [IsRemovable]) VALUES (N'852925d3-deb5-4ae0-a293-ad66de771403', N'EOL', N'EOL', N'6c6f1088-3e78-4b26-8422-3023b34edffd', 1)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp], [IsRemovable]) VALUES (N'a402f4ae-237d-4ce8-8034-75c3121dee35', N'Health manager', N'HEALTH MANAGER', N'e4a54a78-3112-49e2-a460-72f64e5ed15b', 0)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp], [IsRemovable]) VALUES (N'a58e88a6-dbc9-499c-aa9b-6a36dcc56c1e', N'KSD', N'KSD', N'c1b38ba1-1d57-438a-b0d2-10d52723a308', 1)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp], [IsRemovable]) VALUES (N'f4a83683-c515-44ba-bd88-8a01cb9fb6dd', N'User manager', N'USER MANAGER', N'6a2bbcf0-7b29-4936-aa27-7aef366d67e6', 0)
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'852925d3-deb5-4ae0-a293-ad66de771403')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'a402f4ae-237d-4ce8-8034-75c3121dee35')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'f4a83683-c515-44ba-bd88-8a01cb9fb6dd')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'0822f5fa-ded7-435d-9e85-d3f23f859806')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'0012a4e0-86a8-4a4f-89b6-e203e3625f27')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'f4a83683-c515-44ba-bd88-8a01cb9fb6dd')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'a58e88a6-dbc9-499c-aa9b-6a36dcc56c1e')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'a402f4ae-237d-4ce8-8034-75c3121dee35')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'852925d3-deb5-4ae0-a293-ad66de771403')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'28696cf8-1c95-4e88-a8bb-6f3f8ca41577')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'990b1a84-a906-48b9-8faa-445cc1f5feb4', N'28696cf8-1c95-4e88-a8bb-6f3f8ca41577')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'a58e88a6-dbc9-499c-aa9b-6a36dcc56c1e')
GO
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'nekit@chort.com', N'NEKIT@CHORT.COM', N'nekit@chort.com', N'NEKIT@CHORT.COM', 1, N'AQAAAAEAACcQAAAAEN7PvuUw6Aax//dV1dMLLWImQLmYZjj8F4i7vD0omBH9goxC39WIR7bNI0LLMbux1Q==', N'YP7XKGKNS5SLANWXWYVAY5QS6RTXI6RL', N'c127e1df-d850-4709-8252-95d3e4cc01bc', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'990b1a84-a906-48b9-8faa-445cc1f5feb4', N'test456@gmail.com', N'TEST456@GMAIL.COM', N'test456@gmail.com', N'TEST456@GMAIL.COM', 1, N'AQAAAAEAACcQAAAAEMNyLb8IIUyblbZV3EorVDjVYWDJAnpbmfWT+73EvxwRTYX+UoQwZG8m9cyhlRWARQ==', N'MEOLBDGS4DTSJEVSLEHVQY4GDX657IQZ', N'dc302e4e-2b87-4942-a8da-4b6d1131f781', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'provice911@gmail.com', N'PROVICE911@GMAIL.COM', N'provice911@gmail.com', N'PROVICE911@GMAIL.COM', 1, N'AQAAAAIAAYagAAAAENMKCsw/TrZM4xghYviAIXDzDswTkESmPs3nqa87jQH196V5hAARu/r2vrDXhOoLKQ==', N'C6QGXNK7SNTD43FNQMRTOIFEJUCGGZU3', N'ad35b412-7826-4053-87c0-46e9e3ab447e', NULL, 0, 0, NULL, 1, 0)
GO
INSERT [dbo].[AspNetUserTokens] ([UserId], [LoginProvider], [Name], [Value]) VALUES (N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'[AspNetUserStore]', N'AuthenticatorKey', N'YCCGDRQ52IYMY2ULZGDG6B2NIBCGS7HM')
GO
SET IDENTITY_INSERT [dbo].[Components] ON 

INSERT [dbo].[Components] ([Id], [ComponentTypesId], [ConfigurationId], [ComponentName], [ComponentQuery], [ComponentRoletags], [ComponentHasControls], [ComponentFullPathToExe]) VALUES (1, 1, 33, N'MSSQL', N'Server=10.0.8', N'["KSD"]', 0, N'Server=10.0.8.81;Database=K5_Identifications_v2;User Id=sanalitics;Password=32cYq9Cu6t')
INSERT [dbo].[Components] ([Id], [ComponentTypesId], [ConfigurationId], [ComponentName], [ComponentQuery], [ComponentRoletags], [ComponentHasControls], [ComponentFullPathToExe]) VALUES (3, 5, 33, N'MySQL', N'Server=s-ksd-db.kamaz', N'["KSD"]', 0, N'Server=s-ksd-db.kamaz.org;Port=3306;Database=textdb;Uid=root;Pwd=Grade-x')
INSERT [dbo].[Components] ([Id], [ComponentTypesId], [ConfigurationId], [ComponentName], [ComponentQuery], [ComponentRoletags], [ComponentHasControls], [ComponentFullPathToExe]) VALUES (6, 4, 33, N'1', N'google', N'["KSD"]', 0, N'https://google.com')
SET IDENTITY_INSERT [dbo].[Components] OFF
GO
INSERT [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (1, N'MSSQL')
INSERT [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (2, N'Service')
INSERT [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (3, N'Process')
INSERT [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (4, N'URL')
INSERT [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (5, N'MySQL')
GO
SET IDENTITY_INSERT [dbo].[Configurations] ON 

INSERT [dbo].[Configurations] ([Id], [Uri], [Name], [DiscoveryService]) VALUES (33, N'http://localhost:5001/health', N'Real', NULL)
SET IDENTITY_INSERT [dbo].[Configurations] OFF
GO
SET IDENTITY_INSERT [dbo].[Executions] ON 

INSERT [dbo].[Executions] ([Id], [Status], [OnStateFrom], [LastExecuted], [Uri], [Name], [DiscoveryService]) VALUES (18, 0, CAST(N'2023-07-19T12:02:22.5446450' AS DateTime2), CAST(N'2023-07-19T12:30:24.7929251' AS DateTime2), N'http://localhost:5001/health', N'Real', NULL)
SET IDENTITY_INSERT [dbo].[Executions] OFF
GO
SET IDENTITY_INSERT [dbo].[Failures] ON 

INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (1, N'Real', CAST(N'2023-05-22T08:08:05.3306335' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (2, N'Real', CAST(N'2023-05-22T08:18:08.4067572' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (3, N'Real', CAST(N'2023-05-22T08:28:10.4068438' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (4, N'Real', CAST(N'2023-05-22T08:46:36.3929380' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (5, N'Real', CAST(N'2023-05-22T08:56:40.0358807' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (6, N'Real', CAST(N'2023-05-22T09:06:42.5385221' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (7, N'Real', CAST(N'2023-05-22T11:16:31.7213997' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (8, N'Real', CAST(N'2023-05-22T11:26:33.4974756' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (9, N'Real', CAST(N'2023-05-22T11:36:34.0522458' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (10, N'Real', CAST(N'2023-05-22T11:45:28.1211914' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (11, N'Real', CAST(N'2023-05-22T11:56:35.2345795' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (12, N'Real', CAST(N'2023-05-22T12:06:35.5131814' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (13, N'Real', CAST(N'2023-05-22T13:09:32.4224870' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (14, N'Real', CAST(N'2023-05-22T13:12:46.0285661' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (15, N'Real', CAST(N'2023-05-23T07:10:38.2112868' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (16, N'Real', CAST(N'2023-05-23T07:20:39.1226249' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (17, N'Real', CAST(N'2023-05-23T07:30:39.5547498' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (18, N'Real', CAST(N'2023-05-23T07:41:01.3535673' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (19, N'Real', CAST(N'2023-05-23T07:42:45.6818245' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (20, N'Real', CAST(N'2023-05-23T07:43:19.0383186' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (21, N'Real', CAST(N'2023-05-23T07:45:33.6100439' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (22, N'Real', CAST(N'2023-05-23T07:46:32.7456931' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (23, N'Real', CAST(N'2023-05-23T07:56:35.3329074' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (24, N'Real', CAST(N'2023-05-23T08:06:38.0246506' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (25, N'Real', CAST(N'2023-05-23T08:09:51.7221044' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (26, N'Real', CAST(N'2023-05-23T08:12:00.5290359' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (27, N'Real', CAST(N'2023-05-23T08:17:44.5371836' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (28, N'Real', CAST(N'2023-05-23T08:18:06.5323073' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (29, N'Real', CAST(N'2023-05-23T08:23:17.9468799' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (30, N'Real', CAST(N'2023-05-23T08:23:40.0317752' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (31, N'Real', CAST(N'2023-05-23T08:28:02.1035117' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (32, N'Real', CAST(N'2023-05-23T09:07:51.8131785' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (33, N'Real', CAST(N'2023-05-23T09:17:52.1694458' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (34, N'Real', CAST(N'2023-05-23T09:27:53.5844989' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (35, N'Real', CAST(N'2023-05-23T10:04:32.5184223' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (36, N'Real', CAST(N'2023-05-23T10:07:59.5203967' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (37, N'Real', CAST(N'2023-05-23T10:08:21.5580637' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (38, N'Real', CAST(N'2023-05-23T10:19:02.8758290' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (39, N'Real', CAST(N'2023-05-23T10:29:05.2344062' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (40, N'Real', CAST(N'2023-05-23T10:31:35.0898798' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (41, N'Real', CAST(N'2023-05-23T10:36:28.3614416' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (42, N'Real', CAST(N'2023-05-23T10:37:03.3295083' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (43, N'Real', CAST(N'2023-05-23T10:37:25.4356212' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (44, N'Real', CAST(N'2023-05-23T12:23:50.1595650' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (45, N'Real', CAST(N'2023-05-23T12:24:05.6623700' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (46, N'Real', CAST(N'2023-05-23T12:25:02.0150685' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (47, N'Real', CAST(N'2023-05-23T12:25:23.2663580' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (48, N'Real', CAST(N'2023-05-23T12:35:23.5073394' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (49, N'Real', CAST(N'2023-05-23T12:41:14.0026743' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (50, N'Real', CAST(N'2023-05-23T12:41:44.2927306' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (51, N'Real', CAST(N'2023-05-24T05:36:49.5479204' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (52, N'Real', CAST(N'2023-05-24T05:36:59.1033288' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (53, N'Real', CAST(N'2023-05-24T05:37:08.1803294' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (54, N'Real', CAST(N'2023-05-24T05:47:08.1898520' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (55, N'Real', CAST(N'2023-05-24T05:57:04.8812575' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (56, N'Real', CAST(N'2023-05-24T05:57:07.9042456' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (57, N'Real', CAST(N'2023-05-24T05:58:37.3303425' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (58, N'Real', CAST(N'2023-05-24T05:58:40.3428679' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (59, N'Real', CAST(N'2023-05-24T06:08:41.4412412' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (60, N'Real', CAST(N'2023-05-24T06:18:43.6998437' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (61, N'Real', CAST(N'2023-05-24T07:58:50.6940189' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (62, N'Real', CAST(N'2023-05-24T08:08:53.4750272' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (63, N'Real', CAST(N'2023-05-24T08:10:03.2079609' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (64, N'Real', CAST(N'2023-05-24T08:10:21.3955257' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (65, N'Real', CAST(N'2023-05-24T08:20:24.0686239' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (66, N'Real', CAST(N'2023-05-24T08:30:26.4996871' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (67, N'Real', CAST(N'2023-05-24T08:40:29.0226901' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (68, N'Real', CAST(N'2023-05-24T08:50:31.0936057' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (69, N'Real', CAST(N'2023-05-24T09:00:33.1505959' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (70, N'Real', CAST(N'2023-05-24T09:10:35.4025413' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (71, N'Real', CAST(N'2023-05-24T09:20:37.8999419' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (72, N'Real', CAST(N'2023-05-24T09:30:40.2137412' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (73, N'Real', CAST(N'2023-05-24T09:40:42.1706522' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (74, N'Real', CAST(N'2023-05-24T09:50:43.9391796' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (75, N'Real', CAST(N'2023-05-24T10:00:46.2528045' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (76, N'Real', CAST(N'2023-05-24T10:10:48.6806274' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (77, N'Real', CAST(N'2023-05-24T10:20:51.0775615' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (78, N'Real', CAST(N'2023-05-24T10:30:53.2178345' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (79, N'Real', CAST(N'2023-05-24T10:40:55.7117934' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (80, N'Real', CAST(N'2023-05-24T12:09:36.0417522' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (81, N'Real', CAST(N'2023-05-24T12:09:39.3992005' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (82, N'Real', CAST(N'2023-05-24T12:11:30.1890993' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (83, N'Real', CAST(N'2023-05-24T12:12:06.5560080' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (84, N'Real', CAST(N'2023-05-24T12:12:36.8723751' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (85, N'Real', CAST(N'2023-05-24T12:18:42.3622375' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (86, N'Real', CAST(N'2023-05-24T12:20:20.4761854' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (87, N'Real', CAST(N'2023-05-24T12:21:11.0354640' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (88, N'Real', CAST(N'2023-05-24T13:33:10.3675365' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (89, N'Real', CAST(N'2023-05-24T13:35:25.7576123' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (90, N'Real', CAST(N'2023-05-24T13:40:24.5693513' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (91, N'Real', CAST(N'2023-05-24T13:50:25.5388667' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (92, N'Real', CAST(N'2023-05-24T14:00:26.1596430' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (93, N'Real', CAST(N'2023-05-24T14:10:26.8480967' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (94, N'Real', CAST(N'2023-05-25T05:02:10.9989486' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (95, N'Real', CAST(N'2023-05-25T05:12:12.2368410' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (96, N'Real', CAST(N'2023-05-25T05:22:14.9037906' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (97, N'Real', CAST(N'2023-05-25T05:24:15.7037071' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (98, N'Real', CAST(N'2023-05-25T05:26:34.3443318' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (99, N'Real', CAST(N'2023-05-25T05:36:34.6267569' AS DateTime2), 0)
GO
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (100, N'Real', CAST(N'2023-05-25T05:46:36.1235821' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (101, N'Real', CAST(N'2023-05-25T05:56:36.3369353' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (102, N'Real', CAST(N'2023-05-25T06:06:37.7967997' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (103, N'Real', CAST(N'2023-05-25T06:16:39.3511588' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (104, N'Real', CAST(N'2023-05-25T06:26:40.5976559' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (105, N'Real', CAST(N'2023-05-25T06:36:43.0101568' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (106, N'Real', CAST(N'2023-05-25T06:46:45.4306923' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (107, N'Real', CAST(N'2023-05-25T07:19:36.3019267' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (108, N'Real', CAST(N'2023-05-25T07:29:40.8998567' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (109, N'Real', CAST(N'2023-05-25T07:39:46.3165599' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (110, N'Real', CAST(N'2023-06-07T07:06:18.8774102' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (111, N'Real', CAST(N'2023-06-07T07:16:22.9121842' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (112, N'Real', CAST(N'2023-06-07T07:26:25.8149114' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (113, N'Real', CAST(N'2023-06-07T10:34:22.8865312' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (114, N'Real', CAST(N'2023-06-07T10:44:27.5118989' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (115, N'Real', CAST(N'2023-06-07T10:54:31.5713876' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (116, N'Real', CAST(N'2023-06-08T05:15:27.1342167' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (117, N'Real', CAST(N'2023-06-08T05:25:30.3574537' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (118, N'Real', CAST(N'2023-06-08T05:35:32.7928168' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (119, N'Real', CAST(N'2023-06-09T07:42:49.5360687' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (120, N'Real', CAST(N'2023-06-09T07:52:50.8113814' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (121, N'Real', CAST(N'2023-06-09T08:02:53.0783710' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (122, N'Real', CAST(N'2023-06-09T08:12:55.6844149' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (123, N'Real', CAST(N'2023-06-09T08:22:59.2126902' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (124, N'Real', CAST(N'2023-06-13T05:00:52.1229782' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (125, N'Real', CAST(N'2023-06-13T05:10:55.3387174' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (126, N'Real', CAST(N'2023-06-13T05:20:57.4903573' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (127, N'Real', CAST(N'2023-06-13T08:53:25.7925853' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (128, N'Real', CAST(N'2023-06-13T09:03:28.9936551' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (129, N'Real', CAST(N'2023-06-13T09:13:32.0220242' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (130, N'Real', CAST(N'2023-06-13T10:06:25.9856612' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (131, N'Real', CAST(N'2023-06-13T10:16:29.8955942' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (132, N'Real', CAST(N'2023-06-13T10:26:32.4110690' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (133, N'Real', CAST(N'2023-06-16T07:38:36.7975758' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (134, N'Real', CAST(N'2023-06-16T07:48:42.9903022' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (135, N'Real', CAST(N'2023-06-16T07:58:46.0057868' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (136, N'Real', CAST(N'2023-06-16T08:32:47.7168271' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (137, N'Real', CAST(N'2023-06-16T08:42:51.2724627' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (138, N'Real', CAST(N'2023-06-16T08:52:54.1190365' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (139, N'Real', CAST(N'2023-07-04T04:58:30.2839527' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (140, N'Real', CAST(N'2023-07-04T05:08:35.6621405' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (141, N'Real', CAST(N'2023-07-13T07:17:45.5463285' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (142, N'Real', CAST(N'2023-07-13T07:27:46.2734781' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (143, N'Real', CAST(N'2023-07-13T07:33:50.7532014' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (144, N'Real', CAST(N'2023-07-13T07:35:13.5397813' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (145, N'Real', CAST(N'2023-07-13T07:35:30.6883590' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (146, N'Real', CAST(N'2023-07-13T07:36:45.1399733' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (147, N'Real', CAST(N'2023-07-13T07:41:56.1818611' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (148, N'Real', CAST(N'2023-07-13T07:43:02.0583791' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (149, N'Real', CAST(N'2023-07-13T07:43:41.1625380' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (150, N'Real', CAST(N'2023-07-13T07:47:48.1227391' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (151, N'Real', CAST(N'2023-07-13T07:57:50.7020081' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (152, N'Real', CAST(N'2023-07-13T08:07:52.7402536' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (153, N'Real', CAST(N'2023-07-13T08:08:49.3196904' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (154, N'Real', CAST(N'2023-07-13T08:14:25.0803852' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (155, N'Real', CAST(N'2023-07-13T08:19:22.3967501' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (156, N'Real', CAST(N'2023-07-13T10:44:31.5793406' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (157, N'Real', CAST(N'2023-07-13T10:54:40.6038535' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (158, N'Real', CAST(N'2023-07-13T11:04:48.6925016' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (159, N'Real', CAST(N'2023-07-13T11:09:01.4854154' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (160, N'Real', CAST(N'2023-07-13T13:16:48.1255528' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (161, N'Real', CAST(N'2023-07-13T13:30:06.6990761' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (162, N'Real', CAST(N'2023-07-13T13:40:10.5467996' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (163, N'Real', CAST(N'2023-07-13T13:50:18.6821528' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (164, N'Real', CAST(N'2023-07-13T14:00:29.3670691' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (165, N'Real', CAST(N'2023-07-13T14:10:38.6395523' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (166, N'Real', CAST(N'2023-07-13T14:20:48.0003757' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (167, N'Real', CAST(N'2023-07-13T14:30:57.0373795' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (168, N'Real', CAST(N'2023-07-13T14:41:06.4664878' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (169, N'Real', CAST(N'2023-07-13T14:51:16.5098086' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (170, N'Real', CAST(N'2023-07-13T15:01:25.6476843' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (171, N'Real', CAST(N'2023-07-13T15:11:36.9016598' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (172, N'Real', CAST(N'2023-07-13T15:21:45.8326386' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (173, N'Real', CAST(N'2023-07-13T15:31:59.0700268' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (174, N'Real', CAST(N'2023-07-13T15:42:12.1079878' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (175, N'Real', CAST(N'2023-07-13T15:52:14.3077832' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (176, N'Real', CAST(N'2023-07-13T16:02:17.8152178' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (177, N'Real', CAST(N'2023-07-13T16:12:31.8916779' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (178, N'Real', CAST(N'2023-07-13T16:22:36.8555881' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (179, N'Real', CAST(N'2023-07-13T16:32:49.1187086' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (180, N'Real', CAST(N'2023-07-13T16:43:02.1830071' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (181, N'Real', CAST(N'2023-07-13T16:53:03.4677428' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (182, N'Real', CAST(N'2023-07-13T17:03:16.8293586' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (183, N'Real', CAST(N'2023-07-13T17:13:17.3590222' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (184, N'Real', CAST(N'2023-07-13T17:23:20.8582250' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (185, N'Real', CAST(N'2023-07-13T17:33:24.5153341' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (186, N'Real', CAST(N'2023-07-13T17:43:27.3555263' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (187, N'Real', CAST(N'2023-07-13T17:53:29.8998285' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (188, N'Real', CAST(N'2023-07-13T18:03:37.2777499' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (189, N'Real', CAST(N'2023-07-13T18:13:39.8160408' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (190, N'Real', CAST(N'2023-07-13T18:23:40.7775426' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (191, N'Real', CAST(N'2023-07-13T18:33:51.4699027' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (192, N'Real', CAST(N'2023-07-13T18:43:52.7387461' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (193, N'Real', CAST(N'2023-07-13T18:53:56.9188666' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (194, N'Real', CAST(N'2023-07-13T19:04:00.2931679' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (195, N'Real', CAST(N'2023-07-13T19:14:11.8799781' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (196, N'Real', CAST(N'2023-07-13T19:24:15.5391658' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (197, N'Real', CAST(N'2023-07-13T19:34:16.3645046' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (198, N'Real', CAST(N'2023-07-13T19:44:19.3923320' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (199, N'Real', CAST(N'2023-07-13T19:54:21.2860739' AS DateTime2), 0)
GO
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (200, N'Real', CAST(N'2023-07-13T20:04:24.5052364' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (201, N'Real', CAST(N'2023-07-13T20:14:26.6617282' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (202, N'Real', CAST(N'2023-07-13T20:24:28.3584612' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (203, N'Real', CAST(N'2023-07-13T20:34:32.7594843' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (204, N'Real', CAST(N'2023-07-13T20:44:46.0906581' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (205, N'Real', CAST(N'2023-07-13T20:54:52.9683671' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (206, N'Real', CAST(N'2023-07-13T21:04:56.9268534' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (207, N'Real', CAST(N'2023-07-13T21:15:00.3586411' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (208, N'Real', CAST(N'2023-07-13T21:25:02.1540046' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (209, N'Real', CAST(N'2023-07-13T21:35:04.1855102' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (210, N'Real', CAST(N'2023-07-13T21:45:06.5620354' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (211, N'Real', CAST(N'2023-07-13T21:55:09.7909638' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (212, N'Real', CAST(N'2023-07-13T22:05:12.1084300' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (213, N'Real', CAST(N'2023-07-13T22:15:16.3900735' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (214, N'Real', CAST(N'2023-07-13T22:25:17.8005717' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (215, N'Real', CAST(N'2023-07-13T22:35:19.3733183' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (216, N'Real', CAST(N'2023-07-13T22:45:22.0661595' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (217, N'Real', CAST(N'2023-07-13T22:55:26.4842728' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (218, N'Real', CAST(N'2023-07-13T23:05:30.3192163' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (219, N'Real', CAST(N'2023-07-13T23:15:34.8282044' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (220, N'Real', CAST(N'2023-07-13T23:25:36.9362813' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (221, N'Real', CAST(N'2023-07-13T23:35:42.1342700' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (222, N'Real', CAST(N'2023-07-13T23:45:48.5894304' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (223, N'Real', CAST(N'2023-07-13T23:55:51.7574011' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (224, N'Real', CAST(N'2023-07-14T00:05:51.9844554' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (225, N'Real', CAST(N'2023-07-14T00:15:55.6347951' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (226, N'Real', CAST(N'2023-07-14T00:26:00.1221789' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (227, N'Real', CAST(N'2023-07-14T00:36:02.9694131' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (228, N'Real', CAST(N'2023-07-14T00:46:07.1304314' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (229, N'Real', CAST(N'2023-07-14T00:56:09.7474063' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (230, N'Real', CAST(N'2023-07-14T01:06:14.7376349' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (231, N'Real', CAST(N'2023-07-14T01:16:19.2728678' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (232, N'Real', CAST(N'2023-07-14T01:26:24.6308755' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (233, N'Real', CAST(N'2023-07-14T01:36:27.9150412' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (234, N'Real', CAST(N'2023-07-14T01:46:33.4561234' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (235, N'Real', CAST(N'2023-07-14T01:56:38.8124922' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (236, N'Real', CAST(N'2023-07-14T02:06:46.4635813' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (237, N'Real', CAST(N'2023-07-14T02:16:53.4710038' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (238, N'Real', CAST(N'2023-07-14T02:26:57.5004324' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (239, N'Real', CAST(N'2023-07-14T02:37:02.9161306' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (240, N'Real', CAST(N'2023-07-14T02:47:10.1510464' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (241, N'Real', CAST(N'2023-07-14T02:57:19.8571417' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (242, N'Real', CAST(N'2023-07-14T03:07:24.6451645' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (243, N'Real', CAST(N'2023-07-14T03:17:30.4380553' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (244, N'Real', CAST(N'2023-07-14T03:27:38.6869102' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (245, N'Real', CAST(N'2023-07-14T03:37:40.3764328' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (246, N'Real', CAST(N'2023-07-14T03:47:49.3053828' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (247, N'Real', CAST(N'2023-07-14T03:57:59.1409768' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (248, N'Real', CAST(N'2023-07-14T04:08:09.5447406' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (249, N'Real', CAST(N'2023-07-14T04:18:14.6049909' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (250, N'Real', CAST(N'2023-07-14T04:28:15.7226439' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (251, N'Real', CAST(N'2023-07-14T04:38:20.0529033' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (252, N'Real', CAST(N'2023-07-14T04:48:24.2291975' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (253, N'Real', CAST(N'2023-07-14T04:58:30.9817700' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (254, N'Real', CAST(N'2023-07-14T05:08:39.4016547' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (255, N'Real', CAST(N'2023-07-14T05:18:48.6124656' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (256, N'Real', CAST(N'2023-07-14T05:28:57.8614921' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (257, N'Real', CAST(N'2023-07-14T05:39:06.9828801' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (258, N'Real', CAST(N'2023-07-14T05:49:15.8030050' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (259, N'Real', CAST(N'2023-07-14T05:59:30.4766019' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (260, N'Real', CAST(N'2023-07-14T06:09:39.5907191' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (261, N'Real', CAST(N'2023-07-14T06:19:47.6249789' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (262, N'Real', CAST(N'2023-07-14T06:29:55.4032073' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (263, N'Real', CAST(N'2023-07-14T06:40:03.1820248' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (264, N'Real', CAST(N'2023-07-14T06:50:11.0848422' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (265, N'Real', CAST(N'2023-07-14T07:00:19.6800777' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (266, N'Real', CAST(N'2023-07-14T07:10:28.3999733' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (267, N'Real', CAST(N'2023-07-14T07:20:37.1620285' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (268, N'Real', CAST(N'2023-07-14T07:30:45.3585693' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (269, N'Real', CAST(N'2023-07-14T07:40:53.1633047' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (270, N'Real', CAST(N'2023-07-14T07:51:01.1214852' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (271, N'Real', CAST(N'2023-07-14T08:01:09.4355891' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (272, N'Real', CAST(N'2023-07-14T08:11:17.8090434' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (273, N'Real', CAST(N'2023-07-14T08:21:25.6991715' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (274, N'Real', CAST(N'2023-07-14T08:31:33.9442267' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (275, N'Real', CAST(N'2023-07-14T08:41:41.8068061' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (276, N'Real', CAST(N'2023-07-14T08:51:49.5716273' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (277, N'Real', CAST(N'2023-07-14T09:01:57.4071821' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (278, N'Real', CAST(N'2023-07-14T09:12:05.3867891' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (279, N'Real', CAST(N'2023-07-14T09:22:13.8921890' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (280, N'Real', CAST(N'2023-07-14T09:32:22.5389197' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (281, N'Real', CAST(N'2023-07-14T09:42:31.3862936' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (282, N'Real', CAST(N'2023-07-14T09:52:40.0313586' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (283, N'Real', CAST(N'2023-07-14T10:02:48.9667359' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (284, N'Real', CAST(N'2023-07-14T10:12:57.8539377' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (285, N'Real', CAST(N'2023-07-14T10:23:06.9318355' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (286, N'Real', CAST(N'2023-07-14T10:33:15.2284700' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (287, N'Real', CAST(N'2023-07-14T10:43:23.9926855' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (288, N'Real', CAST(N'2023-07-14T10:53:32.1205163' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (289, N'Real', CAST(N'2023-07-14T11:04:10.1742840' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (290, N'Real', CAST(N'2023-07-14T11:14:18.7215305' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (291, N'Real', CAST(N'2023-07-14T11:24:26.7351149' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (292, N'Real', CAST(N'2023-07-14T11:34:34.8171466' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (293, N'Real', CAST(N'2023-07-14T11:44:42.3928146' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (294, N'Real', CAST(N'2023-07-14T11:54:50.1794153' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (295, N'Real', CAST(N'2023-07-14T12:04:57.9795647' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (296, N'Real', CAST(N'2023-07-14T12:15:05.9353690' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (297, N'Real', CAST(N'2023-07-14T12:25:13.9121709' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (298, N'Real', CAST(N'2023-07-14T12:35:21.8461730' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (299, N'Real', CAST(N'2023-07-14T12:45:30.7475512' AS DateTime2), 0)
GO
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (300, N'Real', CAST(N'2023-07-14T12:52:20.1455808' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (301, N'Real', CAST(N'2023-07-14T12:53:04.6948531' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (302, N'Real', CAST(N'2023-07-14T13:03:10.5915609' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (303, N'Real', CAST(N'2023-07-14T13:13:16.4368719' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (304, N'Real', CAST(N'2023-07-14T13:23:14.3901676' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (305, N'Real', CAST(N'2023-07-14T13:41:10.4529381' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (306, N'Real', CAST(N'2023-07-14T13:41:39.9144890' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (307, N'Real', CAST(N'2023-07-14T13:43:57.7167192' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (308, N'Real', CAST(N'2023-07-14T13:53:59.6825154' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (309, N'Real', CAST(N'2023-07-14T14:04:05.0852331' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (310, N'Real', CAST(N'2023-07-14T14:14:09.8825462' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (311, N'Real', CAST(N'2023-07-14T14:24:14.6637007' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (312, N'Real', CAST(N'2023-07-14T14:34:19.3247627' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (313, N'Real', CAST(N'2023-07-14T14:44:23.9588909' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (314, N'Real', CAST(N'2023-07-14T14:54:28.5427191' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (315, N'Real', CAST(N'2023-07-14T15:04:33.0880021' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (316, N'Real', CAST(N'2023-07-14T15:14:37.8425020' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (317, N'Real', CAST(N'2023-07-14T15:24:42.5247261' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (318, N'Real', CAST(N'2023-07-14T15:34:47.2432664' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (319, N'Real', CAST(N'2023-07-14T15:44:51.8537716' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (320, N'Real', CAST(N'2023-07-14T15:54:56.5329189' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (321, N'Real', CAST(N'2023-07-14T16:05:01.2445301' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (322, N'Real', CAST(N'2023-07-14T16:15:05.8113043' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (323, N'Real', CAST(N'2023-07-14T16:25:10.3589911' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (324, N'Real', CAST(N'2023-07-14T16:35:15.0361678' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (325, N'Real', CAST(N'2023-07-14T16:45:19.6516659' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (326, N'Real', CAST(N'2023-07-14T16:55:24.3139511' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (327, N'Real', CAST(N'2023-07-14T17:05:29.2008997' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (328, N'Real', CAST(N'2023-07-14T17:15:33.8460639' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (329, N'Real', CAST(N'2023-07-14T17:25:38.6256126' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (330, N'Real', CAST(N'2023-07-14T17:35:43.3221094' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (331, N'Real', CAST(N'2023-07-14T17:45:48.0285576' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (332, N'Real', CAST(N'2023-07-14T17:55:52.6067625' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (333, N'Real', CAST(N'2023-07-14T18:05:57.1581603' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (334, N'Real', CAST(N'2023-07-14T18:16:01.9351758' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (335, N'Real', CAST(N'2023-07-14T18:26:06.9477939' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (336, N'Real', CAST(N'2023-07-14T18:36:11.4529754' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (337, N'Real', CAST(N'2023-07-14T18:46:15.9157124' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (338, N'Real', CAST(N'2023-07-14T18:56:20.3343100' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (339, N'Real', CAST(N'2023-07-14T19:06:25.0011204' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (340, N'Real', CAST(N'2023-07-14T19:16:29.5245037' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (341, N'Real', CAST(N'2023-07-14T19:26:34.3370944' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (342, N'Real', CAST(N'2023-07-14T19:36:39.0806800' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (343, N'Real', CAST(N'2023-07-14T19:46:43.7125138' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (344, N'Real', CAST(N'2023-07-14T19:56:48.2789169' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (345, N'Real', CAST(N'2023-07-14T20:06:52.9168881' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (346, N'Real', CAST(N'2023-07-14T20:16:57.4557932' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (347, N'Real', CAST(N'2023-07-14T20:27:02.2265823' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (348, N'Real', CAST(N'2023-07-14T20:37:06.9018044' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (349, N'Real', CAST(N'2023-07-14T20:47:11.4950953' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (350, N'Real', CAST(N'2023-07-14T20:57:16.1644250' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (351, N'Real', CAST(N'2023-07-14T21:07:20.7603686' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (352, N'Real', CAST(N'2023-07-14T21:17:25.7372903' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (353, N'Real', CAST(N'2023-07-14T21:27:30.4571992' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (354, N'Real', CAST(N'2023-07-14T21:37:35.0564658' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (355, N'Real', CAST(N'2023-07-14T21:47:39.6368709' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (356, N'Real', CAST(N'2023-07-14T21:57:44.2931085' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (357, N'Real', CAST(N'2023-07-14T22:07:48.9595292' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (358, N'Real', CAST(N'2023-07-14T22:17:53.6185885' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (359, N'Real', CAST(N'2023-07-14T22:27:58.0408637' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (360, N'Real', CAST(N'2023-07-14T22:38:02.7216260' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (361, N'Real', CAST(N'2023-07-14T22:48:07.2943782' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (362, N'Real', CAST(N'2023-07-14T22:58:11.8563141' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (363, N'Real', CAST(N'2023-07-14T23:08:16.6449444' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (364, N'Real', CAST(N'2023-07-14T23:18:21.3832480' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (365, N'Real', CAST(N'2023-07-14T23:28:26.2559782' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (366, N'Real', CAST(N'2023-07-14T23:38:30.7316602' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (367, N'Real', CAST(N'2023-07-14T23:48:35.3742681' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (368, N'Real', CAST(N'2023-07-14T23:58:39.8481163' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (369, N'Real', CAST(N'2023-07-15T00:08:44.4831019' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (370, N'Real', CAST(N'2023-07-15T00:18:48.9914781' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (371, N'Real', CAST(N'2023-07-15T00:28:53.7633550' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (372, N'Real', CAST(N'2023-07-15T00:38:58.3601327' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (373, N'Real', CAST(N'2023-07-15T00:49:02.9039783' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (374, N'Real', CAST(N'2023-07-15T00:59:07.4467511' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (375, N'Real', CAST(N'2023-07-15T01:09:11.8740862' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (376, N'Real', CAST(N'2023-07-15T01:19:16.4885991' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (377, N'Real', CAST(N'2023-07-15T01:29:21.0588020' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (378, N'Real', CAST(N'2023-07-15T01:39:25.7192132' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (379, N'Real', CAST(N'2023-07-15T01:49:30.3764772' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (380, N'Real', CAST(N'2023-07-15T01:59:34.7794138' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (381, N'Real', CAST(N'2023-07-15T02:09:39.4336102' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (382, N'Real', CAST(N'2023-07-15T02:19:44.1268114' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (383, N'Real', CAST(N'2023-07-15T02:29:48.6673138' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (384, N'Real', CAST(N'2023-07-15T02:39:52.9994510' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (385, N'Real', CAST(N'2023-07-15T02:49:57.5417009' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (386, N'Real', CAST(N'2023-07-15T03:00:02.0997369' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (387, N'Real', CAST(N'2023-07-15T03:10:06.6770726' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (388, N'Real', CAST(N'2023-07-15T03:20:11.2855672' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (389, N'Real', CAST(N'2023-07-15T03:30:15.8994178' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (390, N'Real', CAST(N'2023-07-15T03:40:20.5158892' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (391, N'Real', CAST(N'2023-07-15T03:50:25.1790880' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (392, N'Real', CAST(N'2023-07-15T04:00:29.6190925' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (393, N'Real', CAST(N'2023-07-15T04:10:34.1140226' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (394, N'Real', CAST(N'2023-07-15T04:20:38.7460196' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (395, N'Real', CAST(N'2023-07-15T04:30:43.1898765' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (396, N'Real', CAST(N'2023-07-15T04:40:47.6541396' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (397, N'Real', CAST(N'2023-07-15T04:50:52.3001244' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (398, N'Real', CAST(N'2023-07-15T05:00:56.9384604' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (399, N'Real', CAST(N'2023-07-15T05:11:01.6009173' AS DateTime2), 0)
GO
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (400, N'Real', CAST(N'2023-07-15T05:21:06.0272968' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (401, N'Real', CAST(N'2023-07-15T05:31:10.7031840' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (402, N'Real', CAST(N'2023-07-15T05:41:15.3243694' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (403, N'Real', CAST(N'2023-07-15T05:51:19.8996973' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (404, N'Real', CAST(N'2023-07-15T06:01:24.3790612' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (405, N'Real', CAST(N'2023-07-15T06:11:28.9268847' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (406, N'Real', CAST(N'2023-07-15T06:21:33.5397469' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (407, N'Real', CAST(N'2023-07-15T06:31:38.1914453' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (408, N'Real', CAST(N'2023-07-15T06:41:42.9822815' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (409, N'Real', CAST(N'2023-07-15T06:51:47.6242896' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (410, N'Real', CAST(N'2023-07-15T07:01:52.2328058' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (411, N'Real', CAST(N'2023-07-15T07:11:56.8472217' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (412, N'Real', CAST(N'2023-07-15T07:22:01.3935245' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (413, N'Real', CAST(N'2023-07-15T07:32:06.0551149' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (414, N'Real', CAST(N'2023-07-15T07:42:10.7467871' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (415, N'Real', CAST(N'2023-07-15T07:52:15.5225266' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (416, N'Real', CAST(N'2023-07-15T08:02:20.2482868' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (417, N'Real', CAST(N'2023-07-15T08:12:24.8282206' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (418, N'Real', CAST(N'2023-07-15T08:22:29.5992889' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (419, N'Real', CAST(N'2023-07-15T08:32:34.3540783' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (420, N'Real', CAST(N'2023-07-15T08:42:38.9660977' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (421, N'Real', CAST(N'2023-07-15T08:52:43.8432332' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (422, N'Real', CAST(N'2023-07-15T09:02:48.4979833' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (423, N'Real', CAST(N'2023-07-15T09:12:53.1581138' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (424, N'Real', CAST(N'2023-07-15T09:22:57.8526896' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (425, N'Real', CAST(N'2023-07-15T09:33:02.3643490' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (426, N'Real', CAST(N'2023-07-15T09:43:07.1186749' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (427, N'Real', CAST(N'2023-07-15T09:53:11.8888656' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (428, N'Real', CAST(N'2023-07-15T10:03:16.5790497' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (429, N'Real', CAST(N'2023-07-15T10:13:21.2362187' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (430, N'Real', CAST(N'2023-07-15T10:23:25.9621419' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (431, N'Real', CAST(N'2023-07-15T10:33:30.7325643' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (432, N'Real', CAST(N'2023-07-15T10:43:35.2902252' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (433, N'Real', CAST(N'2023-07-15T10:53:40.0791486' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (434, N'Real', CAST(N'2023-07-15T11:03:44.8172093' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (435, N'Real', CAST(N'2023-07-15T11:13:49.6613354' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (436, N'Real', CAST(N'2023-07-15T11:23:54.4526267' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (437, N'Real', CAST(N'2023-07-15T11:33:59.2130491' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (438, N'Real', CAST(N'2023-07-15T11:44:03.9370656' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (439, N'Real', CAST(N'2023-07-15T11:54:08.6615591' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (440, N'Real', CAST(N'2023-07-15T12:04:13.2762680' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (441, N'Real', CAST(N'2023-07-15T12:14:18.0476129' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (442, N'Real', CAST(N'2023-07-15T12:24:22.4674172' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (443, N'Real', CAST(N'2023-07-15T12:34:27.0759214' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (444, N'Real', CAST(N'2023-07-15T12:44:31.8078247' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (445, N'Real', CAST(N'2023-07-15T12:54:36.4676030' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (446, N'Real', CAST(N'2023-07-15T13:04:41.0649412' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (447, N'Real', CAST(N'2023-07-15T13:14:45.6877849' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (448, N'Real', CAST(N'2023-07-15T13:24:50.2614085' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (449, N'Real', CAST(N'2023-07-15T13:34:55.0474466' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (450, N'Real', CAST(N'2023-07-15T13:44:59.8081344' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (451, N'Real', CAST(N'2023-07-15T13:55:04.4932438' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (452, N'Real', CAST(N'2023-07-15T14:05:09.1298737' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (453, N'Real', CAST(N'2023-07-15T14:15:13.8341606' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (454, N'Real', CAST(N'2023-07-15T14:25:18.5107610' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (455, N'Real', CAST(N'2023-07-15T14:35:23.1228762' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (456, N'Real', CAST(N'2023-07-15T14:45:27.8230051' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (457, N'Real', CAST(N'2023-07-15T14:55:32.7435399' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (458, N'Real', CAST(N'2023-07-15T15:05:37.3712858' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (459, N'Real', CAST(N'2023-07-15T15:15:42.3749933' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (460, N'Real', CAST(N'2023-07-15T15:25:46.9807791' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (461, N'Real', CAST(N'2023-07-15T15:35:51.6578161' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (462, N'Real', CAST(N'2023-07-15T15:45:56.1603127' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (463, N'Real', CAST(N'2023-07-15T15:56:00.9355892' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (464, N'Real', CAST(N'2023-07-15T16:06:05.6601308' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (465, N'Real', CAST(N'2023-07-15T16:16:10.4444580' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (466, N'Real', CAST(N'2023-07-15T16:26:15.1132613' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (467, N'Real', CAST(N'2023-07-15T16:36:20.1240752' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (468, N'Real', CAST(N'2023-07-15T16:46:24.6041687' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (469, N'Real', CAST(N'2023-07-15T16:56:29.3885502' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (470, N'Real', CAST(N'2023-07-15T17:06:34.0046883' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (471, N'Real', CAST(N'2023-07-15T17:16:38.8525373' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (472, N'Real', CAST(N'2023-07-15T17:26:43.7544337' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (473, N'Real', CAST(N'2023-07-15T17:36:48.4041613' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (474, N'Real', CAST(N'2023-07-15T17:46:53.0082605' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (475, N'Real', CAST(N'2023-07-15T17:56:57.7316875' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (476, N'Real', CAST(N'2023-07-15T18:07:02.3301224' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (477, N'Real', CAST(N'2023-07-15T18:17:07.1113942' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (478, N'Real', CAST(N'2023-07-15T18:27:11.7117059' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (479, N'Real', CAST(N'2023-07-15T18:37:16.4404241' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (480, N'Real', CAST(N'2023-07-15T18:47:21.0248643' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (481, N'Real', CAST(N'2023-07-15T18:57:25.7541989' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (482, N'Real', CAST(N'2023-07-15T19:07:30.3560152' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (483, N'Real', CAST(N'2023-07-15T19:17:34.9134840' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (484, N'Real', CAST(N'2023-07-15T19:27:39.6586038' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (485, N'Real', CAST(N'2023-07-15T19:37:44.5491642' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (486, N'Real', CAST(N'2023-07-15T19:47:49.2094460' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (487, N'Real', CAST(N'2023-07-15T19:57:53.8690780' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (488, N'Real', CAST(N'2023-07-15T20:07:58.5120225' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (489, N'Real', CAST(N'2023-07-15T20:18:03.2185627' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (490, N'Real', CAST(N'2023-07-15T20:28:07.9000223' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (491, N'Real', CAST(N'2023-07-15T20:38:12.5337705' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (492, N'Real', CAST(N'2023-07-15T20:48:17.2018404' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (493, N'Real', CAST(N'2023-07-15T20:58:21.9615139' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (494, N'Real', CAST(N'2023-07-15T21:08:26.7310859' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (495, N'Real', CAST(N'2023-07-15T21:18:31.6031874' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (496, N'Real', CAST(N'2023-07-15T21:28:36.4737901' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (497, N'Real', CAST(N'2023-07-15T21:38:41.2986894' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (498, N'Real', CAST(N'2023-07-15T21:48:45.8581923' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (499, N'Real', CAST(N'2023-07-15T21:58:50.5554485' AS DateTime2), 0)
GO
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (500, N'Real', CAST(N'2023-07-15T22:08:55.1804312' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (501, N'Real', CAST(N'2023-07-15T22:19:00.0127780' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (502, N'Real', CAST(N'2023-07-15T22:29:04.6676158' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (503, N'Real', CAST(N'2023-07-15T22:39:09.2649285' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (504, N'Real', CAST(N'2023-07-15T22:49:13.8749211' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (505, N'Real', CAST(N'2023-07-15T22:59:18.6348850' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (506, N'Real', CAST(N'2023-07-15T23:09:23.5234007' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (507, N'Real', CAST(N'2023-07-15T23:19:28.2134403' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (508, N'Real', CAST(N'2023-07-15T23:29:32.9086267' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (509, N'Real', CAST(N'2023-07-15T23:39:37.5330491' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (510, N'Real', CAST(N'2023-07-15T23:49:42.2170031' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (511, N'Real', CAST(N'2023-07-15T23:59:47.0339515' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (512, N'Real', CAST(N'2023-07-16T00:09:51.7344516' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (513, N'Real', CAST(N'2023-07-16T00:19:56.3828436' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (514, N'Real', CAST(N'2023-07-16T00:30:01.2124496' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (515, N'Real', CAST(N'2023-07-16T00:40:05.9659169' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (516, N'Real', CAST(N'2023-07-16T00:50:10.6316790' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (517, N'Real', CAST(N'2023-07-16T01:00:15.3721662' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (518, N'Real', CAST(N'2023-07-16T01:10:20.0271723' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (519, N'Real', CAST(N'2023-07-16T01:20:24.4992947' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (520, N'Real', CAST(N'2023-07-16T01:30:29.0446287' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (521, N'Real', CAST(N'2023-07-16T01:40:33.6708556' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (522, N'Real', CAST(N'2023-07-16T01:50:38.1748773' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (523, N'Real', CAST(N'2023-07-16T02:00:42.8386355' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (524, N'Real', CAST(N'2023-07-16T02:10:47.4033093' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (525, N'Real', CAST(N'2023-07-16T02:20:52.2283562' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (526, N'Real', CAST(N'2023-07-16T02:30:56.8840065' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (527, N'Real', CAST(N'2023-07-16T02:41:01.5354023' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (528, N'Real', CAST(N'2023-07-16T02:51:06.1209155' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (529, N'Real', CAST(N'2023-07-16T03:01:10.6007538' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (530, N'Real', CAST(N'2023-07-16T03:11:15.1644136' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (531, N'Real', CAST(N'2023-07-16T03:21:19.5863236' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (532, N'Real', CAST(N'2023-07-16T03:31:24.0451655' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (533, N'Real', CAST(N'2023-07-16T03:41:28.6364622' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (534, N'Real', CAST(N'2023-07-16T03:51:33.2401306' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (535, N'Real', CAST(N'2023-07-16T04:01:37.7898169' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (536, N'Real', CAST(N'2023-07-16T04:11:42.4489066' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (537, N'Real', CAST(N'2023-07-16T04:21:47.0662951' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (538, N'Real', CAST(N'2023-07-16T04:31:51.7273605' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (539, N'Real', CAST(N'2023-07-16T04:41:56.2699672' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (540, N'Real', CAST(N'2023-07-16T04:52:01.0725465' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (541, N'Real', CAST(N'2023-07-16T05:02:05.7670027' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (542, N'Real', CAST(N'2023-07-16T05:12:10.4537626' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (543, N'Real', CAST(N'2023-07-16T05:22:15.1621817' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (544, N'Real', CAST(N'2023-07-16T05:32:19.7910573' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (545, N'Real', CAST(N'2023-07-16T05:42:24.3895438' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (546, N'Real', CAST(N'2023-07-16T05:52:28.8533831' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (547, N'Real', CAST(N'2023-07-16T06:02:33.4686876' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (548, N'Real', CAST(N'2023-07-16T06:12:38.1525248' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (549, N'Real', CAST(N'2023-07-16T06:22:42.7093816' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (550, N'Real', CAST(N'2023-07-16T06:32:47.2351845' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (551, N'Real', CAST(N'2023-07-16T06:42:51.7897655' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (552, N'Real', CAST(N'2023-07-16T06:52:56.3861620' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (553, N'Real', CAST(N'2023-07-16T07:03:00.8948600' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (554, N'Real', CAST(N'2023-07-16T07:13:05.5700810' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (555, N'Real', CAST(N'2023-07-16T07:23:10.6168533' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (556, N'Real', CAST(N'2023-07-16T07:33:15.5392973' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (557, N'Real', CAST(N'2023-07-16T07:43:19.9785530' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (558, N'Real', CAST(N'2023-07-16T07:53:24.6930687' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (559, N'Real', CAST(N'2023-07-16T08:03:29.3001204' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (560, N'Real', CAST(N'2023-07-16T08:13:33.9741075' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (561, N'Real', CAST(N'2023-07-16T08:23:38.8135475' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (562, N'Real', CAST(N'2023-07-16T08:33:43.4791024' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (563, N'Real', CAST(N'2023-07-16T08:43:47.9595533' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (564, N'Real', CAST(N'2023-07-16T08:53:52.6306960' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (565, N'Real', CAST(N'2023-07-16T09:03:57.3521962' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (566, N'Real', CAST(N'2023-07-16T09:14:01.9018517' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (567, N'Real', CAST(N'2023-07-16T09:24:06.5998309' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (568, N'Real', CAST(N'2023-07-16T09:34:11.1991288' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (569, N'Real', CAST(N'2023-07-16T09:44:15.8944881' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (570, N'Real', CAST(N'2023-07-16T09:54:20.6909261' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (571, N'Real', CAST(N'2023-07-16T10:04:25.3651292' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (572, N'Real', CAST(N'2023-07-16T10:14:30.0247567' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (573, N'Real', CAST(N'2023-07-16T10:24:34.9115328' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (574, N'Real', CAST(N'2023-07-16T10:34:39.5222952' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (575, N'Real', CAST(N'2023-07-16T10:44:44.0379351' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (576, N'Real', CAST(N'2023-07-16T10:54:48.4932290' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (577, N'Real', CAST(N'2023-07-16T11:04:53.2509715' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (578, N'Real', CAST(N'2023-07-16T11:14:58.0742699' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (579, N'Real', CAST(N'2023-07-16T11:25:02.9501777' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (580, N'Real', CAST(N'2023-07-16T11:35:07.5949815' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (581, N'Real', CAST(N'2023-07-16T11:45:12.2573702' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (582, N'Real', CAST(N'2023-07-16T11:55:16.8240716' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (583, N'Real', CAST(N'2023-07-16T12:05:21.4303058' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (584, N'Real', CAST(N'2023-07-16T12:15:26.0874065' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (585, N'Real', CAST(N'2023-07-16T12:25:30.6581102' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (586, N'Real', CAST(N'2023-07-16T12:35:35.2474756' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (587, N'Real', CAST(N'2023-07-16T12:45:39.8515057' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (588, N'Real', CAST(N'2023-07-16T12:55:44.6040980' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (589, N'Real', CAST(N'2023-07-16T13:05:49.2712484' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (590, N'Real', CAST(N'2023-07-16T13:15:53.9235173' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (591, N'Real', CAST(N'2023-07-16T13:25:58.9114314' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (592, N'Real', CAST(N'2023-07-16T13:36:03.6301517' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (593, N'Real', CAST(N'2023-07-16T13:46:08.3181712' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (594, N'Real', CAST(N'2023-07-16T13:56:12.8930136' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (595, N'Real', CAST(N'2023-07-16T14:06:17.4121959' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (596, N'Real', CAST(N'2023-07-16T14:16:22.0272914' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (597, N'Real', CAST(N'2023-07-16T14:26:26.7594042' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (598, N'Real', CAST(N'2023-07-16T14:36:31.2988825' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (599, N'Real', CAST(N'2023-07-16T14:46:35.9579352' AS DateTime2), 0)
GO
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (600, N'Real', CAST(N'2023-07-16T14:56:40.5916111' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (601, N'Real', CAST(N'2023-07-16T15:06:45.2389670' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (602, N'Real', CAST(N'2023-07-16T15:16:50.1754462' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (603, N'Real', CAST(N'2023-07-16T15:26:54.9340356' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (604, N'Real', CAST(N'2023-07-16T15:36:59.4900891' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (605, N'Real', CAST(N'2023-07-16T15:47:04.1145581' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (606, N'Real', CAST(N'2023-07-16T15:57:08.6711642' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (607, N'Real', CAST(N'2023-07-16T16:07:13.3122379' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (608, N'Real', CAST(N'2023-07-16T16:17:18.0391331' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (609, N'Real', CAST(N'2023-07-16T16:27:22.6402773' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (610, N'Real', CAST(N'2023-07-16T16:37:27.2083509' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (611, N'Real', CAST(N'2023-07-16T16:47:31.5989765' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (612, N'Real', CAST(N'2023-07-16T16:57:36.1559989' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (613, N'Real', CAST(N'2023-07-16T17:07:40.7857837' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (614, N'Real', CAST(N'2023-07-16T17:17:45.4315590' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (615, N'Real', CAST(N'2023-07-16T17:27:49.9952557' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (616, N'Real', CAST(N'2023-07-16T17:37:54.8518088' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (617, N'Real', CAST(N'2023-07-16T17:47:59.6125852' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (618, N'Real', CAST(N'2023-07-16T17:58:04.2422634' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (619, N'Real', CAST(N'2023-07-16T18:08:08.9553774' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (620, N'Real', CAST(N'2023-07-16T18:18:13.6041226' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (621, N'Real', CAST(N'2023-07-16T18:28:18.4412656' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (622, N'Real', CAST(N'2023-07-16T18:38:23.0317643' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (623, N'Real', CAST(N'2023-07-16T18:48:27.7723584' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (624, N'Real', CAST(N'2023-07-16T18:58:32.2664743' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (625, N'Real', CAST(N'2023-07-16T19:08:36.9109432' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (626, N'Real', CAST(N'2023-07-16T19:18:41.7174039' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (627, N'Real', CAST(N'2023-07-16T19:28:46.3771783' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (628, N'Real', CAST(N'2023-07-16T19:38:50.9090991' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (629, N'Real', CAST(N'2023-07-16T19:48:55.4335805' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (630, N'Real', CAST(N'2023-07-16T19:59:00.1516789' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (631, N'Real', CAST(N'2023-07-16T20:09:04.7139165' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (632, N'Real', CAST(N'2023-07-16T20:19:09.4167153' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (633, N'Real', CAST(N'2023-07-16T20:29:14.0993085' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (634, N'Real', CAST(N'2023-07-16T20:39:18.7360836' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (635, N'Real', CAST(N'2023-07-16T20:49:23.3840999' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (636, N'Real', CAST(N'2023-07-16T20:59:28.0211064' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (637, N'Real', CAST(N'2023-07-16T21:09:32.7508864' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (638, N'Real', CAST(N'2023-07-16T21:19:37.3467838' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (639, N'Real', CAST(N'2023-07-16T21:29:41.9294298' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (640, N'Real', CAST(N'2023-07-16T21:39:46.6546109' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (641, N'Real', CAST(N'2023-07-16T21:49:51.2887625' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (642, N'Real', CAST(N'2023-07-16T21:59:55.8214819' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (643, N'Real', CAST(N'2023-07-16T22:10:00.4565725' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (644, N'Real', CAST(N'2023-07-16T22:20:05.0381598' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (645, N'Real', CAST(N'2023-07-16T22:30:09.6665368' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (646, N'Real', CAST(N'2023-07-16T22:40:14.3447229' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (647, N'Real', CAST(N'2023-07-16T22:50:18.8346449' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (648, N'Real', CAST(N'2023-07-16T23:00:23.3134693' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (649, N'Real', CAST(N'2023-07-16T23:10:28.3068521' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (650, N'Real', CAST(N'2023-07-16T23:20:33.1283490' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (651, N'Real', CAST(N'2023-07-16T23:30:37.8801787' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (652, N'Real', CAST(N'2023-07-16T23:40:42.6323943' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (653, N'Real', CAST(N'2023-07-16T23:50:47.2716177' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (654, N'Real', CAST(N'2023-07-17T00:00:51.8715009' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (655, N'Real', CAST(N'2023-07-17T00:10:56.5055967' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (656, N'Real', CAST(N'2023-07-17T00:21:01.2100737' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (657, N'Real', CAST(N'2023-07-17T00:31:05.9350440' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (658, N'Real', CAST(N'2023-07-17T00:41:10.5958298' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (659, N'Real', CAST(N'2023-07-17T00:51:15.1634648' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (660, N'Real', CAST(N'2023-07-17T01:01:20.1176436' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (661, N'Real', CAST(N'2023-07-17T01:11:24.5898992' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (662, N'Real', CAST(N'2023-07-17T01:21:28.9583804' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (663, N'Real', CAST(N'2023-07-17T01:31:33.7211377' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (664, N'Real', CAST(N'2023-07-17T01:41:38.3094417' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (665, N'Real', CAST(N'2023-07-17T01:51:42.9221648' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (666, N'Real', CAST(N'2023-07-17T02:01:47.5277955' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (667, N'Real', CAST(N'2023-07-17T02:11:52.1542884' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (668, N'Real', CAST(N'2023-07-17T02:21:56.7833514' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (669, N'Real', CAST(N'2023-07-17T02:32:01.5492086' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (670, N'Real', CAST(N'2023-07-17T02:42:06.1190282' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (671, N'Real', CAST(N'2023-07-17T02:52:10.7771584' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (672, N'Real', CAST(N'2023-07-17T03:02:15.4942733' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (673, N'Real', CAST(N'2023-07-17T03:12:19.9368841' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (674, N'Real', CAST(N'2023-07-17T03:22:24.5808359' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (675, N'Real', CAST(N'2023-07-17T03:32:29.2647298' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (676, N'Real', CAST(N'2023-07-17T03:42:34.1731995' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (677, N'Real', CAST(N'2023-07-17T03:52:38.9218796' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (678, N'Real', CAST(N'2023-07-17T04:02:43.4574831' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (679, N'Real', CAST(N'2023-07-17T04:12:48.2823187' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (680, N'Real', CAST(N'2023-07-17T04:22:53.0582670' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (681, N'Real', CAST(N'2023-07-17T04:32:58.1946610' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (682, N'Real', CAST(N'2023-07-17T04:43:03.1956127' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (683, N'Real', CAST(N'2023-07-17T04:53:08.2142501' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (684, N'Real', CAST(N'2023-07-17T05:03:14.2639888' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (685, N'Real', CAST(N'2023-07-17T05:03:29.8899966' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (686, N'Real', CAST(N'2023-07-17T05:05:23.1103544' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (687, N'Real', CAST(N'2023-07-17T05:07:16.4673672' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (688, N'Real', CAST(N'2023-07-17T05:32:08.7523547' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (689, N'Real', CAST(N'2023-07-17T05:41:08.0332010' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (690, N'Real', CAST(N'2023-07-17T05:44:25.6629369' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (691, N'Real', CAST(N'2023-07-17T05:48:15.1334469' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (692, N'Real', CAST(N'2023-07-17T05:50:05.2004335' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (693, N'Real', CAST(N'2023-07-17T05:55:26.5963164' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (694, N'Real', CAST(N'2023-07-17T05:55:40.9474016' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (695, N'Real', CAST(N'2023-07-17T06:05:47.2901744' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (696, N'Real', CAST(N'2023-07-17T06:15:53.5855377' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (697, N'Real', CAST(N'2023-07-17T06:26:00.0170152' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (698, N'Real', CAST(N'2023-07-17T06:30:00.7307264' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (699, N'Real', CAST(N'2023-07-17T06:45:00.6483799' AS DateTime2), 0)
GO
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (700, N'Real', CAST(N'2023-07-17T06:53:46.1185019' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (701, N'Real', CAST(N'2023-07-17T06:54:56.5992610' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (702, N'Real', CAST(N'2023-07-17T07:10:29.4266286' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (703, N'Real', CAST(N'2023-07-17T07:20:41.2130902' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (704, N'Real', CAST(N'2023-07-17T07:30:55.9558302' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (705, N'Real', CAST(N'2023-07-17T07:37:17.8611172' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (706, N'Real', CAST(N'2023-07-17T07:38:15.6082493' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (707, N'Real', CAST(N'2023-07-17T07:39:35.8565475' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (708, N'Real', CAST(N'2023-07-17T07:39:51.0447893' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (709, N'Real', CAST(N'2023-07-17T07:40:57.3749429' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (710, N'Real', CAST(N'2023-07-17T07:41:40.6414402' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (711, N'Real', CAST(N'2023-07-17T07:42:34.9723053' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (712, N'Real', CAST(N'2023-07-17T07:52:01.1658123' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (713, N'Real', CAST(N'2023-07-17T07:53:11.6334533' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (714, N'Real', CAST(N'2023-07-17T07:53:26.7856549' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (715, N'Real', CAST(N'2023-07-17T07:56:31.8243693' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (716, N'Real', CAST(N'2023-07-17T08:03:49.9353745' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (717, N'Real', CAST(N'2023-07-17T08:04:59.3671187' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (718, N'Real', CAST(N'2023-07-17T08:05:28.8621353' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (719, N'Real', CAST(N'2023-07-17T08:06:03.1140782' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (720, N'Real', CAST(N'2023-07-17T08:06:32.1574929' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (721, N'Real', CAST(N'2023-07-17T08:24:11.9735126' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (722, N'Real', CAST(N'2023-07-17T08:34:24.2135149' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (723, N'Real', CAST(N'2023-07-17T08:35:38.7214018' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (724, N'Real', CAST(N'2023-07-17T08:39:24.8012343' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (725, N'Real', CAST(N'2023-07-17T08:40:29.2089637' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (726, N'Real', CAST(N'2023-07-17T08:40:56.7068171' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (727, N'Real', CAST(N'2023-07-17T08:42:31.2713310' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (728, N'Real', CAST(N'2023-07-17T08:42:44.1615402' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (729, N'Real', CAST(N'2023-07-17T10:28:02.6158461' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (730, N'Real', CAST(N'2023-07-17T10:28:45.4391354' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (731, N'Real', CAST(N'2023-07-17T10:34:46.5947696' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (732, N'Real', CAST(N'2023-07-17T10:34:59.3273328' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (733, N'Real', CAST(N'2023-07-17T10:39:08.6397622' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (734, N'Real', CAST(N'2023-07-17T10:40:13.3898357' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (735, N'Real', CAST(N'2023-07-17T10:42:56.0626208' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (736, N'Real', CAST(N'2023-07-17T10:44:46.6537041' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (737, N'Real', CAST(N'2023-07-17T10:48:36.6119732' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (738, N'Real', CAST(N'2023-07-17T10:49:52.7116840' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (739, N'Real', CAST(N'2023-07-17T10:50:07.0849342' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (740, N'Real', CAST(N'2023-07-17T10:59:43.3730027' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (741, N'Real', CAST(N'2023-07-17T11:02:19.4035619' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (742, N'Real', CAST(N'2023-07-17T11:02:32.5458419' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (743, N'Real', CAST(N'2023-07-17T11:05:48.6856218' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (744, N'Real', CAST(N'2023-07-17T11:12:44.1471423' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (745, N'Real', CAST(N'2023-07-17T11:13:31.6275507' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (746, N'Real', CAST(N'2023-07-17T11:23:39.2854185' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (747, N'Real', CAST(N'2023-07-17T11:33:46.9176873' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (748, N'Real', CAST(N'2023-07-17T11:42:18.0273631' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (749, N'Real', CAST(N'2023-07-17T12:12:56.7650185' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (750, N'Real', CAST(N'2023-07-17T12:13:09.2960605' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (751, N'Real', CAST(N'2023-07-17T12:18:02.4513461' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (752, N'Real', CAST(N'2023-07-18T10:35:00.9758981' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (753, N'Real', CAST(N'2023-07-18T10:36:49.0406293' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (754, N'Real', CAST(N'2023-07-18T10:46:55.5744902' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (755, N'Real', CAST(N'2023-07-18T10:57:02.1981720' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (756, N'Real', CAST(N'2023-07-18T11:00:22.9881914' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (757, N'Real', CAST(N'2023-07-18T11:02:13.0381033' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (758, N'Real', CAST(N'2023-07-18T11:02:28.0918666' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (759, N'Real', CAST(N'2023-07-18T11:02:42.2000621' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (760, N'Real', CAST(N'2023-07-18T11:02:57.4030116' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (761, N'Real', CAST(N'2023-07-18T11:03:43.9947181' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (762, N'Real', CAST(N'2023-07-18T11:13:50.8770865' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (763, N'Real', CAST(N'2023-07-18T11:23:57.7266319' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (764, N'Real', CAST(N'2023-07-18T11:34:03.6003614' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (765, N'Real', CAST(N'2023-07-18T11:44:08.7476032' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (766, N'Real', CAST(N'2023-07-18T11:54:13.5582945' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (767, N'Real', CAST(N'2023-07-18T12:04:19.3269547' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (768, N'Real', CAST(N'2023-07-18T12:14:25.2775013' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (769, N'Real', CAST(N'2023-07-18T12:24:31.3602806' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (770, N'Real', CAST(N'2023-07-18T12:34:37.1213605' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (771, N'Real', CAST(N'2023-07-19T06:31:20.4993222' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (772, N'Real', CAST(N'2023-07-19T06:31:53.3715114' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (773, N'Real', CAST(N'2023-07-19T06:37:55.1300364' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (774, N'Real', CAST(N'2023-07-19T06:39:32.9415673' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (775, N'Real', CAST(N'2023-07-19T06:41:20.0310409' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (776, N'Real', CAST(N'2023-07-19T06:46:49.8865250' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (777, N'Real', CAST(N'2023-07-19T06:47:19.0384678' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (778, N'Real', CAST(N'2023-07-19T06:52:54.0564134' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (779, N'Real', CAST(N'2023-07-19T06:57:19.0135062' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (780, N'Real', CAST(N'2023-07-19T06:58:33.3918357' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (781, N'Real', CAST(N'2023-07-19T07:04:08.7915000' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (782, N'Real', CAST(N'2023-07-19T07:13:32.7644276' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (783, N'Real', CAST(N'2023-07-19T07:13:56.9743855' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (784, N'Real', CAST(N'2023-07-19T07:24:03.2623302' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (785, N'Real', CAST(N'2023-07-19T07:24:38.0529777' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (786, N'Real', CAST(N'2023-07-19T07:26:44.7947470' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (787, N'Real', CAST(N'2023-07-19T07:36:46.8646580' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (788, N'Real', CAST(N'2023-07-19T07:40:23.1284901' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (789, N'Real', CAST(N'2023-07-19T07:41:23.4958036' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (790, N'Real', CAST(N'2023-07-19T07:51:25.3250923' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (791, N'Real', CAST(N'2023-07-19T08:00:18.2632690' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (792, N'Real', CAST(N'2023-07-19T08:34:57.6020740' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (793, N'Real', CAST(N'2023-07-19T08:36:44.8819629' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (794, N'Real', CAST(N'2023-07-19T08:36:54.9192563' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (795, N'Real', CAST(N'2023-07-19T08:44:21.6762481' AS DateTime2), 1)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (796, N'Real', CAST(N'2023-07-19T11:08:43.1808196' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (797, N'Real', CAST(N'2023-07-19T11:18:49.8417931' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (798, N'Real', CAST(N'2023-07-19T11:28:55.7340704' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (799, N'Real', CAST(N'2023-07-19T11:38:36.7108154' AS DateTime2), 1)
GO
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (800, N'Real', CAST(N'2023-07-19T12:02:22.3194022' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (801, N'Real', CAST(N'2023-07-19T12:12:34.4813026' AS DateTime2), 0)
INSERT [dbo].[Failures] ([Id], [HealthCheckName], [LastNotified], [IsUpAndRunning]) VALUES (802, N'Real', CAST(N'2023-07-19T12:22:40.1483552' AS DateTime2), 0)
SET IDENTITY_INSERT [dbo].[Failures] OFF
GO
SET IDENTITY_INSERT [dbo].[HealthCheckExecutionEntries] ON 

INSERT [dbo].[HealthCheckExecutionEntries] ([Id], [Name], [Status], [Description], [Duration], [HealthCheckExecutionId], [Tags]) VALUES (268, N'Endpoint', 0, N'Подключение не установлено, т.к. конечный компьютер отверг запрос на подключение. (localhost:5001)', CAST(N'00:00:00' AS Time), 18, NULL)
SET IDENTITY_INSERT [dbo].[HealthCheckExecutionEntries] OFF
GO
SET IDENTITY_INSERT [dbo].[HealthCheckExecutionHistories] ON 

INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (1, N'process', NULL, 0, CAST(N'2023-05-05T22:07:03.3285884' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (2, N'process', NULL, 2, CAST(N'2023-05-05T22:07:07.4611519' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (3, N'process', NULL, 0, CAST(N'2023-05-05T22:33:41.2814714' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (4, N'sqlserver', NULL, 2, CAST(N'2023-05-07T14:40:40.1376546' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (5, N'sqlserver', N'Cannot open database "test" requested by the login. The login failed.
Login failed for user ''PROVICE-PC\Provice''.', 0, CAST(N'2023-05-07T14:43:54.0483581' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (6, N'sqlserver', NULL, 2, CAST(N'2023-05-07T14:45:15.3711158' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (7, N'sqlserver', N'Cannot open database "test" requested by the login. The login failed.
Login failed for user ''PROVICE-PC\Provice''.', 0, CAST(N'2023-05-07T14:45:56.7288209' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (8, N'Test Process', NULL, 2, CAST(N'2023-05-08T16:59:18.1905046' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (9, N'Test Process', NULL, 0, CAST(N'2023-05-08T16:59:57.6498777' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (10, N'Test Process', NULL, 2, CAST(N'2023-05-08T17:00:11.4130683' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (11, N'Test Process', NULL, 0, CAST(N'2023-05-08T17:02:24.9971724' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (12, N'Test Process', NULL, 2, CAST(N'2023-05-08T17:02:35.6010215' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (13, N'Test Process', NULL, 0, CAST(N'2023-05-08T17:02:55.8184811' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (14, N'Test Process', NULL, 2, CAST(N'2023-05-08T17:19:10.7819361' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (15, N'Test Process', NULL, 0, CAST(N'2023-05-08T17:19:18.2121889' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (16, N'Test Process', NULL, 2, CAST(N'2023-05-08T17:19:58.2652789' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (17, N'Test Process', NULL, 0, CAST(N'2023-05-08T17:23:53.7113283' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (18, N'Test Process', NULL, 2, CAST(N'2023-05-08T17:45:39.1649998' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (19, N'Test Process', NULL, 0, CAST(N'2023-05-08T17:46:58.1852206' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (20, N'Test Process', NULL, 2, CAST(N'2023-05-08T17:23:53.0000000' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (22, N'Test Process', NULL, 2, CAST(N'2023-05-13T14:38:26.5325516' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (23, N'Test Process', NULL, 0, CAST(N'2023-05-13T14:38:39.6182353' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (24, N'Test Process', NULL, 2, CAST(N'2023-05-13T14:41:24.9577229' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (25, N'Test Service', NULL, 0, CAST(N'2023-05-13T14:41:36.7422509' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (26, N'Test Process', NULL, 2, CAST(N'2023-05-13T15:03:47.4610476' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (27, N'Test Process', NULL, 0, CAST(N'2023-05-13T15:03:53.6469659' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (28, N'Test Process', NULL, 2, CAST(N'2023-05-13T15:15:04.1993276' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (29, N'Test Process', NULL, 0, CAST(N'2023-05-13T15:15:10.3297573' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (30, N'Test Process', NULL, 2, CAST(N'2023-05-13T15:27:18.0107116' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (31, N'Test Process', NULL, 0, CAST(N'2023-05-13T15:27:21.0724614' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (32, N'Process', NULL, 2, CAST(N'2023-05-13T15:51:55.4223710' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (33, N'Process', NULL, 0, CAST(N'2023-05-13T15:52:04.5730266' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (34, N'Mspaint', NULL, 2, CAST(N'2023-05-13T18:33:39.3881790' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (36, N'Mspaint', NULL, 0, CAST(N'2023-05-13T18:34:00.9456034' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (37, N'Mspaint', NULL, 2, CAST(N'2023-05-13T18:34:19.4637846' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (40, N'Mspaint', NULL, 0, CAST(N'2023-05-13T18:35:18.0317021' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (41, N'Mspaint', NULL, 2, CAST(N'2023-05-13T18:37:13.9718093' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (43, N'CalculatorApp', NULL, 0, CAST(N'2023-05-13T18:38:00.0715203' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (44, N'Mspaint', NULL, 2, CAST(N'2023-05-13T18:38:34.1952008' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (45, N'CalculatorApp', NULL, 0, CAST(N'2023-05-13T19:28:52.9210544' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (46, N'CalculatorApp', NULL, 2, CAST(N'2023-05-13T19:34:22.8571127' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (47, N'CalculatorApp', NULL, 0, CAST(N'2023-05-13T19:34:29.8874298' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (48, N'Mspaint', NULL, 2, CAST(N'2023-05-13T19:48:58.0268723' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (49, N'CalculatorApp', NULL, 2, CAST(N'2023-05-13T19:48:58.0268723' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (50, N'CalculatorApp', NULL, 0, CAST(N'2023-05-13T19:49:12.3081997' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (51, N'CalculatorApp', NULL, 2, CAST(N'2023-05-13T19:52:51.0701217' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (52, N'CalculatorApp', NULL, 0, CAST(N'2023-05-13T19:53:05.1315721' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (53, N'Mspaint', NULL, 2, CAST(N'2023-05-13T20:02:59.0944505' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (54, N'Mspaint', NULL, 0, CAST(N'2023-05-13T20:03:06.1277506' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (55, N'CalculatorApp', NULL, 2, CAST(N'2023-05-13T20:05:35.9539740' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (56, N'CalculatorApp', NULL, 0, CAST(N'2023-05-13T21:04:55.3362062' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (57, N'CalculatorApp', NULL, 2, CAST(N'2023-05-13T21:21:16.5695986' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (58, N'CalculatorApp', NULL, 1, CAST(N'2023-05-13T21:21:30.6817978' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (59, N'CalculatorApp', NULL, 2, CAST(N'2023-05-13T21:24:54.3411745' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (60, N'CalculatorApp', NULL, 1, CAST(N'2023-05-13T21:25:09.4721634' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (61, N'CalculatorApp', NULL, 0, CAST(N'2023-05-13T21:26:01.3949220' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (62, N'CalculatorApp', NULL, 2, CAST(N'2023-05-13T21:26:11.6477510' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (64, N'CalculatorApp', NULL, 0, CAST(N'2023-05-13T21:28:24.3409904' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (65, N'Mspaint', NULL, 2, CAST(N'2023-05-13T21:31:40.1856443' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (66, N'Mspaint', NULL, 0, CAST(N'2023-05-13T21:32:00.7280223' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (67, N'Non system app', NULL, 2, CAST(N'2023-05-20T15:33:56.9269223' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (68, N'Non system app', NULL, 0, CAST(N'2023-05-20T15:34:09.1019502' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (69, N'Non system app', NULL, 2, CAST(N'2023-05-20T15:35:23.6846846' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (70, N'Non system app', NULL, 0, CAST(N'2023-05-20T15:35:29.8002861' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (71, N'Non system app', NULL, 2, CAST(N'2023-05-20T16:09:27.0624270' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (72, N'Non system app', NULL, 0, CAST(N'2023-05-20T16:09:42.3226178' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (73, N'Non system app', NULL, 2, CAST(N'2023-05-20T16:10:31.0425217' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (74, N'Non system app', NULL, 0, CAST(N'2023-05-20T16:10:37.1570642' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (75, N'Non system app', NULL, 2, CAST(N'2023-05-20T16:10:40.2145596' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (76, N'Non system app', NULL, 0, CAST(N'2023-05-20T16:10:55.4360447' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (77, N'Non system app', NULL, 2, CAST(N'2023-05-20T16:11:07.6299020' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (78, N'Non system app', NULL, 0, CAST(N'2023-05-20T16:11:13.7290172' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (79, N'Non system app', NULL, 2, CAST(N'2023-05-20T16:11:25.9217508' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (80, N'Non system app', NULL, 0, CAST(N'2023-05-20T16:11:32.0414795' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (81, N'Non system app', NULL, 2, CAST(N'2023-05-20T16:17:34.3464606' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (82, N'Non system app', NULL, 0, CAST(N'2023-05-20T16:17:52.6054341' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (83, N'Non system app', NULL, 2, CAST(N'2023-05-20T16:18:10.9050566' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (84, N'Non system app', NULL, 0, CAST(N'2023-05-20T16:18:44.3671701' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (85, N'Non system app', NULL, 2, CAST(N'2023-05-20T16:26:07.7669395' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (86, N'Non system app', NULL, 0, CAST(N'2023-05-20T16:43:21.4688946' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (87, N'Non system app', NULL, 2, CAST(N'2023-05-20T16:51:43.1838428' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (88, N'Non system app', NULL, 0, CAST(N'2023-05-20T16:51:46.2593660' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (89, N'Non system app', NULL, 2, CAST(N'2023-05-20T18:12:35.5430491' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (90, N'Non system app', NULL, 0, CAST(N'2023-05-20T18:12:41.6483428' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (91, N'Non system app', NULL, 2, CAST(N'2023-05-20T18:15:40.0123341' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (92, N'Non system app', NULL, 0, CAST(N'2023-05-20T18:18:21.2395723' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (93, N'Service', NULL, 2, CAST(N'2023-05-20T19:40:18.7016824' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (94, N'Service', NULL, 0, CAST(N'2023-05-20T19:40:33.8030126' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (95, N'Grade-X PhrasesDB', N'A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)', 0, CAST(N'2023-05-23T07:10:55.9402316' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (96, N'Grade-X PhrasesDB', N'A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)', 0, CAST(N'2023-05-23T07:46:50.4379377' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (97, N'Grade-X PhrasesDB', N'A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)', 0, CAST(N'2023-05-23T08:12:18.2424775' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (98, N'Grade-X PhrasesDB', N'A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)', 0, CAST(N'2023-05-23T09:08:09.5326772' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (99, N'Test', NULL, 0, CAST(N'2023-05-23T12:25:26.2868962' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (100, N'Simple', NULL, 2, CAST(N'2023-05-24T05:37:02.1295366' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (101, N'Simple', NULL, 0, CAST(N'2023-05-24T05:37:11.2085981' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (102, N'Test', NULL, 2, CAST(N'2023-05-24T08:10:06.2274203' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (103, N'Test', NULL, 0, CAST(N'2023-05-24T08:10:24.4203676' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (104, N'Test', NULL, 2, CAST(N'2023-05-24T12:09:42.4501232' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (105, N'Calc', NULL, 0, CAST(N'2023-05-24T12:11:33.2128536' AS DateTime2), 18)
GO
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (106, N'Calc', NULL, 2, CAST(N'2023-05-24T12:12:09.5921134' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (107, N'Calc', NULL, 0, CAST(N'2023-05-24T12:12:39.9067433' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (108, N'MSSQL', N'A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)', 0, CAST(N'2023-05-24T12:20:38.1504407' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (109, N'MSSQL', NULL, 2, CAST(N'2023-05-24T12:21:14.0622813' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (110, N'MySQL', NULL, 2, CAST(N'2023-05-25T05:24:18.7664506' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (111, N'MySQL', N'Access denied for user ''root@10.17.42.20''@''REENG-193.kamaz.org'' (using password: YES)', 0, CAST(N'2023-05-25T05:26:37.4074127' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (112, N'MySQL', NULL, 2, CAST(N'2023-07-13T07:33:53.7914886' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (113, N'MySQL', N'Unable to connect to any of the specified MySQL hosts.', 0, CAST(N'2023-07-13T07:35:20.5899566' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (114, N'MySQL', NULL, 2, CAST(N'2023-07-13T07:35:33.7167365' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (115, N'MySQL', N'Access denied for user ''root''@''REENG-193.kamaz.org'' (using password: YES)', 0, CAST(N'2023-07-13T07:36:48.1912912' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (116, N'MySQL', NULL, 2, CAST(N'2023-07-13T07:41:59.2127039' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (117, N'MySQL', N'Connect Timeout expired.', 0, CAST(N'2023-07-13T07:43:20.1042261' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (118, N'MySQL', NULL, 2, CAST(N'2023-07-13T07:43:44.1962139' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (119, N'MySQL', N'Access denied for user ''root''@''REENG-193.kamaz.org'' (using password: YES)', 0, CAST(N'2023-07-13T07:47:51.1666685' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (120, N'MySQL', NULL, 2, CAST(N'2023-07-13T08:08:52.3398536' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (121, N'MySQL', N'Access denied for user ''root''@''REENG-193.kamaz.org'' (using password: YES)', 0, CAST(N'2023-07-13T08:14:28.1335653' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (122, N'MySQL', NULL, 2, CAST(N'2023-07-13T08:19:25.4507562' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (123, N'MySQL', N'Unable to connect to any of the specified MySQL hosts.', 0, CAST(N'2023-07-17T11:13:31.7329889' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (124, N'MySQL', NULL, 2, CAST(N'2023-07-17T11:42:18.1341865' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (125, N'MSSQL', N'A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)', 0, CAST(N'2023-07-19T06:57:50.1357424' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (126, N'MySQL', NULL, 2, CAST(N'2023-07-19T07:13:42.8398033' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (127, N'MSPaint', NULL, 0, CAST(N'2023-07-19T07:26:54.8319649' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (128, N'MSPaint', NULL, 2, CAST(N'2023-07-19T07:40:33.1937831' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (129, N'MSPaint', NULL, 0, CAST(N'2023-07-19T07:41:33.5506347' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (130, N'MSPaint', NULL, 2, CAST(N'2023-07-19T08:00:28.3061083' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (131, N'MariaDB', NULL, 0, CAST(N'2023-07-19T08:35:07.6486055' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (132, N'MariaDB', NULL, 2, CAST(N'2023-07-19T08:44:31.7241143' AS DateTime2), 18)
INSERT [dbo].[HealthCheckExecutionHistories] ([Id], [Name], [Description], [Status], [On], [HealthCheckExecutionId]) VALUES (133, N'MSPaint', NULL, 0, CAST(N'2023-07-19T11:08:43.7507557' AS DateTime2), 18)
SET IDENTITY_INSERT [dbo].[HealthCheckExecutionHistories] OFF
GO
SET IDENTITY_INSERT [dbo].[HealthCheckUserActionLogs] ON 

INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (5, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Init', 1, CAST(N'2023-05-14T14:00:00.0000000' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (6, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration t with 1 component(s) was added!', 1, CAST(N'2023-05-14T17:55:35.1889174' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (7, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration Test new with 2 component(s) was added!', 1, CAST(N'2023-05-14T17:56:44.0685340' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (8, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration 2132 with 2 component(s) was added!', 1, CAST(N'2023-05-14T17:57:33.1102025' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (9, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration 232 with 1 component(s) was added!', 2, CAST(N'2023-05-14T17:57:48.7374690' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (10, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "Test new config with logging" with 2 component(s) was added!', 3, CAST(N'2023-05-14T18:00:16.7613548' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (11, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "aa" with 0 component(s) was added!', 4, CAST(N'2023-05-14T18:05:39.5605537' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (12, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "zz" with 0 component(s) was added!', 5, CAST(N'2023-05-14T18:05:50.6300801' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (13, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "xx" with 1 component(s) was added!', 6, CAST(N'2023-05-14T18:05:58.5182975' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (14, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "hh" with 0 component(s) was added!', 7, CAST(N'2023-05-14T18:06:47.8741157' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (15, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "fdghn " with 2 component(s) was added!', 8, CAST(N'2023-05-14T18:08:52.8726811' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (16, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "q" with 1 component(s) was added!', 9, CAST(N'2023-05-15T16:25:45.2494553' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (17, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "3423" with 1 component(s) was added!', 10, CAST(N'2023-05-15T16:33:35.5475349' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (18, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "3423" with 2 component(s) was edited!', 11, CAST(N'2023-05-15T16:33:49.0614994' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (19, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "3423" was removed!', 2, CAST(N'2023-05-15T17:42:23.6897023' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (20, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "q" was removed!', 2, CAST(N'2023-05-15T17:42:30.9538746' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (21, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "fdghn " was removed!', 3, CAST(N'2023-05-15T17:42:42.6818903' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (22, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "Real2" was removed!', 3, CAST(N'2023-05-15T17:43:03.5933535' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (23, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'New configuration "21xxxx" with 1 component(s) was added!', 1, CAST(N'2023-05-15T17:43:42.0932409' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (24, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "21xxxx" was removed!', 3, CAST(N'2023-05-15T17:43:48.2502172' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (25, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'New configuration "zzzx" with 0 component(s) was added!', 1, CAST(N'2023-05-15T17:44:45.3881938' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (26, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "zzzx" was removed!', 3, CAST(N'2023-05-15T17:44:53.3920011' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (27, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Requesting report about health statuses!', 4, CAST(N'2023-05-15T17:58:13.3365403' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (28, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Requesting report about users actions!', 5, CAST(N'2023-05-15T18:02:39.2958167' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (29, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Adding new role: "test1"!', 11, CAST(N'2023-05-15T18:14:31.5335834' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (30, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Removing role: "test1"!', 12, CAST(N'2023-05-15T18:14:33.4217180' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (31, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Removing user "test456@gmail.com" from role "EOL"!', 9, CAST(N'2023-05-15T18:14:35.7326018' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (32, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Adding user "test456@gmail.com" to role "HOFFMAN"!', 9, CAST(N'2023-05-15T18:14:36.6813594' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (33, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-15T19:24:27.1964595' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (34, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'New configuration "123" with 1 component(s) was added!', 1, CAST(N'2023-05-15T20:02:58.8135992' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (35, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "123" was removed!', 3, CAST(N'2023-05-15T20:03:04.5111260' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (36, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "Real" with 3 component(s) was edited!', 2, CAST(N'2023-05-15T20:03:59.1611025' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (37, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-15T20:04:41.0651423' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (38, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-15T20:04:47.6723683' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (39, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-15T20:04:52.7594270' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (40, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "Real" with 4 component(s) was edited!', 2, CAST(N'2023-05-15T20:05:06.2102865' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (41, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-15T20:05:12.2048150' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (42, N'4f862e4c-0613-4849-8e79-2f45e17fc0ca', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-15T20:07:31.8006350' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (43, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-16T18:29:48.6297952' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (44, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 3 component(s) was edited!', 2, CAST(N'2023-05-16T20:34:03.5028308' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (45, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 4 component(s) was edited!', 2, CAST(N'2023-05-17T20:11:49.8592687' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (46, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 4 component(s) was edited!', 2, CAST(N'2023-05-17T20:12:13.2000520' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (47, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 4 component(s) was edited!', 2, CAST(N'2023-05-17T20:13:56.2403630' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (48, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 4 component(s) was edited!', 2, CAST(N'2023-05-17T20:14:36.1068467' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (49, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 4 component(s) was edited!', 2, CAST(N'2023-05-17T20:15:15.7500720' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (50, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 4 component(s) was edited!', 2, CAST(N'2023-05-20T14:16:30.1003012' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (51, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "z" with 1 component(s) was added!', 1, CAST(N'2023-05-20T14:49:22.6576122' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (52, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "z" was removed!', 3, CAST(N'2023-05-20T14:50:44.0418252' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (53, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "x" with 1 component(s) was added!', 1, CAST(N'2023-05-20T14:51:41.2575050' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (54, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "t" with 1 component(s) was added!', 1, CAST(N'2023-05-20T14:52:25.8566954' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (55, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "x" was removed!', 3, CAST(N'2023-05-20T15:25:33.5193912' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (56, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "t" was removed!', 3, CAST(N'2023-05-20T15:25:35.5395754' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (57, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 1 component(s) was edited!', 2, CAST(N'2023-05-20T15:26:57.5063612' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (58, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 1 component(s) was edited!', 2, CAST(N'2023-05-20T15:28:38.7924939' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (59, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'New configuration "r" with 1 component(s) was added!', 1, CAST(N'2023-05-20T15:53:10.9597691' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (60, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "r" was removed!', 3, CAST(N'2023-05-20T15:53:32.9162415' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (61, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 1 component(s) was edited!', 2, CAST(N'2023-05-20T16:41:38.3189981' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (62, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Removing user "provice911@gmail.com" from role "KSD"!', 9, CAST(N'2023-05-20T16:41:45.4170905' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (63, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Removing user "provice911@gmail.com" from role "HOFFMAN"!', 9, CAST(N'2023-05-20T16:41:45.9545797' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (64, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Adding user "provice911@gmail.com" to role "KSD"!', 9, CAST(N'2023-05-20T18:12:28.9913779' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (65, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Removing user "provice911@gmail.com" from role "KSD"!', 9, CAST(N'2023-05-20T18:19:54.7143416' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (66, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Adding user "provice911@gmail.com" to role "KSD"!', 9, CAST(N'2023-05-20T18:20:32.1750244' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (67, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-20T18:40:11.9557992' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (68, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-20T18:41:58.3889472' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (69, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 3 component(s) was edited!', 2, CAST(N'2023-05-20T19:20:45.8548158' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (70, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "Non system app" was started!', 6, CAST(N'2023-05-20T20:35:56.1914117' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (71, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "Non system app" was restarted!', 7, CAST(N'2023-05-20T20:35:57.4374886' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (72, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "Non system app" was stopped!', 8, CAST(N'2023-05-20T20:35:59.3900854' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (73, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 3 component(s) was edited!', 2, CAST(N'2023-05-21T16:14:06.2225470' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (74, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "Service" was started!', 6, CAST(N'2023-05-21T17:32:45.5405189' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (75, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "Service" was stopped!', 8, CAST(N'2023-05-21T17:32:47.2923896' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (76, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "Non system app" was started!', 6, CAST(N'2023-05-21T17:32:49.2166732' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (77, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "Non system app" was stopped!', 8, CAST(N'2023-05-21T17:33:08.6780198' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (78, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "Non system app" was restarted!', 7, CAST(N'2023-05-21T17:33:12.1727372' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (79, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "Non system app" was stopped!', 8, CAST(N'2023-05-21T17:33:16.1977590' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (80, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 1 component(s) was edited!', 2, CAST(N'2023-05-22T08:48:11.5954221' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (81, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 1 component(s) was edited!', 2, CAST(N'2023-05-22T11:20:29.2024265' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (82, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 1 component(s) was edited!', 2, CAST(N'2023-05-22T11:22:54.6117169' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (83, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 1 component(s) was edited!', 2, CAST(N'2023-05-22T11:24:24.9873873' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (84, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Requesting report about users actions!', 5, CAST(N'2023-05-22T11:55:47.2010969' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (85, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 1 component(s) was edited!', 2, CAST(N'2023-05-23T12:24:41.6750952' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (86, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 1 component(s) was edited!', 2, CAST(N'2023-05-24T05:58:17.3037940' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (87, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-24T12:10:38.6342313' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (88, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 1 component(s) was edited!', 2, CAST(N'2023-05-24T12:16:52.1537769' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (89, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-24T13:40:11.0983490' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (90, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-24T13:41:52.4879485' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (91, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-24T13:42:50.9702727' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (92, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-24T13:45:46.0636383' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (93, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-24T13:47:51.6819429' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (94, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-24T13:48:28.8034318' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (95, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-24T13:49:26.6709732' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (96, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-24T13:51:12.1373534' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (97, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-25T05:03:38.5378844' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (98, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-25T05:12:44.7919624' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (99, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-25T05:20:55.8018529' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (100, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-25T05:22:00.7015209' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (101, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-25T05:24:03.3010060' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (102, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-25T05:26:21.0059585' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (103, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-25T05:27:03.1138182' AS DateTime2))
GO
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (104, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-25T05:45:10.1460825' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (105, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-25T05:49:45.6528533' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (106, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-05-25T05:50:01.1336367' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (107, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T07:33:39.3625345' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (108, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T07:36:31.6357579' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (109, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T07:38:32.7750217' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (110, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T07:39:30.9602815' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (111, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T07:41:45.2660640' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (112, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T07:43:47.6459955' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (113, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T07:55:53.0331950' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (114, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T07:56:43.6541057' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (115, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T07:58:07.4512636' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (116, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T07:59:59.2667495' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (117, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T08:00:22.8249836' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (118, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T08:08:41.1047330' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (119, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T08:14:18.8940553' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (120, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T08:15:12.9462009' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (121, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T08:18:01.6525702' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (122, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-13T08:19:13.5720709' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (123, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Adding new role: "a"!', 11, CAST(N'2023-07-13T13:40:21.3068375' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (124, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Removing role: "a"!', 12, CAST(N'2023-07-13T13:40:23.9594757' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (125, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-14T12:47:25.5090723' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (126, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-17T10:25:38.5967512' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (127, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-17T10:27:46.3099086' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (128, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-17T10:45:01.6626118' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (129, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-17T10:48:23.9531204' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (130, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-17T11:03:20.2398322' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (131, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-17T11:10:08.6228144' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (132, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-17T11:13:19.0514693' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (133, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-17T11:42:05.9704542' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (134, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSSQL" was started!', 6, CAST(N'2023-07-18T10:36:24.8631667' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (135, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSSQL" was started!', 6, CAST(N'2023-07-18T11:03:09.8068408' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (136, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSSQL" was changed!', 2, CAST(N'2023-07-19T06:47:15.8994539' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (137, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSSQL" was changed!', 2, CAST(N'2023-07-19T06:53:23.0537029' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (138, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSSQL" was changed!', 2, CAST(N'2023-07-19T06:55:31.3170225' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (139, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-19T06:56:19.2510400' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (140, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSSQL" was changed!', 2, CAST(N'2023-07-19T06:56:21.9819211' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (141, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-19T06:58:08.4665660' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (142, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSSQL" was changed!', 2, CAST(N'2023-07-19T06:58:11.0123257' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (143, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 3 component(s) was edited!', 2, CAST(N'2023-07-19T07:25:54.1378329' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (144, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSPaint" was stopped!', 8, CAST(N'2023-07-19T07:26:20.6791341' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (145, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSPaint" was started!', 6, CAST(N'2023-07-19T07:26:22.4757066' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (146, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSPaint" was restarted!', 7, CAST(N'2023-07-19T07:26:31.5631380' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (147, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSPaint" was stopped!', 8, CAST(N'2023-07-19T07:26:40.3953629' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (148, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSPaint" was started!', 6, CAST(N'2023-07-19T07:26:45.2104618' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (149, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 3 component(s) was edited!', 2, CAST(N'2023-07-19T07:26:54.5138492' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (150, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSPaint" was stopped!', 8, CAST(N'2023-07-19T07:27:34.2241269' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (151, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 4 component(s) was edited!', 2, CAST(N'2023-07-19T07:29:08.8862115' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (152, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 4 component(s) was edited!', 2, CAST(N'2023-07-19T07:29:23.8438834' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (153, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Removing user "provice911@gmail.com" from role "KSD"!', 9, CAST(N'2023-07-19T07:29:30.8586917' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (154, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Adding user "provice911@gmail.com" to role "KSD"!', 9, CAST(N'2023-07-19T07:29:31.5039369' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (155, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Removing user "provice911@gmail.com" from role "EOL"!', 9, CAST(N'2023-07-19T07:29:32.3473500' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (156, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 4 component(s) was edited!', 2, CAST(N'2023-07-19T07:29:42.9312500' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (157, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Adding user "provice911@gmail.com" to role "EOL"!', 9, CAST(N'2023-07-19T07:30:06.6356297' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (158, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MariaDB" was started!', 6, CAST(N'2023-07-19T07:30:08.9602146' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (159, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MariaDB" was started!', 6, CAST(N'2023-07-19T07:37:16.6219053' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (160, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSPaint" was started!', 6, CAST(N'2023-07-19T07:40:23.0206666' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (161, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MSPaint" was stopped!', 8, CAST(N'2023-07-19T07:41:19.8431353' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (162, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MariaDB" was stopped!', 8, CAST(N'2023-07-19T08:38:59.7935449' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (163, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MariaDB" was started!', 6, CAST(N'2023-07-19T08:39:04.2601997' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (164, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MariaDB" was stopped!', 8, CAST(N'2023-07-19T08:39:08.4480357' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (165, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "MariaDB" was started!', 6, CAST(N'2023-07-19T08:44:19.9700524' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (166, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 2 component(s) was edited!', 2, CAST(N'2023-07-19T11:34:59.5679736' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (167, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "" was changed!', 2, CAST(N'2023-07-19T12:01:53.0600239' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (168, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 3 component(s) was edited!', 2, CAST(N'2023-07-19T12:02:13.1911781' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (169, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'The component "" was changed!', 2, CAST(N'2023-07-19T12:02:17.8750027' AS DateTime2))
INSERT [dbo].[HealthCheckUserActionLogs] ([UserActionEntryId], [UserId], [ActionDetails], [UserActionId], [Datetime]) VALUES (170, N'd27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', N'Configuration "Real" with 3 component(s) was edited!', 2, CAST(N'2023-07-19T12:03:35.7688353' AS DateTime2))
SET IDENTITY_INSERT [dbo].[HealthCheckUserActionLogs] OFF
GO
INSERT [dbo].[HealthStatuses] ([StatusId], [StatusName]) VALUES (0, N'Shutted down')
INSERT [dbo].[HealthStatuses] ([StatusId], [StatusName]) VALUES (1, N'Some problems')
INSERT [dbo].[HealthStatuses] ([StatusId], [StatusName]) VALUES (2, N'Working')
GO
SET IDENTITY_INSERT [dbo].[UserActions] ON 

INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (1, N'Configuration creation')
INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (2, N'Configuration edition')
INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (3, N'Configuration removing')
INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (4, N'Requesting healths status report')
INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (5, N'Requesting user actions report')
INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (6, N'Component starting')
INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (7, N'Component restarting')
INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (8, N'Component stopping')
INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (9, N'User role editing')
INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (10, N'User confirmation')
INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (11, N'Role adding')
INSERT [dbo].[UserActions] ([UserActionId], [UserActionName]) VALUES (12, N'Role removing')
SET IDENTITY_INSERT [dbo].[UserActions] OFF
GO
/****** Object:  Index [IX_HealthCheckExecutionEntries_HealthCheckExecutionId]    Script Date: 19.07.2023 15:42:31 ******/
CREATE NONCLUSTERED INDEX [IX_HealthCheckExecutionEntries_HealthCheckExecutionId] ON [dbo].[HealthCheckExecutionEntries]
(
	[HealthCheckExecutionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_HealthCheckExecutionHistories_HealthCheckExecutionId]    Script Date: 19.07.2023 15:42:31 ******/
CREATE NONCLUSTERED INDEX [IX_HealthCheckExecutionHistories_HealthCheckExecutionId] ON [dbo].[HealthCheckExecutionHistories]
(
	[HealthCheckExecutionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetRoles] ADD  CONSTRAINT [DF_AspNetRoles_IsRemovable]  DEFAULT ((1)) FOR [IsRemovable]
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
