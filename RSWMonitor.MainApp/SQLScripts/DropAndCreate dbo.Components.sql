USE [HealthChecksDB]
GO

ALTER TABLE [dbo].[Components] DROP CONSTRAINT [FK_Components_Configurations]
GO

ALTER TABLE [dbo].[Components] DROP CONSTRAINT [FK_Components_ComponentTypes]
GO

ALTER TABLE [dbo].[Components] DROP CONSTRAINT [DF__Component__Compo__114A936A]
GO

/****** Object:  Table [dbo].[Components]    Script Date: 01.05.2023 21:24:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Components]') AND type in (N'U'))
DROP TABLE [dbo].[Components]
GO

/****** Object:  Table [dbo].[Components]    Script Date: 01.05.2023 21:24:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Components](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComponentTypesId] [int] NOT NULL,
	[ConfigurationId] [int] NOT NULL,
	[ComponentName] [nvarchar](500) NOT NULL,
	[ComponentSignature] [nvarchar](500) NOT NULL,
	[ComponentRoletags] [nvarchar](500) NULL,
	[ComponentHasControls] [bit] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Components] ADD  DEFAULT ((0)) FOR [ComponentHasControls]
GO

ALTER TABLE [dbo].[Components] ADD  DEFAULT ((1)) FOR [ComponentTypesId]
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


