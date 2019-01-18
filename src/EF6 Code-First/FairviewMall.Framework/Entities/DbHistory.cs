using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FairviewMall.Framework.Entities
{
    [Table("DbHistory")]
    public class DbHistory
    {
        [Key]
        public int HistoryID { get; set; }
        [MaxLength(25)]
        public string TagName { get; set; }
        public int Major { get; set; }
        public int Minor { get; set; }
        public int Build { get; set; }
    }
}
