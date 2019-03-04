--Outer Joins Exercise
USE [A01-School]
GO

--1. Select All position descriptions and the staff ID's that are in those positions
SELECT  PositionDescription, StaffID
FROM    Position P -- Start with the Position table, because I want ALL position descriptions...
    LEFT OUTER JOIN Staff S ON P.PositionID = S.PositionID

--2. Select the Position Description and the count of how many staff are in those positions. Return the count for ALL positions.
--HINT: Count can use either count(*) which means the entire "row", or "all the columns".
--      Which gives the correct result in this question?
SELECT  PositionDescription,
        COUNT(StaffID) AS 'Number of Staff'
FROM    Position P
    LEFT OUTER JOIN Staff S ON P.PositionID = S.PositionID
GROUP BY P.PositionDescription
-- but -- The following version gives the WRONG results, so just DON'T USE *  !
SELECT PositionDescription, 
       Count(*) -- this is counting the WHOLE row (not just the Staff info)
FROM   Position P
    LEFT OUTER JOIN Staff S
        ON P.PositionID = S.PositionID
GROUP BY P.PositionDescription

--3. Select the average mark of ALL the students. Show the student names and averages.
SELECT  FirstName  + ' ' + LastName AS 'Student Name',
        AVG(Mark) AS 'Average'
FROM    Student S
    LEFT OUTER JOIN Registration R
        ON S.StudentID  = R.StudentID
GROUP BY FirstName, LastName

--4. Select the highest and lowest mark for each student. 
SELECT  FirstName  + ' ' + LastName AS 'Student Name',
        MAX(Mark) AS 'Highest',
		MIN(Mark) 'Lowest'
FROM    Student S
    LEFT OUTER JOIN Registration R
        ON S.StudentID  = R.StudentID
GROUP BY FirstName, LastName

--5. How many students are in each club? Display club name and count.
-- TODO: Student Answer Here...

--6. How many times has each course been offered? Display the course ID and course name along with the number of times it has been offered.
-- HINT: Run the following to add some more rows to your Course table.
INSERT INTO Course(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
VALUES  ('DMIT115', 'Visual SQL', 60, 12, 500),
        ('DMIT175', 'Database Programming', 60, 12, 500),
        ('DMIT228', 'Advanced Application Development', 60, 12, 500),
        ('DMIT215', 'Database Administration', 60, 12, 500)

-- TODO: Student Answer Here...

--7. How many courses have each of the staff taught? Display the full name and the count.
-- TODO: Student Answer Here...

--8. How many second-year courses have the staff taught? Include all the staff and their job position.
--   A second-year course is one where the number portion of the course id starts with a '2'.

--9. What is the average payment amount made by each student? Include all the students,
--   and display the students' full names.

--10. Display the names of all students who have not made a payment.
