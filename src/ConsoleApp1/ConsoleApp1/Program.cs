using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            string message = "I love birds.";
            Console.WriteLine(message.Quack());
            Console.WriteLine(5);
        }
    }

    public static class MyExtensions
    {
        public static string Quack(this string self)
        {
            return self + " Quack";
        }

        public static string Quack(this int self)
        {
            string message = "";
            for (int count = 0; count < self; count++)
                message += "-quack";
            return message;
        }
    }
}
