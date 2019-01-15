using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sandbox
{
    class Program
    {
        static void Main(string[] args)
        {
            // Create an instance of my Program class that will
            // act as the "driver" for my game.
            Program app = new Program();
            app.Start();
        }

        // These are the non-static members of the Program class
        public void Start()
        {
            // This will keep the program running until the user chooses to quit.
            Console.WriteLine("~~~~~ YAHTZEE ~~~~~");
            Console.WriteLine(" (pirated version)");
            string again;
            do
            {
                DoPlayerTurn();
                Console.Write("Again? (y/n) ");
                again = Console.ReadLine().ToUpper();
                Console.Clear(); // clean the screen
            } while (again != "N");
        }

        public void DoPlayerTurn()
        {
            List<Die> dice = new List<Die>();
            for (int count = 1; count <= 5; count++)
                dice.Add(new Die());
            ShowDie(dice);
            int remainingRolls = 2;
            while(remainingRolls > 0)
            {
                Console.WriteLine("Enter die numbers to re-roll (comma-separated) or press [enter] to accept last roll:");
                string dieNumbers = Console.ReadLine();
                if (string.IsNullOrWhiteSpace(dieNumbers))
                    remainingRolls = 0;
                else
                {
                    ReRoll(dice, dieNumbers);
                    remainingRolls--;
                }
                ShowDie(dice);
            }
            Console.WriteLine("-- end of turn --");
        }

        public void ReRoll(List<Die> dice, string input)
        {
            string[] numbers = input.Split(',');
            foreach(string value in numbers)
            {
                int index;
                if (int.TryParse(value, out index)
                    && index <= dice.Count)
                    dice[index - 1].Roll();
            }
        }

        public void ShowDie(List<Die> dice)
        {
            int num = 1;
            foreach (Die item in dice)
                Console.WriteLine($"Die {num++}) {item.FaceValue}");
        }
    }
}
