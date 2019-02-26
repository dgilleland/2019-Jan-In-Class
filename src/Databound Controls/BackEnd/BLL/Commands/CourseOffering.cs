using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BackEnd.BLL.Commands
{
    public class CourseOffering
    {
        public readonly string CourseName;
        public readonly DateTime StartDate;
        public CourseOffering(string courseName, DateTime startDate)
        {
            if (string.IsNullOrWhiteSpace(courseName))
                throw new ArgumentNullException(nameof(courseName), "Course name cannot be empty");
            if (startDate.Equals(DateTime.MinValue))
                throw new ArgumentException("You must supply a start date", nameof(startDate));

            CourseName = courseName.Trim();
            StartDate = startDate;
        }
    }
}
