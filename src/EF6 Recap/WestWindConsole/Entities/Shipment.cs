using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WestWindConsole.Entities
{
    public class Shipment
    {
        public int ShipmentID { get; set; }
        public int OrderID { get; set; }
        public DateTime ShippedDate { get; set; }
        public int ShipVia { get; set; } // FK to the Shipper entity/table
        public decimal FreightCharge { get; set; }
        public string TrackingCode { get; set; }

        [ForeignKey(nameof(ShipVia))]
        public virtual Shipper Shipper { get; set; }
    }
}
