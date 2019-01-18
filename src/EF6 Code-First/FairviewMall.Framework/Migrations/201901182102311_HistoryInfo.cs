namespace FairviewMall.Framework.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class HistoryInfo : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.DbHistory",
                c => new
                    {
                        HistoryID = c.Int(nullable: false, identity: true),
                        TagName = c.String(maxLength: 25),
                        Major = c.Int(nullable: false),
                        Minor = c.Int(nullable: false),
                        Build = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.HistoryID);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.DbHistory");
        }
    }
}
