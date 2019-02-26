using System;
using System.Collections.Generic;

namespace BackEnd.DataModels
{
    public class Ad
    {
        public int AdId { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public DateTime PostingDate { get; set; }
        public DateTime? LastUpdated { get; set; }
        public DateTime? ClosedDate { get; set; }
        public string EmailContact { get; set; }

        public List<Item> Items { get; set; } = new List<Item>();
    }
}
