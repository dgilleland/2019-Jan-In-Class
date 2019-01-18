namespace WestWindSystem.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Payment
    {
        public int PaymentID { get; set; }

        public DateTime PaymentDate { get; set; }

        [Column(TypeName = "smallmoney")]
        public decimal Amount { get; set; }

        public byte PaymentTypeID { get; set; }

        public int OrderID { get; set; }

        public virtual Order Order { get; set; }

        public virtual PaymentType PaymentType { get; set; }
    }
}
