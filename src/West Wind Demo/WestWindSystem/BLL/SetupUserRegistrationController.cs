using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WestWindSystem.DAL;
using WestWindSystem.DataModels;

namespace WestWindSystem.BLL
{
    public class SetupUserRegistrationController
    {
        public IEnumerable<SetupUserInfo> GetActiveEmployees(string emailDomain)
        {
            using (var context = new WestWindContext())
            {
                var results = from staff in context.Employees.ToList()
                              where !staff.TerminationDate.HasValue
                              select new SetupUserInfo
                              {
                                  UserId = staff.EmployeeID.ToString(),
                                  UserName = $"{staff.FirstName}.{staff.LastName}",
                                  EmailAddress = $"{staff.FirstName}.{staff.LastName}@{emailDomain}"
                              };
                return results;
            }
        }

        public IEnumerable<SetupUserInfo> GetCurrentSuppliers()
        {
            using (var context = new WestWindContext())
            {
                var results = from company in context.Suppliers.ToList()
                              select new SetupUserInfo
                              {
                                  UserId = company.SupplierID.ToString(),
                                  UserName = company.ContactName.Replace(' ', '.'),
                                  EmailAddress = company.Email
                              };
                return results;
            }
        }

        public IEnumerable<SetupUserInfo> GetCurrentCustomers()
        {
            using (var context = new WestWindContext())
            {
                var results = from company in context.Customers.ToList()
                              select new SetupUserInfo
                              {
                                  UserId = company.CustomerID,
                                  UserName = company.ContactName.Replace(' ', '.'),
                                  EmailAddress = company.ContactEmail
                              };
                return results;
            }
        }
    }
}
