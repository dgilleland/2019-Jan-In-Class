using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AssortedConcepts
{
    class Program
    {
        static void Main(string[] args)
        {
            AboutDataTypes();
            //AboutTryParse();
        }

        private static void AboutDataTypes()
        {
            const string about = "The {0} data type has a min value of {1} and a max value of {2}";
            Console.WriteLine(about, "int", int.MinValue, int.MaxValue);
            Console.WriteLine(about, "short", short.MinValue, short.MaxValue);
            Console.WriteLine(about, "long", long.MinValue, long.MaxValue);
            Console.WriteLine(about, "double", double.MinValue, double.MaxValue);

        }

        static void AboutTryParse()
        {
            Console.Write("What's your favorite color? ");
            string input = Console.ReadLine();
            Crayola result;
            if (Crayola.TryParse(input, out result))
                Console.WriteLine($"So you like {result.Color}");
            else
                Console.WriteLine($"I don't know that color, so I'll call it {result.Color}");
            // Try again
            Console.Write("What's your second favorite color? ");
            input = Console.ReadLine();
            Crayola.TryParse(input, out result);
            Console.WriteLine($"So you like {result.Color}");

        }

        static void AboutDateTime()
        {
            DateTime startOfCourse; // System.DateTime - Based on the Gregorian Calendar
            DateTime endOfCourse;
            startOfCourse = new DateTime(2019, 1, 7);
            endOfCourse = startOfCourse.AddMonths(4);
            var lengthOfCourse = endOfCourse - startOfCourse;
            Console.WriteLine(DateTime.Now);
            Console.WriteLine(DateTime.Today);
            if (endOfCourse > DateTime.Today)
                Console.WriteLine("Still more to learn....");
            else
                Console.WriteLine("Time for a break!");

            string fromTheBrowser = "Jan 25, 2020";
            DateTime firstJobOffer = DateTime.Parse(fromTheBrowser); // Failure to convert => exception

            if (DateTime.TryParse("Bob", out firstJobOffer)) // .TryParse returns a bool
                Console.WriteLine("How is that a datetime?");
            Console.WriteLine($"Note the date change: {firstJobOffer}");
        }

        static void DemoClasses()
        {
            Person me, you;
            me = new Person { FirstName = "Dan", LastName = "Gilleland", DateOfBirth = new DateTime(1975, 7, 8) };
            you = new Person { FirstName = "Wilma", LastName = "Flintstone", DateOfBirth = new DateTime(1978, 12, 20) };
            Display(me);
            Display(you);
        }
        static void Display(Person someone)
        {
            //
        }
    }
    public class Company // An example of a DTO
    {
        // Has the same overal purpose as a POCO,
        // but the data types of the properties/fields
        // can include other classes/types defined by
        // the developer or 3rd party libraries
        public string Name { get; set; }
        public DateTime DateOfIncorporation { get; set; }
        public Person CEO { get; set; } // <-- Person class makes this Company class a DTO

    }
    public class Person // An example of a POCO
    {
        // The focus is on Properties/Fields to hold data
        // making it easy to move around a set of related information
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime DateOfBirth { get; set; }

        // Little to no methods on this class
    }
}
