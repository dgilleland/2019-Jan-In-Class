using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace WebApp.Admin.Security
{
    /// <summary>
    /// A colletion of application wide settings that provide values which
    /// have been set in the web.config's <appSettings /> section.
    /// </summary>
    public static class Settings
    {
        public static string AdminRole => ConfigurationManager.AppSettings["adminRole"];

        public static string CustomerRole
        { get { return ConfigurationManager.AppSettings["customerRole"]; } }
        public static string EmployeeRole
        { get { return ConfigurationManager.AppSettings["employeeRole"]; } }
        public static string SupplierRole
        { get { return ConfigurationManager.AppSettings["supplierRole"]; } }
    }
}