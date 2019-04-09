using AdHocSchool.DataModels;
using System;
using System.Collections.Generic;
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

            // Courses.Where(x => x.CourseId[4] == '1' && x.CourseId[5] < '5')
        }
    }
}
