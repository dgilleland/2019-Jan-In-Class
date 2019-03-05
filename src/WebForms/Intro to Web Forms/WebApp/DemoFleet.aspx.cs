using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp.StarTrek;

namespace WebApp
{
    public partial class DemoFleet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                // Populate the GridView
                FleetGrid.DataSource = Fleet;
                FleetGrid.DataBind();
            }
        }

        // Static "hack" allows the list of ships to persist on postback
        // Don't ever use this in real life!
        private static List<Ship> Fleet = new List<Ship>();

        protected void AddShip_Click(object sender, EventArgs e)
        {
            // Get the data from the form & put it into a new Ship object
            Ship theShip = new Ship();
            theShip.RegistryId = Registry.Text;      // for the TextBox
            theShip.Class = ShipClass.SelectedValue; // for the Drop-Down
            theShip.Power = int.Parse(Power.Text);   // for the TextBox range control (converted to int)
            Fleet.Add(theShip);
            // Populate the GridView
            FleetGrid.DataSource = Fleet;
            FleetGrid.DataBind();

            MessageLabel.Text = "Ship Added";
        }

        protected void ClearForm_Click(object sender, EventArgs e)
        {
            Registry.Text = string.Empty;
            ShipClass.SelectedIndex = 0;
            Fleet.Clear();
            // Populate the GridView
            FleetGrid.DataSource = Fleet;
            FleetGrid.DataBind();

            MessageLabel.Text = "Fleet Scrapped.";
        }
    }
}