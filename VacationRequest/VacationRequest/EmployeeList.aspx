<%@ Page Title="Employees" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="EmployeeList.aspx.vb" Inherits="VacationRequest.EmployeeList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    <section>
        <div>
            <hgroup>
                <h2><%: Page.Title %></h2>
            </hgroup>

            <asp:ListView ID="productList" runat="server"
                DataKeyNames="EmployeeCode" GroupItemCount="2"
                ItemType="VacationRequest.Employee" SelectMethod="GetEmployees">
                <EmptyDataTemplate>
                    <table>
                        <tr>
                            <td>No Employees in the Database.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <EmptyItemTemplate>
                    <td />
                </EmptyItemTemplate>
                <GroupTemplate>
                    <tr id="itemPlaceholderContainer" runat="server">
                        <td id="itemPlaceholder" runat="server"></td>
                    </tr>
                </GroupTemplate>
                <ItemTemplate>
                    <td runat="server">
                        <table>
                            <tr>
                                <td>
                                    <a href="RequestVacation.aspx?EmployeeCode=<%#:Item.EmployeeCode%>">
                                       <b>Request Vacation For: </b> <%#:Item.EmployeeName%></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>
                                        <b>Type1 Vacation Balance (Annaul): </b><%#: Item.vacType1Balanace%>
                                    </span>
                                    <br />
                                    <span>
                                        <b>Type2 Vacation Balance (Sick): </b><%#: Item.vacType2Balanace%>
                                    </span>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                        </p>
                    </td>
                </ItemTemplate>
                <LayoutTemplate>
                    <table style="width: 100%;">
                        <tbody>
                            <tr>
                                <td>
                                    <table id="groupPlaceholderContainer" runat="server" style="width: 100%">
                                        <tr id="groupPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>
                            <tr></tr>
                        </tbody>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
        </div>
    </section>



</asp:Content>
