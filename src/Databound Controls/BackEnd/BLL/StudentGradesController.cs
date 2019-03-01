using BackEnd.BLL.Commands;
using BackEnd.DataModels.School;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BackEnd.BLL
{
    public class StudentGradesController
    {
        internal static Dictionary<string, Course> CourseDb = new Dictionary<string, Course>();

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
    }
}
