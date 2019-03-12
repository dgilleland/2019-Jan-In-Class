namespace CapstoneSystem.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    internal partial class CapstoneClient
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CapstoneClient()
        {
            TeamAssignments = new HashSet<TeamAssignment>();
        }

        public int Id { get; set; }

        [Required]
        public string CompanyName { get; set; }

        public string Slogan { get; set; }

        [Required]
        public string ContactName { get; set; }

        public bool Confirmed { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TeamAssignment> TeamAssignments { get; set; }
    }
}
