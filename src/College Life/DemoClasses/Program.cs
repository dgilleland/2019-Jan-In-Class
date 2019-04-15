using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DemoClasses
{
    class Program
    {
        #region Driver
        // The ONLY method that should be static is the Main method!!!
        static void Main(string[] args)
        {
            Program myApp = new Program();
            myApp.Run();
        }

        private void Run()
        {
            // Load up with people
            for(LogicalSize = 0; LogicalSize < People.Length - 1; LogicalSize++)
            {
                People[LogicalSize] = GetPersonData();
            }

            DisplayPeople();

            // TODO: Marry them off
            // Quick hack - should probably be in a method
            // $"about {data}" -- string interpolation
            Console.WriteLine($"\n{People[0].FirstName} asks {People[1].FirstName} to marry him");
            People[1].Marry(People[0], true);

            DisplayPeople();
        }
        #endregion

        #region Fields/Constructor
        private Person[] People;
        private int LogicalSize = 0;
        public Program()
        {
            // Create an array
            People = new Person[5];
        }
        #endregion

        #region User Input/Output Methods
        private Person GetPersonData()
        {
            return new Person
            {   // This is an Initializer List. It's where you set
                // values to public properties of the class
                // when the object is created, but AFTER the
                // constructor runs.
                FirstName = Prompt("Enter a first Name: "),
                LastName = Prompt("Enter a last Name: "),
                DateOfBirth = PromptDate("Enter your birthdate: ", 18)
            };
        }

        private string Prompt(string message)
        {
            Console.Write(message);
            return Console.ReadLine();
        }

        private DateTime PromptDate(string message, int minAge)
        {
            DateTime when;
            do
            {
                string whenText = Prompt(message);
                if (!DateTime.TryParse(whenText, out when))
                    Console.WriteLine("\tInvalid date");
            } while (when == DateTime.MinValue);
            return when;
        }

        private void DisplayPeople()
        {
            foreach(var person in People)
            {
                Console.WriteLine(person);
            }
        }
        #endregion
    }

    public class Person
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime DateOfBirth { get; set; }

        //public Person(string givenName, string surname, DateTime birthdate)
        //{
        //    FirstName = givenName;

        //}

        // Override the default behaviour of .ToString()
        public override string ToString()
        {
            var age = DateTime.Today.Year - DateOfBirth.Year;
            return $"Hi, my name is {FirstName} {LastName}.";
        }

        public void Marry(Person spouse, bool takeSpouseLastName)
        {
            if (takeSpouseLastName)
                this.LastName = spouse.LastName;
        }
    }
}
