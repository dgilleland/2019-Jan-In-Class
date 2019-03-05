<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="FormSamples_Default" Codebehind="Default.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="page-header">
        <h1>Data Entry Form Demos</h1>
        <blockquote>A collection of assorted forms for basic data entry. Some of these include Validation Controls, such as <code>&lt;asp:RequiredField ...&gt;</code>. For Regular Expressions, check out this <a href="http://rextester.com/tester" target="_blank">Regular Expressions Tester</a>.</blockquote>
    </div>
    <div class="row">
        <div class="col-md-3">
            <h3>Student Enrollment</h3>
            <p>This illustrates some simple controls to enroll a student in a particular course.
            The design uses only the basic Bootstrap form classes 
            (the <code style="font-style: normal;">form-control</code> class on form elements).</p>
            <p><a href="StudentEnrollment.aspx">Jump to Demo &hellip;</a></p>
        </div>
        <div class="col-md-3">
            <h3>Job Application</h3>
            <p>This illustrates some simple controls to fill out an online job application. It includes radio buttons and checkboxes.</p>
            <p><a href="JobApplication.aspx">Jump to Demo &hellip;</a></p>
        </div>
        <div class="col-md-3">
            <h3>Bank Account</h3>
            <p>This illustrates some basic controls for creating a bank account. Note that the page uses the NuGet <a href="https://www.nuget.org/packages/Bootwrap.FreeCode/" target="_blank">BootWrap</a> package to support Bootstrap's recommended rendering for horizontal form controls while leaving the .aspx file un-cluttered from implementing the extra tags/classes needed for <a href="http://getbootstrap.com/css/#forms-horizontal" target="_blank">horizontal forms in Bootstrap</a>.</p>
            <p><a href="CreateBankAccount.aspx">Jump to Demo &hellip;</a></p>
        </div>
        <div class="col-md-3">
            <h3>Contest Entry</h3>
            <p>This illustrates some simple controls to fill out an entry form for a contest.</p>
            <p><a href="ContestEntry.aspx">Jump to Demo &hellip;</a></p>
        </div>
    </div>
</asp:Content>

