using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp3
{
    class Program
    {
        #region Main Driver Method
        static void Main(string[] args)
        {
            Program app = new Program(); // This class is my Driver.
            string menuChoice;
            do
            {
                app.DisplayMenu();
                menuChoice = Console.ReadLine().ToUpper();
                app.ProcessMenuChoice(menuChoice);
            } while (menuChoice != "X");
        }
        #endregion

        #region General Purpose Methods
        private void DisplayMenu()
        {
            Console.ForegroundColor = ConsoleColor.DarkGreen;

            Console.WriteLine("A) Load Crash Data");
            Console.WriteLine("B) Search Crash Data");
            Console.WriteLine("C) ");
            Console.WriteLine("X) ");
            Console.ResetColor();
            Console.Write("Select an option from the menu: ");
        }

        private void ProcessMenuChoice(string choice)
        {
            switch (choice)
            {
                case "A":
                    LoadCrashData();
                    break;
                case "B":
                    SearchCrashData();
                    break;
                case "C":
                    break;
                case "X":
                    break;
                default:
                    Console.ForegroundColor = ConsoleColor.DarkRed;
                    Console.WriteLine("Invalid menu choice.");
                    break;
            }
            Pause();
            Console.ResetColor();
        }

        private void Pause()
        {
            Console.ForegroundColor = ConsoleColor.Gray;
            Console.WriteLine("\n\nPress any key to continue...");
            Console.ReadKey(true);
            Console.Clear();
        }
        #endregion

        #region Menu Processing Methods
        // TODO: Your specific menu processing methods.
        private void LoadCrashData()
        {
            // Hardcoded path
            const string PATH = @".\Data\2017-Crash-Data.csv";
        }

        private void SearchCrashData()
        {

        }
        #endregion
    }
}
