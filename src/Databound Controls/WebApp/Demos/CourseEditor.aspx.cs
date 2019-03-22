using BackEnd.BLL;
using BackEnd.BLL.Commands;
using BackEnd.BLL.Queries;
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
            // Clean up
            GridViewEventInfo.Text = string.Empty;

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
            MessageUserControl.TryRun(() =>
           {
                // 1) Extract the data from the form
                DateTime start;
               DateTime.TryParse(StartsOn.Text, out start);
               var courseInfo = new CourseOffering(CourseName.Text, start);

               RetrieveAssignments();

                // 2) Send the data to the BLL for processing
                var controller = new StudentGradesController();
               controller.CreateCourse(courseInfo, 7, Assignments);
               Courses.DataBind();
           }, "Course Added", $"Successfully added the {CourseName.Text} course");
        }

        protected void Courses_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            // our opportunity to do something BEFORE the change actually takes place.
            GridViewEventInfo.Text += $"Changing Event - Index position {e.NewSelectedIndex}<br />";
        }

        protected void Courses_SelectedIndexChanged(object sender, EventArgs e)
        {
            // our chance to do something AFTER the change takes place
            GridViewEventInfo.Text += $"Changed Event - {Courses.SelectedDataKey.Value}<br />";
            GridViewEventInfo.Text += "<ul>";
            foreach(var item in Courses.SelectedDataKey.Values.Values)
            {
                GridViewEventInfo.Text += $"<li>{item}</li>";
            }
            GridViewEventInfo.Text += "</ul>";

            // Our actual processing of getting the students based on our "data key" values
            string courseName = Courses.SelectedDataKey[nameof(CourseSummary.CourseName)].ToString();
            string startingDate = Courses.SelectedDataKey[nameof(CourseSummary.StartDate)].ToString();
            // $"" is called String Interpolation
            GridViewEventInfo.Text += $"-{courseName}-{startingDate}-";

            var controller = new StudentGradesController();
            var classListData = controller.ListStudentsInClass(courseName, DateTime.Parse(startingDate));
            ClassListRepeater.DataSource = classListData;
            ClassListRepeater.DataBind();
        }

        protected void CourseDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Take the info from this drop-down and use it to get data for the next drop-down
            if(CourseDropDownList.SelectedIndex > 0)
            {
                var controller = new StudentGradesController();
                AssignmentDropDownList.DataSource = controller.ListAssignments(CourseDropDownList.SelectedValue);
                AssignmentDropDownList.DataTextField = nameof(AssignmentInfo.Description);
                AssignmentDropDownList.DataValueField = nameof(AssignmentInfo.Name);
                AssignmentDropDownList.DataBind();
                AssignmentDropDownList.Items.Insert(0, "[Select an assignment]");
            }
            else
            {
                // Clear out my second drop-down
                AssignmentDropDownList.Items.Clear();
            }
        }
    }
}