using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSharp.Language.Review
{
    public class WeightedMark
    {
        public int Weight { get; private set; }
        public string Name { get; private set; }

        public WeightedMark(string name, int weight)
        {
            if (weight <= 0 || weight > 100)
                throw new Exception("Invalid weight: must be between zero and 100");
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(name.Trim()))
                throw new Exception("Name cannot be empty for weighted item");
            Weight = weight;
            Name = name;
        }
    }
}
