﻿using System;
using System.Collections.Generic;
using System.Linq;
using WestWindModels;
using WestWindSystem.DAL;

namespace WestWindSystem.BLL
{
    public class ProductController
    {
        public List<Product> ListProducts()
        {
            // This "using" statement is different than the "using" at the top of this file.
            // This "using" statement is to ensure that the connection to the database is properly closed after we are done.
            // The variable context is a WestWindContext object
            // The WestWindContext class represents a "virtual" database
            using (var context = new WestWindContext())
            {
                return context.Products.ToList();
            }
        }

        public Product LookupProduct(int productId)
        {
            using (var context = new WestWindContext())
            {
                return context.Products.Find(productId);
            }
        }

        public List<Product> GetProductsByCategory(int searchId)
        {
            throw new NotImplementedException();
        }

        public List<Product> GetProductsBySupplier(int searchId)
        {
            using (var context = new WestWindContext())
            {
                var result = context // from the context of where I connect to Db Server
                             .Database // access the database directly to...
                             .SqlQuery<Product>( // run an SQL statement
                    "EXEC Products_GetBySupplier @p0", searchId);
                return result.ToList();
            }
        }

        public List<Product> GetProductsByPartialName(string name)
        {
            using (var context = new WestWindContext())
            {
                // WARNING! NEVER, EVER, do this....
                // because it's vulnerable to an SQL Injection Attack
                string sql = $"EXEC Products_GetByPartialProductName '{name}'";
                var result = context.Database.SqlQuery<Product>(sql);
                return result.ToList();
            }
        }

        public int AddProduct(Product item) // we could also just return void
        {
            using (var context = new WestWindContext())
            {
                Product addedItem = context.Products.Add(item);
                context.SaveChanges(); // do the work to save the changes to the database
                return addedItem.ProductID; // because the PK is an Identity column and generated by the database
            }
        }

        public void UpdateProduct(Product item)
        {
            using (var context = new WestWindContext())
            {
                // The following approach will update the entire Product object in the database
                var existing = context.Entry(item);
                // Tell the context that this object's data is modified
                existing.State = System.Data.Entity.EntityState.Modified;
                // Save the changes
                context.SaveChanges();
            }
        }

        public void DeleteProduct(int id)
        {
            using (var context = new WestWindContext())
            {
                // The .Find method will look up the specific Product based on the Primary Key value
                var existing = context.Products.Find(id);
                context.Products.Remove(existing);
                context.SaveChanges();
            }
        }

        // Here is an overloaded method that "chains" to the DeleteProduct(int) version
        public void DeleteProduct(Product item)
        {
            DeleteProduct(item.ProductID);
        }
    }
}
