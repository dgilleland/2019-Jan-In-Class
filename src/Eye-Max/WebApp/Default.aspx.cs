using EyeMaxBooking.BLL;
using EyeMaxBooking.Entities.CommandModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApp.CustomServerControls;

namespace WebApp
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MessageLabel.Text = "";
            MessageLabel.CssClass = "";
        }

        protected override void OnPreRender(EventArgs e)
        {
            // Show only relevant panels
            ShowTimePanel.Visible = MovieDropDown.SelectedIndex > 0;
            SeatingPanel.Visible = ShowTimePanel.Visible && ShowTimesListView.SelectedIndex >= 0;

            // Reset selected show-times
            if (!ShowTimePanel.Visible)
                ShowTimesListView.SelectedIndex = -1;

            base.OnPreRender(e);
        }

        protected void PickMovie_Click(object sender, EventArgs e)
        {
            string styling = "btn ";
            styling += MovieDropDown.SelectedIndex == 0 ? "btn-primary" : "btn-default";
            PickMovie.CssClass = styling;
        }

        protected void ShowTimesListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if(e.CommandName.Equals("Deselect"))
            {
                ShowTimesListView.SelectedIndex = -1;
                e.Handled = true;
            }
        }

        protected void ShowTimesListView_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ShowTimesListView.SelectedIndex >= 0)
            {
                PopulateSeatingListView();
            }
        }

        private void PopulateSeatingListView()
        {
            // Populate the SeatingListView
            var selectedShow = ShowTimesListView.SelectedDataKey;
            int showingId, theaterId;
            int.TryParse(selectedShow["ShowingId"].ToString(), out showingId);
            int.TryParse(selectedShow["TheaterId"].ToString(), out theaterId);

            var controller = new BookingController();
            var room = controller.GetAvailability(showingId, theaterId);
            SeatingListView.GroupItemCount = room.SeatsPerRow;
            SeatingListView.DataSource = room.Seats;
            SeatingListView.DataBind();
        }

        protected void ReserveSeats_Click(object sender, EventArgs e)
        {
            // Gather the info on the selected seats

            // 1) Get the Theater & Show info
            var selectedShow = ShowTimesListView.SelectedDataKey;
            int showingId, theaterId;
            int.TryParse(selectedShow["ShowingId"].ToString(), out showingId);
            int.TryParse(selectedShow["TheaterId"].ToString(), out theaterId);

            // 2) Get the seats that are being requested
            List<SeatReservation> seats = new List<SeatReservation>();
            foreach(ListViewDataItem userInputs in SeatingListView.Items)
            {
                var checkbox = userInputs.FindControl("SeatSelection") as CleanCheckBox;
                if(checkbox != null && checkbox.Enabled && checkbox.Checked)
                {
                    var hiddenRow = userInputs.FindControl("SeatRow") as HiddenField;
                    var hiddenNumber = userInputs.FindControl("SeatNumber") as HiddenField;
                    string row = hiddenRow.Value;
                    int number = int.Parse(hiddenNumber.Value);

                    seats.Add(new SeatReservation { Row = row, Number = number });
                }
            }

            var reservation = new MovieReservation
            {
                ShowingId = showingId,
                TheaterId = theaterId,
                Seats = seats
            };

            // Process the reservation
            // NOTE: In a "real" system, I should be including info on the user...
            try
            {
                var controller = new BookingController();
                controller.ReserveShow(reservation);
                MessageLabel.Text = $"The following seats have been reserved for you: <b>{string.Join("</b>, <b>", reservation.Seats)}</b>";
                MessageLabel.CssClass = "alert alert-success";
                MessageLabel.Attributes["role"] = "alert";
            }
            catch (Exception ex)
            {
                MessageLabel.Text = $"There's a problem with your reservation: {ex.Message}";
                MessageLabel.CssClass = "alert alert-danger";
                MessageLabel.Attributes["role"] = "alert";
            }
            PopulateSeatingListView();
        }
    }
}