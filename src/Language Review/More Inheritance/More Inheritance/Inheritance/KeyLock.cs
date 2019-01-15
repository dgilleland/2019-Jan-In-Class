using System;
using System.Collections.Generic;

namespace LanguageReview.CSharp.Inheritance
{
    public sealed class KeyLock : AbstractLock
    {
        private List<KeyPin> KeyTeeth { get; set; }

        public KeyLock(List<KeyPin> keyTeethSettings)
        {
            if (keyTeethSettings == null)
                throw new ArgumentNullException("keyTeethSettings", "A KeyLock cannot have a null list of KeyPin objects for its keyTeethSettings.");
            if (keyTeethSettings.Count < 5 || keyTeethSettings.Count > 6)
                throw new ArgumentException("keyTeethSettings", "A KeyLock must have 5 or 6 KeyPin objects in its keyTeethSettings.");

            KeyTeeth = keyTeethSettings;
        }

        public override void Unlock(params int[] keyNumbers)
        {
            if (keyNumbers.Length == KeyTeeth.Count)
            {
                bool correctKeys = true;
                for (int i = 0; i < keyNumbers.Length; i++)
                {
                    if (keyNumbers[i] != KeyTeeth[i].Length)
                        correctKeys = false;
                }
                if (correctKeys) IsLocked = false;
            }
        }
    }
}
