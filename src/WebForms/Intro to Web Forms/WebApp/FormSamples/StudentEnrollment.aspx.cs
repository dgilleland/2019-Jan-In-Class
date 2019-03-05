using AssortedDemos; // to get our Registration class
using System;
using System.Collections.Generic; // for the List<T> class
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

partial class FormSamples_StudentEnrollment
    : System.Web.UI.Page
{
    // This is very volatile - we're going to toss this later on
    // in favor of a database.
    // We'll use a static field that is initialized from the start
    private static List<Registration> Registrations = 
        new List<Registration>();

    protected void Page_Load(Object sender, EventArgs e)
	{
        if (!IsPostBack)
		{
            // Tell my GridView to get its data from the Registrations field.
            RegistrationGridView.DataSource = Registrations;
            // Tell my GridView to loop through the Data and populate the GridView.
            RegistrationGridView.DataBind();

            int year = DateTime.Today.Year + 1;
            int endYear = year + 4;
            while (year < endYear)
			{
                this.SchoolYear.Items.Add(year.ToString());
                year = year + 1;
		     }
        }
    }
    protected void Submit_Click(object sender, EventArgs e)
    {
        if (IsValid)
        {
            MessageLabel.Text = "Thank you for registering. A confirmation letter will be sent to you in the next few days.";
            // pull information from the form, and create a Registration object

            Registration newStudent = new Registration();
            newStudent.FirstName = FirstName.Text;
            newStudent.LastName = LastName.Text;
            newStudent.MiddleName = MiddleName.Text;
            newStudent.SIN = long.Parse(SocialInsuranceNumber.Text);

            DateTime temp;
            if (DateTime.TryParse(DateOfBirth.Text, out temp))
                newStudent.DOB = temp;

            newStudent.StudyProgram = ProgramOfStudy.SelectedValue;
            newStudent.SchoolYear = int.Parse(SchoolYear.SelectedValue);

            // Add the student to the list'
            Registrations.Add(newStudent);

            // Show the data in the GridView
            RegistrationGridView.DataSource = Registrations;
            RegistrationGridView.DataBind();
        }
        else
        {
            MessageLabel.Text = "Form input was not valid";
        }
    }
}
