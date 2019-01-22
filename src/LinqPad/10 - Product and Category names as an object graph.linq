<Query Kind="Expression">
  <Connection>
    <ID>9f795fec-6525-43c5-bbd0-2819df27768a</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// List all the product and category names in an "object graph"
from data in Categories
select new
{
    Category = data.CategoryName,
    Products = from item in data.Products
               select item.ProductName
}