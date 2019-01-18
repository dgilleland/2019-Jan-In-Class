namespace WestWindSystem.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class ManifestItem
    {
        public int ManifestItemID { get; set; }

        public int ShipmentID { get; set; }

        public int ProductID { get; set; }

        public short ShipQuantity { get; set; }

        public virtual Product Product { get; set; }

        public virtual Shipment Shipment { get; set; }
    }
}
