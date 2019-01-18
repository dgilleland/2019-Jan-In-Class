namespace WestWindSystem.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Shipment
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Shipment()
        {
            ManifestItems = new HashSet<ManifestItem>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ShipmentID { get; set; }

        public int OrderID { get; set; }

        public DateTime ShippedDate { get; set; }

        public int ShipVia { get; set; }

        [Column(TypeName = "money")]
        public decimal FreightCharge { get; set; }

        [StringLength(128)]
        public string TrackingCode { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ManifestItem> ManifestItems { get; set; }

        public virtual Order Order { get; set; }

        public virtual Shipper Shipper { get; set; }
    }
}
