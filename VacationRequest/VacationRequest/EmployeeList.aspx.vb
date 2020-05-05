Imports System.Web.ModelBinding

Public Class EmployeeList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Public Function GetEmployees(<QueryString("EmployeeCode")> employeeCode As String, <RouteData> employeeName As String) As IQueryable(Of Employee)
        Dim db = New RequestVacationContext()
        Dim query As IQueryable(Of Employee) = db.Employees

        'Find by Employee Code
        If employeeCode <> "" Then
            query = query.Where(Function(p) p.EmployeeCode = employeeCode)
        End If

        'Find by Employee Name
        If Not (String.IsNullOrEmpty(employeeName)) Then
            query = query.Where(Function(p) String.Compare(p.EmployeeName, employeeName) = 0)
        End If

        Return query
    End Function
End Class