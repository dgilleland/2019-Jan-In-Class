<Query Kind="Expression">
  <Connection>
    <ID>5265d1f5-021e-4878-9587-a78d45e7824e</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// Get the products displaying the product name, the category, and the unit price. Sort the results alphabetically by category and then in descending order by unit price.
from item in Products
orderby item.Category.CategoryName ascending, item.UnitPrice descending
select new
{
    Product = item.ProductName,
	Category = item.Category.CategoryName,
	Price = item.UnitPrice
}