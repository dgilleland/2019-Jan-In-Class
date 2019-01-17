using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSharp.Language.Review
{
    public class Student // by default, inherit from the built-in class called Object
    {
        public string Name { get; private set; }
        public EarnedMark[] Marks { get; private set; }

        public Student(string name, EarnedMark[] marks)
        {
            Name = name;
            Marks = marks;
        }
    }
}
