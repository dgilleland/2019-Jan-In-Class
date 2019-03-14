using BackEnd.BLL.Commands;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BackEnd.BLL
{
    public static class FakeUniversity
    {
        public static void FakeItToMakeIt()
        {
            var controller = new StudentGradesController();
            foreach(var course in GoodCourses)
            {
                controller.CreateCourse(course, 15, StandardEvaluations);
            }
        }

        static IEnumerable<CourseOffering> GoodCourses
        {
            get
            {
                yield return new CourseOffering("OOP Fundamentals", new DateTime(2019, 9, 7));
                yield return new CourseOffering("Modern Web Frameworks", new DateTime(2019, 9, 7));
                yield return new CourseOffering("Cloud-Based Application Development", new DateTime(2019, 9, 7));
            }
        }

        static IEnumerable<WeightedItem> StandardEvaluations
        {
            get
            {
                yield return new WeightedItem { AssignmentName = "Quiz 1", Weight = 15 };
                yield return new WeightedItem { AssignmentName = "Quiz 2", Weight = 20 };
                yield return new WeightedItem { AssignmentName = "Lab 1", Weight = 10 };
                yield return new WeightedItem { AssignmentName = "Lab 2", Weight = 10 };
                yield return new WeightedItem { AssignmentName = "Quiz 3", Weight = 25 };
                yield return new WeightedItem { AssignmentName = "Project", Weight = 20 };
            }
        }
    }
}
