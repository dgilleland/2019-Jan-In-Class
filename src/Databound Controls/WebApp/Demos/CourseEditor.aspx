<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseEditor.aspx.cs" Inherits="WebApp.Demos.CourseEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-header">Course Editor</h1>

    <asp:Label ID="Label1" runat="server" AssociatedControlID="CourseName" Text="Course Name" />
    <asp:TextBox ID="CourseName" runat="server" CssClass="form-content" />
    
    <asp:Label ID="Label2" runat="server" AssociatedControlID="StartsOn" Text="Starts On" />
    <asp:TextBox ID="StartsOn" runat="server" CssClass="form-content" TextMode="Date" />

    <asp:ListView ID="AssignmentsList" runat="server"
         InsertItemPosition="FirstItem" ItemType="BackEnd.BLL.Commands.WeightedItem">

    </asp:ListView>

    <asp:LinkButton ID="AddCourse" runat="server" CssClass="btn btn-primary" Text="Add Course" />

</asp:Content>
