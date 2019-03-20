--  Stored Procedures (Sprocs)
-- Demonstrate using Transactions in a Stored Procedure

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


-- 1. Add a stored procedure called TransferCourse that accepts a student ID, semester, and two course IDs: the one to move the student out of and the one to move the student in to.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'TransferCourse')
    DROP PROCEDURE TransferCourse
GO
CREATE PROCEDURE TransferCourse
    -- Parameters here
    @StudentID      int,
    @Semester       char(5),
    @LeaveCourseID  char(7),
    @EnterCourseID  char(7)
AS
    -- Body of procedure here
    -- Basic Validation - Parameter values are required
    IF @StudentID IS NULL OR @Semester IS NULL OR @LeaveCourseID IS NULL OR @EnterCourseID IS NULL
    BEGIN
        RAISERROR('All parameters are required (cannot be null)', 16, 1)
    END
    ELSE
    BEGIN
        -- Begin Transaction
        BEGIN TRANSACTION   -- Means that any insert/update/delete is "temporary" until committed
        -- Step 1) Withdraw the student from the first course
        --PRINT('Update Registration to set WithdrawYN to Y')
        UPDATE Registration
           SET WithdrawYN = 'Y'
        WHERE  StudentID = @StudentID
          AND  CourseId = @LeaveCourseID
          AND  Semester = @Semester
          AND  (WithdrawYN = 'N' OR WithdrawYN IS NULL)
        --         Check for error/rowcount
        IF @@ERROR > 0 OR @@ROWCOUNT = 0
        BEGIN
            --PRINT('RAISERROR + ROLLBACK')
            RAISERROR('Unable to withdraw student', 16, 1)
            ROLLBACK TRANSACTION -- reverses the "temporary" changes to the database
        END
        ELSE
        BEGIN
            -- Step 2) Enroll the student in the second course
            --PRINT('Insert Registration to add student')
            INSERT INTO Registration(StudentID, CourseId, Semester)
            VALUES (@StudentID, @EnterCourseID, @Semester)
            --         Check for error/rowcount
            -- Since @@ERROR and @@ROWCOUNT are global variables,
            -- we have to check them immediately after our insert/update/delete
            IF @@ERROR > 0 OR @@ROWCOUNT = 0 -- Do our check for errors after each I/U/D
            BEGIN
                --PRINT('RAISERROR + ROLLBACK')
                RAISERROR('Unable to transfer student to new course', 16, 1)
                ROLLBACK TRANSACTION
            END
            ELSE
            BEGIN
                --PRINT('COMMIT TRANSACTION')
                COMMIT TRANSACTION -- Make the changes permanent on the database
            END
        END
    END
RETURN
GO


-- 2. Add a stored procedure called AdjustMarks that takes in a course ID. The procedure should adjust the marks of all students for that course by increasing the mark by 10%. Be sure that nobody gets a mark over 100%.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'AdjustMarks')
    DROP PROCEDURE AdjustMarks
GO
CREATE PROCEDURE AdjustMarks
    -- Parameters here
    @CourseID   char(7)
AS
    -- Body of procedure here
    -- Step 0) Validation
    IF @CourseID IS NULL
    BEGIN
        RAISERROR('CourseID cannot be null', 16, 1)
    END
    ELSE
    BEGIN
        BEGIN TRANSACTION -- Don't forget this....
        -- Step 1) Deal with those who "could" get 100%+ by just giving them 100%
        PRINT('Step 1 - Update Registration...')
        UPDATE Registration
           SET Mark = 100
        WHERE  CourseId = @CourseID
          AND  Mark * 1.1 > 100
        IF @@ERROR > 0 -- Errors only - it's ok to have zero rows affected
        BEGIN
            PRINT('RAISERROR + ROLLBACK')
            RAISERROR('Problem updating marks', 16, 1)
            ROLLBACK TRANSACTION
        END
        ELSE
        BEGIN
            -- Step 2) Raise all the other marks
            PRINT('Step 2 - Update Registration...')
            UPDATE Registration
               SET Mark = Mark * 1.1
            WHERE  CourseId = @CourseID
              AND  Mark * 1.1 <= 100

            IF @@ERROR > 0 -- Errors only
            BEGIN
                PRINT('RAISERROR + ROLLBACK')
                RAISERROR('Problem updating marks', 16, 1)
                ROLLBACK TRANSACTION
            END
            ELSE
            BEGIN
                COMMIT TRANSACTION -- Success!!!
            END
        END
    END

RETURN
GO

-- 3. Create a stored procedure called RegisterStudent that accepts StudentID, CourseID and Semester as parameters. If the number of students in that course and semester are not greater than the Max Students for that course, add a record to the Registration table and add the cost of the course to the students balance. If the registration would cause the course in that semester to have greater than MaxStudents for that course raise an error.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'RegisterStudent')
    DROP PROCEDURE RegisterStudent
GO

CREATE PROCEDURE RegisterStudent
    @StudentID  int,
    @CourseID   char(7),
    @Semester   char(5)
AS
    IF @StudentID IS NULL OR @CourseID IS NULL OR @Semester IS NULL
    BEGIN
        RAISERROR ('You must provide a studentid, courseid, and semester', 16, 1)
    END
    ELSE
    BEGIN
        -- Declare a bunch of local/temp variables
        -- Each variable can only hold a single value at a time
        DECLARE @MaxStudents    smallint
        DECLARE @CurrentCount   smallint
        DECLARE @CourseCost     money
        -- Assign a value to each of the local variables
        SELECT @MaxStudents = MaxStudents FROM Course WHERE CourseId = @CourseID
        SELECT @CurrentCount = COUNT (StudentID) FROM Registration WHERE CourseId = @CourseID AND Semester = @Semester
        SELECT @CourseCost = CourseCost FROM Course WHERE CourseId = @CourseID

        IF @MaxStudents >= @currentcount 
        BEGIN
            RAISERROR('The course is already full', 16, 1)
        END
        ELSE
        BEGIN
            BEGIN TRANSACTION

            INSERT INTO Registration (StudentID, CourseId, Semester)
            VALUES (@StudentID, @CourseID, @Semester)

            IF @@ERROR <> 0    
            BEGIN
                RAISERROR ('Registration insert failed', 16, 1)
                ROLLBACK TRANSACTION
            END
            ELSE
            BEGIN
                UPDATE  Student
                   SET  BalanceOwing = BalanceOwing + @CourseCost
                WHERE   StudentID = @StudentID

                IF @@ERROR <> 0
                BEGIN
                    RAISERROR ('Balance update failed', 16, 1)
                    ROLLBACK TRANSACTION
                END
                ELSE
                BEGIN
                    COMMIT TRANSACTION
                END
            END
        END
    END
RETURN

GO

-- 4. Add a stored procedure called WitnessProtection that erases all existence of a student from the database. The stored procedure takes the StudentID, first and last names, gender, and birthdate as parameters. Ensure that the student exists in the database before removing them (all the parameter values must match).
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'WitnessProtection')
    DROP PROCEDURE WitnessProtection
GO

CREATE PROCEDURE WitnessProtection
    @StudentID  int,
    @First      varchar(25),
    @Last       varchar(35),
    @Gender     char(1),
    @Birthdate  smalldatetime
AS
    IF @StudentID IS NULL OR @First IS NULL OR @Last IS NULL OR @Gender IS NULL OR @Birthdate IS NULL
    BEGIN
        RAISERROR ('You must provide all identifying student information', 16, 1)
    END
    ELSE
    BEGIN
        IF NOT EXISTS(SELECT StudentID FROM Student
                      WHERE  StudentID = @StudentID
                        AND  FirstName = @First
                        AND  LastName = @Last
                        AND  Gender = @Gender
                        AND  Birthdate = @Birthdate)
        BEGIN
            RAISERROR ('That student does not exist', 16, 1)
        END
        ELSE
        BEGIN
            BEGIN TRANSACTION
            DELETE  Registration 
            WHERE   StudentID = @StudentID
            IF @@ERROR <> 0
            BEGIN
                RAISERROR('Grade delete failed', 16, 1)
                ROLLBACK TRANSACTION
            END
            ELSE
            BEGIN
                DELETE Payment
                WHERE  StudentID = @StudentID 
                IF @@ERROR <> 0
                BEGIN
                    RAISERROR('Payment delete failed', 16, 1)
                    ROLLBACK TRANSACTION
                END
                ELSE
                BEGIN
                    DELETE Activity
                    WHERE  StudentID = @StudentID
                    IF @@ERROR <> 0
                    BEGIN
                        RAISERROR('Activity delete failed', 16, 1)
                        ROLLBACK TRANSACTION
                    END
                    ELSE
                    BEGIN    
                        DELETE Student
                        WHERE  StudentID = @StudentID
                        IF @@ERROR <> 0
                        BEGIN
                            RAISERROR('Student delete failed', 16, 1)
                            ROLLBACK TRANSACTION
                        END
                        ELSE
                        BEGIN
                            COMMIT TRANSACTION
                        END
                    END
                END
            END
        END
    END
RETURN
GO

-- 5. Create a procedure called StudentPayment that accepts Student ID and paymentamount as parameters. Add the payment to the payment table and adjust the students balance owing to reflect the payment.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'StudentPayment')
    DROP PROCEDURE StudentPayment
GO

CREATE PROCEDURE StudentPayment
    @StudentID      int,
    @PaymentAmount  money,
    @PaymentTypeID  tinyint
AS
    IF @StudentID IS NULL OR @PaymentAmount IS NULL OR @PaymentTypeID IS NULL
    BEGIN
        RAISERROR ('Must provide a studentId, Paymentamount and Payment Type ID', 16, 1)
    END
    ELSE
    BEGIN
        BEGIN TRANSACTION
        INSERT INTO Payment(PaymentDate, Amount, PaymentTypeID, StudentID)
        VALUES (GETDATE(), @PaymentAmount, @PaymentTypeID, @StudentID)

        IF @@ERROR <> 0
        BEGIN
            RAISERROR('Payment failed', 16, 1)
            ROLLBACK TRANSACTION
        END
        ELSE
        BEGIN
            UPDATE  Student
               SET  BalanceOwing = BalanceOwing - @PaymentAmount
             WHERE  StudentID = @StudentID
            IF @@ERROR <> 0
            BEGIN
                RAISERROR('Balance update failed', 16, 1)
                ROLLBACK TRANSACTION
            END
            ELSE
            BEGIN
                COMMIT TRANSACTION
            END
        END
    END
RETURN
GO

-- 6. Create a stored procedure called WithdrawStudent that accepts a StudentID, CourseId, and semester as parameters. Withdraw the student by updating their Withdrawn value to 'Y' and subtract 1/2 of the cost of the course from their balance. If the result would be a negative balance set it to 0.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'WithdrawStudent')
    DROP PROCEDURE WithdrawStudent
GO

CREATE PROCEDURE WithdrawStudent
    @StudentID  int,
    @CourseID   char(7),
    @Semester   char(5)
AS
    -- Declare a bunch of local/temp variables
    DECLARE @coursecost     decimal (6,2)
    DECLARE @amount         decimal(6,2)
    DECLARE @balanceowing   decimal(6,2)
    DECLARE @difference     decimal(6,2)

    IF @StudentID IS NULL OR @CourseID IS NULL OR @Semester IS NULL
    BEGIN
        RAISERROR ('You must provide a studentid, courseid, and semester', 16, 1)
    END
    ELSE
    BEGIN
        IF NOT EXISTS (SELECT   * 
                       FROM     Registration 
                       WHERE    StudentID = @StudentID
                         AND    CourseId = @CourseID
                         AND    Semester = @Semester)
        BEGIN
          RAISERROR('that student does not exist in that registration', 16, 1)
        END
        ELSE
        BEGIN
            BEGIN TRANSACTION
              
            UPDATE registration
                SET WithdrawYN = 'Y'
            WHERE  StudentID= @StudentID
              AND  CourseId = @CourseID
              AND  Semester = @Semester
            IF @@ERROR <> 0
            BEGIN
                RAISERROR ('Registration update failed', 16, 1)
                ROLLBACK TRANSACTION
            END
            ELSE
            BEGIN
                -- Calculate the amount that we need to set for the student's BalanceOwing
                SELECT  @coursecost = coursecost
                FROM    Course 
                WHERE   CourseId  = @courseid

                SELECT  @balanceowing = balanceowing 
                FROM    Student
                WHERE   StudentID = @StudentID

                SELECT  @difference = @balanceowing - @coursecost / 2
        
                IF @difference >0
                    SET @amount = @difference
                ELSE
                    SET @amount = 0

                -- Use the calculated amount as the new BalanceOwing for the student        
                UPDATE  Student
                   SET  BalanceOwing = @amount
                WHERE   StudentID = @StudentID

                IF @@ERROR <> 0
                BEGIN
                    RAISERROR ('Balance update failed', 16, 1)
                    ROLLBACK TRANSACTION
                END
                ELSE
                BEGIN
                    COMMIT TRANSACTION
                END
            END
        END
    END
RETURN
GO

-- 7. Create a stored procedure called ArchiveStudentGrades that will accept a year and will archive all grade records from that year from the grade table to an ArchiveGrade table. Copy all the appropriate records from the grade table to the ArchiveGrade table and delete them from the grade table. The ArchiveGrade table will have the same definition as the grade table but will not have any constraints.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ArchiveGrade')
    DROP TABLE ArchiveGrade

CREATE TABLE ArchiveGrade
(
    StudentID        int,
    CourseId        char (7),
    Semester        char (5),
    Mark            decimal(5,2),
    WithdrawYN        char (1),
    StaffID            smallint
)
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'ArchiveStudentGrades')
    DROP PROCEDURE ArchiveStudentGrades
GO

CREATE PROCEDURE ArchiveStudentGrades
    @RecordYear char(4)
AS
    IF @RecordYear IS NULL
    BEGIN
        RAISERROR ('You must provide a year', 16, 1)
    END
    ELSE
    BEGIN
        BEGIN TRANSACTION
        INSERT INTO ArchiveGrade (StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
        SELECT  StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID
        FROM    Registration
        WHERE   LEFT(Semester, 4) = @RecordYear
        IF @@ERROR <> 0 
        BEGIN
            RAISERROR ('Archive failed', 16, 1)
            ROLLBACK TRANSACTION
        END
        ELSE
        BEGIN
            DELETE Registration WHERE LEFT(Semester, 4) = @RecordYear
            IF @@ERROR <> 0
            BEGIN
                RAISERROR ('Archive failed', 16, 1)
                ROLLBACK TRANSACTION
            END
            ELSE
            BEGIN
                COMMIT TRANSACTION
            END
        END
    END
RETURN
GO

