USE [HealthChecksDB]
GO

/****** Object: Table [dbo].[Configurations] Script Date: 29.04.2023 16:05:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE [dbo].[Configurations];


GO
CREATE TABLE [dbo].[Configurations] (
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [Uri]                  NVARCHAR (500) NOT NULL,
    [Name]                 NVARCHAR (500) NOT NULL,
    [ConfigurationTypesId] INT            NULL,
    [ConfigurationRoles]   NVARCHAR (500) NULL,
    [HasControls]          BIT            NOT NULL,
    [DiscoveryService]     NVARCHAR (100) NULL
);
GO
SET IDENTITY_INSERT [dbo].[Configurations] ON
INSERT INTO [dbo].[Configurations] ([Id], [Uri], [Name], [ConfigurationTypesId], [ConfigurationRoles], [HasControls], [DiscoveryService]) VALUES (1, N'db', N'db', 1, N'{}', 0, NULL)
INSERT INTO [dbo].[Configurations] ([Id], [Uri], [Name], [ConfigurationTypesId], [ConfigurationRoles], [HasControls], [DiscoveryService]) VALUES (3, N'sr', N'sr', 2, N'{}', 0, NULL)
INSERT INTO [dbo].[Configurations] ([Id], [Uri], [Name], [ConfigurationTypesId], [ConfigurationRoles], [HasControls], [DiscoveryService]) VALUES (4, N'ap', N'ap', 3, N'{}', 0, NULL)
INSERT INTO [dbo].[Configurations] ([Id], [Uri], [Name], [ConfigurationTypesId], [ConfigurationRoles], [HasControls], [DiscoveryService]) VALUES (5, N'ur', N'ur', 4, N'{}', 0, NULL)
SET IDENTITY_INSERT [dbo].[Configurations] OFF


