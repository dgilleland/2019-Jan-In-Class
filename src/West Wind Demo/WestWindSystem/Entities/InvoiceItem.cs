namespace WestWindSystem.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class InvoiceItem
    {
        [StringLength(40)]
        public string ShipName { get; set; }

        [StringLength(60)]
        public string ShipAddress { get; set; }

        [StringLength(15)]
        public string ShipCity { get; set; }

        [StringLength(15)]
        public string ShipRegion { get; set; }

        [StringLength(10)]
        public string ShipPostalCode { get; set; }

        [StringLength(15)]
        public string ShipCountry { get; set; }

        [StringLength(5)]
        public string CustomerID { get; set; }

        [Key]
        [Column(Order = 0)]
        [StringLength(40)]
        public string CompanyName { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(60)]
        public string Address { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(15)]
        public string City { get; set; }

        [StringLength(15)]
        public string Region { get; set; }

        [StringLength(10)]
        public string PostalCode { get; set; }

        [Key]
        [Column(Order = 3)]
        [StringLength(15)]
        public string Country { get; set; }

        [Key]
        [Column(Order = 4)]
        [StringLength(31)]
        public string SalesRep { get; set; }

        [Key]
        [Column(Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int OrderID { get; set; }

        public DateTime? OrderDate { get; set; }

        public DateTime? RequiredDate { get; set; }

        [Key]
        [Column(Order = 6)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ProductID { get; set; }

        [Key]
        [Column(Order = 7)]
        [StringLength(40)]
        public string ProductName { get; set; }

        [Key]
        [Column(Order = 8, TypeName = "money")]
        public decimal UnitPrice { get; set; }

        [Key]
        [Column(Order = 9)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Quantity { get; set; }

        [Key]
        [Column(Order = 10)]
        public float Discount { get; set; }

        [Column(TypeName = "money")]
        public decimal? ExtendedPrice { get; set; }

        [Column(TypeName = "money")]
        public decimal? Freight { get; set; }
    }
}
