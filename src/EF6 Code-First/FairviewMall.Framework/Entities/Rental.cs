using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FairviewMall.Framework.Entities
{
    public class Rental
    {
        public int RentalID { get; set; }
        public string CompanyName { get; set; }
        public string Website { get; set; }
        public string PhoneNumber { get; set; }
        public string ContactName { get; set; }
        public int RentalTerm { get; set; }
        public decimal MonthlyRate { get; set; }
        public DateTime StartingDate { get; set; }
        public DateTime? ClosingDate { get; set; }
    }
}
