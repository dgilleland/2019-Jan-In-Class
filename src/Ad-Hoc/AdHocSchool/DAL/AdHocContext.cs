namespace AdHocSchool.DAL
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using AdHocSchool.Entities;

    public partial class AdHocContext : DbContext
    {
        public AdHocContext()
            : base("name=AdHocContext")
        {
        }

        public virtual DbSet<Club> Clubs { get; set; }
        public virtual DbSet<Course> Courses { get; set; }
        public virtual DbSet<Payment> Payments { get; set; }
        public virtual DbSet<PaymentType> PaymentTypes { get; set; }
        public virtual DbSet<Position> Positions { get; set; }
        public virtual DbSet<Registration> Registrations { get; set; }
        public virtual DbSet<Staff> Staffs { get; set; }
        public virtual DbSet<Student> Students { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Club>()
                .Property(e => e.ClubId)
                .IsUnicode(false);

            modelBuilder.Entity<Club>()
                .Property(e => e.ClubName)
                .IsUnicode(false);

            modelBuilder.Entity<Club>()
                .HasMany(e => e.Students)
                .WithMany(e => e.Clubs)
                .Map(m => m.ToTable("Activity").MapLeftKey("ClubId").MapRightKey("StudentID"));

            modelBuilder.Entity<Course>()
                .Property(e => e.CourseId)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Course>()
                .Property(e => e.CourseName)
                .IsUnicode(false);

            modelBuilder.Entity<Course>()
                .Property(e => e.CourseCost)
                .HasPrecision(6, 2);

            modelBuilder.Entity<Course>()
                .HasMany(e => e.Registrations)
                .WithRequired(e => e.Course)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Payment>()
                .Property(e => e.Amount)
                .HasPrecision(6, 2);

            modelBuilder.Entity<PaymentType>()
                .Property(e => e.PaymentTypeDescription)
                .IsUnicode(false);

            modelBuilder.Entity<PaymentType>()
                .HasMany(e => e.Payments)
                .WithRequired(e => e.PaymentType)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Position>()
                .Property(e => e.PositionDescription)
                .IsUnicode(false);

            modelBuilder.Entity<Position>()
                .HasMany(e => e.Staffs)
                .WithRequired(e => e.Position)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Registration>()
                .Property(e => e.CourseId)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Registration>()
                .Property(e => e.Semester)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Registration>()
                .Property(e => e.Mark)
                .HasPrecision(5, 2);

            modelBuilder.Entity<Registration>()
                .Property(e => e.WithdrawYN)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Staff>()
                .Property(e => e.FirstName)
                .IsUnicode(false);

            modelBuilder.Entity<Staff>()
                .Property(e => e.LastName)
                .IsUnicode(false);

            modelBuilder.Entity<Staff>()
                .Property(e => e.LoginID)
                .IsUnicode(false);

            modelBuilder.Entity<Student>()
                .Property(e => e.FirstName)
                .IsUnicode(false);

            modelBuilder.Entity<Student>()
                .Property(e => e.LastName)
                .IsUnicode(false);

            modelBuilder.Entity<Student>()
                .Property(e => e.Gender)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Student>()
                .Property(e => e.StreetAddress)
                .IsUnicode(false);

            modelBuilder.Entity<Student>()
                .Property(e => e.City)
                .IsUnicode(false);

            modelBuilder.Entity<Student>()
                .Property(e => e.Province)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Student>()
                .Property(e => e.PostalCode)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<Student>()
                .Property(e => e.BalanceOwing)
                .HasPrecision(7, 2);

            modelBuilder.Entity<Student>()
                .HasMany(e => e.Payments)
                .WithRequired(e => e.Student)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Student>()
                .HasMany(e => e.Registrations)
                .WithRequired(e => e.Student)
                .WillCascadeOnDelete(false);
        }
    }
}
