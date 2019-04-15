namespace AdHocSchool.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Course")]
    public partial class Course
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Course()
        {
            Registrations = new HashSet<Registration>();
        }

        [StringLength(7)]
        public string CourseId { get; set; }

        [Required]
        [StringLength(40)]
        public string CourseName { get; set; }

        public short CourseHours { get; set; }

        public int? MaxStudents { get; set; }

        public decimal CourseCost { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Registration> Registrations { get; set; }
    }
}
