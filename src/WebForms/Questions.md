# Questions on Intro to Web Forms

> These are assorted student questions from reviewing the Intro to Web Forms solution. They've been reorganized into certain categories to make them easier to discuss in class.

## Database Questions

- Is connecting to databases the same?
    - How do we connect to a database?  Same way we did with Razor?
    - Is hooking up a database to an ASP.NET web application done in the Web.Config file the exact same way as Razor?
    - is connecting databases the same as in razor?
- SQL Injection protection with web froms??
- How can we integrate our WebForms with cloud service databases such as AWS or Azure?

## Star Trek Questions

- For the Star Trek fleet after you've made the fleet how did you make the shields on inaccesable?
- Why is the ShieldsOn checkbox disabled? Can you make it so you can check it? Why does it even show up as a column? Do all properties automatically show up as column heads on webgrids when you bind a class to them? Is there a way to not have a a property show up (say if you had an ID property  that you didn't want showing up)?
- What would we do in real life instead of using the static "hack" in the DemoFleet web app?
- Why is there the if(!IsPostBack) in the Page_Load method of the DemoFleet.aspx.cs file?
- "Static "hack" allows the list of ships to persist on postback" What would we use in real life? example....
- On the DemoFleet.aspx.cs page on the Page_Load method, there is FleetGrid.Datasource/DataBind to create the WebGrid. How does this create the grid? Where is FleetGrid created or assigned the grid functionallity?
- Where does the "shields on" Come from and why can you not click on the value?
- Where does the checkbox on the fleet demo come from?
    - Why is the checkbox disabled? 

## C# Questions

- What are pocos and dto
- All the class methods on the back end are labeled "Protected" what does that do differently from static or public or private?
- DateTime when;  - I dont know what that does (DemoWebControls.aspx.cs line 29)
- Convert string to date time, how does the try parse vs try extract work
- determining return value.  what does this return?
- What is a best practice for organizing custom types in a asp project, (how do you structure your folders)
- What is the long Data Type?
- For this line of code: what does the "out" mean?
    ```csharp
    if (DateTime.TryParse(TextBox13.Text, out when))
            result += "From type=datetime : " + when.ToString() + " <br />";
    else
        result += "-No datetime entered-";
    ```

## WebForms & ASP.NET Controls Questions

- What is the purpose of the runat = "server"
    - What exactly does runat mean?
    - Where is the "server" located for the runat tag or is it an "imaginary server"?
- What is Site.Master?
- On the aspx.cs pages, the class inheritance is className : Page. I see that the class Page comes from the System.Web.UI namespace but why is it required?
- whats CausesValidation?
- Can you change the name of the column headers in the webgrid? how? (Like if you wanted to change 'ShieldsOn' to 'Shields On' in the table how would you do that?)
- How does the DemoWebControls.aspx.cs receive the List Box objects. Is it from the asp:ListBox ID="ListBox1" for example?
- How can we ensure that the @ symbol is included in the email input field? My form still accepts the input without it.
- Can you pass data between ASP pages in the same ways that we did before with regular webforms in cshtml?
- How can we create dynamic List lookups with the drop downs? (Change event on dropdown which posts back)
- Autopostback - When using an autpostback, when the page gets posted and the user decides to press the back button, will the page that will be loaded the page that had the pre-post value or the webpage that a user was on previously? I am not sure if this is the same thing but NAIT has a page where when a user searches a course, they get a post everytime a character is added to the textbox but when the user presses the back button, the page just deletes the last character that was inputted and load the page in that previous state. Link :  http://www.nait.ca/programsandcourses.htm?txtSearch=dig
- Using underscore to separate words in a name - Is it acceptable to use underscores to separate words when naming an ID?
- TextBox Range Arrows - When using the Textbox - Range with the arrow keys, is it possible to control how much the range increases or decreases? For instance the arrow gradually increasing from 0-1-2-3-4...10 instead of 0-10-20.
- required attribute - Can the required attribute be used for the textbox?.
- Styling - How does the styling get done in Web Forms? Previously on Razor, we have to code the css and its styling in the header specifically and I cannot see that in webforms at the moment.
- Is ListItem default or a class created by aspx.designer.cs? (DemoWebControls)
- Is datasource always required for gridviews?
- Is a list generated on a site instanced or does the site hold onto lists permanently?
- What is the "Create Webform" used for as it seems like you need to use "Create Webform with Master"
- What is the difference when using ID and AssociatedControlID when working with them in an aspx.cs page?
- `For` attribute in asp on labels?
    - Some tag on label cant remember the name probably already looked this up but I need five questions.
- How do you show the value of the range while you toggle it left and right?
- For a LinkButton, does it need to have a definition for the OnClick in the cs file for it to work? 
- In the TextMode=Range, what does the step mean?
- How does the client side (Browser) Know how to render form elements as HTML/CSS/Javascript? What is happening on the server side for this to happen?
- To further expand on the above, is there any way I can see the HTML that will be rendered in Visual Studio before it's process in the web browser?
- I know you mentioned this a while ago, but how does the Site.Master page hook up to the other pages? Is it similar to Razor but with different syntax?
- Is there a way to show the values of a slider bar for the user before they post it?

## Validation Questions

- In the Job Application Form, there is a validation for the email and phone with some character strings. What do these characters represent? Also, how does the program take the format of the input and convert it to this string?
- Does a RequiredFieldValidator always appear on the page load or can it appear only after bad information is put into the input field?
- Inside of a RequiredFieldValidator, what does the ValueToCompare attribute mean?
- Quick review of the Validations in the CreateBankAccount page ...........ValueToCompare...Operator....ControlToValidate????
- How do we write the stlye of regular expression validator controls in ASP.NET?( i.e: `ValidationExpression="(19|20)\d\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])"`)
- In the FormSamples folder ----> Classes has classes with empty {get;set} properties. Is creating this class required even when there is the validation on the appropriate .aspx pages?
- Should the Validation always be in the backend file or could we have an onclick on the `<asp: text>...ect` itself?
- How do you choose which validation expression to use for different types of validations ( `ValidationExpression="[1-9]\d{9}?"` vs. `ValidationExpression="(19|20)\d\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])"` )
- How can I use the validation expression to validate other characters? 

## Other Questions

- Why use ASP.NET over Razor?
    - Benefit of ASP.Net Web Forms over Razor?
- How does one git on windows
    - ( Can create file as a text and rename with Ren "File Name" "New filename")
- How do we use custom javascript?
    - How can we use custom Javascript on the webforms?
- Would there be any benefit to using custom javascript on the webforms or is there functionality already in place?
- Is the `<script>` tag at the bottom of needed to use bootstrap in my web forms?
- Is it more effecient to make jpg's or more effecient to use favicons/fontawesome?
- Is there a way to do a google search from your web form?

