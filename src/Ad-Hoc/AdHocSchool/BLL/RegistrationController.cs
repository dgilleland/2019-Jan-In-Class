using AdHocSchool.DataModels;
using System;
using System.Collections.Generic;
using System.Data.Entity; // for the .Include(x => x.property) code
using System.Linq; // for the LINQ extension methods.
using System.Text;
using System.Threading.Tasks;

namespace AdHocSchool.BLL
{
    /// <summary>
    /// This controller is used to register students in courses.
    /// </summary>
    public class RegistrationController
    {
        /// <summary>
        /// Registers a set of students for first-term courses (course id is "xxxx1#x"
        /// where the 1 indicates first year and the # is a first-term course when
        /// the number is less than 5).
        /// </summary>
        /// <param name="cohort"></param>
        public void RegisterFirstTermStudents(StudentRegistration cohort)
        {
            // first validation test
            if (cohort == null)
                throw new ArgumentNullException(nameof(cohort));
            // second test
            if (cohort.StudentIds == null || cohort.StudentIds.Count == 0)
                throw new ArgumentException("Must have at least one student to register for first term courses");

            // The following validations will be based on having actual data rather than
            // on the absense of data
            var errors = new List<Exception>(); // to "gather" the errors

            // Make sure the year is not in the past
            if (cohort.Year < DateTime.Today.Year)
                errors.Add(new Exception("Cannot register students for a school year in the past"));

            if (errors.Any())
                throw new BusinessRuleException($"Errors in {nameof(RegisterFirstTermStudents)}", errors);

            using (var context = new AdHocSchool.DAL.AdHocContext())
            {
                // 1) Get a list of all the first-term courses
                // Simple from LinqPad, but harder in Entity Framework
                // Courses.Where(x => x.CourseId[4] == '1' && x.CourseId[5] < '5')
                var firstTermCourses = from data in context.Courses
                                       where data.CourseId.StartsWith("DMIT1")
                                          && (data.CourseId.Substring(4, 1) == "0"
                                          || data.CourseId.Substring(4, 1) == "1"
                                          || data.CourseId.Substring(4, 1) == "2"
                                          || data.CourseId.Substring(4, 1) == "3"
                                          || data.CourseId.Substring(4, 1) == "4")
                                       select data.CourseId;

                // 2) Loop through the list of student Ids to register them into those courses
                foreach(var id in cohort.StudentIds)
                {
                    // Get my student, with the Registration information for the student
                    var student = context.Students
                                  .Include(x => x.Registrations)
                                  .Single(x => x.StudentID == id);
                    // Add them to my courses
                    foreach(var courseId in firstTermCourses)
                    {
                        student.Registrations.Add(new Entities.Registration
                        {
                            CourseId = courseId,
                            Semester = cohort.Semester,
                            StudentID = id
                        });
                    }
                    // Bill the student for the course
                    student.BalanceOwing += 1980;
                    context.Entry(student).State = EntityState.Modified;
                    // or
                    // context.Entry(student).Property(x => x.BalanceOwing).IsModified = true;
                }

                // A single .SaveChanges() to do the transaction
                context.SaveChanges();
            }
        }
    }
}
