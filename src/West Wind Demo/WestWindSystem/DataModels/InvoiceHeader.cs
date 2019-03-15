using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WestWindSystem.DataModels
{
    public class InvoiceHeader
    {
        public string Name { get; set; }
        public string Attn { get; set; }
        public string AttnTitle { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Fax { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
    }
    public class SupplierShipment
    {
        public string Sender { get; set; }
        public DateTime ShippedOn { get; set; }
        public ShipVia ShipVia { get; set; }
        public List<ShippedItem> Manifest { get; set; }
        public decimal FreightCost { get; set; }
    }
    public class ShipVia
    {
        public string Company { get; set; }
        public string Phone { get; set; }
    }
    public class ShippedItem
    {
        public string Product { get; set; }
        public short Quantity { get; set; }
    }
    public class ShipDestination
    {
        public string Destination { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string Country { get; set; }
        public string PostalCode { get; set; }
    }
    public class Invoice
    {
        public string Name { get; set; }
        public int OrderId { get; set; }
        public DateTime OrderDate { get; set; }
        public DateTime RequiredBy { get; set; }
        public bool IsShipped { get; set; }
        public ShipDestination ShipTo { get; set; }
        public decimal Subtotal { get; set; }
        public decimal? FreightCharge { get; set; }
        public DateTime? DueDate { get; set; }
        public decimal PaymentsToDate { get; set; }
        public DateTime? LastPaymentDate { get; set; }
        public int Payments { get; set; }
    }
}
