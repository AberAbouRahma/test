<%@ Page Title="Request Vacation" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="RequestVacation.aspx.vb" Inherits="VacationRequest.EmployeeDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <h1>Vacation Request Form</h1>
    </div>

    <asp:FormView ID="vacationDetail" runat="server" ItemType="VacationRequest.Employee" SelectMethod="GetEmployee" RenderOuterTable="false">
        <EmptyDataTemplate>
            <table>
                <tr>
                    <td>No Employees in the Database.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <ItemTemplate>

            <br />

            <asp:Label ID="requestLabel" runat="server" Text="Request ID"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="requestText" runat="server" Height="19px" Width="116px"
        Text='<%#Item.EmployeeCode & "_" & (Item.ApprovedVacationRequests + 1) %>' Enabled="false"></asp:TextBox>

            <br />
            <br />
            <br />
            <asp:Label ID="nameLabel" runat="server" Text="Employee"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="Nametext" runat="server" Text="<%#:Item.EmployeeName %>" Enabled="false"></asp:TextBox>
            <br />
            <br />
            <br />
            <asp:Label ID="vacationTypeLabel" runat="server" Text="Vacation Type"></asp:Label>&nbsp;&nbsp;&nbsp;
    <asp:DropDownList ID="vacTypeText" AutoPostBack="True" runat="server" OnSelectedIndexChanged="vacTypeText_SelectedIndexChanged" DataSourceID="VacationTypes" DataTextField="Name" DataValueField="Name">

    </asp:DropDownList>
            <asp:SqlDataSource ID="VacationTypes" runat="server" ConnectionString="<%$ ConnectionStrings:VacationRequestDB %>" SelectCommand="SELECT [Name] FROM [VacationTypes]"></asp:SqlDataSource>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="vacationBalancelabel" runat="server" Text="Vacation Balance"></asp:Label>&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="vacationBalanceText" Enabled="false" runat="server" Text="<%#:Item.vacType1Balanace %>"></asp:TextBox>
            <br />
            <br />
            <br />
            <asp:Label ID="vacationFromLabel" runat="server" Text="Vacation From" AutoPostBack="true"></asp:Label>&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="vacationFromText" Enabled="true" runat="server" Width="150px" AutoPostBack="true" OnTextChanged="vacationFromText_TextChanged"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
    <asp:Label ID="vacationToLabel" runat="server" Text="Vacation To"></asp:Label>&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="VacationToText" Enabled="false" runat="server" Width="150px" AutoPostBack="true" OnTextChanged="vacationToText_TextChanged"></asp:TextBox>
            <br />
            <br />
            <br />



            <asp:Label ID="notesLabel" runat="server" Text="Notes"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

    <textarea id="notesText" name="notesText" cols="200"></textarea>
            <br />
            <br />
            <br />
            <asp:Button ID="submitButton" Text="Submit Request" runat="server" OnClick="submitButton_Click" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            <asp:Button ID="canelButton" Text="Cancel Request" runat="server" OnClick="canelButton_Click" />
        </ItemTemplate>
    </asp:FormView>

</asp:Content>
