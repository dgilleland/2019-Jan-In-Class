using AdHocSchool.DAL;
using AdHocSchool.DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AdHocSchool.Specs.TestData
{
    public class StudentRegistrationFactory
    {
        #region Factory Setup
        private StudentRegistration _data;
        public static StudentRegistrationFactory Instance => new StudentRegistrationFactory();
        private StudentRegistrationFactory()
        {
            _data = new StudentRegistration
            {
                Month = StudentRegistration.Term.SEP,
                Year = DateTime.Today.Year,
                StudentIds = UnregisteredStudents
            };
        }
        private static List<int> _students;
        private static List<int> UnregisteredStudents
        {
            get
            {
                if (!_students.Any())
                    using (var context = new AdHocContext())
                    {
                        _students = context.Students.Where(x => x.Registrations.Count == 0).Select(x => x.StudentID).ToList();
                    }
                return new List<int>(_students); // shallow clone
            }
        }
        #endregion

        #region Factory Methods
        public StudentRegistration Build()
        {
            return _data;
        }
        #endregion
    }
}
