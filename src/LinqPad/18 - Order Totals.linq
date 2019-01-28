<Query Kind="Expression">
  <Connection>
    <ID>5265d1f5-021e-4878-9587-a78d45e7824e</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// List all the orders showing the order ID, Company Name, Freight Charge,
// and Subtotal (no discounts) as well as the Subtotal of the discount.
from sale in Orders
select new
{
    OrderId = sale.OrderID,
    Company = sale.Customer.CompanyName,
    FreightCharge = sale.Freight,
    Subtotal = sale.OrderDetails.Sum(lineItem => lineItem.Quantity * lineItem.UnitPrice),
    DiscountSubtotal = 
        sale.OrderDetails.Sum(lineItem =>
                              lineItem.Quantity * lineItem.UnitPrice * (decimal)lineItem.Discount)
}