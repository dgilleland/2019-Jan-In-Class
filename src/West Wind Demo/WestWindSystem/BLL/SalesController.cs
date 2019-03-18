using WestWindSystem.DAL;
using WestWindSystem.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using WestWindSystem.DataModels;

namespace WestWindSystem.BLL
{
    [DataObject]
    public class SalesController
    {
        #region Methods for DataBound Controls
        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<KeyValueOption> ListCustomerNames(bool listAll)
        {
            using (var context = new WestWindContext())
            {
                var names = (from data in context.Customers
                            where data.Orders.Any(x=>x.Shipped == listAll)
                            orderby data.CompanyName
                            select new KeyValueOption
                            {
                                Key = data.CustomerID.ToString(),
                                Text = data.CompanyName
                            }).ToList();
                names.Insert(0, new KeyValueOption { Key = null, Text = "[select a customer]" });
                return names;
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<KeyValueOption> GetOrderHistoryFilters()
        {
            var results = new List<KeyValueOption>();
            results.Add(new KeyValueOption { Key = "open", Text = "Open" });
            results.Add(new KeyValueOption { Key = "shipped", Text = "Shipped" });
            return results.ToList();
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<KeyValueOption> GetProducts()
        {
            using (var context = new WestWindContext())
            {
                var results = from data in context.Products
                              select new KeyValueOption
                              {
                                  Text = data.ProductName,
                                  Key = data.ProductID.ToString()
                              };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<CustomerOrder> GetOrdersByCustomer(string customerId, string filter)
        {
            if (!"open".Equals(filter.ToLower()) && !"shipped".Equals(filter.ToLower()))
                throw new ArgumentException("Filter values are required", nameof(filter));
            using (var context = new WestWindContext())
            {
                var shipped = "shipped".Equals(filter.ToLower());

                var results = from data in context.Orders
                              where data.CustomerID == customerId
                                 && data.Shipped == shipped
                              select new CustomerOrder
                              {
                                  OrderId = data.OrderID,
                                  Employee = data.Employee.FirstName 
                                           + " "
                                           + data.Employee.LastName,
                                  OrderDate = data.OrderDate,
                                  RequiredDate = data.RequiredDate,
                                  Freight = data.Freight,
                                  Shipments = from sent in data.Shipments
                                              select new ShipmentSummary
                                              {
                                                  ShippedOn = sent.ShippedDate,
                                                  Carrier = sent.Shipper.CompanyName
                                              },
                                  OrderTotal = data.OrderDetails.Sum(x => x.Quantity * x.UnitPrice)
                              };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<string> ListCountries()
        {
            using (var context = new WestWindContext())
            {
                var eCountries = context.Employees.Select(x => x.Country);
                var cCountries = context.Customers.Select(x => x.Country);
                var result = eCountries.Union(cCountries).Distinct().ToList();
                result.Sort();
                return result;
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<KeyValueOption> GetShippers()
        {
            using (var context = new WestWindContext())
            {
                var result =
                    context
                    .Shippers
                    .Select(x => new KeyValueOption
                    {
                        Key = x.ShipperID.ToString(),
                        Text = x.CompanyName
                    });
                return result.ToList();
            }
        }
        #endregion

        #region Methods for Manual UI Processing
        #region Query Responsibility
        public CustomerSummary GetCustomerSummary(string customerId)
        {
            using (var context = new WestWindContext())
            {
                var customer = context.Customers.Find(customerId);
                if (customer == null)
                    throw new ArgumentException("Customer does not exist", nameof(customerId));
                return new CustomerSummary
                {
                    CompanyName = customer.CompanyName,
                    ContactName = $"{customer.ContactName} ({customer.ContactTitle})",
                    Phone = customer.Phone,
                    Fax = customer.Fax
                };
            }
        }

        public ProductItem GetProduct(int productId)
        {
            using (var context = new WestWindContext())
            {
                var result = from item in context.Products
                             where item.ProductID == productId
                             select new ProductItem
                             {
                                 ProductId = item.ProductID,
                                 ProductName = item.ProductName,
                                 QuantityPerUnit = item.QuantityPerUnit,
                                 UnitPrice = item.UnitPrice
                             };
                return result.Single();
            }
        }

        public CustomerOrderWithDetails GetExistingOrder(int orderId)
        {
            using (var context = new WestWindContext())
            {
                // Added .ToList()because the .Sum() below
                // won't work on null values in SQL, but works in-memory

                var result = (from data in context.Orders
                              where data.OrderID == orderId
                              select new CustomerOrderWithDetails
                              {
                                  OrderId = data.OrderID,
                                  Employee = data.Employee.FirstName + " " + data.Employee.LastName,
                                  OrderDate = data.OrderDate,
                                  RequiredDate = data.RequiredDate,
                                  Freight = data.Freight,
                                  Shipments = from sent in data.Shipments
                                              select new ShipmentSummary
                                              {
                                                  ShippedOn = sent.ShippedDate,
                                                  Carrier = sent.Shipper.CompanyName
                                              },
                                  OrderTotal = data.OrderDetails.Sum(x => x.Quantity * x.UnitPrice)
                              }).Single();

                result.Details = (from data in context.Orders
                                  where data.OrderID == orderId
                                  from item in data.OrderDetails
                                 select new CustomerOrderItem
                                 {
                                     OrderId = item.OrderID,
                                     ProductId = item.ProductID,
                                     ProductName = item.Product.ProductName,
                                     UnitPrice = item.UnitPrice,
                                     Quantity = item.Quantity,
                                     DiscountPercent = item.Discount,
                                     QuantityPerUnit = item.Product.QuantityPerUnit
                                 }).ToList();

                return result;
            }
        }
        #endregion

        #region Command Responsibility
        public void Save(EditCustomerOrder order)
        {
            // Always ensure you have been given data to work with
            if (order == null)
                throw new ArgumentNullException("order", "Cannot save order; order information was not supplied.");

            // Business validation rules
            if (order.OrderDate.HasValue)
                throw new Exception($"An order date of {order.OrderDate.Value.ToLongDateString()} has been supplied. The order date should only be supplied when placing orders, not saving them.");

            // Decide whether to add new or update
            //  NOTE: Notice that no db activity is occurring yet.
            if (order.OrderId == 0)
                AddPendingOrder(order);
            else
                UpdatePendingOrder(order);
        }

        /// <summary>
        /// AddOrder will create a new customer order, processing it as a single transaction.
        /// </summary>
        /// <param name="order">The particulars of the order</param>
        private void AddPendingOrder(EditCustomerOrder order)
        {
            using (var context = new WestWindContext())
            {
                var orderInProcess = context.Orders.Add(new Order());
                // Make the orderInProcess match the customer order as given...
                // A) The general order information
                orderInProcess.CustomerID = order.CustomerId;
                orderInProcess.SalesRepID = order.EmployeeId;
                orderInProcess.RequiredDate = order.RequiredDate;
                orderInProcess.Freight = order.FreightCharge;
                // B) Add order details
                foreach (var item in order.OrderItems)
                {
                    // Add as a new item
                    var newItem = new OrderDetail
                    {
                        ProductID = item.ProductId,
                        Quantity = item.OrderQuantity,
                        UnitPrice = item.UnitPrice,
                        Discount = item.DiscountPercent
                    };
                    orderInProcess.OrderDetails.Add(newItem);
                }

                // C) Save the changes (one save, one transaction)
                context.SaveChanges();
            }
        }

        /// <summary>
        /// UpdateExistingOrder will make changes to an existing customer order, processing it as a single transaction.
        /// </summary>
        /// <param name="order">The particulars of the order</param>
        private void UpdatePendingOrder(EditCustomerOrder order)
        {
            using (var context = new WestWindContext())
            {
                var orderInProcess = context.Orders.Find(order.OrderId);
                if (orderInProcess == null)
                    throw new Exception("The order could not be found");
                // Make the orderInProcess match the customer order as given...
                // A) The general order information
                orderInProcess.CustomerID = order.CustomerId;
                orderInProcess.SalesRepID = order.EmployeeId;
                orderInProcess.RequiredDate = order.RequiredDate;
                orderInProcess.Freight = order.FreightCharge;

                // B) Add/Update/Delete order details
                //    Loop through the items as known in the database (to update/remove)
                foreach (var detail in orderInProcess.OrderDetails)
                {
                    var changes = order.OrderItems.SingleOrDefault(x => x.ProductId == detail.ProductID);
                    if (changes == null)
                        //toRemove.Add(detail);
                        context.Entry(detail).State = EntityState.Deleted; // flag for deletion
                    else
                    {
                        detail.Discount = changes.DiscountPercent;
                        detail.Quantity = changes.OrderQuantity;
                        detail.UnitPrice = changes.UnitPrice;
                        context.Entry(detail).State = EntityState.Modified;
                    }
                }
                //    Loop through the new items to add to the database
                foreach (var item in order.OrderItems)
                {
                    bool notPresent = !orderInProcess.OrderDetails.Any(x => x.ProductID == item.ProductId);
                    if (notPresent)
                    {
                        // Add as a new item
                        var newItem = new OrderDetail
                        {
                            ProductID = item.ProductId,
                            Quantity = item.OrderQuantity,
                            UnitPrice = item.UnitPrice,
                            Discount = item.DiscountPercent
                        };
                        orderInProcess.OrderDetails.Add(newItem);
                    }
                }

                // C) Save the changes (one save, one transaction)
                context.Entry(orderInProcess).State = EntityState.Modified;
                context.SaveChanges();
            }
        }

        public void PlaceOrder(EditCustomerOrder order)
        {
            // Always ensure you have been given data to work with
            if (order == null)
                throw new ArgumentNullException("order", "Cannot place order; order information was not supplied.");

            // Business validation rules
            if (!order.RequiredDate.HasValue)
                throw new Exception($"A  required date for the order is required when placing orders.");
            if (order.OrderItems.Count() == 0)
                throw new Exception("An order must have at least one item before it can be placed.");

            // Begin processing the order
            order.OrderDate = DateTime.Today;
            using (var context = new WestWindContext())
            {
                // Prep for processing...
                var customer = context.Customers.Find(order.CustomerId);
                if (customer == null)
                    throw new Exception("Customer does not exist");
                var orderInProcess = context.Orders.Find(order.OrderId);
                if (orderInProcess == null)
                    orderInProcess = context.Orders.Add(new Order());
                else
                {
                    if (orderInProcess.OrderDate.HasValue)
                        throw new Exception("Aborting changes: The order has previously been placed.");
                    context.Entry(orderInProcess).State = EntityState.Modified;
                }
                // Make the orderInProcess match the customer order as given...
                // A) The general order information
                orderInProcess.CustomerID = order.CustomerId;
                orderInProcess.SalesRepID = order.EmployeeId;
                orderInProcess.OrderDate = order.OrderDate;
                orderInProcess.RequiredDate = order.RequiredDate;
                orderInProcess.Freight = order.FreightCharge;

                // B) Default the ship-to info to the customer's info
                orderInProcess.ShipName = customer.CompanyName;
                orderInProcess.ShipAddress = customer.Address;
                orderInProcess.ShipCity = customer.City;
                orderInProcess.ShipRegion = customer.Region;
                orderInProcess.ShipPostalCode = customer.PostalCode;

                // C) Add/Remove/Update order details
                //var toRemove = new List<OrderDetail>();
                foreach (var detail in orderInProcess.OrderDetails)
                {
                    var changes = order.OrderItems.SingleOrDefault(x => x.ProductId == detail.ProductID);
                    if (changes == null)
                        //toRemove.Add(detail);
                        context.Entry(detail).State = EntityState.Deleted; // flag for deletion
                    else
                    {
                        detail.Discount = changes.DiscountPercent;
                        detail.Quantity = changes.OrderQuantity;
                        detail.UnitPrice = changes.UnitPrice;
                        context.Entry(detail).State = EntityState.Modified;
                    }
                }
                foreach (var item in order.OrderItems)
                {
                    if (!orderInProcess.OrderDetails.Any(x => x.ProductID == item.ProductId))
                    {
                        // Add as a new item
                        var newItem = new OrderDetail
                        {
                            ProductID = item.ProductId,
                            Quantity = item.OrderQuantity,
                            UnitPrice = item.UnitPrice,
                            Discount = item.DiscountPercent
                        };
                        orderInProcess.OrderDetails.Add(newItem);
                    }
                }

                // D) Save the changes (one save, one transaction)
                context.SaveChanges();
            }
        }
        #endregion
        #endregion

        #region Reporting
        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<RegionalManager> GetRegionalManagers()
        {
            using (var context = new WestWindContext())
            {
                var result = from emp in context.Employees
                             from data in emp.Territories
                             orderby data.Region.RegionDescription, emp.LastName, data.TerritoryDescription
                             select new RegionalManager
                             {
                                 Region = data.Region.RegionDescription,
                                 Territory = data.TerritoryDescription,
                                 TerritoryZip = data.TerritoryID,
                                 FirstName = emp.FirstName,
                                 LastName = emp.LastName,
                                 City = emp.City,
                                 State = emp.Region
                             };
                return result.ToList();
            }
        }
        #endregion
    }
}
