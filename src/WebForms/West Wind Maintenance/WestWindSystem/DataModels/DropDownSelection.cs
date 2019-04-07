using System;
using System.Linq;

namespace WestWindSystem.DataModels
{
    public class DropDownSelection<TKey>
    {
        public string Text { get; set; }
        public TKey Value { get; set; }
    }
}
