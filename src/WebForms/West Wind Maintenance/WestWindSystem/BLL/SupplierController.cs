using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WestWindModels;
using WestWindSystem.DAL;
using WestWindSystem.DataModels;

namespace WestWindSystem.BLL
{
    [DataObject] // from System.ComponentModel namespace
    public class SupplierController
    {
        // Use this class to help us with CRUD maintenance of our database
        [DataObjectMethod(DataObjectMethodType.Select)]
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

        public int AddSupplier(Supplier item)
        {
            using (var context = new WestWindContext())
            {
                var added = context.Suppliers.Add(item);
                context.SaveChanges();
                // After saving changes, my local context object
                // "syncs up" the newly added supplier's ID
                // that was generated from the table's IDENTITY constraint.
                return added.SupplierID;
            }
        }

        public void UpdateSupplier(Supplier item)
        {
            using (var context = new WestWindContext())
            {
                // The following approach will update the entire Supplier object in the database
                DbEntityEntry<Supplier> existing = context.Entry(item);
                // Treat the whole entity (all properties) as being modified
                existing.State = System.Data.Entity.EntityState.Modified;
                // Save the changes
                context.SaveChanges();
            }
        }

        public void DeleteSupplier(int supplierId)
        {
            using (var context = new WestWindContext())
            {
                Supplier found = context.Suppliers.Find(supplierId);
                context.Suppliers.Remove(found);
                context.SaveChanges();
            }
        }

        // Here is an overloaded method that "chains" to the DeleteSupplier(int) version
        public void DeleteSupplier(Supplier item)
        {
            DeleteSupplier(item.SupplierID);
        }
    }
}
