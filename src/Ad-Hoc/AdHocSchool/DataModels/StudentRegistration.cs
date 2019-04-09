using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AdHocSchool.DataModels
{
    public class StudentRegistration
    {
        public enum Term { SEP, JAN, MAY}
        public Term Month { get; set; }
        public int Year { get; set; }
        public string Semester => $"{Month.ToString()[0]}{Year}";

        public ICollection<int> StudentIds { get; set; }
            = new HashSet<int>();
    }
}
