namespace FairviewMall.Framework.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialSchema : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.BayRentals",
                c => new
                    {
                        BayID = c.String(nullable: false, maxLength: 128),
                        RentalID = c.Int(nullable: false),
                        Quadrants = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.BayID, t.RentalID })
                .ForeignKey("dbo.Bays", t => t.BayID, cascadeDelete: true)
                .ForeignKey("dbo.Rentals", t => t.RentalID, cascadeDelete: true)
                .Index(t => t.BayID)
                .Index(t => t.RentalID);
            
            CreateTable(
                "dbo.Bays",
                c => new
                    {
                        BayID = c.String(nullable: false, maxLength: 128),
                        FloorSpace = c.Int(nullable: false),
                        ReservedUse = c.String(maxLength: 25),
                    })
                .PrimaryKey(t => t.BayID);
            
            CreateTable(
                "dbo.Rentals",
                c => new
                    {
                        RentalID = c.Int(nullable: false, identity: true),
                        CompanyName = c.String(nullable: false, maxLength: 30),
                        Website = c.String(maxLength: 40),
                        PhoneNumber = c.String(nullable: false, maxLength: 12, fixedLength: true, unicode: false),
                        ContactName = c.String(nullable: false, maxLength: 50),
                        RentalTerm = c.Int(nullable: false),
                        MonthlyRate = c.Decimal(nullable: false, storeType: "money"),
                        StartingDate = c.DateTime(nullable: false),
                        ClosingDate = c.DateTime(),
                    })
                .PrimaryKey(t => t.RentalID);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.BayRentals", "RentalID", "dbo.Rentals");
            DropForeignKey("dbo.BayRentals", "BayID", "dbo.Bays");
            DropIndex("dbo.BayRentals", new[] { "RentalID" });
            DropIndex("dbo.BayRentals", new[] { "BayID" });
            DropTable("dbo.Rentals");
            DropTable("dbo.Bays");
            DropTable("dbo.BayRentals");
        }
    }
}
