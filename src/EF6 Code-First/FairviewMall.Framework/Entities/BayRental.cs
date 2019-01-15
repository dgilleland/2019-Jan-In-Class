using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FairviewMall.Framework.Entities
{
    [Table("BayRentals")]
    public class BayRental
    {
        [Key, Column(Order = 1)]
        public string BayID { get; set; }
        [Key, Column(Order = 2)]
        public int RentalID { get; set; }

        public Quadrant Quadrants { get; set; }

        #region Navigation Properties
        public virtual Bay Bay { get; set; }
        public virtual Rental Rental { get; set; }
        #endregion
    }
}
