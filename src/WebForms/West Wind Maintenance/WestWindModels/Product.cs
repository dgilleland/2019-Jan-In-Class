using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;        // for [Key] attribute
using System.ComponentModel.DataAnnotations.Schema; // for [Table] attribute
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WestWindModels
{
    // We annotate our classes or other items in our code
    // to give extra information (metadata) that can be
    // used by VS tooling & other libraries to do "magic"
    [Table("Products", Schema = "dbo")] // Identify the table name & schema
    public class Product
    {
        [Key]
        public int ProductID { get; set; }                  // int          NOT NULL
        public string ProductName { get; set; }             // nvarchar     NOT NULL
        public int SupplierID { get; set; }                 // int          NOT NULL
        public int CategoryID { get; set; }                 // int          NOT NULL
        public string QuantityPerUnit { get; set; }         // nvarchar     NOT NULL
        // short? is a short-hand way of writing Nullable<short>
        public short? MinimumOrderQuantity { get; set; }    // smallint         NULL
        public decimal UnitPrice { get; set; }              // money        NOT NULL
        public int UnitsOnOrder { get; set; }               // int          NOT NULL
        public bool Discontinued { get; set; }              // bit          NOT NULL
    }
}
