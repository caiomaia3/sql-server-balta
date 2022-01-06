DROP DATABASE [balta]
GO

CREATE DATABASE [balta]
GO

USE [balta]
GO


-- TABLE CREATION
CREATE TABLE [Student](
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Name] NVARCHAR(120) NOT NULL,
    [Email] NVARCHAR(180) NOT NULL,
    [Document] NVARCHAR(20) NULL,
    [Phone] NVARCHAR(20) NULL,
    [Birthdate] DATETIME NULL,
    [CreateDate] DATETIME NOT NULL
)
GO

CREATE TABLE [Author] (
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Name] NVARCHAR(80) NOT NULL,
    [Title] NVARCHAR(80) NOT NULL,
    [Image] NVARCHAR(1024) NOT NULL,
    [Bio] NVARCHAR(2000) NOT NULL,
    [Url] NVARCHAR(450) NULL,
    [Email] NVARCHAR(160) NOT NULL,
    [Document] NVARCHAR(20) NULL,
    [Type] TINYINT NOT NULL
)
GO

CREATE TABLE [Career] (
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Title] NVARCHAR(160) NOT NULL,
    [Summary] NVARCHAR(2000) NOT NULL,
    [Url] NVARCHAR(1024) NOT NULL,
    [DurationInMinutes] INT NOT NULL,
    [Active] BIT NOT NULL,
    [Featured] BIT NOT NULL,
    [Tags] NVARCHAR(160) NOT NULL,
)

CREATE TABLE [Category] (
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Title] NVARCHAR(160) NOT NULL,
    [Url] NVARCHAR(1024) NOT NULL,
    [Summary] NVARCHAR(2000) NOT NULL,
    [Order] INT NOT NULL,
    [Description] TEXT NOT NULL,
    [Featured] BIT NOT NULL
)

CREATE TABLE [Course]
(
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Tag] NVARCHAR(20) NOT NULL,
    [Title] NVARCHAR(160) NOT NULL,
    [Summary] NVARCHAR(2000) NOT NULL,
    [Url] NVARCHAR(1024) NOT NULL,
    [Level] TINYINT NOT NULL,
    [DurationInMinutes] INT NOT NULL,
    [CreateDate] DATETIME NOT NULL,
    [LastUpdateDate] DATETIME NOT NULL,
    [Active] BIT NOT NULL,
    [Free] BIT NOT NULL,
    [Featured] BIT NOT NULL,
    [AuthorId] UNIQUEIDENTIFIER NOT NULL,
    [CategoryId] UNIQUEIDENTIFIER NOT NULL,
    [Tags] NVARCHAR(160) NOT NULL
)
GO

CREATE TABLE [CareerItem]
(
    [CourseId] UNIQUEIDENTIFIER NOT NULL,
    [CareerId] UNIQUEIDENTIFIER NOT NULL,
    [Title] NVARCHAR(160) NOT NULL,
    [Description] TEXT NOT NULL,
    [Order] TINYINT NOT NULL
)

CREATE TABLE [StudentCourse]
(
    [StudentId] UNIQUEIDENTIFIER NOT NULL,
    [CourseId] UNIQUEIDENTIFIER NOT NULL,
    [Progress] TINYINT NOT NULL,
    [Favorite] BIT NOT NULL,
    [StartDate] DATETIME NOT NULL,
    [LastUpdateDate] DATETIME NULL
)

-- CONSTRAINTS CREATION
ALTER TABLE [Student]
ADD CONSTRAINT [PK_Student]
PRIMARY KEY ([Id])
GO

ALTER TABLE [Author]
ADD CONSTRAINT [PK_Author]
PRIMARY KEY (Id)
GO

ALTER TABLE [Career]
ADD CONSTRAINT [PK_Career]
PRIMARY KEY (Id)
GO

ALTER TABLE [Category]
ADD CONSTRAINT [PK_Category]
PRIMARY KEY (Id)
GO

ALTER TABLE [Course]
ADD CONSTRAINT [PK_Course]
PRIMARY KEY (Id)
GO

ALTER TABLE [Course]
ADD CONSTRAINT [FK_Course_Author_AuthorId]
FOREIGN KEY ([AuthorId]) REFERENCES [Author]([Id])

ALTER TABLE [Course]
ADD CONSTRAINT [FK_Course_Category_CategoryId]
FOREIGN KEY ([CategoryId]) REFERENCES [Category]([Id])
GO

ALTER TABLE [CareerItem]
ADD CONSTRAINT [PK_CareerItem]
PRIMARY KEY ([CourseId],[CareerId])
GO

ALTER TABLE [CareerItem]
ADD CONSTRAINT [FK_CareerItem_Course_CourseId]
FOREIGN KEY ([CourseId]) REFERENCES [Course]([Id])

ALTER TABLE [CareerItem]
ADD CONSTRAINT [FK_CareerItem_Career_CareerId]
FOREIGN KEY ([CareerId]) REFERENCES [Career]([Id])
GO

ALTER TABLE [StudentCourse]
ADD CONSTRAINT [PK_StudentCourse]
PRIMARY KEY ([StudentId],[CourseId])
GO

ALTER TABLE [StudentCourse]
ADD CONSTRAINT [FK_StudentCourse_Student_StudentId]
FOREIGN KEY ([StudentId]) REFERENCES [Student]([Id])

ALTER TABLE [StudentCourse]
ADD CONSTRAINT [FK_StudentCourse_Course_CourseId]
FOREIGN KEY ([CourseId]) REFERENCES [Course]([Id])
GO