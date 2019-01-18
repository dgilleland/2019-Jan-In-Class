namespace FairviewMall.Framework.Migrations
{
    using FairviewMall.Framework.Entities;
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<FairviewMall.Framework.DAL.MallContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(FairviewMall.Framework.DAL.MallContext context)
        {
            //  Seeding means we populate the database with data.
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data.
            char bayNumber = 'A';
            for(int count = 0; count < 15; count++)
            {
                string id = "Bay-" + (char)(bayNumber + count);
                var bay = new Bay
                {   // this is an Initializer List
                    BayID = id,
                    FloorSpace = 800
                };
                if(count == 3 || count == 12)
                {
                    bay.ReservedUse = "Bathrooms";
                }
                // Add this to our database
                context.Bays.AddOrUpdate(bay);
            }
        }
    }
}
