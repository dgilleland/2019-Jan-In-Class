<Query Kind="Expression">
  <Connection>
    <ID>9f795fec-6525-43c5-bbd0-2819df27768a</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// List all the product and category names in a "flat" list
from data in Products
select new
{
   Product = data.ProductName,
   Category = data.Category.CategoryName
}