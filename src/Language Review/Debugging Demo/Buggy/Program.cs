using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Buggy
{
    class Program
    {
        #region Driver Methods
        static void Main(string[] args)
        {
            DisplayAbout();
            string menuChoice;
            do
            {
                Console.ForegroundColor = ConsoleColor.Cyan;
                Console.WriteLine("Demo Looping");
                Console.WriteLine("============");

                // The main "work" of the driver
                DisplayMenu();
                menuChoice = Console.ReadLine().ToUpper();
                ProcessMenuChoice(menuChoice);
            } while (menuChoice != "X");
        }

        private static void DisplayMenu()
        {
            Console.ForegroundColor = ConsoleColor.DarkGreen;

            Console.WriteLine("A) About Page");
            Console.WriteLine("B) Bad Logic");
            Console.WriteLine("C) Continuous Loop");
            Console.WriteLine("D) Double or Nothing");
            Console.WriteLine("E) Extreme Recursion");
            Console.WriteLine("X) eXit");
            Console.ResetColor(); // reset colors to defaults
            Console.Write("Select an option from the menu: ");
        }

        private static void ProcessMenuChoice(string choice)
        {
            // Clear the screen on each menu choice
            Console.Clear();
            switch (choice)
            {
                case "A": // About Page
                    DisplayAbout();
                    break;
                case "B": // Bad Logic
                    BadLogic();
                    break;
                case "C": // Continuous Loop
                    ContinuousLoop();
                    break;
                case "D": // Double or Nothing
                    DoubleOrNothing();
                    break;
                case "E": // Extreme Recursion
                    ExtremeRecursion();
                    break;
                case "X": // eXit
                    Console.WriteLine("\nThanks for trying this demo!\n");
                    break;
                default:
                    Console.ForegroundColor = ConsoleColor.DarkRed;
                    Console.WriteLine("Invalid menu choice.");
                    Console.ResetColor();
                    break;
            }
        }

        private static void DisplayAbout()
        {
            Console.ForegroundColor = ConsoleColor.DarkBlue;
            Console.WriteLine("Debugging Demo");
            Console.WriteLine("==============\n");
            Console.ForegroundColor = ConsoleColor.DarkCyan;
            Console.WriteLine("To debug in Visual Studio:");
            Console.WriteLine("\tA) Set a breakpoint by clicking in the left gutter of the editor (or use [F9])");
            Console.WriteLine("\tB) Click the play button or press [F5]");
            Console.WriteLine("\nYou can use the following keyboard shortcuts while debugging your code:");
            Console.WriteLine("\t[F10] - Step over (execute) the current line of code");
            Console.WriteLine("\t[F11] - Step into a method as you execute the current line of code");
            Console.WriteLine("\t[shift] + [F11] - Step out; i.e. finish executing the current method and pause at whatever line has called the current method");

            PauseDisplay();
            throw new NotImplementedException();
        }

        private static void PauseDisplay()
        {
            Console.ResetColor();
            Console.Write("\n\nPress [Enter] to continue...");
            Console.ReadLine();
        }
        #endregion

        #region Demos
        private static void BadLogic()
        {
            Console.WriteLine("This demo finds the average of 10 numbers");

            int total = 0, count, number;
            for(count = 1; count <= 10; count++)
            {
                Console.Write("Enter a number: ");
                while (!int.TryParse(Console.ReadLine(), out number))
                    Console.Write("\tNot a whole number. Try again: ");
                total += number;
            }
            Console.WriteLine($"The average is {(double)total / count}");
            PauseDisplay();
            Console.Clear();
        }

        private static void ContinuousLoop()
        {
            Console.WriteLine("This demo loops for validating input ...");

            Console.WriteLine("\nBreak me by entering a real number instead of a whole number");
            int number;
            string userInput = Console.ReadLine();
            while (!int.TryParse(userInput, out number))
                Console.Write("\tNot a whole number. Try again: ");

            PauseDisplay();
            Console.Clear();
        }

        private static void DoubleOrNothing()
        {
            Console.WriteLine("This demo has an integer division problem...");

            int installStage = 45;
            double percentComplete = installStage / 100;
            double remaining = (1 / percentComplete) * 100; // inversion - should be 55% remaining
            Console.WriteLine($"You have {remaining} % left to download...");
            PauseDisplay();
            Console.Clear();
        }

        private static void ExtremeRecursion()
        {
            int startFrom = 5;
            Console.WriteLine($"This demo counts down from {startFrom} to 1, using recursion.\n");
            CountDown(startFrom);
            PauseDisplay();
            Console.Clear();
        }

        private static void CountDown(int number)
        {
            Console.Write($"{number},\t");
            if (number != 0)
            {
                number = number - 1;
                CountDown(--number);
            }
        }
        #endregion
    }
}
