Imports System.ComponentModel.DataAnnotations
Public Class Vacation
    <ScaffoldColumn(False), Key(), Display(Name:="Request ID")>
    Public Property RequestId As String

    <Required, StringLength(100), Display(Name:="Employee Code")>
    Public Property EmployeeCode As String

    <Required, StringLength(100), Display(Name:="Employee Name")>
    Public Property EmployeeName As String

    <Required, StringLength(100), Display(Name:="Vacation Type")>
    Public Property vacationType As String

    'Navigation
    'Overridable Property selectedvacationType As VacationType

    <Required, Display(Name:="Vacation From Date"), DisplayFormat(ApplyFormatInEditMode:=True, DataFormatString:="{0:dd/MM/yyyy")>
    Public Property vacationFromDate As Date

    <Required, Display(Name:="Vacation To Date"), DisplayFormat(ApplyFormatInEditMode:=True, DataFormatString:="{0:dd/MM/yyyy")>
    Public Property vacationToDate As Date

    <Required, Display(Name:="Vacation Total Days")>
    Public Property vacationTotalDays As Integer

    <Display(Name:="Vacation Notes")>
    Public Property vacationNotes As String
End Class
