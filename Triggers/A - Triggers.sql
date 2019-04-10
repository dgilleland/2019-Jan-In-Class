-- Triggers Samples
USE [A01-School]
GO

/*
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Table_TriggerType]'))
    DROP TRIGGER Table_TriggerType
GO

CREATE TRIGGER Table_TriggerType
ON TableName
FOR Insert, Update, Delete -- Choose only the DML statement(s) that apply
AS
    -- Body of Trigger
RETURN
GO
*/
-- Making a diagnostic trigger for the first example
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Activity_DML_Diagnostic]'))
    DROP TRIGGER Activity_DML_Diagnostic
GO

CREATE TRIGGER Activity_DML_Diagnostic
ON Activity
FOR Insert, Update, Delete -- Choose only the DML statement(s) that apply
AS
    -- Body of Trigger
    SELECT 'Activity Table:', StudentID, ClubId FROM Activity ORDER BY StudentID
    SELECT 'Inserted Table:', StudentID, ClubId FROM inserted ORDER BY StudentID
    SELECT 'Deleted Table:', StudentID, ClubId FROM deleted ORDER BY StudentID
RETURN
GO
-- Demonstrate the diagnostic trigger
SELECT * FROM Activity
INSERT INTO Activity(StudentID, ClubId) VALUES (200494476, 'CIPS')
-- (note: generally, it's not a good idea to change a primary key, even part of one)
UPDATE Activity SET ClubId = 'NASA1' WHERE StudentID = 200494476
DELETE FROM Activity WHERE StudentID = 200494476

-- 1. In order to be fair to all students, a student can only belong to a maximum of 3 clubs. Create a trigger to enforce this rule.
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Actvitity_InsertUpdate]'))
    DROP TRIGGER Actvitity_InsertUpdate
GO

CREATE TRIGGER Actvitity_InsertUpdate
ON Activity
FOR Insert, Update -- Choose only the DML statement(s) that apply
AS
    -- Body of Trigger
    IF @@ROWCOUNT > 0 -- It's a good idea to see if any rows were affected first
       AND
       EXISTS (SELECT StudentID FROM Activity
               GROUP BY StudentID HAVING COUNT(StudentID) > 3)
    BEGIN
        -- State why I'm going to abort the changes
        RAISERROR('Max of 3 clubs that a student can belong to', 16, 1)
        -- "Undo" the changes
        ROLLBACK TRANSACTION
    END
RETURN
GO
-- Before doing my tests, examine the data in the table
-- to see what I could use for testing purposes
SELECT * FROM Activity
SELECT StudentID, FirstName, LastName FROM Student WHERE StudentID = 200495500

-- The following test should result in a rollback.
INSERT INTO Activity(StudentID, ClubId)
VALUES (200495500, 'CIPS') -- Robert Smith

-- The following should succeed
INSERT INTO Activity(StudentID, ClubId)
VALUES (200312345, 'CIPS') -- Mary Jane

INSERT INTO Activity(StudentID, ClubId)
VALUES (200122100, 'CIPS'), -- Peter Codd   -- New to the Activity table
       (200494476, 'CIPS'), -- Joe Cool     -- New to the Activity table
       (200522220, 'CIPS'), -- Joe Petroni  -- New to the Activity table
       (200978400, 'CIPS'), -- Peter Pan    -- New to the Activity table
       (200688700, 'CIPS')  -- Robbie Chan  -- New to the Activity table
      ,(200495500, 'CIPS')  -- Robert Smith -- This would be his 4th club!

-- 2. The Education Board is concerned with rising course costs! Create a trigger to ensure that a course cost does not get increased by more than 20% at any one time.
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Course_Update_CourseCostLimit]'))
    DROP TRIGGER Course_Update_CourseCostLimit
GO

CREATE TRIGGER Course_Update_CourseCostLimit
ON Course
FOR Update -- Choose only the DML statement(s) that apply
AS
    -- Body of Trigger
    IF @@ROWCOUNT > 0 AND
       EXISTS(SELECT * FROM inserted I INNER JOIN deleted D ON I.CourseId = D.CourseId
              WHERE I.CourseCost > D.CourseCost * 1.20) -- 20% higher
    BEGIN
        RAISERROR('Students can''t afford that much of an increase!', 16, 1)
        ROLLBACK TRANSACTION
    END
RETURN
GO
-- TODO: Write the code that will test this stored procedure.
SELECT * FROM Course
UPDATE Course SET CourseCost = 1000 -- This should fail
UPDATE Course SET CourseCost = CourseCost * 1.21
UPDATE Course SET CourseCost = CourseCost * 1.195

-- 3. Too many students owe us money and keep registering for more courses! Create a trigger to ensure that a student cannot register for any more courses if they have a balance owing of more than $500.
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Registration_Insert_BalanceOwing]'))
    DROP TRIGGER Registration_Insert_BalanceOwing
GO

CREATE TRIGGER Registration_Insert_BalanceOwing
ON Registration
FOR Insert
AS
    -- Body of Trigger
    IF @@ROWCOUNT > 0 AND
       EXISTS(SELECT S.StudentID FROM inserted I INNER JOIN  Student S ON I.StudentID = S.StudentID
              WHERE S.BalanceOwing > 500)
    BEGIN
        RAISERROR('Student owes too much money - cannot register student in course', 16, 1)
        ROLLBACK TRANSACTION
    END
RETURN
GO
-- TODO: Write code to test this trigger
SELECT * FROM Student WHERE BalanceOwing > 0

-- Write a stored procedure called RegisterStudent that puts a student in a course and increases the balance owing by the cost of the course.


--4. Our school DBA has suddenly disabled some Foreign Key constraints to deal with performance issues! Create a trigger on the Registration table to ensure that only valid CourseIDs, StudentIDs and StaffIDs are used for grade records. (You can use sp_help tablename to find the name of the foreign key constraints you need to disable to test your trigger.) Have the trigger raise an error for each foreign key that is not valid. If you have trouble with this question create the trigger so it just checks for a valid student ID.
-- sp_help Registration -- then disable the foreign key constraints....
ALTER TABLE Registration NOCHECK CONSTRAINT FK_GRD_CRS_CseID
ALTER TABLE Registration NOCHECK CONSTRAINT FK_GRD_STF_StaID
ALTER TABLE Registration NOCHECK CONSTRAINT FK_GRD_STU_StuID
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Registration_InsertUpdate_EnforceForeignKeyValues]'))
    DROP TRIGGER Registration_InsertUpdate_EnforceForeignKeyValues
GO

CREATE TRIGGER Registration_InsertUpdate_EnforceForeignKeyValues
ON Registration
FOR Insert,Update -- Choose only the DML statement(s) that apply
AS
	-- Body of Trigger
    IF @@ROWCOUNT > 0
    BEGIN
        -- UPDATE(columnName) is a function call that checks to see if information between the 
        -- deleted and inserted tables for that column are different (i.e.: data in that column
        -- has changed).
        IF UPDATE(StudentID) AND
           NOT EXISTS (SELECT * FROM inserted I INNER JOIN Student S ON I.StudentID = S.StudentID)
        BEGIN
            RAISERROR('That is not a valid StudentID', 16, 1)
            ROLLBACK TRANSACTION
        END
        ELSE
        IF UPDATE(CourseID) AND
           NOT EXISTS (SELECT * FROM inserted I INNER JOIN Course C ON I.CourseId = C.CourseId)
        BEGIN
            RAISERROR('That is not a valid CourseID', 16, 1)
            ROLLBACK TRANSACTION
        END
        ELSE
        IF UPDATE(StaffID) AND
           NOT EXISTS (SELECT * FROM inserted I INNER JOIN Staff S ON I.StaffID = S.StaffID)
        BEGIN
            RAISERROR('That is not a valid StaffID', 16, 1)
            ROLLBACK TRANSACTION
        END
    END
RETURN
GO

-- 5. The school has placed a temporary hold on the creation of any more clubs. (Existing clubs can be renamed or removed, but no additional clubs can be created.) Put a trigger on the Clubs table to prevent any new clubs from being created.
IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Club_Insert_Lockdown]'))
    DROP TRIGGER Club_Insert_Lockdown
GO

CREATE TRIGGER Club_Insert_Lockdown
ON Club
FOR Insert -- Choose only the DML statement(s) that apply
AS
	-- Body of Trigger
    IF @@ROWCOUNT > 0
    BEGIN
        RAISERROR('Temporary lockdown on creating new clubs.', 16, 1)
        ROLLBACK TRANSACTION
    END
RETURN
GO
INSERT INTO Club(ClubId, ClubName) VALUES ('HACK', 'Honest Analyst Computer Knowledge')
GO
-- 6. Our network security officer suspects our system has a virus that is allowing students to alter their balance owing records! In order to track down what is happening we want to create a logging table that will log any changes to the balance owing in the Student table. You must create the logging table and the trigger to populate it when the balance owing is modified.
-- Step 1) Make the logging table
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'BalanceOwingLog')
    DROP TABLE BalanceOwingLog
GO
CREATE TABLE BalanceOwingLog
(
    LogID           int  IDENTITY (1,1) NOT NULL CONSTRAINT PK_BalanceOwingLog PRIMARY KEY,
    StudentID       int                 NOT NULL,
    ChangeDateTime  datetime            NOT NULL,
    OldBalance      money               NOT NULL,
    NewBalance      money               NOT NULL
)
GO

IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[Student_Update_AuditBalanceOwing]'))
    DROP TRIGGER Student_Update_AuditBalanceOwing
GO

CREATE TRIGGER Student_Update_AuditBalanceOwing
ON Student
FOR Update -- Choose only the DML statement(s) that apply
AS
	-- Body of Trigger
    IF @@ROWCOUNT > 0 AND UPDATE(BalanceOwing)
	BEGIN
	    INSERT INTO BalanceOwingLog (StudentID, ChangedateTime, OldBalance, NewBalance)
	    SELECT I.StudentID, GETDATE(), D.BalanceOwing, I.BalanceOwing
        FROM deleted D INNER JOIN inserted I on D.StudentID = I.StudentID
	    IF @@ERROR <> 0 
	    BEGIN
		    RAISERROR('Insert into BalanceOwingLog Failed',16,1)
            ROLLBACK TRANSACTION
		END	
	END
RETURN
GO

SELECT * FROM BalanceOwingLog -- To see what's in there before an update
-- Hacker statements happening offline....
UPDATE Student SET BalanceOwing = BalanceOwing - 100 -- Hacker failed, but not disuaded
UPDATE Student SET BalanceOwing = BalanceOwing - 100 WHERE BalanceOwing > 100
SELECT * FROM BalanceOwingLog -- To see what's in there after a hack attempt
UPDATE Student SET BalanceOwing = 10000 -- He's graduated, and doesn't want competition
SELECT * FROM BalanceOwingLog -- To see what's in there after a hack attempt



