using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WestWindSystem.DataModels
{
    public class RegionalManager
    {
        public string City { get; internal set; }
        public string FirstName { get; internal set; }
        public string LastName { get; internal set; }
        public string Region { get; internal set; }
        public string State { get; internal set; }
        public string Territory { get; internal set; }
        public string TerritoryZip { get; internal set; }
    }
    public class KeyValueOption
    {
        public string Key { get; set; }
        public string Text { get; set; }
    }
    public class CustomerOrder
    {
        public int OrderId { get; set; }
        public string Employee { get; set; }
        public DateTime? OrderDate { get; set; }
        public DateTime? RequiredDate { get; set; }
        public IEnumerable<ShipmentSummary> Shipments {get;set;}
        public decimal? Freight { get; set; }
        public decimal OrderTotal { get; set; }
    }
    public class ShipmentSummary
    {
        public DateTime ShippedOn { get; set; }
        public string Carrier { get; set; }

    }
    public class CustomerSummary
    {
        public string CompanyName { get; set; }
        public string ContactName { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
    }
    public class ProductItem
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string QuantityPerUnit { get; set; }
        public decimal UnitPrice { get; set; }
    }
    public class CustomerOrderWithDetails : CustomerOrder
    {
        public IEnumerable<CustomerOrderItem> Details { get; set; }
            = new List<CustomerOrderItem>();
    }
    public class CustomerOrderItem : ProductItem
    {
        public int OrderId { get; set; }
        public short Quantity { get; set; }
        public float DiscountPercent { get; set; }
        public string Supplier { get; set; }
    }
    public class EditOrderItem
    {
        public int ProductId { get; set; }
        public decimal UnitPrice { get; set; }
        public short OrderQuantity { get; set; }
        public float DiscountPercent { get; set; }
    }
}
