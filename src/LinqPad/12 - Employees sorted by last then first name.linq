<Query Kind="Expression">
  <Connection>
    <ID>5265d1f5-021e-4878-9587-a78d45e7824e</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// Look up the Employees, sorted by last name then first name. Show the last/first name as distinct properties.
from person in Employees
orderby person.LastName, person.FirstName
select new
{
    person.FirstName,
	person.LastName
}