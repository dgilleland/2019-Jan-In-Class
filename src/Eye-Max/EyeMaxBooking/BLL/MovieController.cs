using EyeMaxBooking.DAL;
using EyeMaxBooking.Entities;
using EyeMaxBooking.Entities.SharedModels;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EyeMaxBooking.BLL
{
    [DataObject]
    public class MovieController
    {
        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<Movie> ListAllMovies()
        {
            using (var context = new DAL.TheaterContext())
            {
                return context.Movies.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<Theater> ListAllTheaters()
        {
            using (var context = new DAL.TheaterContext())
            {
                return context.Theaters.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<MovieShowTime> GetShowTimes(int movieId)
        {
            using (var context = new TheaterContext())
            {
                var result = from movie in context.Movies
                             where movie.MovieId == movieId
                             from show in movie.ShowTimes
                             from room in show.Theaters
                             orderby show.StartTime
                             select new MovieShowTime
                             {
                                 ShowTimeId = show.ShowingId,
                                 TheaterId = room.TheaterId,
                                 StartTime = show.StartTime,
                                 TheaterNumber = room.Number
                             };
                return result.ToList();
            }
        }
    }
}
