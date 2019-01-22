<Query Kind="Expression">
  <Connection>
    <ID>9f795fec-6525-43c5-bbd0-2819df27768a</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// List the full name of all the employees who look after 7 or more territories
from person in Employees
where person.EmployeeTerritories.Count >= 7
select person.FirstName + " " + person.LastName