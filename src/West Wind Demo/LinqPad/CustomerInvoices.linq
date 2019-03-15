<Query Kind="Expression">
  <Connection>
    <ID>05a2444e-14ea-4451-ad3d-3398e9ff7898</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// Generate a list of invoices for a specific customer ("QUICK").
from order in Orders
where order.CustomerID == "QUICK"
orderby order.PaymentDueDate descending
select new // Invoice
{
    Name = order.Customer.CompanyName,
    OrderId = order.OrderID,
    OrderDate = order.OrderDate,
    RequiredBy = order.RequiredDate,
    IsShipped = order.Shipped,
    ShipTo = new // ShipDestination
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
}