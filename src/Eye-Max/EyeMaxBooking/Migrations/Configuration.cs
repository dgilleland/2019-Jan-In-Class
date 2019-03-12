using EyeMaxBooking.DAL;

namespace EyeMaxBooking.Migrations
{
    using EyeMaxBooking.Entities;
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<TheaterContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(TheaterContext context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data.
            context.Theaters.AddOrUpdate(room1, room2, room3, room4);

            context.Movies.AddOrUpdate(
                new Movie { Name = "Facing the Giants", ShowTimes = Times(room1, room2, room3, room4) },
                new Movie { Name = "Courageous", ShowTimes = Times(room3, room4, room1, room2) });
        }

        Theater room1 = new Theater { Number = 1, MaxRow = "G", MaxSeatPerRow = 12 };
        Theater room2 = new Theater { Number = 2, MaxRow = "G", MaxSeatPerRow = 12 };
        Theater room3 = new Theater { Number = 3, MaxRow = "G", MaxSeatPerRow = 12 };
        Theater room4 = new Theater { Number = 4, MaxRow = "G", MaxSeatPerRow = 12 };

        private Showing[] Times(Theater roomA, Theater roomB, Theater roomC, Theater roomD)
        {
            var times = new Showing[3];
            times[0] = new Showing
            {
                StartTime = new DateTime(2017, 12, 20, 16, 40, 0),
                EndTime = new DateTime(2017, 12, 20, 19, 20, 0),
                Theaters = {roomA, roomB}
            };
            times[1] = new Showing
            {
                StartTime = new DateTime(2017, 12, 20, 19, 10, 0),
                EndTime = new DateTime(2017, 12, 20, 21, 40, 0),
                Theaters = { roomC, roomD }
            };
            times[2] = new Showing
            {
                StartTime = new DateTime(2017, 12, 20, 21, 20, 0),
                EndTime = new DateTime(2017, 12, 20, 23, 50, 0),
                Theaters = { roomA, roomB }
            };
            return times;
        }
    }
}
