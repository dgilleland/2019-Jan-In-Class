using EyeMaxBooking.DAL;
using EyeMaxBooking.Entities.CommandModels;
using EyeMaxBooking.Entities.QueryModels;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EyeMaxBooking.BLL
{
    [DataObject]
    public class BookingController
    {
        [DataObjectMethod(DataObjectMethodType.Select)]
        public IList<KeyValuePair<int, string>> ListMovies()
        {
            using (var context = new TheaterContext())
            {
                var results = from data in context.Movies.ToList()
                              select new KeyValuePair<int, string>(data.MovieId, data.Name);
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public IList<ShowTime> GetShowTimes(int movieId)
        {
            using (var context = new TheaterContext())
            {
                var results = from data in context.Showings
                              where data.MovieId == movieId
                              from room in data.Theaters
                              select new ShowTime
                              {
                                  TheaterNumber = room.Number,
                                  ShowingId = data.ShowingId,
                                  TheaterId = room.TheaterId,
                                  StartTime = data.StartTime,
                                  EndTime = data.EndTime
                              };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public TheaterBookings GetAvailability(int showId, int theaterId)
        {
            using (var context = new TheaterContext())
            {
                // Get the room
                var room = context.Theaters.Find(theaterId);

                // Make all the seats
                var seats = new List<Seat>();
                for (int row = 0, max = room.MaxRow.ToUpper()[0] - 'A'; row < max; row++)
                    for (int seat = 1; seat <= room.MaxSeatPerRow; seat++)
                        seats.Add(new Seat { Number = seat, Row = ((char)(row + 'A')).ToString() });

                // Get what's already booked
                var booked = from data in context.Reservations
                             where data.ShowingId == showId
                                && data.TheaterId == theaterId
                             select new Seat
                             {
                                 Reserved = true,
                                 Number = data.SeatNumber,
                                 Row = data.Row
                             };

                // Update my seating info
                foreach (var spot in booked)
                    seats.Single(x => x.Row == spot.Row && x.Number == spot.Number).Reserved = true;

                var result = new TheaterBookings
                {
                    TheaterNumber = room.Number,
                    SeatsPerRow = room.MaxSeatPerRow,
                    Seats = seats
                };

                return result;
            }
        }

        public void ReserveShow(MovieReservation reservation)
        {
            if (reservation == null)
                throw new ArgumentNullException(nameof(reservation), $"{nameof(reservation)} is null.");
            if (reservation.Seats.Count() == 0)
                throw new ArgumentException("At least one seat must be selected to book a reservation.");
            using (var context = new TheaterContext())
            {
                foreach(var seat in reservation.Seats)
                {
                    var existing = context.Reservations.SingleOrDefault(x => x.ShowingId == reservation.ShowingId && x.TheaterId == reservation.TheaterId && x.Row == seat.Row && x.SeatNumber == seat.Number);
                    if (existing != null)
                        throw new Exception($"Seat {seat.Row}-{seat.Number} has already been reserved.");
                    context.Reservations.Add(new Entities.Reservation
                    {
                        ShowingId = reservation.ShowingId,
                        TheaterId = reservation.TheaterId,
                        Row = seat.Row,
                        SeatNumber = seat.Number
                    });
                }

                context.SaveChanges();
            }
        }
    }
}
