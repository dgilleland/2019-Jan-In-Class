using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EyeMaxBooking.Entities.SharedModels
{
    public class MovieShowTime
    {
        public int ShowTimeId { get; set; }
        public int TheaterId { get; set; }
        public int TheaterNumber { get; set; }
        public DateTime StartTime { get; set; }
    }
}
