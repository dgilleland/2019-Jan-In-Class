using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BackEnd.BLL.Queries
{
    public class CourseSummary
    {
        public string CourseName { get; set; }
        public DateTime StartDate { get; set; }
        public int EnrolledStudentCount { get; set; }
        public string Evaluations { get; set; }
    }
    public class StudentMark
    {
        public int StudentID { get; set; }
        public int AssignmentID { get; set; }
        public double EarnedMarks { get; set; }
    }
}
