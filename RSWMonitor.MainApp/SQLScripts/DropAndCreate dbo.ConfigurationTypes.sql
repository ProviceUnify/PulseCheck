USE [HealthChecksDB]
GO

/****** Object: Table [dbo].[ConfigurationTypes] Script Date: 29.04.2023 15:45:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE [dbo].[ConfigurationTypes];


GO
CREATE TABLE [dbo].[ConfigurationTypes] (
    [ConfigurationTypesId]   INT         NOT NULL,
    [ConfigurationTypesName] NVARCHAR (500) NULL
);
GO
INSERT INTO [dbo].[ConfigurationTypes] ([ConfigurationTypesId], [ConfigurationTypesName]) VALUES (1, N'Database')
INSERT INTO [dbo].[ConfigurationTypes] ([ConfigurationTypesId], [ConfigurationTypesName]) VALUES (2, N'Service')
INSERT INTO [dbo].[ConfigurationTypes] ([ConfigurationTypesId], [ConfigurationTypesName]) VALUES (3, N'App')
INSERT INTO [dbo].[ConfigurationTypes] ([ConfigurationTypesId], [ConfigurationTypesName]) VALUES (4, N'URL')



