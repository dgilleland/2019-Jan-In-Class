<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageShowTimes.aspx.cs" Inherits="WebApp.Admin.ManageShowTimes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 class="page-header">Manage Show-Times</h1>

    <div class="row">
        <div class="col-md-4">
            <asp:DropDownList ID="ExistingMovies" runat="server"
                AppendDataBoundItems="true" DataSourceID="MoviesDataSource" DataTextField="Name" DataValueField="MovieId"
                 AutoPostBack="true">
                <asp:ListItem Value="0">[Select a Movie]</asp:ListItem>
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="MoviesDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ListAllMovies" TypeName="EyeMaxBooking.BLL.MovieController"></asp:ObjectDataSource>
        </div>
        <div class="col-md-8">
            <asp:LinkButton ID="SaveShowTimes" runat="server" OnClick="SaveShowTimes_Click">Save</asp:LinkButton>
            <div>
                <asp:Label ID="MessageBox" runat="server" />
            </div>
            <hr />
            <asp:ListView ID="MovieShowTimesListView" runat="server"
                 DataSourceID="ShowTimesDataSource"
                 ItemType="EyeMaxBooking.Entities.SharedModels.MovieShowTime">
                <LayoutTemplate><div runat="server" id="itemPlaceholder"></div></LayoutTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="ShowTimeIdField" runat="server" Value="<%# Item.ShowTimeId %>" />
                    <asp:Calendar ID="StartTime" runat="server" SelectedDate="<%# Item.StartTime %>" style="display:inline-block;"></asp:Calendar>
                    <asp:DropDownList ID="RoomDropDown" runat="server" DataSourceID="TheaterDataSource" DataTextField="Number" DataValueField="TheaterId" SelectedValue="<%# Item.TheaterId %>"></asp:DropDownList>
                    <asp:ObjectDataSource runat="server" ID="TheaterDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ListAllTheaters" TypeName="EyeMaxBooking.BLL.MovieController"></asp:ObjectDataSource>
                </ItemTemplate>
                <ItemSeparatorTemplate><hr /></ItemSeparatorTemplate>
            </asp:ListView>
            <asp:ObjectDataSource runat="server" ID="ShowTimesDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetShowTimes" TypeName="EyeMaxBooking.BLL.MovieController">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ExistingMovies" PropertyName="SelectedValue" Name="movieId" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </div>

</asp:Content>
