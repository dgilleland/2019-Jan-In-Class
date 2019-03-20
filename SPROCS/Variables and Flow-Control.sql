-- Variables and Flow Control



DECLARE @Cost money
SET @Cost = (Select CourseCost FROM Course WHERE CourseId = 'DMIT101')
PRINT @Cost
