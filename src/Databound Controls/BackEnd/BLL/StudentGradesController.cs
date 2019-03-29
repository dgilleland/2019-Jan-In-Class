using BackEnd.BLL.Commands;
using BackEnd.BLL.Queries;
using BackEnd.DataModels.School;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BackEnd.BLL
{
    [DataObject]
    public class StudentGradesController
    {
        #region In-Memory Database
        internal static Dictionary<string, Course> CourseDb = new Dictionary<string, Course>();
        internal static Dictionary<string, Dictionary<string, List<AssignedGrade>>> GradesDb = new Dictionary<string, Dictionary<string, List<AssignedGrade>>>();
        #endregion

        #region Command Processing
        public void CreateCourse(CourseOffering commandData, int enrollmentCount, IEnumerable<WeightedItem> assignments)
        {
            var violations = new BusinessRuleException(nameof(CreateCourse));
            // 0) Validate input
            if (CourseDb.ContainsKey(commandData.CourseName))
                violations.Errors.Add(new ArgumentException("Course is already registered"));
            // TODO: Other validation
            //  - Max students between 5 and 15
            if (enrollmentCount < 5 || enrollmentCount > 15)
                violations.Errors.Add(new ArgumentException("Max number of students must be between 5 and 15"));
            //  - Total assignment weight must be exactly 100.
            if (assignments == null)
                violations.Errors.Add(new ArgumentNullException(nameof(assignments), "Missing a collection of weighted items"));
            else
            {
                if (assignments.Count() < 2)
                    violations.Errors.Add(new ArgumentException("There must be at least two assignments for a course"));
                if (assignments.Any(x => x == null))
                    violations.Errors.Add(new ArgumentNullException(nameof(assignments), "One or more of the weighted items is null"));
                if (assignments.Sum(x => x.Weight) != 100)
                    violations.Errors.Add(new ArgumentException("Assignments must total to 100% for the course"));
                if (assignments.Any(x => x.Weight <= 0))
                    violations.Errors.Add(new ArgumentException("Assignment weights must be greater than zero"));
            }
            if (violations.Errors.Any()) // if there are any errors
                throw violations;

            // 1) Create the course
            var course = new Course
            {
                CourseName = commandData.CourseName,
                StartDate = commandData.StartDate
            };

            // 2) Add the assignments
            int id = 0;
            foreach (var item in assignments)
                course.Assignments.Add(new Assignment
                {
                    AssignmentID = id++,
                    Name = item.AssignmentName,
                    WeightedValue = item.Weight
                });

            // 3) Enroll some students
            var faker = new StudentFaker();
            course.Students.AddRange(faker.Generate(enrollmentCount));

            // 4) "Save" to the "database"
            CourseDb.Add(course.CourseName, course);
        }
        #endregion

        #region Queries
        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<CourseSummary> ExistingCourses()
        {
            var result = from data in CourseDb.Values
                         select new CourseSummary
                         {
                             CourseName = data.CourseName,
                             StartDate = data.StartDate,
                             EnrolledStudentCount = data.Students.Count,
                             Evaluations = string.Join(", ", data.Assignments)
                         };
            return result.ToList();
        }

        public IEnumerable<StudentInfo> ListStudentsInClass(string courseName, DateTime dateTime)
        {
            var result = from data in CourseDb.Values
                         where data.CourseName == courseName
                            && data.StartDate == dateTime
                         from person in data.Students
                         select new StudentInfo
                         {
                             GivenName = person.FirstName,
                             Surname = person.LastName,
                             Id = person.StudentID
                         };
            return result;
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public IEnumerable<AssignmentInfo> ListAssignments(string selectedValue)
        {
            var result = from data in CourseDb.Values
                         where data.CourseName == selectedValue
                         from work in data.Assignments
                         select new AssignmentInfo
                         {
                             Name = work.Name,
                             Description = $"{work.Name} ({work.WeightedValue} %)"
                         };
            return result;
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public IEnumerable<StudentMark> ListStudentGrades(string courseName, string assignmentName)
        {
            if(GradesDb.ContainsKey(courseName))
            {
                // Get the data from the GradesDb
                var grades = GradesDb[courseName][assignmentName];
                var course = CourseDb[courseName];
                List<StudentMark> marks = new List<StudentMark>();
                foreach (var item in grades)
                {
                    marks.Add(new StudentMark
                    {
                        EarnedMarks = item.EarnedMarks,
                        PossibleMarks = item.PossibleMarks,
                        StudentID = item.StudentID,
                        GivenName = course.Students.Single(x => x.StudentID == item.StudentID).FirstName,
                        Surname = course.Students.Single(x => x.StudentID == item.StudentID).LastName
                    });
                }
                return marks;
            }
            else
            {
                // Make up a list of "empty" student marks
                var course = CourseDb[courseName];
                List<StudentMark> marks = new List<StudentMark>();
                foreach(var student in course.Students)
                {
                    var assignment = course.Assignments.Single(x => x.Name == assignmentName);
                    marks.Add(new StudentMark
                    {
                        GivenName = student.FirstName,
                        Surname = student.LastName,
                        StudentID = student.StudentID
                    });
                }
                return marks;
            }
        }

        public void ProcessMarks(string courseName, string assignmentName, IEnumerable<AssignedGrade> grades)
        {

        }
        #endregion
    }

    public class AssignmentInfo
    {
        public string Name { get; set; }
        public string Description { get; set; }
    }
    public class StudentInfo
    {
        public string GivenName { get; set; }
        public string Surname { get; set; }
        public int Id { get; internal set; }
    }
    public class StudentMark : AssignedGrade
    {
        public string GivenName { get; set; }
        public string Surname { get; set; }
    }
    public class AssignedGrade
    {
        public int PossibleMarks { get; set; }
        public double EarnedMarks { get; set; }
        public int StudentID { get; set; }
    }
}
