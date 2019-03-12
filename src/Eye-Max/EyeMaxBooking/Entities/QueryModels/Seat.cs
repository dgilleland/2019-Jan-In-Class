using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EyeMaxBooking.Entities.QueryModels
{
    /// <summary>
    /// A single seat in a theater.
    /// </summary>
    public class Seat
    {
        public string Row { get; set; }
        public int Number { get; set; }
        public bool Reserved { get; set; }
        public override string ToString()
        {
            return $"{Row}-{Number,2:D2}";
        }
    }

    public class TheaterBookings
    {
        public int TheaterNumber { get; set; }
        public int SeatsPerRow { get; set; }
        public IEnumerable<Seat> Seats { get; set; }
    }

    /// <summary>
    /// Represents seating and theater information for a specific movie.
    /// </summary>
    public class Show
    {
        public int ShowingId { get; set; }
        public int TheaterId { get; set; }
        public int TheaterNumber { get; set; }
        public string MovieTitle { get; set; }
        public IEnumerable<Seat> Seating { get; set; }
        public int SeatsPerRow { get; set; }
    }
    /// <summary>
    /// A show time for a movie.
    /// </summary>
    public class ShowTime
    {
        public int ShowingId { get; set; }
        public int TheaterId { get; set; }
        public int TheaterNumber { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public TimeSpan Length { get { return EndTime - StartTime; } }
    }

}
