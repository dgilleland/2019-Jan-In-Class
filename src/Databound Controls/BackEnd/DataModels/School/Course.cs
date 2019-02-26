using System;
using System.Collections.Generic;

namespace BackEnd.DataModels.School
{
    internal class Course
    {
        public string CourseName { get; set; }
        public DateTime StartDate { get; set; }

        public List<Assignment> Assignments = new List<Assignment>();
        public List<Student> Students = new List<Student>();
    }
}
