<Query Kind="Program">
  <Connection>
    <ID>5265d1f5-021e-4878-9587-a78d45e7824e</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>WestWind</Database>
  </Connection>
</Query>

// Other Linq Extension Methods
void Main()
{
    // .Distinct()
    var customerCities = Customers.Select(x => x.City);
    customerCities.Dump("All customer cities");
    customerCities.Distinct().Dump("All customer cities - no duplicates");
    
    // .Take() & .Skip()
    customerCities.Take(5).Dump("First five cities");
    customerCities.Skip(5).Take(3).Dump("Next three cities");
    
    // .Any() - returns true if any of the items matches the condition
    Categories.Where(cat => cat.Products.Any(thing => thing.UnitPrice < 5.0m)).Dump("Categories with low-price items");
    // by the way, the value 5.0 is a double, while the literal value 5.0m is a decimal.
    
    // .All() - returns true only if ALL of the items match the condition
    Categories.Where(cat => cat.Products.All(thing => thing.UnitPrice > 7.5m)).Dump("Categories w. prices over $7.50");
    
}

// Define other methods and classes here
