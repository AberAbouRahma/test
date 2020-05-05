Imports System.ComponentModel.DataAnnotations

Public Class Employee

    <ScaffoldColumn(False), Key(), Display(Name:="Employee Code")>
    Public Property EmployeeCode As String

    <Required, StringLength(100), Display(Name:="Employee Name")>
    Public Property EmployeeName As String

    <Required>
    Public Property vacType1Balanace As Integer

    <Required>
    Public Property vacType2Balanace As Integer
    'These are not approved vacation days. These are the number of approved requests
    ' Used to generate the  vacation request Id along with the employy code 
    ' (To form unique vacation request id)
    <Display(Name:="Vacations Taken")>
    Public Property ApprovedVacationRequests As Integer = 0

End Class
