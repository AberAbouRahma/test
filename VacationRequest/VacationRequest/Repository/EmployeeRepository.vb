Imports VacationRequest.RequestVacationContext
Imports VacationRequest.Vacation
Public Class EmployeeRepository
    Dim db As New RequestVacationContext
    Public Function GetEmployees() As List(Of Employee)
        Return db.Employees.ToList
    End Function

    Public Function InsertEmployee(emp As Employee)
        db.Employees.Add(emp)
        db.SaveChanges()
    End Function

    Public Function UpdateEmployee(emp As Employee)
        Dim employeeToUpdate As Employee = db.Employees.FirstOrDefault(Function(e) e.EmployeeCode = emp.EmployeeCode)
        employeeToUpdate.EmployeeCode = emp.EmployeeCode
        employeeToUpdate.EmployeeName = emp.EmployeeName
        employeeToUpdate.vacType1Balanace = emp.vacType1Balanace
        employeeToUpdate.vacType2Balanace = emp.vacType2Balanace
        employeeToUpdate.ApprovedVacationRequests = emp.ApprovedVacationRequests
        db.SaveChanges()
    End Function

    Public Function DeleteEmployee(employeeCode As Integer)
        Dim employeeToDelete As Employee = db.Employees.FirstOrDefault(Function(e) e.EmployeeCode = employeeCode)
        db.Employees.Remove(employeeToDelete)
        db.SaveChanges()
    End Function
End Class

