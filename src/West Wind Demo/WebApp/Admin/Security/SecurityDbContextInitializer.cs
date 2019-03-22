using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Web;
using WebApp.Models;
using WestWindSystem.BLL;
using WestWindSystem.DataModels;

// You can learn about Database Initialization Strategies in EF6 via
// http://www.entityframeworktutorial.net/code-first/database-initialization-strategy-in-code-first.aspx

namespace WebApp.Admin.Security
{
    /// <summary>
    /// Provide functionality for setting up the database for the ApplicationDbContext.
    /// The specific functionality is to create the database if it does not exist.
    /// </summary>
    public class SecurityDbContextInitializer : CreateDatabaseIfNotExists<ApplicationDbContext>
    {
        protected override void Seed(ApplicationDbContext context)
        {
            // To "seed" a database is to provide it with some initial data
            // when the database is created.
            #region Seed the security roles
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
            var startupRoles = ConfigurationManager.AppSettings["startupRoles"].Split(';');
            foreach (var role in startupRoles)
                roleManager.Create(new IdentityRole { Name = role });
            #endregion

            #region Seed the users
            // First, create the administrator for the site
            string adminUser = ConfigurationManager.AppSettings["adminUserName"];
            string adminEmail = ConfigurationManager.AppSettings["adminEmail"];
            string adminPassword = ConfigurationManager.AppSettings["adminPassword"];
            var userManager = new ApplicationUserManager(new UserStore<ApplicationUser>(context));
            var result = userManager.Create(new ApplicationUser
            {
                UserName = adminUser,
                Email = adminEmail,
                EmailConfirmed = true
            }, adminPassword);
            if (result.Succeeded)
                userManager.AddToRole(userManager.FindByName(adminUser).Id, Settings.AdminRole);

            // Next, create login accounts for all the employees
            string defaultPassword = ConfigurationManager.AppSettings["defaultPassword"];
            string emailDomain = ConfigurationManager.AppSettings["companyDomain"];
            var controller = new SetupUserRegistrationController();
            IEnumerable<SetupUserInfo> employees = controller.GetActiveEmployees(emailDomain);
            foreach(var person in employees)
            {
                result = userManager.Create(new ApplicationUser
                {
                    UserName = person.UserName,
                    Email = person.EmailAddress,
                    EmailConfirmed = true,
                    EmployeeId = int.Parse(person.UserId)
                }, defaultPassword);
                if (result.Succeeded)
                    userManager.AddToRole(userManager.FindByName(person.UserName).Id, Settings.EmployeeRole);
            }

            // Also create login accounts for all the suppliers
            IEnumerable<SetupUserInfo> suppliers = controller.GetCurrentSuppliers();
            foreach (var supplier in suppliers)
            {
                result = userManager.Create(new ApplicationUser
                {
                    UserName = supplier.UserName,
                    Email = supplier.EmailAddress,
                    EmailConfirmed = true,
                    SupplierId = int.Parse(supplier.UserId)
                }, defaultPassword);
                if (result.Succeeded)
                    userManager.AddToRole(userManager.FindByName(supplier.UserName).Id, Settings.SupplierRole);
            }

            // Lastly, create login accounts for all the customers
            IEnumerable<SetupUserInfo> customers = controller.GetCurrentCustomers();
            foreach(var company in customers)
            {
                result = userManager.Create(new ApplicationUser
                {
                    UserName = company.UserName,
                    Email = company.EmailAddress,
                    EmailConfirmed = true,
                    CustomerId = company.UserId
                }, defaultPassword);
                if (result.Succeeded)
                    userManager.AddToRole(userManager.FindByName(company.UserName).Id, Settings.CustomerRole);
            }
            #endregion

            base.Seed(context);
        }
    }
}