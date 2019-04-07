﻿using System;
using System.Collections.Generic;
using System.Linq;
using WestWindSystem.DAL;
using WestWindSystem.DataModels;

namespace WestWindSystem.BLL
{
    public class CategoryController
    {
        public List<DropDownSelection<int>> ListCategoriesNameAndId()
        {
            using (var context = new WestWindContext())
            {
                string sql = "SELECT CategoryID AS 'Value', CategoryName AS 'Text' FROM Categories ORDER BY CategoryName";
                var result = context.Database.SqlQuery<DropDownSelection<int>>(sql);
                return result.ToList();
            }
        }
    }
}
