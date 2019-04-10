using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnderstandingTryParse
{
    class Program
    {
        static void Main(string[] args)
        {
            if ('0' != 0)
                Console.WriteLine("They are different");

            Console.Write("What is your age? ");
            string userInput = Console.ReadLine();
            int age;

            if(TryToParseDigit(userInput, out age))
            {
                Console.WriteLine("You are young!");
            }

            if(int.TryParse(userInput, out age))
            {
                if (age < 0)
                    Console.WriteLine("I don't believe you");
                // Use string.Format to make a message and then display it
                string message = string.Format("You are {0} years old.", age);
                Console.WriteLine(message);
                // Uses the version of WriteLine that builds the string with String.Format
                Console.WriteLine("You are {0} years old.", age);
                // Use "string interpolation"
                Console.WriteLine($"You are {age} years old.");
            }
            else
            {
                Console.WriteLine($"I don't understand '{userInput}' as a number.");
            }
        }


        static bool TryToParseDigit(string text, out int result)
        {
            bool success = false; // pessimistically

            if(!string.IsNullOrEmpty(text) && text.Length == 1)
            {
                switch(text)
                {
                    case "0":
                        result = 0;
                        break;
                    case "1":
                        result = 1;
                        break;
                    case "2":
                        result = 2;
                        break;
                    case "3":
                        result = 3;
                        break;
                    case "4":
                        result = 4;
                        break;
                    case "5":
                        result = 5;
                        break;
                    case "6":
                        result = 6;
                        break;
                    case "7":
                        result = 7;
                        break;
                    case "8":
                        result = 8;
                        break;
                    case "9":
                        result = 9;
                        break;
                    default:
                        result = -1;
                        break;
                }
            }
            else
            {
                result = -1;
            }
            return success;
        }
    }
}
