<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseEditor.aspx.cs" Inherits="WebApp.Demos.CourseEditor" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-header">Course Editor</h1>
    
    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <asp:Label ID="Label1" runat="server" AssociatedControlID="CourseName" Text="Course Name" />
    <asp:TextBox ID="CourseName" runat="server" CssClass="form-content" />
    
    <asp:Label ID="Label2" runat="server" AssociatedControlID="StartsOn" Text="Starts On" />
    <asp:TextBox ID="StartsOn" runat="server" CssClass="form-content" TextMode="Date" />

    <asp:LinkButton ID="AddCourse" runat="server" CssClass="btn btn-primary" Text="Add Course"
         OnClick="AddCourse_Click"/>

    <asp:ListView ID="AssignmentsList" runat="server"
         InsertItemPosition="FirstItem" ItemType="BackEnd.BLL.Commands.WeightedItem"
         OnItemInserting="AssignmentsList_ItemInserting">
        <InsertItemTemplate>
            <div>
                <asp:TextBox ID="ItemWeight" runat="server" Text="<%# BindItem.Weight %>" TextMode="Number" placeholder="% Weight" />
                <asp:TextBox ID="ItemTitle" runat="server" Text="<%# BindItem.AssignmentName %>" placeholder="Assignment Name" />
                <asp:LinkButton ID="AddItem" runat="server" CommandName="Insert" Text="Add Assignment"
                     CssClass="btn btn-default" />
            </div>
        </InsertItemTemplate>
        <ItemTemplate>
            <div>
                <asp:Label ID="Weight" runat="server" Text="<%# Item.Weight %>" /> % &ndash;
                <asp:Label ID="AssignmentTitle" runat="server" Text="<%# Item.AssignmentName %>" />
            </div>
        </ItemTemplate>
        <LayoutTemplate>
            <h3>Course Assignments</h3>
            <%--The ListView looks for a server-run control with an id of 
            itemPlaceholder
            as the element to replace with the contents of a template
            for each item.--%>
            <div id="itemPlaceholder" runat="server" />
        </LayoutTemplate>
    </asp:ListView>

    <hr />
    <h2>Current Courses</h2>
    <asp:GridView ID="Courses" runat="server" AutoGenerateColumns="False" DataSourceID="CourseListingDataSource" CssClass="table table-condensed table-hover">
        <Columns>
            <asp:BoundField DataField="CourseName" HeaderText="Course" SortExpression="CourseName"></asp:BoundField>
            <asp:BoundField DataField="StartDate" HeaderText="Starting" DataFormatString="{0:MMM dd yyyy}" SortExpression="StartDate"></asp:BoundField>
            <%--TODO: Switch # Students to Template Column with selected item template--%>
            <asp:BoundField DataField="EnrolledStudentCount" HeaderText="# Students" SortExpression="EnrolledStudentCount"></asp:BoundField>
            <asp:BoundField DataField="Evaluations" HeaderText="Evaluation Plan" SortExpression="Evaluations"></asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource runat="server" ID="CourseListingDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ExistingCourses" TypeName="BackEnd.BLL.StudentGradesController"></asp:ObjectDataSource>

    <hr />

    <h2>Searching Courses</h2>

    <%--TODO: Cascading drop-downs--%>
</asp:Content>
