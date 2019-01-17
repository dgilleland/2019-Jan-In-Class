using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LanguageReview.CSharp.Inheritance
{
    public sealed class KeyPin
    {
        public int Length { get; private set; }
        public KeyPin(int length)
        {
            if (length < 1 || length > 10)
                throw new ArgumentOutOfRangeException("Length", "KeyPin lengths must be between 1 and 10 inclusive");
            this.Length = length;
        }
    }
}