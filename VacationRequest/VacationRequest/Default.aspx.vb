Public Class _Default
    Inherits Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim init As New EmployeeList
        init.GetEmployees("", "initiator")
    End Sub
End Class