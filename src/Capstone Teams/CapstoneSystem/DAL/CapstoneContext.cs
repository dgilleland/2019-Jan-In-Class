namespace CapstoneSystem.DAL
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using CapstoneSystem.Entities;

    internal partial class CapstoneContext : DbContext
    {
        public CapstoneContext()
            : base("name=CapstoneDb")
        {
        }

        public virtual DbSet<CapstoneClient> CapstoneClients { get; set; }
        public virtual DbSet<Student> Students { get; set; }
        public virtual DbSet<TeamAssignment> TeamAssignments { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<CapstoneClient>()
                .HasMany(e => e.TeamAssignments)
                .WithRequired(e => e.CapstoneClient)
                .HasForeignKey(e => e.ClientId);
        }
    }
}
