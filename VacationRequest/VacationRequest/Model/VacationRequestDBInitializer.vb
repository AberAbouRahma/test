Imports System.Data.Entity
Imports System.Data.SqlClient
Imports Microsoft.SqlServer.Server

Public Class VacationRequestDBInitializer : Inherits DropCreateDatabaseIfModelChanges(Of RequestVacationContext)
    Protected Overrides Sub Seed(context As RequestVacationContext)
        MyBase.Seed(context)
        GetEmployees.ForEach(Function(c) context.Employees.Add(c))
        GetVacationTypes.ForEach(Function(c) context.VacationTypes.Add(c))
        CreateStoredProcdures(context)
    End Sub
    Public Shared Sub CreateStoredProcdures(context As RequestVacationContext)
        GetAllEmployees(context)
        GetEmployeesWithVacationBalance(context)
        GetVacationsForEmployee(context)
        GetReportParameters(context)
        GetAllVacationsToReport(context)
        GetTotalsReportParameters(context)
    End Sub
    ' Applies the CR filters for the summary report to get the total vacations days per selected name per vacation type
    Public Shared Sub GetTotalsReportParameters(context As RequestVacationContext)
        context.Database.ExecuteSqlCommand("CREATE PROCEDURE dbo.[GetTotalsReportParameters]" &
                             " @Employee1Name nvarchar (100) ," &
                             " @Employee2Name nvarchar (100) ," &
                             " @fromDate dateTime ," &
                             " @toDate dateTime " &
                             " AS " &
                             " BEGIN " &
                             " WITH VacationsCTE AS " &
                             " ( " &
                             " SELECT * FROM Vacations WHERE (EmployeeName >= @Employee1Name or @Employee1Name = '' ) AND " &
                             " (EmployeeName <= @Employee2Name or @Employee2Name ='') " &
                             " intersect " &
                             " SELECT  * FROM Vacations WHERE  (vacationFromDate >= @fromDate or @fromdate = '') AND " &
                             " (vacationToDate <= @toDate or @toDate ='') " &
                             " ) " &
                             " select vacationTotalDays , EmployeeName ," &
                             " vacationType " &
                             " from VacationsCTE ORDER BY EmployeeName, vacationType " &
                              " END")
        '" select vacationTotalDays AS 'Vacation Total Days', EmployeeName AS 'Employee Name', " &
        '" vacationType AS 'Vacation Type' " &
        '" from VacationsCTE ORDER BY EmployeeName, vacationType " &


    End Sub

    Public Shared Sub GetReportParameters(context As RequestVacationContext)
        context.Database.ExecuteSqlCommand("CREATE PROCEDURE dbo.[GetReportParameters]" &
                             " @Employee1Name nvarchar (100) ," &
                             " @Employee2Name nvarchar (100) ," &
                             " @fromDate dateTime ," &
                             " @toDate dateTime " &
                             " AS " &
                             " BEGIN " &
                             " WITH VacationsCTE AS " &
                             " ( " &
                             " SELECT * FROM Vacations WHERE (EmployeeName >= @Employee1Name or @Employee1Name = '' ) AND " &
                             " (EmployeeName <= @Employee2Name or @Employee2Name ='') " &
                             " intersect " &
                             " SELECT  * FROM Vacations WHERE  (vacationFromDate >= @fromDate or @fromdate = '') AND " &
                             " (vacationToDate <= @toDate or @toDate ='') " &
                             " ) " &
                             " SELECT RequestId AS 'Request ID', EmployeeCode AS 'Employee Code', EmployeeName AS 'Employee Name', " &
                             " vacationType AS 'Vacation Type', " &
                             " CONVERT(VARCHAR(10), [vacationFromDate], 103) AS 'Vacation From Date', " &
                             " CONVERT(VARCHAR(10), [vacationToDate], 103) AS 'Vacation to Date', " &
                             " vacationTotalDays AS 'Vacation Total Days' " &
                             " FROM VacationsCTE " &
                             " END")
    End Sub
    ' All vacations record(s) in the system less the notes field(s)
    Public Shared Sub GetAllVacationsToReport(context As RequestVacationContext)

        context.Database.ExecuteSqlCommand("CREATE PROCEDURE dbo.[GetAllVacationsToReport]" &
                              " AS " &
                              " BEGIN " &
                              " SELECT RequestId AS 'Request ID', EmployeeCode AS 'Employee Code', EmployeeName AS 'Employee Name', " &
                             " vacationType AS 'Vacation Type', " &
                             " CONVERT(VARCHAR(10), [vacationFromDate], 103) AS 'Vacation From Date', " &
                             " CONVERT(VARCHAR(10), [vacationToDate], 103) AS 'Vacation to Date', " &
                             " vacationTotalDays AS 'Vacation Total Days' " &
                             " FROM Vacations " &
                              " END 
                              ")
    End Sub
    Public Shared Sub GetVacationsForEmployee(context As RequestVacationContext)

        context.Database.ExecuteSqlCommand("CREATE PROCEDURE dbo.[GetVacationsForEmployee]" &
                              " @EmployeeCode nvarchar (128) " &
                              " AS " &
                              " BEGIN " &
                              " SELECT * FROM Vacations where EmployeeCode = @EmployeeCode" &
                              " END 
                              ")

    End Sub

    Public Shared Sub GetEmployeesWithVacationBalance(context As RequestVacationContext)

        context.Database.ExecuteSqlCommand("CREATE PROCEDURE dbo.[GetEmpsWithVacationBalance]" &
                              " AS " &
                              " BEGIN " &
                              " SELECT * FROM Employees where vacType1Balanace > 0 OR vacType2Balanace > 0" &
                              " END 
                              ")

    End Sub
    Public Shared Sub GetAllEmployees(context As RequestVacationContext)

        context.Database.ExecuteSqlCommand("CREATE PROCEDURE dbo.[GetAllEmployees]" &
                              " AS " &
                              " BEGIN " &
                              " SELECT * FROM Employees " &
                              " END 
                              ")
    End Sub
    Private Shared Function GetEmployees() As List(Of Employee)
        Dim employees = New List(Of Employee) From {
            New Employee With {
                .EmployeeCode = "EmpCode1",
                .EmployeeName = "Aber Abou-Rahma",
                .vacType1Balanace = 15,
                .vacType2Balanace = 7
                },
            New Employee With {
                .EmployeeCode = "EmpCode2",
                .EmployeeName = "Ahmed Sami",
                .vacType1Balanace = 15,
                .vacType2Balanace = 7
                },
            New Employee() With {
                .EmployeeCode = "EmpCode3",
                .EmployeeName = "Hossam AbdAllah",
                .vacType1Balanace = 15,
                .vacType2Balanace = 7
                },
            New Employee() With {
                .EmployeeCode = "EmpCode4",
                .EmployeeName = "Noha Mostafa",
                .vacType1Balanace = 15,
                .vacType2Balanace = 7
                },
            New Employee() With {
                .EmployeeCode = "EmpCode5",
                .EmployeeName = "Ali Hossam",
                .vacType1Balanace = 15,
                .vacType2Balanace = 7
                }
        }
        Return employees
    End Function

    Private Shared Function GetVacationTypes() As List(Of VacationType)
        Dim vacationType = New List(Of VacationType) From {
            New VacationType With {
                .Id = 1,
                .Name = "Type1 (Annual)"
                },
            New VacationType With {
                .Id = 2,
                .Name = "Type2 (Sick)"
                }
        }
        Return vacationType
    End Function
End Class
