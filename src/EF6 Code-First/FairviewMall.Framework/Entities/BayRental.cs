using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FairviewMall.Framework.Entities
{
    public class BayRental
    {
        public string BayID { get; set; }
        public int RentalID { get; set; }
        public Quadrant Quadrants { get; set; }
    }
}
