using BackEnd.BLL;
using BackEnd.BLL.Commands;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp.Demos
{
    public partial class CourseEditor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                PopulateAssignments(null);
            }
        }

        // This method is populating the ListView with WeightedItem objects
        // that have been entered by the user
        private void PopulateAssignments(WeightedItem item)
        {
            RetrieveAssignments();
            if (item != null)
                Assignments.Add(item);
            AssignmentsList.DataSource = Assignments;
            AssignmentsList.DataBind();
        }

        private void RetrieveAssignments()
        {
            // Loop through all the items in the ListView, and add them back to
            // our List<WeightedItem> field.
            foreach(ListViewDataItem item in AssignmentsList.Items)
            {
                // Use the item to find the control that has the data we want
                var nameLabel = item.FindControl("AssignmentTitle") as Label;
                var weightLabel = item.FindControl("Weight") as Label;

                if(nameLabel != null && weightLabel != null)
                {
                    var existing = new WeightedItem
                    {
                        AssignmentName = nameLabel.Text,
                        Weight = int.Parse(weightLabel.Text)
                    };
                    Assignments.Add(existing);
                }
            }
        }

        // A local list of objects that we rebuild each time the PopulateAssignments()
        // method get called.
        private List<WeightedItem> Assignments = new List<WeightedItem>();

        // This method handles the list view's OnItemInserting command.
        // That command gets triggered by the linkbutton with the CommandName="Insert"
        protected void AssignmentsList_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            // Grab the values that were inserted.
            string name = e.Values[nameof(WeightedItem.AssignmentName)].ToString();
            int weight = Convert.ToInt32(e.Values[nameof(WeightedItem.Weight)]);
            var newItem = new WeightedItem { AssignmentName = name, Weight = weight };

            // bind the listview with the added information
            PopulateAssignments(newItem);
        }

        // Final processing for this page to add courses to our system.
        protected void AddCourse_Click(object sender, EventArgs e)
        {
            // 1) Extract the data from the form
            DateTime start;
            DateTime.TryParse(StartsOn.Text, out start);
            var courseInfo = new CourseOffering(CourseName.Text, start);

            RetrieveAssignments();

            // 2) Send the data to the BLL for processing
            var controller = new StudentGradesController();
            controller.CreateCourse(courseInfo, 7, Assignments);
        }
    }
}