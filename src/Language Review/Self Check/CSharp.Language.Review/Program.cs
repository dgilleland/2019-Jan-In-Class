// Identifies the namespaces containing the data type(s)
// that we want to use (or reference) in the code in this
// file.
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

// Declares an "area" or named-space in which we can
// place our programmer-defined data types.
namespace CSharp.Language.Review
{
    // The namespace plus the class name is what's called
    // a "fully-qualified" class name.
    // The fully-qualified class name for Program is
    //     CSharp.Language.Review.Program
    public class Program
    {
        // A static field initialized to a new Random object
        private static Random rnd = new Random();

        // Main() is the entry point
        public static void Main(string[] args)
        {
            // The body of the Main() method
            // acts as the "driver" of my application.
            Program app = new Program(args);

            app.AssignMarks(30, 80);

            foreach (Student person in app.Students)
            {
                System.Console.WriteLine("Name: " + person.Name);
                foreach (EarnedMark item in person.Marks)
                    System.Console.WriteLine("\t" + item);
            }
        }

        // This field is acting as a "backing store"
        // for the Students property.
        private List<Student> _students = new List<Student>();

        // This property provides "controlled access"
        // to the data in the backing store (the field).
        public List<Student> Students
        {
            get { return _students; }
            set { _students = value; }
        }

        // This is a constructor.
        // The job of a constructor is to ensure
        // that all of the fields/properties
        // have "meaningful" values.
        public Program(string[] studentNames)
        {
            WeightedMark[] CourseMarks = new WeightedMark[4];
            CourseMarks[0] = new WeightedMark("Quiz 1", 20);
            CourseMarks[1] = new WeightedMark("Quiz 2", 20);
            CourseMarks[2] = new WeightedMark("Exercises", 25);
            CourseMarks[3] = new WeightedMark("Lab", 35);
            int[] possibleMarks = new int[4] { 25, 50, 12, 35 };

            foreach (string name in studentNames)
            {
                EarnedMark[] marks = new EarnedMark[4];
                for (int i = 0; i < possibleMarks.Length; i++)
                    marks[i] = new EarnedMark(CourseMarks[i], possibleMarks[i], 0);
                Students.Add(new Student(name, marks));
            }
        }

        /// <summary>
        /// This assigns a random mark to each student
        /// in the <see cref="Students"/> property.
        /// </summary>
        /// <param name="min">The minimum possible earned value for the student's mark</param>
        /// <param name="max">The maximum possible earned value for the student's mark</param>
        public void AssignMarks(int min, int max)
        {
            foreach (Student person in Students)
                foreach (EarnedMark item in person.Marks)
                    item.Earned = (rnd.Next(min, max) / 100.0) * item.Possible;
        }
    }
}
