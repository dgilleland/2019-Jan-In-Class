using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WestWindSystem.DataModels
{
    // This is a POCO (Plain Old CLR Object) class, used to hold data
    // for moving between the PL & BLL
    public class ProductInfo
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string QtyPerUnit { get; set; }
        public string Supplier { get; set; }
        public int SupplierId { get; set; }
        public string Category { get; set; }
        public int CategoryId { get; set; }
        public bool IsDiscontinued { get; set; }
    }
}
