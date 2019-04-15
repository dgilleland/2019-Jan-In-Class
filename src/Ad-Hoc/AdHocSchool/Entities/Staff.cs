namespace AdHocSchool.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Staff")]
    public partial class Staff
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Staff()
        {
            Registrations = new HashSet<Registration>();
        }

        public short StaffID { get; set; }

        [Required]
        [StringLength(25)]
        public string FirstName { get; set; }

        [Required]
        [StringLength(35)]
        public string LastName { get; set; }

        [Column(TypeName = "smalldatetime")]
        public DateTime DateHired { get; set; }

        [Column(TypeName = "smalldatetime")]
        public DateTime? DateReleased { get; set; }

        public byte PositionID { get; set; }

        [StringLength(30)]
        public string LoginID { get; set; }

        public virtual Position Position { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Registration> Registrations { get; set; }
    }
}
