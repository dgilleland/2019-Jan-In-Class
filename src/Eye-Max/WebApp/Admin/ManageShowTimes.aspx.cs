using EyeMaxBooking.Entities.SharedModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp.Admin
{
    public partial class ManageShowTimes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SaveShowTimes_Click(object sender, EventArgs e)
        {
            // Demo grabbing all the data from the ListView control
            // to build a List<MovieShowTime> objects.

            // A ListView stores all its data inside the .Items property.
            List<MovieShowTime> theData = new List<MovieShowTime>();
            foreach(ListViewDataItem data in MovieShowTimesListView.Items)
            {
                // I need to "find" the asp.net controls that hold my data
                HiddenField hiddenShowTimeId = // Find and do a "safe cast"
                    data.FindControl("ShowTimeIdField") as HiddenField;
                Calendar startTimeCalendar =
                    data.FindControl("StartTime") as Calendar;
                DropDownList roomDropDown =
                    data.FindControl("RoomDropDown") as DropDownList;

                // To be save, check that we found the controls
                if(hiddenShowTimeId != null && startTimeCalendar != null && roomDropDown != null)
                {
                    var info = new MovieShowTime
                    {
                        ShowTimeId = int.Parse(hiddenShowTimeId.Value),
                        StartTime = startTimeCalendar.SelectedDate,
                        TheaterId = int.Parse(roomDropDown.SelectedValue)
                    };
                    theData.Add(info);
                }
            } // end of loop
            MessageBox.Text = $"I found {theData.Count} items";
        }
    }
}