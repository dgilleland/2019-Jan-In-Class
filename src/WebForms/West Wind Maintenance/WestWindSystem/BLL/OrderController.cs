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
    }
}
