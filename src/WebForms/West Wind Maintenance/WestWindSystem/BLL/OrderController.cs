using System.Collections.Generic;
using System.Linq;
using WestWindModels;
using WestWindSystem.DAL;

namespace WestWindSystem.BLL
{
    public class OrderController
    {
        public List<Order> ListOrders()
        {
            using (var context = new WestWindContext())
            {
                return context.Orders.ToList();
            }
        }

        public List<Order> ListOrders(string byCustomerId)
        {
            using (var context = new WestWindContext())
            {
                string sql = "EXEC Orders_GetByCustomer @0";
                var result = context.Database.SqlQuery<Order>(sql, byCustomerId);
                return result.ToList();
            }
        }
    }
}
