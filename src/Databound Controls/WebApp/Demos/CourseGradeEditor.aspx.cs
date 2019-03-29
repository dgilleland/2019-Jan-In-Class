using BackEnd.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp.Demos
{
    public partial class CourseGradeEditor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void StudentMarkDataSource_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            MessageUserControl.HandleDataBoundException(e);
        }

        protected void SubmitGrades_Click(object sender, EventArgs e)
        {
            // Take the form's data and send it to the BLL for processing
            // The .TryRun will process the anonymous method inside a try block & report any errors.
            MessageUserControl.TryRun(() =>
            {
                // 1) Gather form data
                var course = CourseDropDown.SelectedValue;
                var assignment = AssignmentDropDown.SelectedValue;
                var studentGrades = new List<AssignedGrade>();
                // 1.a) Get the data from the ListView
                int possible;
                if (!int.TryParse(PossibleMarks.Text, out possible))
                    throw new Exception("You must enter a number for possible marks.");
                foreach(ListViewDataItem item in StudentMarkListView.Items)
                {
                    // Get a reference to the controls in the <ItemTemplate> that hold the data
                    var markTextBox = item.FindControl("EarnedMarksTextBox") as TextBox;
                    var idLabel = item.FindControl("StudentIDLabel") as Label;
                    // Don't assume! Check that the controls were actually found before using them
                    if(markTextBox != null && idLabel != null)
                    {
                        double mark;
                        int id;
                        if (!double.TryParse(markTextBox.Text, out mark))
                            throw new Exception("You can only enter numbers for the student grade");
                        if (!int.TryParse(idLabel.Text, out id))
                            throw new Exception("Stop hacking the code-behind on the form");
                        var grade = new AssignedGrade
                        {
                            EarnedMarks = mark,
                            StudentID = id,
                            PossibleMarks = possible
                        };
                        studentGrades.Add(grade);
                    }
                    else
                    {
                        throw new Exception("Programmer, check your code!");
                    }
                }
                // 2) Send to BLL
                var controller = new StudentGradesController();
                controller.ProcessMarks(course, assignment, studentGrades);
            }, "Grades Processed", "Grades were sent. Beyond that, I don't know what they did with them");
        }
    }
}