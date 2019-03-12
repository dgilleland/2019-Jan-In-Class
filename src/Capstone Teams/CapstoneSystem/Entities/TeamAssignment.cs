namespace CapstoneSystem.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    internal partial class TeamAssignment
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int StudentId { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ClientId { get; set; }

        [StringLength(1)]
        public string TeamNumber { get; set; }

        public virtual CapstoneClient CapstoneClient { get; set; }

        public virtual Student Student { get; set; }
    }
}
