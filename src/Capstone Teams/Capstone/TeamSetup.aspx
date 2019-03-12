<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TeamSetup.aspx.cs" Inherits="Capstone.TeamSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-header">Capstone Team Setup</h1>

    <div class="row">
        <div class="col-md-6">
            <asp:GridView ID="StudentAssignmentGridView" runat="server"
                AutoGenerateColumns="False"
                ItemType="CapstoneSystem.Entities.POCOs.StudentInfo"
                DataSourceID="StudentDataSource"
                CssClass="table table-hover table-condensed">
                <Columns>
                    <asp:TemplateField HeaderText="Student Name">
                        <ItemTemplate>
                            <asp:HiddenField runat="server" Value='<%# Item.StudentId %>' ID="StudentId"></asp:HiddenField>
                            <asp:Label runat="server" Text='<%# Item.FullName %>' ID="StudentName"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Client">
                        <ItemTemplate>
                            <asp:DropDownList ID="ClientDropDown" runat="server"
                                DataSourceID="ClientDataSource"
                                AppendDataBoundItems="true"
                                DataTextField="Company" DataValueField="ClientId">
                                <asp:ListItem Value="">Select a company</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Team Letter">
                        <ItemTemplate>
                            <asp:TextBox ID="TeamLetter" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:LinkButton ID="SaveTeams" runat="server"
                 OnClick="SaveTeams_Click" CssClass="btn btn-primary">
                Save Teams
            </asp:LinkButton>

        </div>
        <div class="col-md-6">
            <h2>Notes</h2>
            <p>Put your own notes here to remember what we did</p>
        </div>
    </div>

    <asp:ObjectDataSource ID="StudentDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="ListAllStudents" TypeName="CapstoneSystem.BLL.CapstoneTeamController"></asp:ObjectDataSource>

    <asp:ObjectDataSource ID="ClientDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="ListCapstoneClients" TypeName="CapstoneSystem.BLL.CapstoneTeamController"></asp:ObjectDataSource>
</asp:Content>
