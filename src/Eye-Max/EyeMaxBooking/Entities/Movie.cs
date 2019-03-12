using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EyeMaxBooking.Entities
{
    public class Movie
    {
        public int MovieId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Showing> ShowTimes { get; set; }
            = new HashSet<Showing>();
    }
    public class Showing
    {
        public int ShowingId { get; set; }
        public int MovieId { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public bool Is3D { get; set; }

        public virtual Movie Movie { get; set; }
        public virtual ICollection<Reservation> Reservations { get; set; }
            = new HashSet<Reservation>();
        public virtual ICollection<Theater> Theaters { get; set; }
            = new HashSet<Theater>();
    }
    public class Reservation
    {
        public int ReservationId { get; set; }
        public int ShowingId { get; set; }
        public int TheaterId { get; set; }
        public string Row { get; set; }
        public int SeatNumber { get; set; }
        /// <summary>In the form of "{Row}-{SeatNumber}". E.g.: "A-11"</summary>
        [NotMapped]
        public string Seat { get { return $"{Row}-{SeatNumber}"; } }

        public virtual Showing ShowTime { get; set; }
        public virtual Theater Theater { get; set; }
    }
    public class Theater
    {
        public int TheaterId { get; set; }
        public int Number { get; set; }
        [MaxLength(1), Required]
        public string MaxRow { get; set; }
        public int MaxSeatPerRow { get; set; }

        public virtual ICollection<Showing> Shows { get; set; }
    }
}
