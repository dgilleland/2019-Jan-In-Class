using CapstoneSystem.BLL;
using CapstoneSystem.Entities.POCOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capstone
{
    public partial class TeamSetup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SaveTeams_Click(object sender, EventArgs e)
        {
            // Loop through all the rows on the GridView,
            // and build up some data to send into the BLL
            // for OLTP processing.
            var data = new List<StudentAssignment>();
            foreach(GridViewRow row in StudentAssignmentGridView.Rows)
            {
                // Find the controls in that row
                var hiddenStudentId = row.FindControl("StudentId") as HiddenField;
                var selectedClientId = row.FindControl("ClientDropDown") as DropDownList;
                var letterTextBox = row.FindControl("TeamLetter") as TextBox;

                if(hiddenStudentId != null && selectedClientId !=null && letterTextBox != null)
                {
                    var dataItem = new StudentAssignment();
                    dataItem.StudentId = int.Parse(hiddenStudentId.Value);
                    int clientId;
                    if(int.TryParse(selectedClientId.SelectedValue, out clientId))
                    {
                        dataItem.ClientId = clientId;
                        if (!string.IsNullOrWhiteSpace(letterTextBox.Text))
                            dataItem.TeamLetter = letterTextBox.Text.Trim();
                        // Add it to the list of data items we will send to
                        // the BLL
                        data.Add(dataItem);
                    }
                }
            }
            var controller = new CapstoneTeamController();
            controller.AssignTeams(data);
        }
    }
}