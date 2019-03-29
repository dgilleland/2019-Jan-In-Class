<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseGradeEditor.aspx.cs" Inherits="WebApp.Demos.CourseGradeEditor" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
    <div class="row">
        <div class="col-md-5">
            <asp:DropDownList ID="CourseDropDown" runat="server"
                DataSourceID="CourseDataSource" DataTextField="CourseName" DataValueField="CourseName"
                AppendDataBoundItems="true" AutoPostBack="true">
                <asp:ListItem Value="">[Select a course]</asp:ListItem>
            </asp:DropDownList>

            <asp:ObjectDataSource runat="server" ID="CourseDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ExistingCourses" TypeName="BackEnd.BLL.StudentGradesController"></asp:ObjectDataSource>
            <asp:DropDownList ID="AssignmentDropDown" runat="server"
                DataSourceID="AssignmentDataSource" DataTextField="Description" DataValueField="Name"
                AppendDataBoundItems="true" AutoPostBack="true">
                <asp:ListItem Value="">[Select an assignment]</asp:ListItem>
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="AssignmentDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ListAssignments" TypeName="BackEnd.BLL.StudentGradesController">
                <SelectParameters>
                    <asp:ControlParameter ControlID="CourseDropDown" PropertyName="SelectedValue" Name="selectedValue" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
        <div class="col-md-7">
            <asp:TextBox ID="PossibleMarks" runat="server" placeholder="Possible Marks" />
            <asp:LinkButton ID="SubmitGrades" runat="server" CssClass="btn btn-primary" OnClick="SubmitGrades_Click">Submit Grades</asp:LinkButton>
            <asp:ListView ID="StudentMarkListView" runat="server" DataSourceID="StudentMarkDataSource">
                <ItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Label Text='<%# Eval("GivenName") %>' runat="server" ID="GivenNameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Surname") %>' runat="server" ID="SurnameLabel" /></td>
                        <td>
                            <asp:TextBox Text='<%# Eval("EarnedMarks") %>' runat="server" ID="EarnedMarksTextBox" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("StudentID") %>' runat="server" ID="StudentIDLabel" /></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                    <tr runat="server" style="">
                                        <th runat="server">GivenName</th>
                                        <th runat="server">Surname</th>
                                        <th runat="server">EarnedMarks</th>
                                        <th runat="server">StudentID</th>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style=""></td>
                        </tr>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
            <asp:ObjectDataSource runat="server" ID="StudentMarkDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ListStudentGrades" TypeName="BackEnd.BLL.StudentGradesController" OnSelected="StudentMarkDataSource_Selected">
                <SelectParameters>
                    <asp:ControlParameter ControlID="CourseDropDown" PropertyName="SelectedValue" Name="courseName" Type="String"></asp:ControlParameter>
                    <asp:ControlParameter ControlID="AssignmentDropDown" PropertyName="SelectedValue" Name="assignmentName" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>
