namespace EyeMaxBooking.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCommit : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Movies",
                c => new
                    {
                        MovieId = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                    })
                .PrimaryKey(t => t.MovieId);
            
            CreateTable(
                "dbo.Showings",
                c => new
                    {
                        ShowingId = c.Int(nullable: false, identity: true),
                        MovieId = c.Int(nullable: false),
                        StartTime = c.DateTime(nullable: false),
                        EndTime = c.DateTime(nullable: false),
                        Is3D = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.ShowingId)
                .ForeignKey("dbo.Movies", t => t.MovieId, cascadeDelete: true)
                .Index(t => t.MovieId);
            
            CreateTable(
                "dbo.Reservations",
                c => new
                    {
                        ReservationId = c.Int(nullable: false, identity: true),
                        ShowingId = c.Int(nullable: false),
                        TheaterId = c.Int(nullable: false),
                        Row = c.String(),
                        SeatNumber = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.ReservationId)
                .ForeignKey("dbo.Showings", t => t.ShowingId, cascadeDelete: true)
                .ForeignKey("dbo.Theaters", t => t.TheaterId, cascadeDelete: true)
                .Index(t => t.ShowingId)
                .Index(t => t.TheaterId);
            
            CreateTable(
                "dbo.Theaters",
                c => new
                    {
                        TheaterId = c.Int(nullable: false, identity: true),
                        Number = c.Int(nullable: false),
                        MaxRow = c.String(nullable: false, maxLength: 1),
                        MaxSeatPerRow = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.TheaterId);
            
            CreateTable(
                "dbo.TheaterShowings",
                c => new
                    {
                        Theater_TheaterId = c.Int(nullable: false),
                        Showing_ShowingId = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.Theater_TheaterId, t.Showing_ShowingId })
                .ForeignKey("dbo.Theaters", t => t.Theater_TheaterId, cascadeDelete: true)
                .ForeignKey("dbo.Showings", t => t.Showing_ShowingId, cascadeDelete: true)
                .Index(t => t.Theater_TheaterId)
                .Index(t => t.Showing_ShowingId);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Reservations", "TheaterId", "dbo.Theaters");
            DropForeignKey("dbo.TheaterShowings", "Showing_ShowingId", "dbo.Showings");
            DropForeignKey("dbo.TheaterShowings", "Theater_TheaterId", "dbo.Theaters");
            DropForeignKey("dbo.Reservations", "ShowingId", "dbo.Showings");
            DropForeignKey("dbo.Showings", "MovieId", "dbo.Movies");
            DropIndex("dbo.TheaterShowings", new[] { "Showing_ShowingId" });
            DropIndex("dbo.TheaterShowings", new[] { "Theater_TheaterId" });
            DropIndex("dbo.Reservations", new[] { "TheaterId" });
            DropIndex("dbo.Reservations", new[] { "ShowingId" });
            DropIndex("dbo.Showings", new[] { "MovieId" });
            DropTable("dbo.TheaterShowings");
            DropTable("dbo.Theaters");
            DropTable("dbo.Reservations");
            DropTable("dbo.Showings");
            DropTable("dbo.Movies");
        }
    }
}
