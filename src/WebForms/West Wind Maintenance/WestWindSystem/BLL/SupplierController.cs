﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WestWindModels;
using WestWindSystem.DAL;

namespace WestWindSystem.BLL
{
    public class SupplierController
    {
        // Use this class to help us with CRUD maintenance of our database
        public List<Supplier> ListSuppliers()
        {
            // Make use of our "virtual database" class to get the data
            using (var context = new WestWindContext())
            {
                return context.Suppliers.ToList();
            }
        }

        public Supplier GetSuppier(int id)
        {
            using (var context = new WestWindContext())
            {
                // The .Find() method will look up the object based on its primary key
                return context.Suppliers.Find(id);
            }
        }
    }
}
