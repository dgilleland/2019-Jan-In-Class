using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EyeMaxBooking.Entities.CommandModels
{
    public class MovieReservation
    {
        public int ShowingId { get; set; }
        public int TheaterId { get; set; }
        public IEnumerable<SeatReservation> Seats { get; set; }
    }
    public class SeatReservation
    {
        public string Row { get; set; }
        public int Number { get; set; }
        public override string ToString()
        {
            return $"{Row}-{Number,2:D2}";
        }
    }
}
