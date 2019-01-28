<Query Kind="Program">
  <Connection>
    <ID>5265d1f5-021e-4878-9587-a78d45e7824e</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// Linq Extension Methods for Selections and Filtering
void Main()
{
    // .Select()
    var staff = Employees.Select(person => person.FirstName + " " + person.LastName);
    var alt = from person in Employees
              select person.FirstName + " " + person.LastName;
    staff.Dump("All staff");
    alt.Dump("All staff as query syntax");
    
    // .OrderBy()
    var alphabetical = staff.OrderBy(name => name);
    alphabetical.Dump("Staff by first name");
    
    // .Select() with an anonymous type
    var staff2 = Employees.Select(person => new { person.FirstName, person.LastName, person.BirthDate });
    staff2.Dump("Staff object result");
    staff2.OrderBy(name => name.LastName).Dump("Staff by last name");
    
    
    // .First() and .FirstOrDefault()
    staff2.First().Dump("First person in the staff object list");
    staff2.OrderBy(person => person.BirthDate).First().Dump("The oldest staff member");
    staff2.First(person => person.FirstName.Contains("an")).Dump("First in list with 'an' in their name");
    staff2.OrderByDescending(person => person.LastName).First(person => person.FirstName.Contains("an")).Dump("First in Sorted");
    
    var me = Employees.FirstOrDefault(person => person.FirstName.StartsWith("Dan"));
    me.Dump("First person named Dan");
    
    // .Single() and .SingleOrDefault()
    staff.Single(person => person.StartsWith("R")).Dump("Staff member starting with 'R'");
    //staff.Single(person => person.StartsWith("M")).Dump("Staff member starting with 'M'");
    staff.SingleOrDefault(person => person.StartsWith("Z")).Dump("Staff member starting with 'Z'");
}

// Define other methods and classes here
