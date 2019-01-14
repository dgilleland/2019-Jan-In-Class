using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WestWindConsole.Entities
{
    [Table("Employees")]
    public class Employee
    {
        [Key]
        public int EmployeeID { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string TitleOfCourtesy { get; set; }
        public string JobTitle { get; set; }
        public int? ReportsTo { get; set; }  // FK to the employee who is a manager
        public DateTime HireDate { get; set; }
        public string OfficePhone { get; set; }
        public string Extension { get; set; }
        public DateTime BirthDate { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Region { get; set; }
        public string PostalCode { get; set; }
        public string Country { get; set; }
        public string HomePhone { get; set; }
        public byte[] Photo { get; set; }
        public string PhotoMimeType { get; set; }
        public string Notes { get; set; }
        public bool Active { get; set; }

        #region Not-Mapped Properties
        // NotMapped properties are properties that exist on the Entity, but NOT in the Database
        [NotMapped]
        public string FullName
        { get { return FirstName + " " + LastName; } }
        #endregion

        #region Navigation Properties
        // Virtual properties in Entity Framework entities allow for "lazy loading"
        [ForeignKey(nameof(ReportsTo))]
        public virtual Employee Manager { get; set; }

        // Always initialize collection navigational properties to a HashSet<Entity>()
        public virtual ICollection<Employee> Subordinates { get; set; } =
            new HashSet<Employee>();
        #endregion
    }
}



