using System;
using System.Collections.Generic;
using System.Linq;
using WestWindModels;
using WestWindSystem.DAL;

namespace WestWindSystem.BLL
{
    public class ProductController
    {
        public List<Product> GetProductsByCategory(int searchId)
        {
            throw new NotImplementedException();
        }

        public List<Product> GetProductsBySupplier(int searchId)
        {
            using (var context = new WestWindContext())
            {
                var result = context.Database.SqlQuery<Product>("EXEC Products_GetBySupplier @p0", searchId);
                return result.ToList();
            }
        }

        public List<Product> GetProductsByPartialName(string name)
        {
            using (var context = new WestWindContext())
            {
                // WARNING! NEVER, EVER, do this....
                // because it's vulnerable to an SQL Injection Attack
                string sql = $"EXEC Products_GetByPartialProductName {name}";
                var result = context.Database.SqlQuery<Product>(sql);
                return result.ToList();
            }
        }
    }
}
