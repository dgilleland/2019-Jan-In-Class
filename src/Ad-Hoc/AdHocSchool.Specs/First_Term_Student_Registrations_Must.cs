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
        public void Ensure_Students_Exist()
        {
            // - Validate students exist
            var givenData = Factory.Instance.WithStudentIds(0, -1, 77777).Build();
            var error = Assert.Throws<BusinessRuleException>(() => Sut.RegisterFirstTermStudents(givenData));
            error.Errors.Count.Should().Be(3, because: "3 false student Ids were sent to the BLL");
        }

        #region Just a little self-check for getting first term registrations
        [Fact, AutoRollback]
        public void SelfCheck_FirstTermRegistrations()
        {
            var given = Factory.Instance.Build();
            var actual = Factory.Instance.ListFirstTermRegistrations(given.Semester);
            actual.Should().NotBeNull();
            actual.Should().BeEmpty();
        }
        #endregion

        [Fact, AutoRollback]
        public void Register_Students_In_Existing_Courses()
        {
            // - Register students in existing courses
            // Arrange
            var given = Factory.Instance.Build();
            var expectedCourses = Factory.Instance.ListFirstTermCourses();

            // Act
            Sut.RegisterFirstTermStudents(given);

            // Assert
            var dbChanges = Factory.Instance.ListFirstTermRegistrations(given.Semester);
            var actual = dbChanges.GroupBy(x => x.StudentID);
            foreach(var studentCourses in actual)
            {
                studentCourses.Count().Should().Be(expectedCourses.Count, because: $"The student should have been registered in {expectedCourses.Count} courses");
                foreach (var course in studentCourses)
                    expectedCourses.Should().Contain(course.CourseId, because: "The student should be registered in the correct course");
            }
        }

        [Fact, AutoRollback]
        public void Bill_Students_For_One_Semester()
        {
            // - Bill students for a semester's tuition ($1980)
            // Arrange
            var given = Factory.Instance.Build();
            var expectedCourses = Factory.Instance.ListFirstTermCourses();

            // Act
            Sut.RegisterFirstTermStudents(given);

            // Assert
            var dbChanges = Factory.Instance.ListFirstTermRegistrations(given.Semester);
            var actual = dbChanges.GroupBy(x => x.Student);
            foreach (var student in actual)
            {
                student.Key.BalanceOwing.Should().Be(1980);
            }
        }
    }
}
