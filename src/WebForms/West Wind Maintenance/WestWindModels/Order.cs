using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WestWindModels
{
    [Table("Orders")]
    public class Order
    {
        // NOTE: Primitive Value Types can be made "nullable" by
        //       adding a ? after the data type - decimal?
        [Key]                                           //  SQL Types
        public int OrderID { get; set; }                // int      NOT NULL
        public int SalesRepID { get; set; }             // int      NOT NULL
        public string CutomerID { get; set; }           // nchar(5) NOT NULL
        public DateTime? OrderDate { get; set; }        // datetime     NULL
        public DateTime? RequiredDate { get; set; }     // datetime     NULL
        public decimal? Freight { get; set; }           // money        NULL
        // NOTE: Strings are Reference Types, and can store a null value
        //       by definition.
        public string ShipName { get; set; }            // nvarchar     NULL
        public string ShipAddress { get; set; }
        public string ShipCity { get; set; }
        public string ShipRegion { get; set; }
        public string ShipPostalCode { get; set; }
        public string ShipCountry { get; set; }
        public string Comments { get; set; }
    }
}
