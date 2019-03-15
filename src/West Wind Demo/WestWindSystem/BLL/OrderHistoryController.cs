using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WestWindSystem.DAL;
using WestWindSystem.DataModels;

namespace WestWindSystem.BLL
{
    public class OrderHistoryController
    {
        public List<Invoice> GetCustomerInvoices(string customerId)
        {
            using (var context = new WestWindContext())
            {
                // Answer to query
                var result = from order in context.Orders
                             where order.CustomerID == customerId
                                && order.OrderDate.HasValue
                                && order.RequiredDate.HasValue
                             orderby order.PaymentDueDate descending
                             select new Invoice
                             {
                                 Name = order.Customer.CompanyName,
                                 OrderId = order.OrderID,
                                 OrderDate = order.OrderDate.Value,
                                 RequiredBy = order.RequiredDate.Value,
                                 IsShipped = order.Shipped,
                                 ShipTo = new ShipDestination
                                 {
                                     Destination = order.ShipName,
                                     Address = order.ShipAddress,
                                     City = order.ShipCity,
                                     Region = order.ShipRegion,
                                     Country = order.ShipCountry,
                                     PostalCode = order.ShipPostalCode
                                 },
                                 Subtotal = order.OrderDetails.Sum(od => od.Quantity * od.UnitPrice * (1 - Convert.ToDecimal(od.Discount))),
                                 FreightCharge = order.Freight,
                                 DueDate = order.PaymentDueDate,
                                 PaymentsToDate = order.Payments.Sum(p => p.Amount),
                                 LastPaymentDate = order.Payments.Max(p => p.PaymentDate),
                                 Payments = order.Payments.Count
                             };
                return result.ToList();
            }
        }

        public List<SupplierShipment> OrderShipments(int orderId)
        {
            using (var context = new WestWindContext())
            {
                // Answer to query
                var result = from shipment in context.Shipments
                             where shipment.OrderID == 11021
                             select new SupplierShipment
                             {
                                 Sender = shipment.ManifestItems.First().Product.Supplier.CompanyName,
                                 ShippedOn = shipment.ShippedDate,
                                 ShipVia = new ShipVia
                                 {
                                     Company = shipment.Shipper.CompanyName,
                                     Phone = shipment.Shipper.Phone
                                 },
                                 Manifest = (from item in shipment.ManifestItems
                                            select new ShippedItem
                                            {
                                                Product = item.Product.ProductName,
                                                Quantity = item.ShipQuantity
                                            }).ToList(),
                                 FreightCost = shipment.FreightCharge

                             };
                return result.ToList();
            }
        }

        public InvoiceHeader GetInvoiceHeader(string customerId)
        {
            using (var context = new WestWindContext())
            {
                // Answer to query
                // Generate the invoicing header for a specific customer ("QUICK").
                var result = (from customer in context.Customers
                              where customer.CustomerID == customerId
                              select new InvoiceHeader
                              {
                                  Name = customer.CompanyName,
                                  Attn = customer.ContactName,
                                  AttnTitle = customer.ContactTitle,
                                  Email = customer.ContactEmail,
                                  Phone = customer.Phone,
                                  Fax = customer.Fax,
                                  City = customer.City,
                                  Country = customer.Country
                              }).FirstOrDefault();
                return result;
            }
        }
    }
}
