<Query Kind="Expression">
  <Connection>
    <ID>9f795fec-6525-43c5-bbd0-2819df27768a</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// List the first and last name of all the employees who look after 7 or more territories
// as well as the names of all the territories they are responsible for
from person in Employees
where person.EmployeeTerritories.Count >= 7
select new
{
   First = person.FirstName,
   Last = person.LastName,
   Territories = from place in person.EmployeeTerritories
                 select place.Territory.TerritoryDescription
}