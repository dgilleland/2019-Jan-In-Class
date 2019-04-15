using DemoClasses.Samples;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DemoClasses
{
    class Program
    {
        static void Main(string[] args)
        {
            Program app = new Program();
            // app.DemoLearnSomething();
            app.PlayCards();
        }
        public void PlayCards()
        {
            var deck = new DeckOfCards();
            foreach (var card in deck.Cards)
                Console.WriteLine(card);
            Console.Write("-- [enter] to continue --");
            Console.ReadLine();
            deck.Shuffle();
            foreach (var card in deck.Cards)
                Console.WriteLine(card);
        }
        public void DemoLearnSomething()
        {
            LearnSomething firstThing, secondThing;
            firstThing = new LearnSomething();
            secondThing = new LearnSomething("I am the second object");

            LearnSomething nextThing = new LearnSomething("I am Groot", 8);
        }
    }
}
