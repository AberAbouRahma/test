
CREATE DATABASE [VacationRequestDB]
 CONTAINMENT = NONE
 GO
ALTER DATABASE [VacationRequestDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VacationRequestDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VacationRequestDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VacationRequestDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VacationRequestDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VacationRequestDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VacationRequestDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [VacationRequestDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [VacationRequestDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VacationRequestDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VacationRequestDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VacationRequestDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VacationRequestDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VacationRequestDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VacationRequestDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VacationRequestDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VacationRequestDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [VacationRequestDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VacationRequestDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VacationRequestDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VacationRequestDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VacationRequestDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VacationRequestDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [VacationRequestDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VacationRequestDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [VacationRequestDB] SET  MULTI_USER 
GO
ALTER DATABASE [VacationRequestDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VacationRequestDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VacationRequestDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VacationRequestDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [VacationRequestDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [VacationRequestDB]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 5/3/2020 7:56:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeCode] [nvarchar](128) NOT NULL,
	[EmployeeName] [nvarchar](100) NOT NULL,
	[vacType1Balanace] [int] NOT NULL,
	[vacType2Balanace] [int] NOT NULL,
	[ApprovedVacationRequests] [int] NOT NULL,
 CONSTRAINT [PK_dbo.Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vacations]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vacations](
	[RequestId] [nvarchar](128) NOT NULL,
	[EmployeeCode] [nvarchar](100) NOT NULL,
	[EmployeeName] [nvarchar](100) NOT NULL,
	[vacationType] [nvarchar](100) NOT NULL,
	[vacationFromDate] [datetime] NOT NULL,
	[vacationToDate] [datetime] NOT NULL,
	[vacationTotalDays] [int] NOT NULL,
	[vacationNotes] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Vacations] PRIMARY KEY CLUSTERED 
(
	[RequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VacationTypes]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VacationTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.VacationTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202005030542326_InitialCreate', N'VacationRequest.RequestVacationContext', 0x1F8B0800000000000400ED5BCD72DB3610BE77A6EFC0E1A99D714C5BB9B41E2919478E3B9AC63F13D9B97660129239050186005DE9D97AE823F515BAE00F48810445525494A41A1F2C12C0B78BC5B7C0025CFCFBF73FE3B7AB80582F38E23EA313FBFCF4CCB6307599E7D3E5C48EC5E2D52FF6DB373FFE307EEF052BEB535EEFB5AC072D299FD8CF4284178EC3DD671C207E1AF86EC4385B885397050EF298333A3BFBD5393F773040D8806559E38F31157E809307789C32EAE250C488DC300F139EBD879279826ADDA200F310B978627F422E12A0C447FC39C65CD8D625F111A831C764615B88522692F28B478EE7226274390FE105220FEB1043BD05221C67CA5F14D5DBF6E36C24FBE1140D732837E682051D01CF5F678671F4E6BDCC6B2BC381E9DE8389C55AF63A31DFC47E1F8484AD31745E1776312591AC58B1EE69DEE6C4D24A4E14198033F2EFC49AC644C4119E501C8B089113EB3E7E22BEFB3B5E3FB03F319DD09890B286A023946DBC8057F7110B7124D61FF142D37B0ADCB02D6713C1D12114406DEBB497C00BE0B76DDDA0D5074C97E219983FFAC5B6AEFD15F6F23719511EA90FEE008D4414C3E32D74023D11ACCA9D56D2E55393F4B3B37D487F41AE1479FE0E1144C17B720D6654BC1EF5451B0D83761986117BC19EC62BDE0575EC14246FA47E2EA40BF5F3E743523F9338F3BAF3BED4F450A4DFE672FB21FDC15D2EE18A947B38E9D7110BAE90501AC8DF0F7EB04377D8C07002912BB4EEE4ED66B85B26306FB036FC6C65ED9DE69674C4BBCF2FB2F490734C9FC9A598554C0357B2C05CB008FF86298E8036DE3D1202475462E0C494DB06798B1F0F3FB6108D0AE483BA9B33693E42B218AF44CD5043C4998D36CFA46E762C859F63A1CD5440DD429F34923D2D8235A7192457AB0EA458F65A8224BA3700A51CAF33A5325A11BB3B69F09E07F98E21CA1FDFA03084512D45FDD91B6B9E86FCD357F3EEE1709062382EAF898A95B64A1270142DB1560AA241D36B3FE202A63CF48424AFA65E50A966A088C1E8B9509D05BAAF16C390B790BF37474C0FD47590C29AD7D0C1005C2EE92B56CA94F60595A6C9060CA2BDA871819F321207747BACDE063175F63AC4B4A43D6235F62DA3564B3B238F1A91477D90CD31715982B95655D2D8D1465FE7985321D9BE58C83C7FE167E1494C5DF9BF5E62527D46391826AF68E53F52B115AF4C671A25FE8FB4751DA1DB51FA1E45F016D6A9BA42750A328DA3084C5A3FC2ED986E109416EE26A84A714D58B5C2200247DB048E86126876044DB0B9623B05C6CE261DEBAA3C861E84377D099BB63E12F648D88108BB49C7BA2A5798E0FE844D5BEF9BB07791BFF42922A65E6EF6A16EF56BBDEA6C5B09F3F2227E6B15DD15E1F92EEBAA0AE4BB4777E6A6A6812A9D1C95C30EE35954FB41FF6A23C5D2E6468BE50CDB9E7688C5314C1D6A51DA435766C6CDCBFAA0AA63997A6055DC1D3B3BA3A9C3CD8A0E1EBD3679D917885E73F13DA2D7926F6A136BA9649830E0BB8A374ADE5D5DFA4B85C3082A1CDE20ACA83050CF58A3B8BC7828616A7630CA53358611994D1C067159E981437CE5D5DD43FCA3571FBDFAE8D5BB79F59EF641CAABBBEF83BA79F5F7B3034ABF2D0C119F25DEDB7F2754DFDC345CFA36A8DBFEA7BA4B31ED4E768D751B47A7F29546AFA2A4ABAF35DA579971F685647B8296C16580ED117BF13DF9B964BEE60207A7B2C2E9FC3399123FF1E0BCC20DA2FE02063CFDAE698FCECE475A9AD7D79372E570EE919679575F45EE137D4191FB8CA26A22C8007916F5E032D761A0CC255FF264A0BCA53E58DBB296B66376CF593A70DED0E084D9CEC61E84D9371B2B493D8383EB393B326E11C3E5EC0C00A7E5ECF4F4C56AC64E6ECA9F02B4FAB90C395456CE17CF8A494CB335EFA5A3EDEAA8BD83C954C4BBE940F9E99375B95C467809AA2BF5DEC53E1133AA9E6F7D823CDFCD81D4FB199FB220647CA36F2AD6957ACC616105A55C586C2F09617FCD40B8EFFA02E2932C171DCC972CBF40DC27A60DA0826A37B1244940335A9DBF74731B600D534A2DACF4FF2DB08D4B5B81DA0EA57E516B8DD26A39AB471B3B359B0E23A9B2C38F23A98EA41A8E54D9DEFB7F46AA5636D2BF257C43366A0A4077F5BA2E766FE175FB73E6A67073575873A0D965A2680C317B00D505979D619AC2CA1D661CFD0CFFE84D476F3A7AD3CEDEF4EDADDF3B7B53BD81EAEF1D5473CF0DE7EDFA3963D36D82725FAD87D46EA57B082DEF0934DE35A81351BAA5D0E12AC2D69B084DA2B2BB0C3D2F2B548FBBC74EF9D6F2F80A737F5940C83BCC146F8EACAA33A30B966FE6A1A7658DF22ADA5EFF060B041300BA8C84BF40AE806217739E5C7EF984489C8CDA13F666F42E16612C2E39C7C113D9B84C233F0E35C94F6E646CEA3CBE0B93511AA20BA0A62FE7B03B2ABDD9537A5FD79C891A20A407640728A0D55CC88394E55A21DD32DA122833DF150E3195C72F0F18280F60FC8ECED10BEEA3DB23C71F60D272D7F9570B33C8F681D834FBF8CA474B9878788651B48747E0B017ACDEFC07DE8075FBBC3F0000, N'6.4.0')
INSERT [dbo].[Employees] ([EmployeeCode], [EmployeeName], [vacType1Balanace], [vacType2Balanace], [ApprovedVacationRequests]) VALUES (N'EmpCode1', N'Aber Abou-Rahma', 0, 0, 2)
INSERT [dbo].[Employees] ([EmployeeCode], [EmployeeName], [vacType1Balanace], [vacType2Balanace], [ApprovedVacationRequests]) VALUES (N'EmpCode2', N'Ahmed Sami', 0, 0, 2)
INSERT [dbo].[Employees] ([EmployeeCode], [EmployeeName], [vacType1Balanace], [vacType2Balanace], [ApprovedVacationRequests]) VALUES (N'EmpCode3', N'Hossam AbdAllah', 15, 0, 1)
INSERT [dbo].[Employees] ([EmployeeCode], [EmployeeName], [vacType1Balanace], [vacType2Balanace], [ApprovedVacationRequests]) VALUES (N'EmpCode4', N'Noha Mostafa', 3, 0, 2)
INSERT [dbo].[Employees] ([EmployeeCode], [EmployeeName], [vacType1Balanace], [vacType2Balanace], [ApprovedVacationRequests]) VALUES (N'EmpCode5', N'Ali Hossam', 15, 7, 0)
INSERT [dbo].[Vacations] ([RequestId], [EmployeeCode], [EmployeeName], [vacationType], [vacationFromDate], [vacationToDate], [vacationTotalDays], [vacationNotes]) VALUES (N'EmpCode1_1', N'EmpCode1', N'Aber Abou-Rahma', N'Type1 (Annual)', CAST(N'2020-05-20T00:00:00.000' AS DateTime), CAST(N'2020-06-03T00:00:00.000' AS DateTime), 15, N'')
INSERT [dbo].[Vacations] ([RequestId], [EmployeeCode], [EmployeeName], [vacationType], [vacationFromDate], [vacationToDate], [vacationTotalDays], [vacationNotes]) VALUES (N'EmpCode1_2', N'EmpCode1', N'Aber Abou-Rahma', N'Type2 (Sick)', CAST(N'2020-06-04T00:00:00.000' AS DateTime), CAST(N'2020-06-10T00:00:00.000' AS DateTime), 7, N'')
INSERT [dbo].[Vacations] ([RequestId], [EmployeeCode], [EmployeeName], [vacationType], [vacationFromDate], [vacationToDate], [vacationTotalDays], [vacationNotes]) VALUES (N'EmpCode2_1', N'EmpCode2', N'Ahmed Sami', N'Type1 (Annual)', CAST(N'2020-05-20T00:00:00.000' AS DateTime), CAST(N'2020-06-03T00:00:00.000' AS DateTime), 15, N'')
INSERT [dbo].[Vacations] ([RequestId], [EmployeeCode], [EmployeeName], [vacationType], [vacationFromDate], [vacationToDate], [vacationTotalDays], [vacationNotes]) VALUES (N'EmpCode2_2', N'EmpCode2', N'Ahmed Sami', N'Type2 (Sick)', CAST(N'2020-06-04T00:00:00.000' AS DateTime), CAST(N'2020-06-10T00:00:00.000' AS DateTime), 7, N'')
INSERT [dbo].[Vacations] ([RequestId], [EmployeeCode], [EmployeeName], [vacationType], [vacationFromDate], [vacationToDate], [vacationTotalDays], [vacationNotes]) VALUES (N'EmpCode3_1', N'EmpCode3', N'Hossam AbdAllah', N'Type2 (Sick)', CAST(N'2020-06-04T00:00:00.000' AS DateTime), CAST(N'2020-06-10T00:00:00.000' AS DateTime), 7, N'')
INSERT [dbo].[Vacations] ([RequestId], [EmployeeCode], [EmployeeName], [vacationType], [vacationFromDate], [vacationToDate], [vacationTotalDays], [vacationNotes]) VALUES (N'EmpCode4_1', N'EmpCode4', N'Noha Mostafa', N'Type2 (Sick)', CAST(N'2020-06-04T00:00:00.000' AS DateTime), CAST(N'2020-06-10T00:00:00.000' AS DateTime), 7, N'')
INSERT [dbo].[Vacations] ([RequestId], [EmployeeCode], [EmployeeName], [vacationType], [vacationFromDate], [vacationToDate], [vacationTotalDays], [vacationNotes]) VALUES (N'EmpCode4_2', N'EmpCode4', N'Noha Mostafa', N'Type1 (Annual)', CAST(N'2020-05-20T00:00:00.000' AS DateTime), CAST(N'2020-05-31T00:00:00.000' AS DateTime), 12, N'')
SET IDENTITY_INSERT [dbo].[VacationTypes] ON 

INSERT [dbo].[VacationTypes] ([Id], [Name]) VALUES (1, N'Type1 (Annual)')
INSERT [dbo].[VacationTypes] ([Id], [Name]) VALUES (2, N'Type2 (Sick)')
SET IDENTITY_INSERT [dbo].[VacationTypes] OFF
/****** Object:  StoredProcedure [dbo].[Employee_Delete]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employee_Delete]
    @EmployeeCode [nvarchar](128)
AS
BEGIN
    DELETE [dbo].[Employees]
    WHERE ([EmployeeCode] = @EmployeeCode)
END
GO
/****** Object:  StoredProcedure [dbo].[Employee_Insert]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employee_Insert]
    @EmployeeCode [nvarchar](128),
    @EmployeeName [nvarchar](100),
    @vacType1Balanace [int],
    @vacType2Balanace [int],
    @ApprovedVacationRequests [int]
AS
BEGIN
    INSERT [dbo].[Employees]([EmployeeCode], [EmployeeName], [vacType1Balanace], [vacType2Balanace], [ApprovedVacationRequests])
    VALUES (@EmployeeCode, @EmployeeName, @vacType1Balanace, @vacType2Balanace, @ApprovedVacationRequests)
END
GO
/****** Object:  StoredProcedure [dbo].[Employee_Update]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employee_Update]
    @EmployeeCode [nvarchar](128),
    @EmployeeName [nvarchar](100),
    @vacType1Balanace [int],
    @vacType2Balanace [int],
    @ApprovedVacationRequests [int]
AS
BEGIN
    UPDATE [dbo].[Employees]
    SET [EmployeeName] = @EmployeeName, [vacType1Balanace] = @vacType1Balanace, [vacType2Balanace] = @vacType2Balanace, [ApprovedVacationRequests] = @ApprovedVacationRequests
    WHERE ([EmployeeCode] = @EmployeeCode)
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllEmployees]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllEmployees] AS  BEGIN  SELECT * FROM Employees  END 
                              
GO
/****** Object:  StoredProcedure [dbo].[GetAllVacationsToReport]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllVacationsToReport] AS  BEGIN  SELECT RequestId AS 'Request ID', EmployeeCode AS 'Employee Code', EmployeeName AS 'Employee Name',  vacationType AS 'Vacation Type',  CONVERT(VARCHAR(10), [vacationFromDate], 103) AS 'Vacation From Date',  CONVERT(VARCHAR(10), [vacationToDate], 103) AS 'Vacation to Date',  vacationTotalDays AS 'Vacation Total Days'  FROM Vacations  END 
                              
GO
/****** Object:  StoredProcedure [dbo].[GetEmpsWithVacationBalance]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmpsWithVacationBalance] AS  BEGIN  SELECT * FROM Employees where vacType1Balanace > 0 OR vacType2Balanace > 0 END 
                              
GO
/****** Object:  StoredProcedure [dbo].[GetReportParameters]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetReportParameters] @Employee1Name nvarchar (100) , @Employee2Name nvarchar (100) , @fromDate dateTime , @toDate dateTime  AS  BEGIN  WITH VacationsCTE AS  (  SELECT * FROM Vacations WHERE (EmployeeName >= @Employee1Name or @Employee1Name = '' ) AND  (EmployeeName <= @Employee2Name or @Employee2Name ='')  intersect  SELECT  * FROM Vacations WHERE  (vacationFromDate >= @fromDate or @fromdate = '') AND  (vacationToDate <= @toDate or @toDate ='')  )  SELECT RequestId AS 'Request ID', EmployeeCode AS 'Employee Code', EmployeeName AS 'Employee Name',  vacationType AS 'Vacation Type',  CONVERT(VARCHAR(10), [vacationFromDate], 103) AS 'Vacation From Date',  CONVERT(VARCHAR(10), [vacationToDate], 103) AS 'Vacation to Date',  vacationTotalDays AS 'Vacation Total Days'  FROM VacationsCTE  END
GO
/****** Object:  StoredProcedure [dbo].[GetTotalsReportParameters]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTotalsReportParameters] @Employee1Name nvarchar (100) , @Employee2Name nvarchar (100) , @fromDate dateTime , @toDate dateTime  AS  BEGIN  WITH VacationsCTE AS  (  SELECT * FROM Vacations WHERE (EmployeeName >= @Employee1Name or @Employee1Name = '' ) AND  (EmployeeName <= @Employee2Name or @Employee2Name ='')  intersect  SELECT  * FROM Vacations WHERE  (vacationFromDate >= @fromDate or @fromdate = '') AND  (vacationToDate <= @toDate or @toDate ='')  )  select vacationTotalDays , EmployeeName , vacationType  from VacationsCTE ORDER BY EmployeeName, vacationType  END
GO
/****** Object:  StoredProcedure [dbo].[GetVacationsForEmployee]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetVacationsForEmployee] @EmployeeCode nvarchar (128)  AS  BEGIN  SELECT * FROM Vacations where EmployeeCode = @EmployeeCode END 
                              
GO
/****** Object:  StoredProcedure [dbo].[Vacation_Delete]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Vacation_Delete]
    @RequestId [nvarchar](128)
AS
BEGIN
    DELETE [dbo].[Vacations]
    WHERE ([RequestId] = @RequestId)
END
GO
/****** Object:  StoredProcedure [dbo].[Vacation_Insert]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Vacation_Insert]
    @RequestId [nvarchar](128),
    @EmployeeCode [nvarchar](100),
    @EmployeeName [nvarchar](100),
    @vacationType [nvarchar](100),
    @vacationFromDate [datetime],
    @vacationToDate [datetime],
    @vacationTotalDays [int],
    @vacationNotes [nvarchar](max)
AS
BEGIN
    INSERT [dbo].[Vacations]([RequestId], [EmployeeCode], [EmployeeName], [vacationType], [vacationFromDate], [vacationToDate], [vacationTotalDays], [vacationNotes])
    VALUES (@RequestId, @EmployeeCode, @EmployeeName, @vacationType, @vacationFromDate, @vacationToDate, @vacationTotalDays, @vacationNotes)
END
GO
/****** Object:  StoredProcedure [dbo].[Vacation_Update]    Script Date: 5/3/2020 7:56:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Vacation_Update]
    @RequestId [nvarchar](128),
    @EmployeeCode [nvarchar](100),
    @EmployeeName [nvarchar](100),
    @vacationType [nvarchar](100),
    @vacationFromDate [datetime],
    @vacationToDate [datetime],
    @vacationTotalDays [int],
    @vacationNotes [nvarchar](max)
AS
BEGIN
    UPDATE [dbo].[Vacations]
    SET [EmployeeCode] = @EmployeeCode, [EmployeeName] = @EmployeeName, [vacationType] = @vacationType, [vacationFromDate] = @vacationFromDate, [vacationToDate] = @vacationToDate, [vacationTotalDays] = @vacationTotalDays, [vacationNotes] = @vacationNotes
    WHERE ([RequestId] = @RequestId)
END
GO
USE [master]
GO
ALTER DATABASE [VacationRequestDB] SET  READ_WRITE 
GO
