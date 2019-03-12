<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApp._Default" %>
<%@ Register TagPrefix="wap" Namespace="WebApp.CustomServerControls" Assembly="WebApp" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Eye-Max</h1>
        <p class="lead">The leading <b>High Comfort</b> theater, offering complementary drinks and popcorn. <a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>

    <div class="row">
        <div class="col-md-3">
            <h2><i class="glyphicon glyphicon-film"></i> Pick a Movie</h2>            
            <p>Pick from one of our upcoming movies.</p>
            <asp:DropDownList ID="MovieDropDown" runat="server"
                 DataSourceID="MovieDataSource" DataTextField="Value" DataValueField="Key"
                 AppendDataBoundItems="true" CssClass="form-control">
                <asp:ListItem Value="0">[Select a Movie]</asp:ListItem>
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="MovieDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ListMovies" TypeName="EyeMaxBooking.BLL.BookingController"></asp:ObjectDataSource>
            <asp:LinkButton ID="PickMovie" runat="server" CssClass="btn btn-primary" OnClick="PickMovie_Click">View Start Times</asp:LinkButton>
        </div>
        <asp:Panel ID="ShowTimePanel" runat="server" CssClass="col-md-9">
            <h2><i class="glyphicon glyphicon-time"></i> Choose a Start Time</h2>
            <p>Select from one of the available start times.</p>
            <asp:ListView ID="ShowTimesListView" runat="server"
                 DataSourceID="ShowTimeDataSource" DataKeyNames="ShowingId,TheaterId"
                 ItemType="EyeMaxBooking.Entities.QueryModels.ShowTime"
                 OnItemCommand="ShowTimesListView_ItemCommand"
                 OnSelectedIndexChanged="ShowTimesListView_SelectedIndexChanged">
                <LayoutTemplate><div runat="server" id="itemPlaceholder"></div></LayoutTemplate>
                <ItemTemplate>
                    <div class="panel panel-default" style="display: inline-block;">
                        <div class="panel-heading">
                            Theater #: <b><%# Item.TheaterNumber %></b>
                        </div>
                        <div class="panel-body">
                            Date: <b><%# Item.StartTime.ToLongDateString() %></b><br />
                            <br />
                            Start Time: <b><%# Item.StartTime.ToShortTimeString() %></b><br />
                            Length: <b><%# Math.Round(Item.Length.TotalMinutes) %></b> minutes<br />
                            <asp:LinkButton ID="ShowTimeSelect" runat="server"
                                 CommandName="Select" CssClass="btn btn-success">View Seating</asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
                <SelectedItemTemplate>
                    <div class="panel panel-primary" style="display: inline-block;">
                        <div class="panel-heading">
                            Theater #: <b><%# Item.TheaterNumber %></b>
                        </div>
                        <div class="panel-body">
                            Date: <b><%# Item.StartTime.ToLongDateString() %></b><br />
                            <br />
                            Start Time: <b><%# Item.StartTime.ToShortTimeString() %></b><br />
                            Length: <b><%# Math.Round(Item.Length.TotalMinutes) %></b> minutes<br />
                            <asp:LinkButton ID="ShowTimeDeselect" runat="server"
                                 CommandName="Deselect" CssClass="btn btn-primary">Close</asp:LinkButton>
                        </div>
                    </div>
                </SelectedItemTemplate>
            </asp:ListView>
            <asp:ObjectDataSource runat="server" ID="ShowTimeDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetShowTimes" TypeName="EyeMaxBooking.BLL.BookingController">
                <SelectParameters>
                    <asp:ControlParameter ControlID="MovieDropDown" PropertyName="SelectedValue" Name="movieId" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </asp:Panel>
    </div>
    <asp:Panel ID="SeatingPanel" runat="server" CssClass="row">
        <div class="col-md-12">
            <h2><i class="glyphicon glyphicon-ok-circle text-success"></i> Grab a Seat</h2>
            <p>You can reserve multiple seats.
                <asp:LinkButton ID="ReserveSeats" runat="server"
                     CssClass="btn btn-success" OnClick="ReserveSeats_Click"><i class="glyphicon glyphicon-bookmark"></i> Reserve My Seats</asp:LinkButton>
                <asp:Label ID="MessageLabel" runat="server" />
            </p>
            <asp:ListView ID="SeatingListView" runat="server"
                 ItemType="EyeMaxBooking.Entities.QueryModels.Seat">
                <LayoutTemplate>
                    <div style="white-space:nowrap; display:inline-block; margin-left: 3em;">
                        <div>
                            <figure class="panel panel-default">
                                <img src="Images/BigScreen.png"
                                     style="width:100%; padding-bottom: 15px;" />
                                <figcaption class="panel-footer text-center">8 meters (24 ft) to Big Screen</figcaption>
                            </figure>
                        </div>
                        <div style="margin-left: 1.5em;">
                            <div runat="server" id="groupPlaceholder" />
                        </div>
                    </div>
                </LayoutTemplate>
                <GroupTemplate>
                        <div runat="server" id="itemPlaceholder" />
                </GroupTemplate>
                <GroupSeparatorTemplate>
                    <div>
                        <hr />
                    </div>
                </GroupSeparatorTemplate>
                <ItemTemplate>
                    <div style="display:inline-block; background-image: url('Images/Seat.png'); height: 62px; width: 62px; padding-top: 7px;">
                        <asp:Label ID="SeatInfo" runat="server"
                             CssClass="label label-primary" Text="<%# Item.ToString() %>"
                             style="margin-left: 12px;"/>
                        <br />
                        <wap:CleanCheckBox ID="SeatSelection" runat="server" Enabled="<%# ! Item.Reserved %>" Checked="<%# Item.Reserved %>" InputCssClass="form-control" InputStyle="margin: 0 auto; width: 20px; height: 20px;" />
                        <asp:HiddenField ID="SeatRow" runat="server" Value="<%# Item.Row %>" />
                        <asp:HiddenField ID="SeatNumber" runat="server" Value="<%# Item.Number %>" />
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </asp:Panel>

</asp:Content>
