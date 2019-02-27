--Simple Select Exercise 2
-- This set of exercises demonstrates performing simple Aggregate functions
-- to get results such as SUM(), AVG(), COUNT() 
-- All aggregates are done using built-in functions in the database
Use [A01-School]
GO

--1.	Select the average Mark from all the Marks in the registration table
SELECT  AVG(Mark) AS 'Average Mark'
FROM    Registration

--1.a.  Show the average mark, the total of all marks, and a count of all marks.
SELECT  AVG(Mark) AS 'Average Mark',
        SUM(Mark) AS 'Total of Marks',
        COUNT(Mark) AS 'How Many Marks'
FROM    Registration


--2.	Select the average Mark of all the students who are taking DMIT104
SELECT  AVG(Mark) AS 'Average Mark' -- Some Aggregate functions expect to work with numbers
FROM    Registration
WHERE   CourseId = 'DMIT104'

--3.	Select how many students are there in the Student Table
SELECT  COUNT(FirstName) AS 'Student Count'
FROM    Student

--3.b   The argument for the COUNT() function can be any column and/or expression.
--      COUNT() will count the number of occurrences (i.e., "rows").
SELECT  COUNT(1) AS 'Student Count'
FROM    Student

-- 3.c  Select how many people are in the Staff table
SELECT  COUNT(StaffID) AS 'Staff Count' -- It's common to use the PK as the column that you're counting
FROM    Staff

-- 3.d  Do a count of the people in the Staff table who are no longer working here
--      Refresh your memory about all the data in the Staff table
SELECT  * FROM Staff
SELECT  COUNT(DateReleased) AS 'Retired Staff'
FROM    Staff

--4.	Select how many students have taken (have a grade for) DMIT152
SELECT  COUNT(Mark) AS 'Student Count for DMIT152'
FROM    Registration
WHERE   CourseId = 'DMIT152'

--4.b   Select how many students are or have been in DMIT152
--      SELECT * FROM Registration WHERE CourseId = 'DMIT152'
SELECT  COUNT(StudentID)
FROM    Registration
WHERE   CourseId = 'DMIT152'
    -- BTW, what course is 'DMIT152'???
    SELECT  CourseName
    FROM    Course
    WHERE   CourseId = 'DMIT152'

--5.	Select the average payment amount for payment type 5
-- TODO: Student Answer Here - Hint: It's in the Payment table....


-- Given that there are some other aggregate methods like MAX(columnName) and MIN(columnName), complete the following two questions:
--6. Select the highest payment amount
-- TODO: Student Answer Here


--7.	 Select the lowest payment amount
-- TODO: Student Answer Here


--8. Select the total of all the payments that have been made
-- TODO: Student Answer Here

--9. How many different payment types does the school accept?
-- Do a bit of exploratory selects
SELECT PaymentTypeDescription
FROM   PaymentType
-- TODO: Student Answer Here

--10. How many students are in club 'CSS'?
-- TODO: Student Answer Here

