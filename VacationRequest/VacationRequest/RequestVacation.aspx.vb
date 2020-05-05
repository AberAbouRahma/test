Imports System.Data.SqlClient
Imports System.Web.ModelBinding

Public Class EmployeeDetails
    Inherits System.Web.UI.Page
    Public Shared currentEmpCode As String
    Public Shared db As RequestVacationContext
    Public Shared query As IEnumerable(Of Employee)
    Public Shared VacationQuery As IEnumerable(Of Vacation)
    Public Shared requestedVacationDays As Integer
    Public Shared fromDate As Date
    Public Shared toDate As Date

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        db = New RequestVacationContext()
        query = db.Employees
    End Sub

    Public Function GetEmployee(<QueryString("EmployeeCode")> employeeCode As String, <RouteData> employeeName As String) As IQueryable(Of Employee)

        If employeeCode <> "" Then
            query = query.Where(CType(Function(p) p.EmployeeCode = employeeCode, Func(Of Employee, Boolean))).AsQueryable()
            currentEmpCode = employeeCode
            Dim q As List(Of Employee) = query.ToList
            Dim emp As Employee = q.ElementAt(0)
            If emp.vacType1Balanace = 0 And emp.vacType2Balanace = 0 Then
                MsgBox("Sorry! Can not request vacation for " & emp.EmployeeName & ". No vacation balance left")
                Response.Redirect("EmployeeList.aspx")
            End If
        ElseIf Not String.IsNullOrEmpty(employeeName) Then
            query = query.Where(Function(p) String.Compare(p.EmployeeName, employeeName) = 0).AsQueryable()
        Else
            query = Nothing
        End If
        Return query
    End Function







    Protected Sub vacTypeText_SelectedIndexChanged(sender As Object, e As EventArgs)

        Dim vacTypeText As DropDownList = vacationDetail.FindControl("vacTypeText")
        Dim value As String
        If (Not vacTypeText Is Nothing) Then
            value = vacTypeText.SelectedIndex
            query = query.Where(CType(Function(p) p.EmployeeCode = currentEmpCode, Func(Of Employee, Boolean)))
            Dim q As List(Of Employee) = query.ToList
            Dim emp As Employee = q.ElementAt(0)

            If value = 0 Then

                Dim balance As Integer = emp.vacType1Balanace
                Dim vacationBalanceText As TextBox = vacationDetail.FindControl("vacationBalanceText")
                vacationBalanceText.Text = balance.ToString
            ElseIf value = 1 Then
                Dim balance As Integer = emp.vacType2Balanace
                Dim vacationBalanceText As TextBox = vacationDetail.FindControl("vacationBalanceText")
                vacationBalanceText.Text = balance.ToString
            End If
        End If

        ' ToDo Need to memic the same behaviour
        Dim vacationFromText As TextBox = vacationDetail.FindControl("vacationFromText")
        Dim vacationToText As TextBox = vacationDetail.FindControl("vacationToText")
        vacationToText.Text = ""
        vacationFromText.Text = ""
    End Sub

    Protected Sub vacationFromText_TextChanged(sender As Object, e As EventArgs)
        Dim vacationFromText As TextBox = vacationDetail.FindControl("vacationFromText")
        Dim vacationToText As TextBox = vacationDetail.FindControl("vacationToText")
        Try
            Dim vacFromVal As String = vacationFromText.Text
            Dim day As Integer = vacFromVal.Substring(0, 2)
            Dim month As Integer = vacFromVal.Substring(3, 2)
            Dim year As Integer = vacFromVal.Substring(6, 4)
            Dim isValidDate As Boolean = IsDate(month & "/" & day & "/" & year)
            If Not isValidDate Then
                Throw New Exception("Please re-enter all dates in 'DD/MM/YYYY' format")
            End If
            Dim enteredDate As Date = CDate(month & "/" & day & "/" & year), currentDate As Date = Date.Now
            Dim dateCompareResult As Integer = DateTime.Compare(enteredDate, currentDate)
            If dateCompareResult < 0 Then
                Throw New Exception("Entered date must be greater than or equal to today's date")
            End If
            'Date satisfies and passes buisness rules so far, we can enable the "Vacation To" date
            vacationToText.Enabled = True
        Catch EX As Exception
            MsgBox(EX.Message & " Dates must be in 'DD/MM/YYYY' format.")
            vacationFromText.Text = ""
            vacationToText.Text = ""
        End Try
    End Sub

    Protected Sub vacationToText_TextChanged(sender As Object, e As EventArgs)
        Dim vacationToText As TextBox = vacationDetail.FindControl("vacationToText")
        Dim vacationFromText As TextBox = vacationDetail.FindControl("vacationFromText")

        Try
            Dim vacFromVal As String = vacationFromText.Text
            Dim dayFrom As Integer = vacFromVal.Substring(0, 2)
            Dim monthFrom As Integer = vacFromVal.Substring(3, 2)
            Dim yearFrom As Integer = vacFromVal.Substring(6, 4)

            Dim vacToVal As String = vacationToText.Text
            Dim day As Integer = vacToVal.Substring(0, 2)
            Dim month As Integer = vacToVal.Substring(3, 2)
            Dim year As Integer = vacToVal.Substring(6, 4)
            Dim isValidDate As Boolean = IsDate(month & "/" & day & "/" & year)
            If Not isValidDate Then
                Throw New Exception("Please re-enter all dates in 'DD/MM/YYYY' format")
            End If
            Dim enteredDate As Date = CDate(month & "/" & day & "/" & year),
                enteredromDate As Date = CDate(monthFrom & "/" & dayFrom & "/" & yearFrom)
            Dim dateCompareResult As Integer = DateTime.Compare(enteredDate, enteredromDate)
            If dateCompareResult < 0 Then
                Throw New Exception("'Vacation To' date must be greater than or equal to 'Vacation From' date")
            End If
            'Calculate the requested vacation days
            requestedVacationDays = (DateDiff(DateInterval.Day, enteredromDate, enteredDate) + 1)
            Dim vacationBalanceText As TextBox = vacationDetail.FindControl("vacationBalanceText")
            Dim vacationBalanceValue = Val(vacationBalanceText.Text)
            If requestedVacationDays > vacationBalanceValue Then
                Dim msg As String = "Sorry! Cannot grant your request. You do not have sufficient vacation balance. Vacation Days Requested: " & requestedVacationDays
                MsgBox(msg)
                vacationToText.Text = ""
                vacationFromText.Text = ""
            End If
            Dim EmployeeCodeParameter As New SqlParameter("@EmployeeCode", currentEmpCode)
            VacationQuery = db.Database.SqlQuery(Of Vacation)("GetVacationsForEmployee @EmployeeCode", EmployeeCodeParameter)


            fromDate = enteredromDate
            toDate = enteredDate
            'To check if the employee has requested vacations within the same period
            Dim vacationOverlapFlag As Boolean = False
            For Each priorVacation As Vacation In VacationQuery
                vacationOverlapFlag = If((DateTime.Compare(toDate, priorVacation.vacationFromDate) < 0) Or
                    (DateTime.Compare(fromDate, priorVacation.vacationToDate) > 0),
                    False, True)
                If vacationOverlapFlag Then
                    Dim msg As String = "Can not grant your request as you already have entered vacation within same period"
                    MsgBox(msg)
                    vacationToText.Text = ""
                    vacationFromText.Text = ""
                    Exit For
                End If
            Next
        Catch EX As Exception
            MsgBox(EX.Message & " Dates must be in 'DD/MM/YYYY' format.")
            vacationToText.Text = ""
        End Try
    End Sub

    Protected Sub submitButton_Click(sender As Object, e As EventArgs)
        Dim vacationToText As TextBox = vacationDetail.FindControl("vacationToText")
        Dim vacationFromText As TextBox = vacationDetail.FindControl("vacationFromText")
        If vacationToText.Text = "" Or vacationFromText.Text = "" Then
            MsgBox("you must enter your vacation dates or cancel the request")
            Exit Sub
        End If
        'So far everything seems okay lets increment the no of vacation request for the employee and adjust related 
        ' vacation type's balance
        Dim emp As Employee = query.Where(CType(Function(p) p.EmployeeCode = currentEmpCode, Func(Of Employee, Boolean))).AsQueryable().
            ToList.ElementAt(0)
        emp.ApprovedVacationRequests += 1
        Dim vacTypeText As DropDownList = vacationDetail.FindControl("vacTypeText")
        Dim value As String = vacTypeText.SelectedIndex

        If value = 0 Then
            emp.vacType1Balanace -= requestedVacationDays

        ElseIf value = 1 Then
            emp.vacType2Balanace -= requestedVacationDays
        End If
        'Let's create the vacation record in the vacation table
        Dim vactype As String = db.VacationTypes.Where(CType(Function(p) p.Id = value + 1, Func(Of VacationType, Boolean))).ToList.ElementAt(0).Name

        Dim notesText As String = Request.Form("notesText")

        'Stored proc call to insert the new vaction request record into the vacations table
        Dim EmployeeNameParameter As New SqlParameter("@EmployeeName", emp.EmployeeName)
        Dim EmployeeCodeParameter As New SqlParameter("@EmployeeCode", emp.EmployeeCode)
        Dim RequestIdParameter As New SqlParameter("@RequestId", emp.EmployeeCode & "_" & emp.ApprovedVacationRequests)
        Dim vacationFromDateParameter As New SqlParameter("@vacationFromDate", fromDate.Date)
        Dim vacationToDateParameter As New SqlParameter("@vacationToDate", toDate.Date)
        Dim vacationNotesParameter As New SqlParameter("@vacationNotes", notesText)
        Dim vacationTypeParameter As New SqlParameter("@vacationType", vactype)
        Dim vacationTotalDaysParameter As New SqlParameter("@vacationTotalDays", requestedVacationDays)
        db.Database.ExecuteSqlCommand("exec Vacation_Insert @RequestId, @EmployeeCode, @EmployeeName, @vacationType, 
@vacationFromDate, @vacationToDate, @vacationTotalDays, @vacationNotes", RequestIdParameter, EmployeeCodeParameter, EmployeeNameParameter,
vacationTypeParameter, vacationFromDateParameter, vacationToDateParameter, vacationTotalDaysParameter, vacationNotesParameter)

        db.SaveChanges()

        Response.Redirect("EmployeeList.aspx")
    End Sub

    Protected Sub canelButton_Click(sender As Object, e As EventArgs)
        Response.Redirect("EmployeeList.aspx")
    End Sub
End Class