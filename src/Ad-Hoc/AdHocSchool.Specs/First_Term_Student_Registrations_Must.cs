using AdHocSchool.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xunit;
using Factory = AdHocSchool.Specs.TestData.StudentRegistrationFactory;

namespace AdHocSchool.Specs
{
    public class First_Term_Student_Registrations_Must
    {
        // Sut stands for "Situation Under Test"
        private RegistrationController Sut => new RegistrationController();

        [Fact]
        public void Reject_Null_Data()
        {
            var errors = Assert.Throws<ArgumentNullException>(() => Sut.RegisterFirstTermStudents(null));
        }


    }
}
