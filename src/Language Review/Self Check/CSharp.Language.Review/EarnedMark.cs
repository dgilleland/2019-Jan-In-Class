using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSharp.Language.Review
{
    public class EarnedMark : WeightedMark
    {
        // This is an example of an auto-implemented property - have a "hidden" backing store
        // Properties provide a controlled access to information
        public int Possible { get; private set; }

        // This is a field
        private double _Earned;
        // This is an explicitly implemented property
        public double Earned
        {
            // We are using the _Earned field as a "backing store"
            get { return _Earned; }
            set
            {
                if (value < 0 || value > Possible)
                    throw new Exception("Invalid earned mark assigned");
                _Earned = value;
            }
        }

        public double Percent // An example of a property that derives its values from other data
        {  get { return (Earned / Possible) * 100; } }

        public double WeightedPercent
        {  get { return Percent * Weight / 100; } }

        // This constructor calls another constructor
        // BEFORE it runs it's own body of instructions.
        // Hooking up constructors in this fashion is
        // known as "daisy-chaining" your constructor
        // calls.
        public EarnedMark(WeightedMark markableItem, int possible, double earned)
            : this(markableItem.Name, markableItem.Weight, possible, earned)
        {
        }

        public EarnedMark(string name, int weight, int possible, double earned) : base(name, weight)
        {
            if (possible <= 0)
                throw new Exception("Invalid possible marks");
            Possible = possible;
            Earned = earned;
        }

        // Changing the behaviour of the base class by overriding some method
        // is one way that we accomplish Polymorphism
        public override string ToString()
        {
            return string.Format("{0} ({1})\t - {2}% ({3}/{4}) \t- Weighted Mark {5}%",
                Name,
                Weight,
                Percent,
                Earned,
                Possible,
                WeightedPercent);
        }
    }
}
