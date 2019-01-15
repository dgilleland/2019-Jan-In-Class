using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FairviewMall.Framework.Entities
{
    [Table("Bays")]
    public class Bay
    {
        [Key]
        public string BayID { get; set; }
        public int FloorSpace { get; set; }
        [MaxLength(25)] // vs. [StringLength(25)]
        public string ReservedUse { get; set; }

        #region Navigation Properties
        public virtual ICollection<BayRental> BayRentals { get; set; }
        #endregion
    }
}
