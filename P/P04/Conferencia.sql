IF (
    NOT EXISTS (
        SELECT *
        FROM sys.schemas
        WHERE name = 'Stock'
    )
) BEGIN EXEC ('CREATE SCHEMA [Stock] AUTHORIZATION [dbo]');