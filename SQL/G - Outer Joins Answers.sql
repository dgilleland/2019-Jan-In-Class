USE [A01-School]
GO

--5. How many students are in each club? Display club name and count.
-- TODO: Student Answer Here...
SELECT  ClubName,
        COUNT(Studentid) AS 'StudentCount'
FROM    Club
    LEFT OUTER JOIN Activity
        ON Club.ClubId = Activity.ClubId
GROUP BY ClubName

--6. How many times has each course been offered? Display the course ID and course name along with the number of times it has been offered.
-- TODO: Student Answer Here...
SELECT  C.CourseId, C.CourseName, COUNT(R.CourseId) AS 'Offerings'
FROM    Course AS C
    LEFT OUTER JOIN Registration AS R
        ON C.CourseId = R.CourseId
GROUP BY C.CourseId, C.CourseName

--7. How many courses have each of the staff taught? Display the full name and the count.
-- TODO: Student Answer Here...
--   One way of interpreting the question is to think of the number of courses as being the number of times the staff has taught a course (even if it's a course they have taught before).
SELECT  FirstName + ' ' + LastName,
        COUNT(R.CourseId) AS 'CourseCount'
FROM    Staff AS S
    LEFT OUTER JOIN Registration AS R ON S.StaffID = R.StaffID
GROUP BY FirstName, LastName

--   Another way of interpreting the question is to think of the number of "kinds" of courses the staff has taught
SELECT  FirstName + ' ' + LastName,
       COUNT(DISTINCT CourseId) AS 'CourseCount'
FROM    Staff AS S
   LEFT OUTER JOIN Registration AS R ON S.StaffID = R.StaffID
GROUP BY FirstName, LastName


--8. How many second-year courses have the staff taught? Include all the staff and their job position.
--   A second-year course is one where the number portion of the course id starts with a '2'.
SELECT  PositionDescription,
        FirstName + ' ' + LastName AS 'StaffName',
        COUNT(CourseId) AS 'CourseCount'
FROM    Position AS P
    -- Use an INNER join to only include positions with staff members
    --INNER JOIN Staff AS S ON P.PositionID = S.PositionID
    LEFT OUTER JOIN Staff AS S ON P.PositionID = S.PositionID
    LEFT OUTER JOIN Registration AS R ON S.StaffID = R.StaffID
WHERE   CourseId LIKE '____2%' -- An underscore means a single character
   OR   CourseId IS NULL -- Now I will get staff that haven't taught a course
GROUP BY PositionDescription, FirstName, LastName
--   Another way of interpreting the question is to think of the number of "kinds" of courses the staff has taught
SELECT  PositionDescription,
        FirstName + ' ' + LastName AS 'StaffName',
        COUNT(DISTINCT CourseId) AS 'CourseCount'
FROM    Position AS P
    -- Use an INNER join to only include positions with staff members
    --INNER JOIN Staff AS S ON P.PositionID = S.PositionID
    LEFT OUTER JOIN Staff AS S ON P.PositionID = S.PositionID
    LEFT OUTER JOIN Registration AS R ON S.StaffID = R.StaffID
WHERE   CourseId LIKE '____2%' -- An underscore means a single character
   OR   CourseId IS NULL -- Now I will get staff that haven't taught a course
GROUP BY PositionDescription, FirstName, LastName

--9. What is the average payment amount made by each student? Include all the students,
--   and display the students' full names.
SELECT  FirstName + ' ' + LastName AS 'Student',
        AVG(Amount) AS 'AveragePayment'
FROM    Student AS S 
    LEFT OUTER JOIN Payment AS P
        ON S.StudentID = P.StudentID
GROUP BY FirstName, LastName

--10. Display the names of all students who have not made a payment.
SELECT  FirstName + ' ' + LastName AS 'StudentName'
FROM    Student AS S
    LEFT OUTER JOIN Payment AS P
        ON S.StudentID = P.StudentID
WHERE   P.StudentID IS NULL -- Where the Payment does not exist
