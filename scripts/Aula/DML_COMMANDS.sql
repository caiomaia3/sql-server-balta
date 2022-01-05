USE [Cursos]
GO

INSERT INTO [Categoria]([Nome]) VALUES ('Backend')
INSERT INTO [Categoria]([Nome]) VALUES ('Frontend')
INSERT INTO [Categoria]([Nome]) VALUES ('Mobile')
GO

SELECT * FROM [Categoria]
GO

INSERT INTO [Curso]([Nome], [CategoriaId]) VALUES('Fundamentos de C#',1)
INSERT INTO [Curso]([Nome], [CategoriaId]) VALUES('Fundamentos OOP',1)
INSERT INTO [Curso]([Nome], [CategoriaId]) VALUES('Angular',2)
INSERT INTO [Curso]([Nome], [CategoriaId]) VALUES('Flutter',3)
GO

INSERT INTO [Curso] VALUES ('Flutter e SQLite',3)
GO

SELECT TOP 10 * FROM [Curso]
GO


SELECT DISTINCT TOP 100
    [Nome]
FROM
    [Categoria]
GO


BEGIN TRANSACTION
    UPDATE
        [Categoria]
    SET
        [Nome] = ''
    WHERE
        [Id] = 1
ROLLBACK
GO

SELECT
    [Id],[Nome]
FROM
    [Categoria]
GO


BEGIN TRANSACTION
    UPDATE
        [Categoria]
    SET
        [Nome] = 'Backend'
    WHERE
        [Id] = 1
COMMIT
GO

DELETE
    [Categoria]
WHERE
    [Id] = 3
GO

SELECT * FROM [Curso]
WHERE [Nome] LIKE '%Fundamentos%'
GO


SELECT * FROM [Curso]
WHERE [Id] in (2,3)
GO