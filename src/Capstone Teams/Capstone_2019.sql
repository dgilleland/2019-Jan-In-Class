USE [Capstone_2019]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.TeamAssignments_dbo.Students_StudentId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TeamAssignments]'))
ALTER TABLE [dbo].[TeamAssignments] DROP CONSTRAINT [FK_dbo.TeamAssignments_dbo.Students_StudentId]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.TeamAssignments_dbo.CapstoneClients_ClientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TeamAssignments]'))
ALTER TABLE [dbo].[TeamAssignments] DROP CONSTRAINT [FK_dbo.TeamAssignments_dbo.CapstoneClients_ClientId]
GO
/****** Object:  Table [dbo].[TeamAssignments]    Script Date: 2018-11-15 1:02:52 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TeamAssignments]') AND type in (N'U'))
DROP TABLE [dbo].[TeamAssignments]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 2018-11-15 1:02:52 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Students]') AND type in (N'U'))
DROP TABLE [dbo].[Students]
GO
/****** Object:  Table [dbo].[CapstoneClients]    Script Date: 2018-11-15 1:02:52 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CapstoneClients]') AND type in (N'U'))
DROP TABLE [dbo].[CapstoneClients]
GO
/****** Object:  Table [dbo].[CapstoneClients]    Script Date: 2018-11-15 1:02:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CapstoneClients]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CapstoneClients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](max) NOT NULL,
	[Slogan] [nvarchar](max) NULL,
	[ContactName] [nvarchar](max) NOT NULL,
	[Confirmed] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.CapstoneClients] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Students]    Script Date: 2018-11-15 1:02:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Students]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Students](
	[StudentId] [int] IDENTITY(1,1) NOT NULL,
	[SchoolId] [nvarchar](max) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dbo.Students] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[TeamAssignments]    Script Date: 2018-11-15 1:02:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TeamAssignments]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TeamAssignments](
	[StudentId] [int] NOT NULL,
	[ClientId] [int] NOT NULL,
	[TeamNumber] [nvarchar](1) NULL,
 CONSTRAINT [PK_dbo.TeamAssignments] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC,
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[CapstoneClients] ON 
GO
INSERT [dbo].[CapstoneClients] ([Id], [CompanyName], [Slogan], [ContactName], [Confirmed]) VALUES (1, N'Gerhold Inc', N'Digitized disintermediate emulation', N'Joanne Bashirian', 1)
GO
INSERT [dbo].[CapstoneClients] ([Id], [CompanyName], [Slogan], [ContactName], [Confirmed]) VALUES (2, N'Weissnat Inc', N'Right-sized maximized support', N'Bernadette Pouros', 1)
GO
INSERT [dbo].[CapstoneClients] ([Id], [CompanyName], [Slogan], [ContactName], [Confirmed]) VALUES (3, N'Hudson - Russel', N'Down-sized next generation utilisation', N'Mercedes Pacocha', 1)
GO
INSERT [dbo].[CapstoneClients] ([Id], [CompanyName], [Slogan], [ContactName], [Confirmed]) VALUES (4, N'Runolfsdottir Inc', N'Re-engineered context-sensitive intranet', N'Cory Renner', 1)
GO
INSERT [dbo].[CapstoneClients] ([Id], [CompanyName], [Slogan], [ContactName], [Confirmed]) VALUES (5, N'Nienow LLC', N'Assimilated discrete local area network', N'Rosemarie Sporer', 1)
GO
INSERT [dbo].[CapstoneClients] ([Id], [CompanyName], [Slogan], [ContactName], [Confirmed]) VALUES (6, N'Mertz Inc', N'Down-sized object-oriented toolset', N'Minnie Howell', 1)
GO
SET IDENTITY_INSERT [dbo].[CapstoneClients] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (1, N'20102682', N'Timothy', N'Jacobi')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (2, N'20154422', N'Garry', N'Bergstrom')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (3, N'20133452', N'Erin', N'Prohaska')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (4, N'20110451', N'Sherman', N'Lueilwitz')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (5, N'20124491', N'Leroy', N'Haag')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (6, N'20135615', N'Alyssa', N'Bode')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (7, N'20152162', N'Judy', N'Herzog')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (8, N'20177499', N'Peggy', N'Runolfsdottir')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (9, N'20138620', N'Guadalupe', N'Ankunding')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (10, N'20172801', N'Gene', N'Kuphal')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (11, N'20164706', N'Christina', N'Rau')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (12, N'20158435', N'Jill', N'Williamson')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (13, N'20143366', N'Cody', N'Dickens')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (14, N'20144040', N'Pete', N'Lebsack')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (15, N'20152139', N'Lewis', N'Casper')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (16, N'20165993', N'Sammy', N'Bruen')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (17, N'20171116', N'Shari', N'Lowe')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (18, N'20124030', N'Lillian', N'Terry')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (19, N'20103416', N'Suzanne', N'Lockman')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (20, N'20170076', N'Rick', N'Klein')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (21, N'20173968', N'Terri', N'Oberbrunner')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (22, N'20153075', N'Elena', N'Mosciski')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (23, N'20147726', N'Anthony', N'Schaefer')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (24, N'20130273', N'Noah', N'Gulgowski')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (25, N'20157225', N'Ashley', N'Howell')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (26, N'20165836', N'Roberta', N'Koepp')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (27, N'20170844', N'Enrique', N'Reilly')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (28, N'20149621', N'Clark', N'Schultz')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (29, N'20173747', N'Ignacio', N'Fay')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (30, N'20122726', N'Sophia', N'O''Connell')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (31, N'20105332', N'Dwayne', N'Champlin')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (32, N'20157702', N'Conrad', N'Padberg')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (33, N'20170195', N'Laura', N'Bednar')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (34, N'20146930', N'Wanda', N'Davis')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (35, N'20106810', N'Sonya', N'Armstrong')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (36, N'20174999', N'Michele', N'Osinski')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (37, N'20175839', N'Victor', N'Barton')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (38, N'20125955', N'Ken', N'Kub')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (39, N'20108920', N'Judith', N'Kuhlman')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (40, N'20103818', N'Phyllis', N'Walsh')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (41, N'20146060', N'Tamara', N'Kemmer')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (42, N'20145542', N'Percy', N'McClure')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (43, N'20103006', N'Eugene', N'Herzog')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (44, N'20165404', N'Cary', N'Anderson')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (45, N'20124829', N'Vicki', N'Hegmann')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (46, N'20109754', N'Milton', N'Klein')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (47, N'20169956', N'Ryan', N'Wolf')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (48, N'20116131', N'Genevieve', N'Bauch')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (49, N'20105514', N'Heidi', N'Mitchell')
GO
INSERT [dbo].[Students] ([StudentId], [SchoolId], [FirstName], [LastName]) VALUES (50, N'20145711', N'Ricky', N'Veum')
GO
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.TeamAssignments_dbo.CapstoneClients_ClientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TeamAssignments]'))
ALTER TABLE [dbo].[TeamAssignments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TeamAssignments_dbo.CapstoneClients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[CapstoneClients] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.TeamAssignments_dbo.CapstoneClients_ClientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TeamAssignments]'))
ALTER TABLE [dbo].[TeamAssignments] CHECK CONSTRAINT [FK_dbo.TeamAssignments_dbo.CapstoneClients_ClientId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.TeamAssignments_dbo.Students_StudentId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TeamAssignments]'))
ALTER TABLE [dbo].[TeamAssignments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TeamAssignments_dbo.Students_StudentId] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([StudentId])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.TeamAssignments_dbo.Students_StudentId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TeamAssignments]'))
ALTER TABLE [dbo].[TeamAssignments] CHECK CONSTRAINT [FK_dbo.TeamAssignments_dbo.Students_StudentId]
GO
