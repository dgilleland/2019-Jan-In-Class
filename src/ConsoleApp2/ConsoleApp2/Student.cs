using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp2
{
    class Student
    {
        public int StudentID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        private string _MiddleName; // field as backing store
        public string MiddleName
        {
            get { return _MiddleName; }
            set
            {
                if (string.IsNullOrWhiteSpace(value))
                    _MiddleName = null;
                else
                    _MiddleName = value.Trim();
            }
        }
        public string FullName
        {
            get
            {
                return 
            }
        }
    }
}
