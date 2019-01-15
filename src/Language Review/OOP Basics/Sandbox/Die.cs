using System;

namespace Sandbox
{
    // The Die class will act like a template for creating objects.
    // Die objects are things that we can roll and that we can
    // see the "side" that is on the top of the die.
    public class Die
    {
        // Field for the Random Number Generator
        // This will be the only other "static" item
        // in order to improve it's ability to be random
        private static Random _rnd = new Random();

        // Property for the side that is facing up.
        // This is an auto-implemented property
        public int FaceValue { get; private set; }

        // Field to store the # of sides
        private int _Sides;
        // Property for the number of sides for a die
        public int Sides
        {
            get { return _Sides; }
            private set
            {
                if (value < 4 || value > 20)
                    throw new Exception("Invalid number of sides for the die");
                _Sides = value;
            }
        }

        // Constructor - Our chance to give meaningful values
        // to the object when it is created.
        public Die() // This is a parameterless constructor
        {
            Sides = 6;
            Roll();
        }
        public Die(int numberOfSides)
        {
            Sides = numberOfSides; // store the value using the property
        }

        // Methods
        public void Roll()
        {
            FaceValue = _rnd.Next(1, Sides + 1);
        }
    }
}
