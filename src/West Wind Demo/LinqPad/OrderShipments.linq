<Query Kind="Expression">
  <Connection>
    <ID>05a2444e-14ea-4451-ad3d-3398e9ff7898</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// Get the shipment details for a specific order
from shipment in Shipments
where shipment.OrderID == 11021
select new // SupplierShipment
{
    Sender = shipment.ManifestItems.First().Product.Supplier.CompanyName,
    ShippedOn = shipment.ShippedDate,
    ShipVia = new // ShipVia
              {
                  Company = shipment.ShipViaShipper.CompanyName,
                  Phone = shipment.ShipViaShipper.Phone
              },
    Manifest = from item in shipment.ManifestItems
               select new // ShippedItem
               {
                   Product = item.Product.ProductName,
                   Quantity = item.ShipQuantity
               },
    FreightCost = shipment.FreightCharge
               
}