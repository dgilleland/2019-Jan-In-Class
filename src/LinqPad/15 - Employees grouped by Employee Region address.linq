<Query Kind="Expression">
  <Connection>
    <ID>5265d1f5-021e-4878-9587-a78d45e7824e</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// Display the Employees, grouped by the region in which the employee lives. Show the employee's first name, last name, and job title as separate properties within each group.
from person in Employees
group person by person.Region into EmployeeGroups
select new
{
    Region = EmployeeGroups.Key,
	Employee = from staff in EmployeeGroups
	           select new
               {
			       FirstName = staff.FirstName,
				   LastName = staff.LastName,
				   JobTitle = staff.JobTitle
               }
}