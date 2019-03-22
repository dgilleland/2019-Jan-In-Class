using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WestWindSystem.DAL;
using WestWindSystem.DataModels;

namespace WestWindSystem.BLL
{
    public class AboutController
    {
        public DatabaseVersion GetDatabaseVersion()
        {
            using (var context = new WestWindContext())
            {
                var info = context.BuildVersions.ToList().Last();
                return new DatabaseVersion
                {
                    Version = new Version(info.Major, info.Minor, info.Build),
                    ReleaseDate = info.ReleaseDate
                };
            }
        }
    }
}
