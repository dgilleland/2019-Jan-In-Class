using AdHocSchool.DataModels;
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
            // Courses.Where(x => x.CourseId[4] == '1' && x.CourseId[5] < '5')
        }
    }
}
