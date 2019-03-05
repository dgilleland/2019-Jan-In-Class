using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp.StarTrek
{
    public class Ship
    {
        public string RegistryId { get; set; }
        public string Class { get; set; }
        public int Power { get; set; }
        public bool ShieldsOn { get; set; }
    }
}