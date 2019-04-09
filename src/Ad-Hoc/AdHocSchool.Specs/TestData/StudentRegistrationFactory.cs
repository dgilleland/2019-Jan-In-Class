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
        private StudentRegistration _data;
        public static StudentRegistrationFactory Instance => new StudentRegistrationFactory();
        private StudentRegistrationFactory()
        {
            _data = new StudentRegistration
            {
                Month = StudentRegistration.Term.SEP,
                Year = DateTime.Today.Year
            };
            using (var context = new AdHocContext())
            {
                var students = context.Students.Where(x => x.Registrations.Count == 0).Select(x => x.StudentID).ToList();
                _data.StudentIds = students;
            }
        }
    }
}
