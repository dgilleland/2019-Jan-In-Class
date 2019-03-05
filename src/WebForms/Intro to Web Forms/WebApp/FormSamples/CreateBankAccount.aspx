<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" Inherits="FormSamples_CreateBankAccount" Codebehind="CreateBankAccount.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="page-header">
        <h1>Create Bank Account</h1>
    </div>
    <div class="row col-md-12">
        <blockquote>
            <i>This illustrates some basic controls for creating a bank account. Note that the page uses the NuGet <a href="https://www.nuget.org/packages/Bootwrap.FreeCode/" target="_blank">BootWrap</a> package to support Bootstrap's recommended rendering for horizontal form controls while leaving the .aspx file un-cluttered from implementing the extra tags/classes needed for <a href="http://getbootstrap.com/css/#forms-horizontal" target="_blank">horizontal forms in Bootstrap</a>.</i>
        </blockquote>
    </div>
    <div class="row">
        <div class="col-md-6">
            <p>
                Fill in the following form and click Submit.
            </p>
            <fieldset class="form-horizontal">
                <legend>New Bank Account</legend>
                <asp:Label ID="Label1" runat="server" AssociatedControlID="AccountHolder">Account Holder</asp:Label>
                <asp:TextBox ID="AccountHolder" runat="server"></asp:TextBox>

                <asp:Label ID="Label2" runat="server" AssociatedControlID="AccountNumber">Account Number</asp:Label>
                <asp:TextBox ID="AccountNumber" runat="server"></asp:TextBox>

                <asp:Label ID="Label3" runat="server" AssociatedControlID="OpeningBalance">Opening Balance</asp:Label>
                <asp:TextBox ID="OpeningBalance" runat="server"></asp:TextBox>

                <asp:Label ID="Label4" runat="server" AssociatedControlID="OverdraftLimit">Overdraft Limit</asp:Label>
                <asp:TextBox ID="OverdraftLimit" runat="server"></asp:TextBox>

                <asp:Label ID="Label5" runat="server" AssociatedControlID="AccountType">Account Type</asp:Label>
                <asp:DropDownList ID="AccountType" runat="server">
                    <asp:ListItem>Chequing</asp:ListItem>
                    <asp:ListItem>Savings</asp:ListItem>
                    <asp:ListItem>Credit</asp:ListItem>
                </asp:DropDownList>
            </fieldset>
            <p>
                <asp:Button ID="Submit" runat="server" Text="Submit" OnClick="Submit_Click" />
                <asp:Button ID="ClearForm" runat="server" Text="Clear Form" OnClick="ClearForm_Click" CausesValidation="false" />
            </p>
        </div>
        <div class="col-md-6">
            <asp:Label ID="MessageLabel" runat="server" />
            <div>
                <%--Validation Controls--%>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="alert alert-warning alert-dismissible" HeaderText="Please fix the following problems before sumitting this form." />
                <asp:RequiredFieldValidator ID="ValidateAccountHolder" runat="server" Display="None"
                    ControlToValidate="AccountHolder" 
                    ErrorMessage="The name of the holder of the account is required."></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="ValidateAccountNumber" runat="server" Display="None"
                    ControlToValidate="AccountNumber" 
                    ErrorMessage="Account numbers must be 10 digits." 
                    ValidationExpression="[1-9]\d{9}?"></asp:RegularExpressionValidator>
                <asp:CompareValidator ID="ValidateOpeningBalance" runat="server" Display="None"
                    ControlToValidate="OpeningBalance" 
                    ErrorMessage="Opening Balance must be greater than zero." 
                    ValueToCompare="0" Operator="GreaterThan" Type="Currency"></asp:CompareValidator>
                <asp:CompareValidator ID="ValidateOverdraftLimit" runat="server" Display="None"
                    ControlToValidate="OverdraftLimit" 
                    ErrorMessage="Overdraft Limit must be greater than or equal to zero." 
                    ValueToCompare="0" Operator="GreaterThanEqual" Type="Currency"></asp:CompareValidator>
            </div>

            <asp:GridView ID="BankAccountGridView" runat="server"
                 EmptyDataText="No bank accounts entered"></asp:GridView>

            <p>To complete this sample in class, do the following:</p>
            <ul>
                <li>Create a C# class to represent the Bank Account information entered in this form.</li>
                <li>Add a GridView control to this form.</li>
                <li>In the code-behind, add a <code>static List&lt;BankAccount&gt;</code> property to hold the bank account information.</li>
                <li>Complete the <code>Submit_Click()</code> method to add the bank account to the GridView. Check the Validation Controls, and also do a "manual check" in C# to ensure that there are no duplicate account numbers in the list.</li>
            </ul>
            <p>In addition, do a manual code-behind check of the AgreeToTerms checkbox.</p>

        </div>
    </div>
    <script src="../Scripts/bootwrap-freecode.js"></script>
</asp:Content>

