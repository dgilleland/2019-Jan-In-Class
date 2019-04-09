using FluentAssertions;
using AdHocSchool.BLL;
using AdHocSchool.Specs.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xunit;
// This is an alias to the class with the long name
using Factory = AdHocSchool.Specs.TestData.StudentRegistrationFactory;

namespace AdHocSchool.Specs
{
    public class First_Term_Student_Registrations_Must
    {
        // Sut stands for "Situation Under Test"
        private RegistrationController Sut => new RegistrationController();

        [Fact, AutoRollback]
        public void Reject_Null_Data()
        {
            // - Validate for null
            var errors = Assert.Throws<ArgumentNullException>(() => Sut.RegisterFirstTermStudents(null));
        }

        [Fact, AutoRollback]
        public void Reject_Empty_List_Of_Students()
        {
            // - Validate for student ids not being empty
            // Arrange - doing setup for the test
            var givenData = Factory.Instance.WithoutStudents().Build();

            // Act - using the system that you are testing
            // Assert - making sure it behaved as expected
            var error = Assert.Throws<ArgumentException>(() => Sut.RegisterFirstTermStudents(givenData));
        }

        [Fact, AutoRollback]
        public void Reject_Past_Years()
        {
            // - Validate for future/upcoming year
            var givenData = Factory.Instance.WithSchoolYear(2015).Build();
            var error = Assert.Throws<BusinessRuleException>(() => Sut.RegisterFirstTermStudents(givenData));
        }

        [Fact, AutoRollback]
        public void SelfCheck_FirstTermRegistrations()
        {
            var given = Factory.Instance.Build();
            var actual = Factory.Instance.ListFirstTermRegistrations(given.Semester);
            actual.Should().NotBeNull();
            actual.Should().BeEmpty();
        }

        // TODO:
        // - Validate students exist
        // - Register students in existing courses
        // - Bill students for a semester's tuition ($1940)
    }
}
