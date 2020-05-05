Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine

Public Class VacationsRequestsReports
    Inherits System.Web.UI.Page
    Public Shared EmpFilterationStatus As Boolean = False
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim crystalReport As New ReportDocument()
        crystalReport.Load(Server.MapPath("~/CrystalReports/MainReport.rpt"))
        CrystalReportViewer1.ReportSource = crystalReport
        CrystalReportViewer1.RefreshReport()

    End Sub

    Protected Sub empsFilterCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles empsFilterCheckBox.CheckedChanged
        If empsFilterCheckBox.Checked Then
            fromEmpLabel.Visible = True
            fromEmpDropDownList.Visible = True
            toEmpLabel.Visible = True
            toEmpDropDownList.Visible = True
            filterButton.Visible = True
        Else
            fromEmpLabel.Visible = False
            fromEmpDropDownList.Visible = False
            toEmpLabel.Visible = False
            toEmpDropDownList.Visible = False
            If datesFilterCheckBox.Checked = False Then
                filterButton.Visible = False
            End If
        End If
        CrystalReportViewer1.Visible = False
    End Sub

    Protected Sub datesFilterCheckBox_CheckedChanged(sender As Object, e As EventArgs) Handles datesFilterCheckBox.CheckedChanged
        If datesFilterCheckBox.Checked Then
            fromDateLabel.Visible = True
            fromDateCalendar.Visible = True
            toDatelabel.Visible = True
            toDateCalendar.Visible = True
            filterButton.Visible = True
        Else
            fromDateLabel.Visible = False
            fromDateCalendar.Visible = False
            toDatelabel.Visible = False
            toDateCalendar.Visible = False
            If empsFilterCheckBox.Checked = False Then
                filterButton.Visible = False
            End If
        End If
        CrystalReportViewer1.Visible = False
    End Sub

    Protected Sub filterButton_Click(sender As Object, e As EventArgs) Handles filterButton.Click
        Dim filterConfirmMessage As String = ""
        If empsFilterCheckBox.Checked Then
            EmpFilterationStatus = True
            If fromEmpDropDownList.SelectedValue = toEmpDropDownList.SelectedValue Then
                filterConfirmMessage &= "Filter by emp " & fromEmpDropDownList.SelectedValue
            ElseIf fromEmpDropDownList.SelectedValue > toEmpDropDownList.SelectedValue Then
                filterConfirmMessage &= "Filter from emp " & toEmpDropDownList.SelectedValue & " to emp " &
                    fromEmpDropDownList.SelectedValue
            ElseIf fromEmpDropDownList.SelectedValue < toEmpDropDownList.SelectedValue Then
                filterConfirmMessage &= "Filter from emp " & fromEmpDropDownList.SelectedValue & " to emp " &
                    toEmpDropDownList.SelectedValue
            End If
        Else
            EmpFilterationStatus = False
            fromEmpDropDownList.SelectedIndex = -1
            toEmpDropDownList.SelectedIndex = -1
        End If

        If datesFilterCheckBox.Checked And fromDateCalendar.SelectedDate <> Nothing And toDateCalendar.SelectedDate <> Nothing Then
            If Date.Compare(fromDateCalendar.SelectedDate, toDateCalendar.SelectedDate) = 0 Then
                filterConfirmMessage &= If(filterConfirmMessage <> "", ". And on " & fromDateCalendar.SelectedDate.ToShortDateString,
                   "Filters will be applied on " & fromDateCalendar.SelectedDate.ToShortDateString)
            ElseIf Date.Compare(fromDateCalendar.SelectedDate, toDateCalendar.SelectedDate) < 0 Then
                filterConfirmMessage &= If(filterConfirmMessage <> "", ". And from " & fromDateCalendar.SelectedDate.ToShortDateString & " to " &
                    toDateCalendar.SelectedDate.ToShortDateString, "Filters will be applied from " & fromDateCalendar.SelectedDate.ToShortDateString & " to " &
                    toDateCalendar.SelectedDate.ToShortDateString)
            Else
                If filterConfirmMessage <> "" Then
                    filterConfirmMessage &= ". The selected 'from date' is greater than the 'to date'. Filters will be applied only by the selected employee(s)."
                    fromDateCalendar.SelectedDate = Date.MinValue
                    toDateCalendar.SelectedDate = Date.MaxValue
                Else
                    filterConfirmMessage &= "The selected 'from date' is greater than the 'to date'. The report will include all vacations requests by all employees"
                    fromEmpDropDownList.SelectedIndex = -1
                    toEmpDropDownList.SelectedIndex = -1
                    fromDateCalendar.SelectedDate = Date.MinValue
                    toDateCalendar.SelectedDate = Date.MaxValue
                End If
            End If
        ElseIf datesFilterCheckBox.Checked And fromDateCalendar.SelectedDate <> Nothing Then
            filterConfirmMessage &= If(filterConfirmMessage <> "", ". And on or from " & fromDateCalendar.SelectedDate.ToShortDateString,
                "Filters will be applied for vacations on or from " & fromDateCalendar.SelectedDate.ToShortDateString)
        ElseIf datesFilterCheckBox.Checked And toDateCalendar.SelectedDate <> Nothing Then
            filterConfirmMessage &= If(filterConfirmMessage <> "", ". And before or on " & toDateCalendar.SelectedDate.ToShortDateString,
                "Filters will be applied for vacations before or on " & toDateCalendar.SelectedDate.ToShortDateString)
        Else
            If filterConfirmMessage <> "" Then
                filterConfirmMessage &= ". You did not select the filteration dates. Filters will be applied only by the selected employee(s)."
            Else
                filterConfirmMessage &= "You did not select the filteration dates nor employee(s). The report will include all vacations requests by all employees"
                fromEmpDropDownList.SelectedIndex = -1
                toEmpDropDownList.SelectedIndex = -1
            End If
        End If
        Dim result As String = MsgBox(filterConfirmMessage, vbOKCancel)
        If result = vbOK Then
            'Hide all filters
            fromEmpLabel.Visible = False
            fromEmpDropDownList.Visible = False
            toEmpLabel.Visible = False
            toEmpDropDownList.Visible = False
            fromDateLabel.Visible = False
            fromDateCalendar.Visible = False
            toDatelabel.Visible = False
            toDateCalendar.Visible = False

            'clear the filtering check boxes
            empsFilterCheckBox.Checked = False
            datesFilterCheckBox.Checked = False

            ' Regenerate the CR with the filtering criteria
            BindReportingFilters()
            ' Hide the button itself
            filterButton.Visible = False
            CrystalReportViewer1.Visible = True
        Else ' User pressed cancel
            MsgBox("Select filters for the vacations report, or clear checked filteration boxes")
        End If
    End Sub

    Private Sub BindReportingFilters()

        '   Dim test As String = dsVacation.Tables.Item(0).Rows(0)("Request ID").ToString()

        Dim crystalReport As New ReportDocument()
        crystalReport.Load(Server.MapPath("~/CrystalReports/MainReport.rpt"))
        Dim dsVacation As DataSet
        Dim dsVacationTotals As DataSet
        If EmpFilterationStatus Then
            dsVacation = GetDetailsSubReportData(fromEmpDropDownList.SelectedValue, toEmpDropDownList.SelectedValue,
                                                               fromDateCalendar.SelectedDate, toDateCalendar.SelectedDate)
            'GetTotalsReportParameters
            dsVacationTotals = GetTotalsSubReportData(fromEmpDropDownList.SelectedValue, toEmpDropDownList.SelectedValue,
                                                               fromDateCalendar.SelectedDate, toDateCalendar.SelectedDate)
        Else
            dsVacation = GetDetailsSubReportData("", "",
                                                               fromDateCalendar.SelectedDate, toDateCalendar.SelectedDate)
            'GetTotalsReportParameters
            dsVacationTotals = GetTotalsSubReportData(fromEmpDropDownList.SelectedValue, toEmpDropDownList.SelectedValue,
                                                               fromDateCalendar.SelectedDate, toDateCalendar.SelectedDate)
        End If
        EmpFilterationStatus = False
        ' Clearing all previous filteration selections
        fromEmpDropDownList.SelectedIndex = -1
        toEmpDropDownList.SelectedIndex = -1
        fromDateCalendar.SelectedDate = Date.MinValue
        toDateCalendar.SelectedDate = Date.MaxValue

        crystalReport.DataSourceConnections.Clear()
        crystalReport.Subreports(0).DataSourceConnections.Clear()
        crystalReport.Subreports(1).DataSourceConnections.Clear()
        crystalReport.Subreports(0).SetDataSource(dsVacation.Tables.Item(0))
        crystalReport.Subreports(1).SetDataSource(dsVacationTotals.Tables.Item(0))
        CrystalReportViewer1.ReportSource = crystalReport
        CrystalReportViewer1.RefreshReport()
    End Sub


    Private Function GetTotalsSubReportData(ByVal fromEmp As String, ByVal toEmp As String, ByVal fromDate As Date, ByVal toDate As Date) As DataSet
        Dim conString As String = ConfigurationManager.ConnectionStrings("VacationRequestDB").ConnectionString
        Using cmd As SqlCommand = New SqlCommand("Exec GetTotalsReportParameters @Employee1Name, @Employee2Name, @fromDate, @toDate")
            Using con As SqlConnection = New SqlConnection(conString)
                Using sda As SqlDataAdapter = New SqlDataAdapter()
                    cmd.Connection = con
                    sda.SelectCommand = cmd
                    cmd.Parameters.AddWithValue("@Employee1Name", fromEmp)
                    cmd.Parameters.AddWithValue("@Employee2Name", toEmp)
                    If fromDate = DateTime.MinValue Then ' No selected from date, start from the first mssql date
                        fromDate = #01/01/1753#
                    End If
                    If toDate = DateTime.MinValue Then ' No selected to date, end to the last mssql date
                        toDate = #12/31/9999#
                    End If
                    cmd.Parameters.AddWithValue("@fromDate", fromDate)
                    cmd.Parameters.AddWithValue("@toDate", toDate)
                    Dim dsVacationsTotals As DataSet = New DataSet()
                    sda.Fill(dsVacationsTotals)
                    Return dsVacationsTotals
                End Using
            End Using
        End Using
    End Function
    Private Function GetDetailsSubReportData(ByVal fromEmp As String, ByVal toEmp As String, ByVal fromDate As Date, ByVal toDate As Date) As DataSet
        Dim conString As String = ConfigurationManager.ConnectionStrings("VacationRequestDB").ConnectionString
        Using cmd As SqlCommand = New SqlCommand("Exec GetReportParameters @Employee1Name, @Employee2Name, @fromDate, @toDate")
            Using con As SqlConnection = New SqlConnection(conString)
                Using sda As SqlDataAdapter = New SqlDataAdapter()
                    cmd.Connection = con
                    sda.SelectCommand = cmd
                    cmd.Parameters.AddWithValue("@Employee1Name", fromEmp)
                    cmd.Parameters.AddWithValue("@Employee2Name", toEmp)
                    If fromDate = DateTime.MinValue Then
                        fromDate = #01/01/1753#
                    End If
                    If toDate = DateTime.MinValue Then
                        toDate = #12/31/9999#
                    End If
                    cmd.Parameters.AddWithValue("@fromDate", fromDate)
                    cmd.Parameters.AddWithValue("@toDate", toDate)
                    Dim dsVacations As DataSet = New DataSet()
                    sda.Fill(dsVacations)
                    Return dsVacations
                End Using
            End Using
        End Using
    End Function

    Protected Sub fromDateCalendar_SelectionChanged(sender As Object, e As EventArgs) Handles fromDateCalendar.SelectionChanged
        ' No toDte yet selected, set the todate default to the selected from date, the user can still select his desired todate date
        ' but this is for easier navigation to the target todate as it cannot be less than the from date anyways
        ' Same of the user selected a toDate less than the desired from date, will set the todate to the fromdate
        If toDateCalendar.SelectedDate = DateTime.MinValue Or
            Date.Compare(toDateCalendar.SelectedDate, fromDateCalendar.SelectedDate) < 0 Then

            toDateCalendar.SelectedDate = fromDateCalendar.SelectedDate
            toDateCalendar.VisibleDate = toDateCalendar.SelectedDate

        End If
    End Sub
End Class
