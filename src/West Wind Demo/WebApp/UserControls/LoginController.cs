using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using WebApp.Models;

namespace WebApp.UserControls
{
    [DataObject]
    public class LoginController
    {
        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<ListItem> ListRoles()
        {
            var dbContext = HttpContext.Current.GetOwinContext().Get<ApplicationDbContext>();
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(dbContext));
            var result = from role in roleManager.Roles
                         select new ListItem
                         {
                             Text = role.Name,
                             Value = role.Id
                         };
            return result.ToList();
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<ListItem> ListUsers(string roleId)
        {
            var context = HttpContext.Current;
            var userManager = context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var dbContext = context.GetOwinContext().Get<ApplicationDbContext>();
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(dbContext));
            if (roleId == null)
                return new List<ListItem>();
            var role = roleManager.FindById(roleId);
            var result = from user in role.Users
                         select new ListItem
                         {
                             Text = userManager.FindById(user.UserId).UserName,
                             Value = user.UserId
                         };
            return result.ToList();
        }
    }
}