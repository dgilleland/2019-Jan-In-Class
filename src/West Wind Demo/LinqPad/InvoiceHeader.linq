<Query Kind="Expression">
  <Connection>
    <ID>05a2444e-14ea-4451-ad3d-3398e9ff7898</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// Generate the invoicing header for a specific customer ("QUICK").
(from customer in Customers
where customer.CustomerID == "QUICK"
select new // InvoiceHeader
{
    Name = customer.CompanyName,
    Attn = customer.ContactName,
    AttnTitle = customer.ContactTitle,
    Email = customer.ContactEmail,
    Phone = customer.Phone,
    Fax = customer.Fax,
    City = customer.City,
    Country = customer.Country
}).FirstOrDefault()