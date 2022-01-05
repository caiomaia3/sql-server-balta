USE [Cursos]
GO

DROP TABLE IF EXISTS [Curso]
GO

CREATE TABLE [Curso](
    [Id] INT NOT NULL IDENTITY,
    [Nome] NVARCHAR(80) NOT NULL,
    [CategoriaId] INT NOT NULL
)
GO

-- Criacao da tadela categoria
DROP TABLE IF EXISTS [Categoria]
GO

CREATE TABLE [Categoria](
    [Id] INT NOT NULL IDENTITY,
    [Nome] NVARCHAR(80) NOT NULL,
)
GO


ALTER TABLE [Curso]
ADD CONSTRAINT [PK_Curso] PRIMARY KEY ([Id])

ALTER TABLE [Categoria]
ADD CONSTRAINT [PK_Categoria] PRIMARY KEY ([Id])

ALTER TABLE [Curso]
ADD CONSTRAINT [FK_Curso_Categoria] FOREIGN KEY ([CategoriaId]) REFERENCES [Categoria] ([Id])
GO