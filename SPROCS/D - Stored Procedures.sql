--Stored Procedures (Sprocs)
-- Global Variables - @@IDENTITY, @@ROWCOUNT, @@ERROR
-- Other global variables can be found here:
--  https://code.msdn.microsoft.com/Global-Variables-in-SQL-749688ef
USE [A01-School]
GO

/*
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'SprocName')
    DROP PROCEDURE SprocName
GO
CREATE PROCEDURE SprocName
    -- Parameters here
AS
    -- Body of procedure here
RETURN
GO
*/

-- 1. Create a stored procedure called AddPosition that will accept a Position Description (varchar 50). Return the primary key value that was database-generated as a result of your Insert statement. Also, ensure that the supplied description is not NULL and that it is at least 5 characters long. Make sure that you do not allow a duplicate position name.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'AddPosition')
    DROP PROCEDURE AddPosition
GO
CREATE PROCEDURE AddPosition
    -- Parameters here
    @Description    varchar(50)
AS
    -- Body of procedure here
    IF @Description IS NULL
    BEGIN -- {
        RAISERROR('Description is required', 16, 1) -- Throw an exception
    END   -- }
    ELSE
    BEGIN -- {
        IF LEN(@Description) < 5
        BEGIN -- {
            RAISERROR('Description must be between 5 and 50 characters', 16, 1)
        END   -- }
        ELSE
        BEGIN -- {
            IF EXISTS(SELECT * FROM Position WHERE PositionDescription = @Description)
            BEGIN -- {
                RAISERROR('Duplicate positions are not allowed', 16, 1)
            END   -- }
            ELSE
            BEGIN -- { -- This BEGIN/END is needed, because of two SQL statements
                INSERT INTO Position(PositionDescription)
                VALUES (@Description)
                -- Send back the database-generated primary key
                SELECT @@IDENTITY AS 'NewPositionID' -- This is a global variable
            END   -- }
        END   -- }
    END   -- }
RETURN
GO

-- Let's test our AddPosition stored procedure

EXEC AddPosition 'The Boss'
EXEC AddPosition NULL -- This should result in an error being raised
EXEC AddPosition 'Me' -- This should result in an error being raised
EXEC AddPosition 'The Boss' -- This should result in an error as well (a duplicate)
-- This long string gets truncated at the parameter, because the parameter size is 50
EXEC AddPosition 'The Boss of everything and everyone, everywhere and all the time, both past present and future, without any possible exception. Unless, of course, I''m not...'
EXEC AddPosition 'The Janitor'
SELECT * FROM Position
-- DELETE FROM Position WHERE PositionID = 12
GO

ALTER PROCEDURE AddPosition
    -- Parameters here
    @Description    varchar(500) -- Just to "allow" a larger value, but check the length later
AS
    -- Body of procedure here
    IF @Description IS NULL
    BEGIN -- {
        RAISERROR('Description is required', 16, 1) -- Throw an exception
    END   -- }
    ELSE
    BEGIN -- {
        IF LEN(@Description) < 5 OR Len(@Description) > 50
        BEGIN -- {
            RAISERROR('Description must be between 5 and 50 characters', 16, 1)
        END   -- }
        ELSE
        BEGIN -- {
            IF EXISTS(SELECT * FROM Position WHERE PositionDescription = @Description)
            BEGIN -- {
                RAISERROR('Duplicate positions are not allowed', 16, 1)
            END   -- }
            ELSE
            BEGIN -- { -- This BEGIN/END is needed, because of two SQL statements
                INSERT INTO Position(PositionDescription)
                VALUES (@Description)
                -- Send back the database-generated primary key
                SELECT @@IDENTITY -- This is a global variable
            END   -- }
        END   -- }
    END   -- }
RETURN
GO

EXEC AddPosition 'Still the Boss of everything and everyone, everywhere and all the time, both past present and future, without any possible exception. Unless, of course, I''m not...'
SELECT * FROM Position
-- DELETE FROM Position WHERE PositionID = 12

-- 2) Create a stored procedure called LookupClubMembers that takes a club ID and returns the full names of all members in the club.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'LookupClubMembers')
    DROP PROCEDURE LookupClubMembers
GO
CREATE PROCEDURE LookupClubMembers
    -- Parameters here
    @ClubId     varchar(10)
AS
    -- Body of procedure here
    IF @ClubId IS NULL OR NOT EXISTS(SELECT * FROM Club WHERE ClubId = @ClubId)
    BEGIN
        RAISERROR('ClubID is invalid/does not exist', 16, 1)
    END
    ELSE
    BEGIN
        SELECT  FirstName + ' ' + LastName AS 'MemberName'
        FROM    Student S
            INNER JOIN Activity A ON A.StudentID = S.StudentID
        WHERE   A.ClubId = @ClubId
    END
RETURN
GO

-- Test the above sproc
EXEC LookupClubMembers 'CHESS'
EXEC LookupClubMembers 'CSS'
EXEC LookupClubMembers 'Drop Out'
EXEC LookupClubMembers 'NASA1'
EXEC LookupClubMembers NULL

-- 3) Create a stored procedure called RemoveClubMembership that takes a club ID and deletes all the members of that club. Be sure that the club exists. Also, raise an error if there were no members deleted from the club.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'RemoveClubMembership')
    DROP PROCEDURE RemoveClubMembership
GO
CREATE PROCEDURE RemoveClubMembership
    -- Parameters here
    @ClubId     varchar(10)
AS
    -- Body of procedure here
    IF @ClubId IS NULL OR NOT EXISTS(SELECT * FROM Club WHERE ClubId = @ClubId)
    BEGIN
        RAISERROR('ClubID is invalid/does not exist', 16, 1)
    END
    ELSE
    BEGIN
        DELETE FROM Activity
        WHERE       ClubId = @ClubId
        -- Any Insert/Update/Delete will affect the global @@ROWCOUNT value
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No members were deleted', 16, 1)
        END
    END
RETURN
GO
-- Test the above sproc...
EXEC RemoveClubMembership NULL
EXEC RemoveClubMembership 'Drop Out'
EXEC RemoveClubMembership 'NASA1'
EXEC RemoveClubMembership 'CSS'
EXEC RemoveClubMembership 'CSS' -- The second time this is run, there will be no members to remove


-- 4) Create a stored procedure called OverActiveMembers that takes a single number: ClubCount. This procedure should return the names of all members that are active in as many or more clubs than the supplied club count.
--    (p.s. - You might want to make sure to add more members to more clubs, seeing as tests for the last question might remove a lot of club members....)



-- 5) Create a stored procedure called ListStudentsWithoutClubs that lists the full names of all students who are not active in a club.



-- 6) Create a stored procedure called LookupStudent that accepts a partial student last name and returns a list of all students whose last name includes the partial last name. Return the student first and last name as well as their ID.


