using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LanguageReview.CSharp.Inheritance
{
    public sealed class CombinationDial
    {
        public int Length { get; private set; }
        public int KeyPosition { get; private set; }

        public CombinationDial(int length, int keyPosition)
        {
            if (length < 8 || length > 9)
                throw new ArgumentOutOfRangeException("Length", "CombinationDial lengths must be between 8 and 9 digits");
            if (keyPosition < 1 || keyPosition > length)
                throw new ArgumentOutOfRangeException("keyPosition", "The keyPosition for this CombinationDial must be greater than 1 and less than " + length.ToString());
            this.Length = length;
            this.KeyPosition = keyPosition;
        }
    }
}
