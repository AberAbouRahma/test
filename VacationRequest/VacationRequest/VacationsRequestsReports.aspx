<%@ Page Title="Vacations Requests Reports" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="VacationsRequestsReports.aspx.vb" Inherits="VacationRequest.VacationsRequestsReports" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <h1>Vacations Requests Report</h1>
    </div>
    <div id="FiltersDiv" style="float: left;" class="">
        <div id="EmpsFilterDiv" style="float: left; margin-left: 100px; position: relative; margin-bottom: 25px;" class="">
            <asp:CheckBox ID="empsFilterCheckBox" AutoPostBack="true" runat="server" Text="Filter From Employee To Employee" />
            <div id="fromEmpPicker" style="margin-top: 10px;">
                <asp:Label ID="fromEmpLabel" runat="server" Text="From Employee" Visible="false"></asp:Label>
                <asp:DropDownList ID="fromEmpDropDownList" runat="server" Visible="False" DataSourceID="VacationRequestDB" DataTextField="EmployeeName" DataValueField="EmployeeName"></asp:DropDownList>
            </div>
            <div id="toEmpPicker" style="margin-top: 15px;">
                <asp:Label ID="toEmpLabel" runat="server" Text="To Employee" Visible="false"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="toEmpDropDownList" runat="server" Visible="False" DataSourceID="VacationRequestDB" DataTextField="EmployeeName" DataValueField="EmployeeName"></asp:DropDownList>
                <asp:SqlDataSource ID="VacationRequestDB" runat="server" ConnectionString="<%$ ConnectionStrings:VacationRequestDB %>" SelectCommand="SELECT [EmployeeName] FROM [Employees]"></asp:SqlDataSource>
            </div>
        </div>
        <div id="datesFilterDiv" style="float: left; margin-left: 100px; position: relative; margin-bottom: 25px;" class="">
            <div id="datesFilterDivCheckBoxDiv">
                <asp:CheckBox ID="datesFilterCheckBox" AutoPostBack="true" runat="server" Text="Filter From Date to Date" />
            </div>
            <div id="fromDatePicker" style="float: left; margin-left: 20px; margin-top: 10px;">
                <asp:Label ID="fromDateLabel" runat="server" Text="From Date" Visible="false"></asp:Label>
                <asp:Calendar ID="fromDateCalendar" runat="server" Visible="false"></asp:Calendar>
            </div>
            <div id="toDatePicker" style="float: left; margin-left: 20px; margin-top: 10px;">
                <asp:Label ID="toDatelabel" runat="server" Text="To Date" Visible="false"></asp:Label>
                <asp:Calendar ID="toDateCalendar" runat="server" Visible="false"></asp:Calendar>
            </div>
        </div>
    </div>
    <div id="filterButtonDiv" style="float: left; margin-left: 50px; margin-bottom: 25px;" class="">
        <asp:Button ID="filterButton" Text="Generate Report" runat="server" class="btn btn-info" Visible="false" />
    </div>
    <div id="CRDiv" class="">
        
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" Visible="false" AutoDataBind="True" Height="1202px" ToolPanelWidth="200px" Width="1104px" />

        <%-- <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
        <Report FileName="~/CrystalReports/MainReport.rpt">
        </Report>
    </CR:CrystalReportSource>--%>
    </div>

</asp:Content>
