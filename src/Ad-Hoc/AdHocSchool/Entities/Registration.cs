namespace AdHocSchool.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Registration")]
    public partial class Registration
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int StudentID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(7)]
        public string CourseId { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(5)]
        public string Semester { get; set; }

        public decimal? Mark { get; set; }

        [StringLength(1)]
        public string WithdrawYN { get; set; }

        public short? StaffID { get; set; }

        public virtual Course Course { get; set; }

        public virtual Staff Staff { get; set; }

        public virtual Student Student { get; set; }
    }
}
