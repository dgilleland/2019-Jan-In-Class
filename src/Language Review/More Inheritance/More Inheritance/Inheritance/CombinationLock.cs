using System;
using System.Collections.Generic;

namespace LanguageReview.CSharp.Inheritance
{
    public sealed class CombinationLock : AbstractLock
    {
        private static Random spinner = new Random();

        private List<CombinationDial> CombinationDials { get; set; }
        public List<int> CurrentCombination { get; private set; }
        public int HighestCombinationNumber { get; private set; }
        public CombinationLock(List<CombinationDial> combination)
        {
            if (combination == null)
                throw new ArgumentNullException("combination", "CombinationLock requires a list of CombinationDial objects as its combination");
            if (combination.Count < 3 || combination.Count > 5)
                throw new ArgumentOutOfRangeException("CombinationLock requires between 3 and 5 (inclusive) CombinationDial objects as its combination");
            HighestCombinationNumber = combination[0].Length;
            foreach (CombinationDial dial in combination)
            {
                if (dial.Length != HighestCombinationNumber)
                    throw new ArgumentException("combination", "CombinationNumbers do not match; each CombinationDial must be the same size (Length) to act as the combination numbers");
            }
            CombinationDials = combination;
            CurrentCombination = new List<int>(combination.Count);

            // Leave the CombinationLock "unlocked"
            for (int i = 0; i < CombinationDials.Count; i++)
            {
                CurrentCombination[i] = CombinationDials[i].KeyPosition;
            }
        }

        public override void Lock()
        {
            for (int i = 0; i < CombinationDials.Count; i++)
            {
                CurrentCombination[i] = spinner.Next(HighestCombinationNumber) + 1;
            }
            base.Lock();
        }


        public override void Unlock(params int[] keyNumbers)
        {
            if (keyNumbers.Length != CombinationDials.Count)
                throw new ArgumentException("keyNumbers", "The proposed combination cannot be checked because the supplied keyNumbers had " + keyNumbers.Length + " values but this CombinationLock has " + CombinationDials.Count + " dials");

            bool correctCombination = true;
            for (int i = 0; i < keyNumbers.Length; i++)
            {
                if (keyNumbers[i] < 1 || keyNumbers[i] > HighestCombinationNumber)
                    throw new ArgumentException("keyNumbers", "Cannot check the value " + keyNumbers[i] + " in the proposed combination because it is not in the range of numbers on the dials (from 1 to " + HighestCombinationNumber.ToString());
                if (keyNumbers[i] != CombinationDials[i].KeyPosition)
                    correctCombination = false;
            }
            if (correctCombination) IsLocked = false;
        }
    }
}
