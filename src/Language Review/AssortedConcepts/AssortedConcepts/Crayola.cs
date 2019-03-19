using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AssortedConcepts
{
    // First invented in 1903, the original Crayola box contained only eight colors, including red, orange, yellow, green, blue, violet, brown, and black. It sold for only a nickel. 
    public class Crayola // colors
    {
        #region Standard Colors
        const string White = nameof(White);
        const string Red = "Red";
        const string Orange = nameof(Orange); // nameof() is a function that gets the name of a type/variable
        const string Yellow = nameof(Yellow);
        const string Green = nameof(Green);
        const string Blue = nameof(Blue);
        //
        #endregion

        #region Instance members
        public string Color { get; private set; }

        public Crayola(string color)
        {
            // Assume some validation
            Color = color;
        }
        #endregion

        #region Static members
        public static Crayola Parse(string color)
        {
            if (Red.Equals(color, StringComparison.CurrentCultureIgnoreCase))
                return new Crayola(Red);
            if (Orange.Equals(color, StringComparison.CurrentCultureIgnoreCase))
                return new Crayola(Orange);
            if (Yellow.Equals(color, StringComparison.CurrentCultureIgnoreCase))
                return new Crayola(Yellow);
            if (Green.Equals(color, StringComparison.CurrentCultureIgnoreCase))
                return new Crayola(Green);
            if (Blue.Equals(color, StringComparison.CurrentCultureIgnoreCase))
                return new Crayola(Blue);
            throw new Exception("Invalid color");
        }

        public static bool TryParse(string color, out Crayola converted)
        {
            // converted is an "implied" return value, by virtue of the out keyword.
            // The idea of the out keyword is that you give me a variable reference and I'll store a value in that variable for you.
            try
            {
                converted = Crayola.Parse(color);
                return true; // Explicit return value
            }
            catch(Exception ex)
            {
                converted = new Crayola(Crayola.White);
                return false; // Explicit return value
            }
        }
        #endregion

    }
}
