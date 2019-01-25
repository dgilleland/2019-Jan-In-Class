<Query Kind="Expression">
  <Connection>
    <ID>5265d1f5-021e-4878-9587-a78d45e7824e</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// Lookup the category names, in alphabetical order
from row in Categories
orderby row.CategoryName // descending for reverse alphabetical order
select row.CategoryName