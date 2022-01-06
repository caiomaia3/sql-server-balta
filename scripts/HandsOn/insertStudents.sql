
USE [balta]
GO

SELECT TOP 10 * FROM [Author]
GO

CREATE OR ALTER VIEW vwCourses AS
    (SELECT
    --  [c].[Id],
        [c].[Tag],
        [c].[Title],
    --   [c].[Url],
    --   [c].[Summary],
        [ct].[Title] AS "Category",
        [a].[Name]
    FROM
        [Course] [c]
        INNER JOIN [Category] [ct] ON [c].[CategoryId] = [ct].[Id]
        INNER JOIN [Author] [a] ON [c].[AuthorId] = [a].[Id]
    WHERE [c].[Active]=1)
GO

SELECT TOP 5 * FROM vwCourses ORDER BY [Title]
GO

CREATE OR ALTER VIEW vwCareers AS
    SELECT [c].[Id], [c].[Title], [c].[Url], COUNT([c].[Id]) AS "Itens" FROM [Career] [c]
    INNER JOIN [CareerItem] [ci] ON [ci].[CareerId] = [c].[Id]
    GROUP BY [c].[Id], [c].[Title], [c].[Url]
GO


SELECT * FROM [Student]
SELECT * FROM [Course]
WHERE [Title] LIKE 'F%'
SELECT * FROM [StudentCourse]
GO



INSERT INTO
    [Student]([Id],[Name],[Email],[Document],[Phone],[Birthdate],[CreateDate])
VALUES
    ('c966a8e7-e788-43d3-8f92-155684075f5a',
    'André Baltieri',
    'hello@balta.io',
    '1235456789',
    '12345678',
    NULL,
    GETDATE()
    )
GO

INSERT INTO [StudentCourse](
    [CourseId],
    [StudentId],
    [Progress],
    [Favorite],
    [StartDate],
    [LastUpdateDate]
    )
VALUES(
    '5f5a33f8-4ff3-7e10-cc6e-3fa000000000',
    'c966a8e7-e788-43d3-8f92-155684075f5a',
    50,
    0,
    '2020-01-13 12:30',
    GETDATE()
)


DECLARE @StudentId UNIQUEIDENTIFIER = 'c966a8e7-e788-43d3-8f92-155684075f5a'
SELECT  [Student].[Name],
        [Student].[Email],
--        [Student].[Document],
--        [Student].[Phone],
--        [Student].[Birthdate],
        [Student].[CreateDate],
        [Course].[Title],
        [StudentCourse].[Progress],
        [StudentCourse].[LastUpdateDate]

FROM [Student]
    INNER JOIN [StudentCourse] ON [Student].[Id] = [StudentCourse].[StudentId]
    INNER JOIN [Course] ON [Course].[Id] = [StudentCourse].[CourseId]
WHERE
    StudentCourse.StudentId = @StudentId
    AND [StudentCourse].[Progress] < 100
    AND [StudentCourse].[Progress] > 0
ORDER BY
    [StudentCourse].[LastUpdateDate] DESC
GO

-- DECLARE @StudentId UNIQUEIDENTIFIER = 'c966a8e7-e788-43d3-8f92-155684075f5a'

CREATE OR ALTER PROCEDURE spStudentProgress (
    @StudentId UNIQUEIDENTIFIER
)
AS
    SELECT  [Student].[Name],
            [Course].[Title],
            [StudentCourse].[Progress],
            [StudentCourse].[LastUpdateDate]
    FROM [Student]
        INNER JOIN [StudentCourse] ON [Student].[Id] = [StudentCourse].[StudentId]
        INNER JOIN [Course] ON [Course].[Id] = [StudentCourse].[CourseId]
    WHERE
        StudentCourse.StudentId = @StudentId
        AND [StudentCourse].[Progress] < 100
        AND [StudentCourse].[Progress] > 0
    ORDER BY
        [StudentCourse].[LastUpdateDate] DESC
GO
 
EXEC spStudentProgress 'c966a8e7-e788-43d3-8f92-155684075f5a'


CREATE OR ALTER PROCEDURE spDeleteStudent(
    @StudentId UNIQUEIDENTIFIER
)
AS
    BEGIN TRANSACTION
        DELETE FROM
            [StudentCourse]
        WHERE
            [StudentId] = @StudentId
        
        DELETE FROM
            [Student]
        WHERE
            [Id] = @StudentId
    COMMIT


EXEC spDeleteStudent 'c966a8e7-e788-43d3-8f92-155684075f5a'

SELECT * FROM [Student]
SELECT * FROM [StudentCourse]
