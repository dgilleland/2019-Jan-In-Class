<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" Inherits="FormSamples_ContestEntry" Codebehind="ContestEntry.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="page-header">
        <h1>Contest Entry</h1>
    </div>
    <div class="row col-md-12">
        <blockquote style="font-style: italic">
            This illustrates some simple controls to fill out an entry form for a contest.
        </blockquote>
    </div>
    <div class="row">
        <div class="col-md-6">
            <p>
                Please fill out the following form to enter the contest. This contest is only 
        available to residents in Western Canada.
            </p>
            <fieldset class="form-horizontal">
                <legend>Entry Form</legend>
                <asp:Label ID="Label1" runat="server" AssociatedControlID="FirstName">First Name</asp:Label>
                <asp:TextBox ID="FirstName" runat="server"></asp:TextBox>

                <asp:Label ID="Label2" runat="server" AssociatedControlID="LastName">Last Name</asp:Label>
                <asp:TextBox ID="LastName" runat="server"></asp:TextBox>

                <asp:Label ID="Label3" runat="server" AssociatedControlID="StreetAddress1">Street Address 1</asp:Label>
                <asp:TextBox ID="StreetAddress1" runat="server"></asp:TextBox>

                <asp:Label ID="Label4" runat="server" AssociatedControlID="StreetAddress2">Street Address 2</asp:Label>
                <asp:TextBox ID="StreetAddress2" runat="server"></asp:TextBox>

                <asp:Label ID="Label5" runat="server" AssociatedControlID="City">City</asp:Label>
                <asp:TextBox ID="City" runat="server"></asp:TextBox>

                <asp:Label ID="Label6" runat="server" AssociatedControlID="Province">Province</asp:Label>
                <asp:DropDownList ID="Province" runat="server">
                    <asp:ListItem>BC</asp:ListItem>
                    <asp:ListItem>AB</asp:ListItem>
                    <asp:ListItem>SK</asp:ListItem>
                    <asp:ListItem>MB</asp:ListItem>
                </asp:DropDownList>

                <asp:Label ID="Label7" runat="server" AssociatedControlID="PostalCode">Postal Code</asp:Label>
                <asp:TextBox ID="PostalCode" runat="server"></asp:TextBox>

                <asp:Label ID="Label8" runat="server" AssociatedControlID="EmailAddress">Email</asp:Label>
                <asp:TextBox ID="EmailAddress" runat="server"></asp:TextBox>

                <asp:Label ID="Label9" runat="server" AssociatedControlID="AgreeToTerms">Terms and Conditions</asp:Label>
                <asp:CheckBox ID="AgreeToTerms" runat="server"
                    Text="I agree to the terms of the contest." />
                <br />
            </fieldset>
            <asp:Button ID="Submit" runat="server" Text="Submit" OnClick="Submit_Click" />
            <asp:Button ID="ClearForm" runat="server" Text="Clear Form" CausesValidation="false" OnClick="ClearForm_Click" />
            <p>Note: You must agree to the contest terms in order to be entered.</p>
        </div>
        <div class="col-md-6">
            <asp:Label ID="MessageLabel" runat="server" />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                CssClass="alert alert-warning"
                HeaderText="Please fix these problems on the form before submitting." />
            
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="FirstName" Display="None"
                ErrorMessage="You must supply your first name">
            </asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="LastName" Display="None"
                ErrorMessage="Last Name is required">
            </asp:RequiredFieldValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="EmailAddress" Display="None"
                ErrorMessage="I need your email to tell you when you won the contest">
            </asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                ControlToValidate="PostalCode" Display="None"
                ValidationExpression="\D\d\D \d\D\d"
                ErrorMessage="Postal codes must be in the format of A9A 9A9">
            </asp:RegularExpressionValidator>
            

            <p>Apply the following validation rules:</p>
            <ul>
                <li>First and Last Name are required.</li>
                <li>Postal Code must be in the correct format: <code>\D\d\D \d\D\d</code></li>
                <li>Email is required.</li>
            </ul>
            <p>In addition, do a manual code-behind check of the AgreeToTerms checkbox.</p>
        </div>
    </div>
    <script src="../Scripts/bootwrap-freecode.js"></script>
</asp:Content>

