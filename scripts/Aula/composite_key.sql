USE [Curso]
GO

DROP TABLE IF EXISTS [Aluno] 
GO

-- TABLE CREATION
CREATE TABLE [Aluno](
    [Id] INT NOT NULL,
    [Nome] NVARCHAR(80) NOT NULL,
    [Email] NVARCHAR(160) NOT NULL,
    [Nascimento] DATETIME NULL,
    [Active] BIT NOT NULL DEFAULT(0)
)
GO

-- Criacao da tabela Curso
DROP TABLE IF EXISTS [Curso]
GO

CREATE TABLE [Curso](
    [Id] INT NOT NULL,
    [Nome] NVARCHAR(80) NOT NULL,
    [CategoriaId] INT NOT NULL
)
GO

-- Criacao da tadela categoria
DROP TABLE IF EXISTS [Categoria]
GO

CREATE TABLE [Categoria](
    [Id] INT NOT NULL,
    [Nome] NVARCHAR(80) NOT NULL,
)
GO

-- Tabela associativa
DROP TABLE IF EXISTS [ProgressoCurso]
GO

CREATE TABLE [ProgressoCurso](
    [AlunoId] INT NOT NULL,
    [CursoId] INT NOT NULL,
    [Progresso] INT NOT NULL,
    [UltimaAtualizacao] DATETIME NOT NULL DEFAULT(GETDATE())
)
GO

-- CONSTRAINTS
ALTER TABLE [Aluno]
ADD CONSTRAINT [UQ_Aluno_Email] UNIQUE([Email])
GO

ALTER TABLE [Aluno]
ADD CONSTRAINT [PK_Aluno] PRIMARY KEY ([Id])
GO

ALTER TABLE [Curso]
ADD CONSTRAINT [PK_Curso] PRIMARY KEY ([Id])

ALTER TABLE [Categoria]
ADD CONSTRAINT [PK_Categoria] PRIMARY KEY ([Id])
GO

ALTER TABLE [Curso]
ADD CONSTRAINT [FK_Curso_Categoria] FOREIGN KEY ([CategoriaId]) REFERENCES [Categoria] ([Id])

ALTER TABLE [ProgressoCurso]
ADD CONSTRAINT [PK_Aluno_Curso] PRIMARY KEY ([AlunoId],[CursoId])
GO