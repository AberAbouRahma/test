Imports VacationRequest.RequestVacationContext
Imports VacationRequest.Vacation
Public Class VacationRepository
    Dim db As New RequestVacationContext
    Public Function GetVacations() As List(Of Vacation)
        Return db.Vacations.ToList
    End Function

    Public Function InsertVacation(vacation As Vacation)
        db.Vacations.Add(vacation)
        db.SaveChanges()
    End Function

    Public Function UpdateVacation(vacation As Vacation)
        Dim vacationToUpdate As Vacation = db.Vacations.FirstOrDefault(Function(v) v.RequestId = vacation.RequestId)
        vacationToUpdate.EmployeeCode = vacation.EmployeeCode
        vacationToUpdate.EmployeeName = vacation.EmployeeName
        vacationToUpdate.vacationType = vacation.vacationType
        vacationToUpdate.vacationFromDate = vacation.vacationFromDate
        vacationToUpdate.vacationToDate = vacation.vacationToDate
        vacationToUpdate.vacationTotalDays = vacation.vacationTotalDays
        vacationToUpdate.vacationNotes = vacation.vacationNotes
        db.SaveChanges()
    End Function

    Public Function DeleteVacation(vacationId As Integer)
        Dim vacationToDelete As Vacation = db.Vacations.FirstOrDefault(Function(v) vacationId = v.RequestId)
        db.Vacations.Remove(vacationToDelete)
        db.SaveChanges()
    End Function
End Class
