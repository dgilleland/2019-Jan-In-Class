using LanguageReview.CSharp.Inheritance;
using System.Collections.Generic;
using System;

namespace LanguageReview.CSharp
{
    // Demo that will show the use of the various Lock classes
    public class LockDriver
    {
        private AbstractLock _TheLock;
        private readonly int _KeyLength; // readonly will mean that the value for this field must be either set here (where it is declared) or in the constructor. After that, the value cannot be changed.

        public LockDriver()
        {
            // Set up the fields/properties with values
            // A standard KeyLock
            // 1) Build a key pattern for the lock
            int[] keySequence = { 5, 7, 2, 3, 5 };
            _KeyLength = keySequence.Length;

            List<KeyPin> key = new List<KeyPin>();
            key.Add(new KeyPin(5));
            key.Add(new KeyPin(7));
            key.Add(new KeyPin(2));
            key.Add(new KeyPin(3));
            key.Add(new KeyPin(5));

            _TheLock = new KeyLock(key);
            // Test of my lock
            _TheLock.Lock();
            if (!_TheLock.IsLocked)
                throw new System.Exception("ERROR - Faulty lock");
            _TheLock.Unlock(keySequence);
            if (_TheLock.IsLocked)
                throw new System.Exception("ERROR - Can't unlock with correct key sequence");
            // Display the key sequence for this lock
            DisplayKeySequence(keySequence);
        }

        private void DisplayKeySequence(int[] keySequence)
        {
            foreach (int item in keySequence)
                Console.Write(item.ToString() + " ");
            Console.WriteLine();
        }

        public void PickLock()
        {
            _TheLock.Lock(); // Start out by locking the lock
            int count = 0; // to track the number of attempts
            int[] keySequence = new int[_KeyLength];
            while(_TheLock.IsLocked)
            {
                // attempt to pick the lock
                count++;
                IncrementKeySequence(keySequence);
                DisplayKeySequence(keySequence);
                _TheLock.Unlock(keySequence);
            }
            // Output how many tries it took to pick the lock
            Console.WriteLine($"The computer picked the lock after {count} attempts.");
            Console.WriteLine($"The key sequence is {string.Join(", ", keySequence)}");
        }

        public void IncrementKeySequence(int[] sequence)
        {
            sequence[sequence.Length - 1]++;
            for (int index = sequence.Length - 1; index > 0; index--)
            {
                if (sequence[index] > 10)
                {
                    sequence[index - 1]++;
                    sequence[index] = 0;
                }
                if (sequence[index] == 0)
                    sequence[index] = 1;
            }
            if (sequence[0] == 0) sequence[0]++;
        }
    }
}
