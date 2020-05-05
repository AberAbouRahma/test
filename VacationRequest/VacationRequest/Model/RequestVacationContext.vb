Imports System.Data.Entity

Public Class RequestVacationContext : Inherits DbContext
    Public Sub New()
        MyBase.New("VacationRequestDB")

    End Sub

    Public Property Employees As DbSet(Of Employee)
    Public Property VacationTypes As DbSet(Of VacationType)
    Public Property Vacations As DbSet(Of Vacation)

    Protected Overrides Sub OnModelCreating(ByVal modelBuilder As DbModelBuilder)
        modelBuilder.Entity(Of Vacation)().MapToStoredProcedures()
        modelBuilder.Entity(Of Employee)().MapToStoredProcedures()
        MyBase.OnModelCreating(modelBuilder)

    End Sub
End Class

