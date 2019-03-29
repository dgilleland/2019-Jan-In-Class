<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Databound Controls</h1>
        <asp:Label ID="MessageLabel" runat="server" />
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Course Offerings Demo</h2>
            <p>
                In this demo, you will create a list of courses with assignments using a "batch processing" approach.
            </p>
            <p>
                <asp:LinkButton ID="PrepopulateCourses" runat="server"
                     OnClick="PrepopulateCourses_Click" CssClass="btn btn-default"><i class="fa fa-graduation-cap"></i> Pre-populate Courses</asp:LinkButton>
                <a class="btn btn-primary" href="Demos/CourseEditor.aspx">Run Demo &raquo;</a>
                <a class="btn btn-primary" href="Demos/CourseGradeEditor.aspx">Enter Grades &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Student Marks Demo</h2>
            <p>
                TBA
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>TBA</h2>
            <p>
                TBA
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301950">Learn more &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
