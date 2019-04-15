using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DemoClasses.Samples
{
    public enum Suit { Hearts, Clubs, Diamonds, Spades }
    public enum CardValue // CardValue is a Data Type
    {
        // The CardValue data type consist of the following
        // allowed Values:
        Joker,
        Ace = 1,
        Two,
        Three,
        Four,
        Five,
        Six,
        Seven,
        Eight,
        Nine,
        Ten,
        Jack,
        Queen,
        King
    }
    public class Card
    {
        #region Properties
        public Suit Suit { get; private set; }
        public CardValue Value { get; private set; }
        #endregion

        #region Constructors
        public Card(Suit theSuit, CardValue theValue)
        {
            Suit = theSuit;
            Value = theValue;
        }
        #endregion

        #region
        public override string ToString()
        {
            // I'm using String Interpolation to concatenate my string
            return $"{Value} of {Suit}";
        }
        #endregion
    }
    public class DeckOfCards
    {
        // Static, because this can be "shared" among various decks of cards
        public static Random _rnd = new Random();

        public List<Card> Cards { get; private set; }
        public DeckOfCards()
        {
            // A new deck of cards should be a full deck
            Cards = new List<Card>();
            foreach(Suit cardSuit in Enum.GetValues(typeof(Suit)))
            {
                foreach(CardValue cardValue in Enum.GetValues(typeof(CardValue)))
                {
                    Cards.Add(new Card(cardSuit, cardValue));
                }
            }
        }

        public void Shuffle(int times = 5)
        {
            if (times < 5)
                throw new Exception("That's not much of a shuffle...");
            if (times > 50)
                throw new Exception("That's a lot of shuffling...");
            int changes = Cards.Count * times;
            while(changes > 0)
            {
                // Identify a card
                var index = _rnd.Next(Cards.Count);
                // Take it "out" of the deck
                var card = Cards[index];
                Cards.RemoveAt(index);
                // Put it on the bottom;
                Cards.Add(card);
                // Decrement the change counter
                changes--;
            }
        }
    }
}
