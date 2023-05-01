USE [HealthChecksDB]
GO

/****** Object:  Table [dbo].[Configurations]    Script Date: 01.05.2023 21:25:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Configurations]') AND type in (N'U'))
DROP TABLE [dbo].[Configurations]
GO

/****** Object:  Table [dbo].[Configurations]    Script Date: 01.05.2023 21:25:43 ******/
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


