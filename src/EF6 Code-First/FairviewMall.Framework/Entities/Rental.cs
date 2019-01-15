using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FairviewMall.Framework.Entities
{
    [Table("Rentals")]
    public class Rental
    {
        [Key]
        public int RentalID { get; set; }
        [Required, StringLength(30)]
        public string CompanyName { get; set; }
        [StringLength(40)]
        public string Website { get; set; }
        [Required, StringLength(12, MinimumLength = 12), Column(TypeName = "char")]
        public string PhoneNumber { get; set; }
        [Required, StringLength(50)]
        public string ContactName { get; set; }
        [Range(6, 24)]
        public int RentalTerm { get; set; }
        [Column(TypeName = "money")]
        public decimal MonthlyRate { get; set; }
        public DateTime StartingDate { get; set; }
        public DateTime? ClosingDate { get; set; }

        #region Navigation Properties
        public virtual ICollection<BayRental> BayRentals { get; set; }
        #endregion
    }
}
