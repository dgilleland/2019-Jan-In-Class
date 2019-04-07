﻿using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;
using WestWindModels;
using WestWindSystem.DAL;

namespace WestWindSystem.BLL
{
    public class CategoryController
    {
        public List<KeyValuePair<int, string>> ListCategoriesNameAndId()
        {
            using (var context = new WestWindContext())
            {
                string sql = "SELECT CategoryID AS Key, CategoryName as Value FROM Categories ORDER BY CategoryName";
                var result = context.Database.SqlQuery<KeyValuePair<int, string>>(sql);
                return result.ToList();
            }
        }
    }

    public class ProductController
    {
        public List<Product> GetProductsByCategory(int searchId)
        {
            throw new NotImplementedException();
        }
        public List<Product> GetProductsBySupplier(int searchId)
        {
            throw new NotImplementedException();
        }

        public List<Product> GetProductsByPartialName(string name)
        {
            throw new NotImplementedException();
        }
    }

    public class CustomerController
    {
        public List<Customer> ListCustomers()
        {
            using (var context = new WestWindContext())
            {
                return context.Customers.ToList();
            }
        }

        public List<Customer> GetCustomersByCompanyName(string partialCompanyName)
        {
            // This method is allowing me to get a filtered result
            // of "rows" of customers from the database by using
            // a stored procedure that gets this short list.
            using (var context = new WestWindContext())
            {
                // My SQL string is a call to the store procedure.
                // In Sql Server, a parameter is denoted by the @ symbol.
                // Parameters are numbered rather than named, and the
                // numbering starts at zero.
                string sql = "EXEC Customers_GetByPartialCompanyName @name";
                // @name is a "named parameter", and we prevent SQL Injection Attacks
                // by constructing an SqlParameter object with the value we want to supply
                var param = new SqlParameter("name", partialCompanyName);
                // We call our context class' .Database object to run
                // the SQL Query with the expected return type.
                DbRawSqlQuery<Customer> result = 
                    context.Database.SqlQuery<Customer>(sql, param);
                //                           \row type/     \@name/
                // The order of arguments sent in relates to the SQL parameter's
                // position.

                // When debugging, it can helpful to use another variable
                // to hold the result of the .ToList()
                var finalResult = result.ToList();

                return finalResult;
            }
        }

        public List<Customer> GetCustomersByContact(string partialContactName)
        {
            using (var context = new WestWindContext())
            {
                var result = context.Database.SqlQuery<Customer>("EXEC Customers_GetByPartialContactName {0}", partialContactName);
                return result.ToList();
            }
        }
    }
}
