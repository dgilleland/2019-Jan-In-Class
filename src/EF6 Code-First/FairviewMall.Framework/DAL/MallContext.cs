using FairviewMall.Framework.Entities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FairviewMall.Framework.DAL
{
    public class MallContext : DbContext
    {
        public MallContext() : base("name=MallDb")
        {
        }

        #region Table References
        public DbSet<Bay> Bays { get; set; }
        public DbSet<Rental> Rentals { get; set; }
        public DbSet<BayRental> BayRentals { get; set; }

        public DbSet<DbHistory> DatabaseVersions { get; set; }
        #endregion
    }
}
