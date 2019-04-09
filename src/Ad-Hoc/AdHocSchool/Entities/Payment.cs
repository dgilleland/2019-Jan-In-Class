namespace AdHocSchool.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Payment")]
    public partial class Payment
    {
        public int PaymentID { get; set; }

        public DateTime PaymentDate { get; set; }

        public decimal Amount { get; set; }

        public byte PaymentTypeID { get; set; }

        public int StudentID { get; set; }

        public virtual PaymentType PaymentType { get; set; }

        public virtual Student Student { get; set; }
    }
}
