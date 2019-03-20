-- Stored Procedures (Sprocs)
-- File: C - Stored Procedures.sql

USE [A01-School]
GO

-- Take the following queries and turn them into stored procedures.

-- 1.   Selects the studentID's, CourseID and mark where the Mark is between 70 and 80
SELECT  StudentID, CourseId, Mark
FROM    Registration
WHERE   Mark BETWEEN 70 AND 80 -- BETWEEN is inclusive
--      Place this in a stored procedure that has two parameters,
--      one for the upper value and one for the lower value.
--      Call the stored procedure ListStudentMarksByRange
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'ListStudentMarksByRange')
    DROP PROCEDURE ListStudentMarksByRange
GO
CREATE PROCEDURE ListStudentMarksByRange
    @lower  decimal,
    @upper  decimal
AS
    SELECT  StudentID, CourseId, Mark
    FROM    Registration
    WHERE   Mark BETWEEN @lower AND @upper -- BETWEEN is inclusive
RETURN
GO

-- Testing
--  Good inputs
EXEC ListStudentMarksByRange 70, 80
--  Bad inputs
EXEC ListStudentMarksByRange 80, 70
EXEC ListStudentMarksByRange 70, NULL
EXEC ListStudentMarksByRange NULL, 80
EXEC ListStudentMarksByRange NULL, NULL
EXEC ListStudentMarksByRange -5, 80
EXEC ListStudentMarksByRange 70, 101 -- Specifically checking the upper limit

--  Alter the stored procedure to handle validation of inputs
GO
ALTER PROCEDURE ListStudentMarksByRange
    @lower  decimal,
    @upper  decimal
AS
    IF @lower IS NULL OR @upper IS NULL
        RAISERROR('Lower and Upper values are required and cannot be null', 16, 1)
    ELSE IF @lower > @upper
        RAISERROR('The lower limit cannot be larger than the upper limit', 16, 1)
    ELSE IF @lower < 0
        RAISERROR('The lower limit cannot be less than zero', 16, 1)
    ELSE IF @upper > 100
        RAISERROR('The upper limit cannot be greater than 100', 16, 1)
    ELSE
        SELECT  StudentID, CourseId, Mark
        FROM    Registration
        WHERE   Mark BETWEEN @lower AND @upper -- BETWEEN is inclusive
RETURN
GO

/* ----------------------------------------------------- */

-- 2.   Selects the Staff full names and the Course ID's they teach.
SELECT  DISTINCT -- The DISTINCT keyword will remove duplate rows from the results
        FirstName + ' ' + LastName AS 'Staff Full Name',
        CourseId
FROM    Staff S
    INNER JOIN Registration R
        ON S.StaffID = R.StaffID
ORDER BY 'Staff Full Name', CourseId
--      Place this in a stored procedure called CourseInstructors.


/* ----------------------------------------------------- */

-- 3.   Selects the students first and last names who have last names starting with S.
SELECT  FirstName, LastName
FROM    Student
WHERE   LastName LIKE 'S%'
--      Place this in a stored procedure called FindStudentByLastName.
--      The parameter should be called @PartialName.
--      Do NOT assume that the '%' is part of the value in the parameter variable;
--      Your solution should concatenate the @PartialName with the wildcard.


/* ----------------------------------------------------- */

-- 4.   Selects the CourseID's and Coursenames where the CourseName contains the word 'programming'.
SELECT  CourseId, CourseName
FROM    Course
WHERE   CourseName LIKE '%programming%'
--      Place this in a stored procedure called FindCourse.
--      The parameter should be called @PartialName.
--      Do NOT assume that the '%' is part of the value in the parameter variable.


/* ----------------------------------------------------- */

-- 5.   Selects the Payment Type Description(s) that have the highest number of Payments made.
SELECT PaymentTypeDescription
FROM   Payment 
    INNER JOIN PaymentType 
        ON Payment.PaymentTypeID = PaymentType.PaymentTypeID
GROUP BY PaymentType.PaymentTypeID, PaymentTypeDescription 
HAVING COUNT(PaymentType.PaymentTypeID) >= ALL (SELECT COUNT(PaymentTypeID)
                                                FROM Payment 
                                                GROUP BY PaymentTypeID)
--      Place this in a stored procedure called MostFrequentPaymentTypes.

/* ----------------------------------------------------- */

-- 6.   Selects the current staff members that are in a particular job position.
SELECT  FirstName + ' ' + LastName AS 'StaffFullName'
FROM    Position P
    INNER JOIN Staff S ON S.PositionID = P.PositionID
WHERE   DateReleased IS NULL
  AND   PositionDescription = 'Instructor'
--      Place this in a stored procedure called StaffByPosition

/* ----------------------------------------------------- */

-- 7.   Selects the staff members that have taught a particular course (e.g.: 'DMIT101').
SELECT  DISTINCT FirstName + ' ' + LastName AS 'StaffFullName',
        CourseId
FROM    Registration R
    INNER JOIN Staff S ON S.StaffID = R.StaffID
WHERE   DateReleased IS NULL
  AND   CourseId = 'DMIT101'
--      This select should also accommodate inputs with wildcards. (Change = to LIKE)
--      Place this in a stored procedure called StaffByCourseExperience

