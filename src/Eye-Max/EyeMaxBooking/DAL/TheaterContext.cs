using EyeMaxBooking.Entities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EyeMaxBooking.DAL
{
    internal class TheaterContext : DbContext
    {
        public TheaterContext() : base("name=EMB")
        {
        }

        public DbSet<Movie> Movies { get; set; }
        public DbSet<Showing> Showings { get; set; }
        public DbSet<Reservation> Reservations { get; set; }
        public DbSet<Theater> Theaters { get; set; }
    }
}
