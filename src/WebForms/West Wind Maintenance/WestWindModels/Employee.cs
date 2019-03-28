using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace WestWindModels
{
    [Table("Employees")]
    public class Employee
    {
        public int EmployeeID { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string TitleOfCourtesy { get; set; }
        public string JobTitle { get; set; }
        public int? ReportsTo { get; set; }
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
        public bool? Active { get; set; }
        public DateTime? TerminationDate { get; set; }
        public bool OnLeave { get; set; }
        public string LeaveReason { get; set; }
        public DateTime? ReturnDate { get; set; }

        [NotMapped]
        public string FullName
        { get { return $"{TitleOfCourtesy} {FirstName} {LastName}".Trim(); } }

        [NotMapped]
        public string FormalName
        { get { return $"{LastName}, {FirstName}"; } }
    }
}
