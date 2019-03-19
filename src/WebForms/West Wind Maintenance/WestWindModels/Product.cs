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
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public int SupplierID { get; set; }
        public int CategoryID { get; set; }
        public string QuantityPerUnit { get; set; }
        public decimal UnitPrice { get; set; }
        public int UnitsOnOrder { get; set; }
        public bool Discontinued { get; set; }
    }
}
