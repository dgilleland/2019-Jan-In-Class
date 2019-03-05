<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DemoWebControls.aspx.cs" Inherits="WebApp.DemoWebControls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/bootwrap-freecode.css" rel="stylesheet" />
    <div class="row col-md-12 bg-info">
        <h2>User Output:</h2>
        <asp:Label ID="MessageLabel" runat="server" />
        <br />
    </div>

    <div class="row">
        <div class="col-md-6">
            <asp:LinkButton ID="ProcessTextboxes" runat="server" CssClass="btn btn-default" OnClick="ProcessTextboxes_Click" Text="Process Textboxes"></asp:LinkButton>
            <fieldset>
                <legend>Textbox Controls</legend>
                <asp:Label ID="Label1" runat="server" AssociatedControlID="TextBox1">TextBox</asp:Label>
                <asp:TextBox runat="server" ID="TextBox1" />

                <asp:Label ID="Label2" runat="server" AssociatedControlID="TextBox2">TextBox - Password</asp:Label>
                <asp:TextBox runat="server" ID="TextBox2" TextMode="Password"
                     BackColor="YellowGreen" ForeColor="Orange" 
                     Font-Italic="true" />

                <asp:Label ID="Label3" runat="server" AssociatedControlID="TextBox3">TextBox - Number</asp:Label>
                <asp:TextBox runat="server" ID="TextBox3" TextMode="Number" />

                <asp:Label ID="Label4" runat="server" AssociatedControlID="TextBox4">TextBox - SingleLine</asp:Label>
                <asp:TextBox runat="server" ID="TextBox4" TextMode="SingleLine" />

                <asp:Label ID="Label5" runat="server" AssociatedControlID="TextBox5">TextBox - Email</asp:Label>
                <asp:TextBox runat="server" ID="TextBox5" TextMode="Email" />

                <asp:Label ID="Label6" runat="server" AssociatedControlID="TextBox6">TextBox - Url</asp:Label>
                <asp:TextBox runat="server" ID="TextBox6" TextMode="Url" />

                <asp:Label ID="Label8" runat="server" AssociatedControlID="TextBox8">TextBox - Search</asp:Label>
                <asp:TextBox runat="server" ID="TextBox8" TextMode="Search" />

                <asp:Label ID="Label9" runat="server" AssociatedControlID="TextBox9">TextBox - Phone</asp:Label>
                <asp:TextBox runat="server" ID="TextBox9" TextMode="Phone" />

                <asp:Label ID="Label25" runat="server" AssociatedControlID="FileUpload1">FileUpload</asp:Label>
                <asp:FileUpload runat="server" ID="FileUpload1" />

                <asp:Label ID="Label10" runat="server" AssociatedControlID="TextBox10">TextBox - Color</asp:Label>
                <asp:TextBox runat="server" ID="TextBox10" TextMode="Color" />

                <asp:Label ID="Label11" runat="server" AssociatedControlID="TextBox11">TextBox - Date</asp:Label>
                <asp:TextBox runat="server" ID="TextBox11" TextMode="Date" />

                <asp:Label ID="Label13" runat="server" AssociatedControlID="TextBox13">TextBox - DateTime</asp:Label>
                <asp:TextBox runat="server" ID="TextBox13" TextMode="DateTime" />

                <asp:Label ID="Label14" runat="server" AssociatedControlID="TextBox14">TextBox - DateTimeLocal</asp:Label>
                <asp:TextBox runat="server" ID="TextBox14" TextMode="DateTimeLocal" />

                <asp:Label ID="Label12" runat="server" AssociatedControlID="TextBox12">TextBox - Time</asp:Label>
                <asp:TextBox runat="server" ID="TextBox12" TextMode="Time" />

                <asp:Label ID="Label15" runat="server" AssociatedControlID="TextBox15">TextBox - Month</asp:Label>
                <asp:TextBox runat="server" ID="TextBox15" TextMode="Month" />

                <asp:Label ID="Label16" runat="server" AssociatedControlID="TextBox16">TextBox - Week</asp:Label>
                <asp:TextBox runat="server" ID="TextBox16" TextMode="Week" />

                <asp:Label ID="Label18" runat="server" AssociatedControlID="TextBox18">TextBox - Range</asp:Label>
                <asp:TextBox runat="server" ID="TextBox18" TextMode="Range" />

                <asp:Label ID="Label7" runat="server" AssociatedControlID="TextBox7">TextBox - MultiLine</asp:Label>
                <asp:TextBox runat="server" ID="TextBox7" TextMode="MultiLine" Rows="5" />
            </fieldset>
        </div>

        <div class="col-md-6">
            <asp:LinkButton ID="ProcessListControls" runat="server" CssClass="btn btn-default" OnClick="ProcessListControls_Click">Process List Controls</asp:LinkButton>
            <fieldset>
                <legend>List Controls</legend>
                <asp:Label ID="Label23" runat="server" AssociatedControlID="DropDownList1">DropDownList</asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem Text="text1" />
                    <asp:ListItem Text="text2" Value="2nd" />
                    <asp:ListItem Text="text3" Value="99" />
                    <asp:ListItem Text="text4" Value="Last" />
                </asp:DropDownList>

                <asp:Label ID="Label24" runat="server" AssociatedControlID="ListBox1">ListBox - Single</asp:Label>
                <asp:ListBox ID="ListBox1" runat="server" SelectionMode="Single">
                    <asp:ListItem Text="text1" />
                    <asp:ListItem Text="text2" />
                    <asp:ListItem Text="text3" />
                    <asp:ListItem Text="text4" />
                </asp:ListBox>

                <asp:Label ID="Label17" runat="server" AssociatedControlID="ListBox2">ListBox - Multiple</asp:Label>
                <asp:ListBox ID="ListBox2" runat="server" SelectionMode="Multiple">
                    <asp:ListItem Text="text1" />
                    <asp:ListItem Text="text2" />
                    <asp:ListItem Text="text3" />
                    <asp:ListItem Text="text4" />
                </asp:ListBox>
                <asp:Label ID="Label28" runat="server" AssociatedControlID="RadioButtonList0">RadioButtonList "Flow"</asp:Label>
                <asp:RadioButtonList ID="RadioButtonList0" runat="server" RepeatLayout="Flow">
                    <asp:ListItem Text="text1" />
                    <asp:ListItem Text="text2" />
                    <asp:ListItem Text="text3" />
                    <asp:ListItem Text="text4" />
                </asp:RadioButtonList>

                <asp:Label ID="Label19" runat="server" AssociatedControlID="CheckBoxList1">CheckBoxList "Flow"</asp:Label>
                <asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatLayout="Flow">
                    <asp:ListItem Text="text1" />
                    <asp:ListItem Text="text2" />
                    <asp:ListItem Text="text3" />
                    <asp:ListItem Text="text4" />
                </asp:CheckBoxList>
            </fieldset>
        </div>
        <div class="col-md-6">
            <asp:LinkButton ID="ProcessOthers" runat="server" CssClass="btn btn-default" OnClick="ProcessOthers_Click">Process Others</asp:LinkButton>
            <fieldset>
                <legend>Other Controls</legend>
                <asp:Label ID="Label20" runat="server" AssociatedControlID="CheckBox1">Single CheckBox</asp:Label>
                <asp:CheckBox ID="CheckBox1" runat="server" Text="Agree to Terms" />

                <asp:Label ID="Label21" runat="server" AssociatedControlID="HiddenField1">HiddenField Control</asp:Label>
                <asp:HiddenField ID="HiddenField1" runat="server" />


            </fieldset>
        </div>
    </div>
    <script src="Scripts/bootwrap-freecode.js"></script>
</asp:Content>
