<Query Kind="Expression">
  <Connection>
    <ID>9f795fec-6525-43c5-bbd0-2819df27768a</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// - Filter on partial name
// List employees who have an "an" in their first name
from person in Employees
where person.FirstName.Contains("an")
select person
