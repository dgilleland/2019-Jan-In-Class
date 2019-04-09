using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AdHocSchool.DataModels
{
    /// <summary>
    /// Represents a set of students to be registered for 
    /// a specific term intake in a specific year.
    /// </summary>
    public class StudentRegistration
    {
        /// <summary>
        /// A enumerated data type of the months in which school terms start
        /// </summary>
        public enum Term { SEP, JAN, MAY } // an enumeration is a primitive set of named constants

        /// <summary>
        /// The school term in which this specific cohort of students is being registered.
        /// </summary>
        public Term Month { get; set; }

        /// <summary>
        /// The calendar year corresponding with the <see cref="Month"/> of the school term.
        /// </summary>
        public int Year { get; set; }

        /// <summary>
        /// Is a calculation of the school term and year to produce a value that matches the
        /// expectations of the school database.
        /// </summary>
        public string Semester => $"{Year}{Month.ToString()[0]}";

        /// <summary>
        /// A list of student Ids that presumably exist in the database.
        /// </summary>
        public ICollection<int> StudentIds { get; set; }
            = new HashSet<int>();
    }
}
