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
            // 0) Validate input
            if (CourseDb.ContainsKey(commandData.CourseName))
                throw new ArgumentException("Course is already registered");
            // TODO: Other validation
            //  - Max students between 5 and 15
            if (enrollmentCount < 5 || enrollmentCount > 15)
                throw new ArgumentException("Max number of students must be between 5 and 15");
            //  - Total assignment weight must be exactly 100.
            if (assignments == null)
                throw new ArgumentNullException(nameof(assignments), "Missing a collection of weighted items");
            if (assignments.Count() < 2)
                throw new ArgumentException("There must be at least two assignments for a course");
            if (assignments.Any(x => x == null))
                throw new ArgumentNullException(nameof(assignments), "One or more of the weighted items is null");
            if (assignments.Sum(x => x.Weight) != 100)
                throw new ArgumentException("Assignments must total to 100% for the course");
            if (assignments.Any(x => x.Weight <= 0))
                throw new ArgumentException("Assignment weights must be greater than zero");

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
