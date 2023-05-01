USE [HealthChecksDB]
GO

/****** Object: Table [dbo].[ComponentTypes] Script Date: 01.05.2023 17:04:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE [dbo].[ComponentTypes];


GO
CREATE TABLE [dbo].[ComponentTypes] (
    [ComponentTypesId]   INT            NOT NULL,
    [ComponentTypesName] NVARCHAR (500) NULL
);
GO
INSERT INTO [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (1, N'Database')
INSERT INTO [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (2, N'Service')
INSERT INTO [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (3, N'App')
INSERT INTO [dbo].[ComponentTypes] ([ComponentTypesId], [ComponentTypesName]) VALUES (4, N'URL')

