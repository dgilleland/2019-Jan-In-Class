using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BackEnd.DataModels
{
    public class Member
    {
        public int MemberId { get; set; }
        public string Name { get; set; }

        public List<Ad> PostedAds { get; set; } = new List<Ad>();
    }
}
