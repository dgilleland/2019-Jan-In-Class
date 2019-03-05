<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebApp.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>Your application description page.</h3>
    <p>Use this area to provide additional information. Enter your full name and click the button.</p>

<%--    Tips:
    - [Ctrl] + [k] , [Ctrl] + [c] will comment out your selected text
    - [Ctrl] + [k] , [Ctrl] + [u] will un-comment  your selected text
    - [Ctrl] + [k] , [Ctrl] + [d] will format the code in your current file--%>
    
    <%--I am using this label for general messages--%>
    <asp:Label ID="MessageLabel" runat="server" />
    <br />

    <%--The AssociatedControlID attribute/property must have a value that is the ID of another control
    on the form.--%>
    <asp:Label ID="Label1" runat="server" AssociatedControlID="FullName">Your Full Name:</asp:Label>
    <%--The ID attribute will generate a field name in the code-behind class
    that allows me to programmatically interact with the asp.net server control.--%>
    <asp:TextBox ID="FullName" runat="server" />
    
    <%--A LinkButton will "look like" a link (render as an <a></a>), but "work like" a button--%>
    <asp:LinkButton ID="GetInitials" runat="server"
        CssClass="btn btn-primary" Text="Get Your Initials"
        OnClick="GetInitials_Click" />
    <%--The OnClick that I specify here associates the click event of the button with a
    method handler in the code-behind of the page.--%>

    <asp:Label ID="Initials" runat="server" />
    <asp:LinkButton ID="ReverseName" runat="server"
        CssClass="btn btn-default" Text="Spell it backwards"
        Visible="false" OnClick="ReverseName_Click" />

    <hr />

    <h3>Various TextBox Modes</h3>
    <asp:TextBox ID="YourPassword" runat="server" TextMode="Password" />
    <br />
    <asp:TextBox ID="DateOfBirth" runat="server" TextMode="Date" />
    <br />
    <asp:TextBox ID="SkyColor" runat="server" TextMode="Color" />
    <br />
    <asp:TextBox ID="SchoolEmail" runat="server" TextMode="Email" />
    <br />
    <asp:TextBox ID="Bio" runat="server" TextMode="MultiLine" />
    <hr />

    <h3>Other User Input Controls</h3>
    <asp:FileUpload ID="Avatar" runat="server" />
    <br />
    <asp:CheckBox ID="AgreeToTerms" runat="server" Text="Agree to Terms" />
    <br />
    <asp:DropDownList ID="CareerPath" runat="server">
        <asp:ListItem Value="">[Select a Career Path]</asp:ListItem>
        <asp:ListItem Value="Best">Computer Software Development</asp:ListItem>
        <asp:ListItem Value="Acceptable">Business Analysis</asp:ListItem>
        <asp:ListItem Value="AlsoAcceptable">Systems Analyst</asp:ListItem>
        <asp:ListItem Value="TemporaryEmployment">Games Development</asp:ListItem>
    </asp:DropDownList>
    <br />
    <asp:CheckBoxList ID="Languages" runat="server">
        <asp:ListItem Value="CSharp">C#</asp:ListItem>
        <asp:ListItem Value="Java">Java</asp:ListItem>
        <asp:ListItem Value="VB">Visual Basic</asp:ListItem>
        <asp:ListItem Value="HTML">HTML</asp:ListItem>
        <asp:ListItem Value="CSS">CSS</asp:ListItem>
        <asp:ListItem Value="JS">JavaScript</asp:ListItem>
        <asp:ListItem Value="SQL">SQL</asp:ListItem>
    </asp:CheckBoxList>
    <br />
    <asp:RadioButtonList ID="Gender" runat="server">
        <asp:ListItem Value="M">Male</asp:ListItem>
        <asp:ListItem Value="F">Female</asp:ListItem>
    </asp:RadioButtonList>
    <br />
    <asp:Image ID="Logo" runat="server" ImageUrl="https://www.google.ca/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png" />
    <br />
    <asp:Button ID="AddStuff" runat="server" Text="Add Stuff" />
    vs.
    <asp:LinkButton ID="AddMore" runat="server">Add More Stuff</asp:LinkButton>
    vs.
    <asp:HyperLink ID="HyperLink1" runat="server">HyperLink</asp:HyperLink>
    vs.
    <asp:ImageButton ID="AddThing" runat="server" ImageUrl="https://www.google.ca/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png" />

</asp:Content>
