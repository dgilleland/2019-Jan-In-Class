using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WestWindModels;
using WestWindSystem.DAL;
using WestWindSystem.DataModels;

namespace WestWindSystem.BLL
{
    public class SupplierController
    {
        // Use this class to help us with CRUD maintenance of our database
        public List<Supplier> ListSuppliers()
        {
            // Make use of our "virtual database" class to get the data
            using (var context = new WestWindContext())
            {
                return context.Suppliers.ToList();
            }
        }

        public List<Country> ListCountries()
        {
            using (var context = new WestWindContext())
            {
                string sql = "SELECT DISTINCT Country AS 'Name' FROM Suppliers ORDER BY Country";
                // The .Database property of our DbContext object gives more direct access
                // to the database. With this, we can call methods such as .Execute()
                // or .SqlQuery<TResult>().
                var result = context.Database.SqlQuery<Country>(sql);
                return result.ToList();
            }
        }

        public Supplier GetSuppier(int id)
        {
            using (var context = new WestWindContext())
            {
                // The .Find() method will look up the object based on its primary key
                return context.Suppliers.Find(id);
            }
        }
    }
}
