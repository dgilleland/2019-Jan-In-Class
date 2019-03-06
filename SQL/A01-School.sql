/* School database - DMIT-1508-A01, Jan 2017 
   Table Creation and Load Data Script 
   **************************************** */

-- CREATE DATABASE [A01-School]
GO

USE [A01-School]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Payment')
  DROP TABLE  Payment
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PaymentType')
  DROP TABLE   PaymentType
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Registration')
  DROP TABLE  Registration
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Activity')
  DROP TABLE   Activity
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Staff')
  DROP TABLE  Staff
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Course')
  DROP TABLE  Course
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Student')
  DROP TABLE  Student
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Club')
  DROP TABLE  Club
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Position')
  DROP TABLE  Position
go

CREATE TABLE  Position
(
	PositionID		tinyint identity(10,1)		Constraint PK_POS_PosID			Primary Key clustered,
	PositionDescription	varchar(50)			Constraint NN_POS_PosDesc		not null
)
go


CREATE TABLE  Club
(
	ClubId			Varchar (10)			Constraint PK_CLB_ClubID		Primary Key Clustered,
	ClubName		Varchar (50)			Constraint NN_CLB_ClubName		not null
)
go


CREATE TABLE  Student
(
	StudentID		int identity(200900001,1)	Constraint PK_STU_SID			Primary Key,
	FirstName	varchar(25)			Constraint NN_STU_StuFName		not null,
	LastName		varchar(35)			Constraint NN_STU_StuLName		not null,
	Gender			char (1)			Constraint NN_STU_Gender		not null
								Constraint CK_STU_Gender_MF		check (Gender in ('M','F')),
	StreetAddress		varchar (35)			Constraint NL_STU_StrAddress		null,
	City			varchar (30)			Constraint NL_STU_City			null,
	Province		char (2)			Constraint NL_STU_Prov			null
								Constraint DF_STU_Prov_AB		default 'AB'
								Constraint CK_STU_Prov_ZZ		check (Province like '[A-Z][A-Z]'),
	PostalCode		char (6)			Constraint NL_STU_PCode			null
								Constraint CK_STU_PCode_Z9Z9Z9		check
												 (PostalCode like '[A-Z][0-9][A-Z][0-9][A-Z][0-9]'),
	Birthdate		smalldatetime			Constraint NN_STU_BDate			not null
								Constraint CK_STU_BDate_GE16		check
													 (birthdate <= dateadd(yy, -16, getdate())),
	BalanceOwing		decimal(7,2)			Constraint NN_STU_BalOwe		null
								Constraint DF_STU_BalOwe_0		default 0
								Constraint CK_STU_BalOwe_GE0		check (BalanceOwing >= 0)
)
go


CREATE TABLE  Course
(
	CourseId		char (7)			Constraint PK_CRS_CseID			Primary Key,
	CourseName		varchar (40)			Constraint PK_CRS_CName			not null
								Constraint DF_CRS_CName			default 'unknown',
	CourseHours		smallint			Constraint NN_CRS_CHours		not null
								Constraint CK_CRS_CHours_GT0		check (CourseHours > 0),
	MaxStudents		int				Constraint NN_CRS_MaxStu		null
								Constraint DF_CRS_MaxStu_0		default 0
								Constraint CK_CRS_MaxStu_GE0		check (MaxStudents >= 0),
	CourseCost		decimal(6,2)			Constraint NN_CRS_CCost			not null
								Constraint DF_CRS_CCost_0		default 0
								Constraint CK_CRS_CCost_GT0		check (CourseCost >= 0),
)
go


CREATE TABLE  Staff
(
	StaffID			smallint identity (15,1)	Constraint PK_STF_StaID			Primary Key Clustered,
	FirstName		varchar (25)			Constraint NN_STF_StaFName		not null,
	LastName		varchar (35)			Constraint NN_STF_StaLName		not null,
	DateHired		smalldatetime			Constraint NN_STF_HireDate		not null
								Constraint DF_STF_HireDate_Today	default getdate(),
	DateReleased		smalldatetime			Constraint NL_STF_RelDate		null,
	PositionID		tinyint				Constraint NN_STF_PosID			not null
								Constraint FK_STF_POS_PosID		references Position(PositionID),
	LoginID			varchar (30)			Constraint NL_STF_Login			null,
	Constraint CK_STF_RelDate_GT_HireDate Check (DateReleased > DateHired)
)
go


CREATE TABLE  Activity
(
	StudentID		int				Constraint FK_ACT_STU_StuID		references Student (StudentID), 
	ClubId			varchar (10)			Constraint FK_ACT_CLB_ClubID		references Club (ClubId),
	Constraint PK_ACT_SID_ClubID Primary Key Clustered (StudentID, ClubId)
)
go


CREATE TABLE Registration
(
	StudentID		int				Constraint FK_GRD_STU_StuID		references Student (StudentID),
	CourseId		char (7)			Constraint FK_GRD_CRS_CseID		references Course (CourseId),
	Semester		char (5)			Constraint NN_GRD_Sem			not null
								Constraint CK_GRD_Sem_9999Z		check
													 (Semester like '[1-9][0-9][0-9][0-9][A-Z]'),
	Mark			decimal(5,2)			Constraint NL_GRD_Mark			null
								Constraint CK_GRD_Mark_0to100		check (Mark between 0 and 100),
	WithdrawYN		char (1)			Constraint NL_GRD_Withdr		null
								Constraint DF_GRD_Withdr_N		default 'N'
								Constraint CK_GRD_Withdr_NY		check (WithdrawYN in ('N','Y')),
	StaffID			smallint			Constraint NL_GRD_StaID			null
								Constraint FK_GRD_STF_StaID		references Staff (StaffID)
	Constraint PK_GRD_StuID_CseID_Sem Primary Key Clustered (StudentID, CourseId, Semester)
)
go


CREATE TABLE  PaymentType
(
	PaymentTypeID		tinyint Identity (10,1)		Constraint PK_PTYP_PayTypeID		Primary Key Clustered,
	PaymentTypeDescription	varchar(40)			Constraint NL_PTYP_PayTypeDesc		null
)
go

			
CREATE TABLE  Payment
(
	PaymentID		int Identity (10000,1)		Constraint PK_PAY_PayID			Primary Key Clustered,
	PaymentDate		datetime			Constraint NN_PAY_PayID			not null
								Constraint DF_PAY_PDate_Today		default getdate()
								Constraint CK_PAY_PDate_Not_Old		check (PaymentDate >= getdate()),
	Amount		decimal(6,2)			Constraint NN_PAY_PayAmt		not null
								Constraint DF_PAY_PayAmt_0		default 0
								Constraint CK_PAY_PayAmt_GE0		check (Amount >= 0),
	PaymentTypeID		tinyint				Constraint NN_PAY_PayTypeID		not null
								Constraint FK_PAY_PTYP_PayTypeID	references PaymentType(PaymentTypeID),
	StudentID		int				Constraint NN_PAY_StuID			not null
								Constraint FK_PAY_STU_StuID		references Student (StudentID)
)
go

/* School158 Data Inserts */

USE [A01-School]
GO

delete from Payment
delete from PaymentType
delete from Registration
delete from Activity
delete from Staff
delete from Course
delete from Student
delete from Club
delete from Position
go

set Identity_Insert Position ON
Insert into Position
	(PositionID, PositionDescription)
Values
	(1, 'Dean')
Insert into Position
	(PositionID, PositionDescription)
Values
	(7, 'Assistant Dean')
Insert into Position
	(PositionID, PositionDescription)
Values
	(2, 'Program Chair')
Insert into Position
	(PositionID, PositionDescription)
Values
	(3, 'Assistant Program Chair')
Insert into Position
	(PositionID, PositionDescription)
Values
	(4, 'Instructor')
Insert into Position
	(PositionID, PositionDescription)
Values
	(5, 'Office Administrator')
Insert into Position
	(PositionID, PositionDescription)
Values
	(6, 'Technical Support Staff')
set Identity_Insert Position Off
go

set Identity_Insert Staff On
Insert into Staff
	(StaffID, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
Values
	(4, 'Nolan', 'Itall', 'Aug 12, 1993', null, 4, null)
Insert into Staff
	(StaffID, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
Values
	(10, 'Chip', 'Andale', 'July 14, 2007', null, 6, null)
Insert into Staff
	(StaffID, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
Values
	(2, 'Robert', 'Smith', 'June 12, 1990', null, 3, null)
insert into Staff
	(StaffID, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
Values
	(3, 'Tess', 'Agonor', 'Apr 25, 1992', 'May 22, 1996', 4, null)
Insert into Staff
	(StaffID, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
Values
	(9, 'Nic', 'Bustamante', 'Jun 15, 2007', null, 2, null)
Insert into Staff
	(StaffID, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
Values
	(6, 'Sia', 'Latter', 'Oct 30, 1996', null, 4, null)
Insert into Staff
	(StaffID, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
Values
	(7, 'Hugh', 'Guy', 'Oct 10, 1998', null, 1, null)
Insert into Staff
	(StaffID, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
Values
	(5, 'Jerry', 'Kan', 'Aug 15, 1995', null, 4, null)
Insert into Staff
	(StaffID, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
Values
	(1, 'Donna', 'Bookem', 'Apr 17, 1988', null, 5, null)
Insert into Staff
	(StaffID, FirstName, LastName, DateHired, DateReleased, PositionID, LoginID)
Values
	(8, 'Cher', 'Power', 'May 30, 2000', null, 3, null)
set Identity_Insert Staff Off
go


set Identity_Insert Student On
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(198933540, 'Winnie', 'Woo', 'F', '200 - 3 St. S.W', 'Calgary', 'AB', 'T9A1N1', 'Nov  4 1978', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(199899200, 'Ivy', 'Kent', 'F', '11044 -83 ST.', 'Edm', 'AB', 'T4N9A7', 'Dec 11 1979', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(199912010, 'Dave', 'Brown', 'M', '11206-106 St.', 'Edm', 'AB', 'T4J7H2', 'Jan  2 1976', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(199966250, 'Dennis', 'Kent', 'M', '11044 -83 ST.', 'Edm', 'AB', 'T3O1J1', 'Apr 29 1979', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200011730, 'Jay ', 'Smith', 'M', 'Box 761', 'Red Deer', 'AB', 'T6J7V3', 'May  6 1983', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200122100, 'Peter', 'Codd', 'M', '172 Downers Grove', 'Victoria', 'BC', 'V6E4R2', 'May  7 1981', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200312345, 'Mary', 'Jane', 'F', '11044 -83 Ave.', 'Edm', 'AB', 'T3Q9N5', 'Dec 11 1969', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200322620, 'Flying', 'Nun', 'F', 'Fantasy Land', 'Edmonton', 'AB', 'T9T4Z4', 'Oct 22 1962', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200494470, 'Minnie', 'Ono', 'F', '12003 -103 ST.', 'Edm', 'AB', 'T2W7P7', 'Dec 10 1970', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200494476, 'Joe', 'Cool', 'M', '12003 -103 ST.', 'Edm', 'AB', 'T2G6L7', 'Dec 10 1975', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200495500, 'Robert', 'Smith', 'M', 'Box 333', 'Leduc', 'AB', 'T6P3Z3', 'Mar 20 1976', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200522220, 'Joe', 'Petroni', 'M', '11206 Imperial Building', 'Calgary', 'AB', 'T3Q5A7', 'Aug  3 1965', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200578400, 'Andy', 'Kowaski', 'M', '172 Downing St.', 'Woolerton', 'SK', 'S7Y0Q3', 'Nov  7 1976', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200645320, 'Thomas', 'Brown', 'M', '11206 Empire Building', 'Edmonton', 'AB', 'T4S6S2', 'Oct  2 1977', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200688700, 'Robbie', 'Chan', 'F', 'Box 561', 'Athabasca', 'AB', 'T4Z4B1', 'Mar 30 1968', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200978400, 'Peter', 'Pan', 'M', '182 Downing St.', 'Tisdale', 'SK', 'S1K9H3', 'Nov  7 1986', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200645328, 'Andy', 'Brown', 'M', '11206 Empire Building', 'Edmonton', 'AB', 'T4S6S2', 'Oct  2 1977', 0.00)
Insert into Student
	(StudentID, FirstName, LastName, Gender, StreetAddress, City, Province, PostalCode, Birthdate, BalanceOwing)
Values
	(200645329, 'Zach', 'Brown', 'M', '11206 Empire Building', 'Edmonton', 'AB', 'T4S6S2', 'Oct  2 1977', 0.00)
set Identity_Insert Student Off
go


Insert into Club
	(ClubId, ClubName)
Values
	('CSS', 'Computer System Society')
Insert into Club
	(ClubId, ClubName)
Values
	('NASA', 'NAIT Staff Association')
Insert into Club
	(ClubId, ClubName)
Values
	('CIPS', 'Computer Info Processing Society')
Insert into Club
	(ClubId, ClubName)
Values
	('CHESS', 'NAIT Chess Club')
Insert into Club
	(ClubId, ClubName)
Values
	('ACM', 'Association of Computing Machinery')
Insert into Club
	(ClubId, ClubName)
Values
	('NAITSA', 'NAIT Student Association')
Insert into Club
	(ClubId, ClubName)
Values
	('DBTG', 'DataBase Task Group')
Insert into Club
	(ClubId, ClubName)
Values
	('NASA1', 'NAIT Support Staff Association')
go

Insert into Activity
	(StudentID, ClubId)
Values
	(199912010, 'CSS')
Insert into Activity
	(StudentID, ClubId)
Values
	(199912010, 'ACM')
Insert into Activity
	(StudentID, ClubId)
Values
	(199912010, 'NASA')
Insert into Activity
	(StudentID, ClubId)
Values
	(200312345, 'CSS')
Insert into Activity
	(StudentID, ClubId)
Values
	(199899200, 'CSS')
Insert into Activity
	(StudentID, ClubId)
Values
	(200495500, 'CHESS')
Insert into Activity
	(StudentID, ClubId)
Values
	(200495500, 'CSS')
Insert into Activity
	(StudentID, ClubId)
Values
	(200322620, 'CSS')
Insert into Activity
	(StudentID, ClubId)
Values
	(200495500, 'ACM')
Insert into Activity
	(StudentID, ClubId)
Values
	(200322620, 'ACM')
go

Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT103', 'Applied Problem Solving', 96, 3, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT104', 'Programming Fundamentals', 96, 5, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT101', 'Communications in IT and New Media', 64, 4, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT108', 'Web Design 1', 64, 4, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT172', 'Systems Analysis & Design 1', 96, 5, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT152', 'Advanced Programming (.net 1)', 96, 5, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT168', 'Math & Physics', 80, 5, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT225', 'Systems Analysis & Design 2', 96, 3, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT259', 'DMIT259 Project Management', 64, 2, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT163', 'Game Programming 1', 96, 4, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT221', 'Open Source Programming (J2EE)', 96, 4, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT223', 'Quality Assurance', 64, 4, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT170', 'Networking 1', 64, 4, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT227', 'Web Server Administration (IIS, Apache)', 64, 5, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT224', 'Server Administration & Applications', 64, 5, 450.00)
Insert into Course
	(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
Values
	('DMIT254', 'Capstone Project', 192, 5, 1575.00)
go

Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT103', '2000S', 80, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT104', '2000S', 83, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT172', '2000S', 98, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT108', '2000S', 98, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT101', '2000S', 85, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT225', '2001J', 88, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT163', '2001J', 88, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT221', '2001S', 85, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT227', '2002J', 80, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT223', '2001S', 78, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT168', '2001J', 78, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT152', '2001J', 89, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT170', '2001J', 83, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT224', '2002J', 89, 'N', 6)

Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200495500, 'DMIT103', '2000S', 80, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200495500, 'DMIT104', '2000S', 83, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200495500, 'DMIT172', '2000S', 98, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200495500, 'DMIT108', '2000S', 98, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200495500, 'DMIT101', '2000S', 85, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200495500, 'DMIT225', '2001J', 88, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200495500, 'DMIT163', '2001J', 88, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT227', '2002J', 80, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT223', '2001S', 78, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT168', '2001J', 78, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT152', '2001J', 89, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT170', '2001J', 83, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT224', '2002J', 89, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT103', '2000S', 80, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT104', '2000S', 83, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT172', '2000S', 98, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT108', '2000S', 98, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT101', '2000S', 85, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT225', '2001J', 88, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200494470, 'DMIT163', '2001J', 88, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200122100, 'DMIT221', '2003M', 85, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200122100, 'DMIT227', '2003S', 80, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200122100, 'DMIT223', '2003J', 78, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200122100, 'DMIT168', '2002S', 78, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200122100, 'DMIT152', '2002S', 89, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200122100, 'DMIT170', '2003J', 83, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200122100, 'DMIT224', '2003S', 89, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200312345, 'DMIT227', '2004M', 80, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200312345, 'DMIT221', '2003S', 88, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200312345, 'DMIT168', '2003M', 78, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200312345, 'DMIT152', '2003J', 89, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200312345, 'DMIT104', '2002S', 83, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200312345, 'DMIT224', '2004J', 89, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200312345, 'DMIT259', '2004M', 89, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200578400, 'DMIT259', '2004M', 30, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200578400, 'DMIT104', '2000S', 83, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200578400, 'DMIT172', '2000S', 98, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200578400, 'DMIT108', '2000S', 98, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200578400, 'DMIT101', '2000S', 85, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200578400, 'DMIT259', '2004S', 88, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200578400, 'DMIT163', '2004J', 88, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199899200, 'DMIT221', '2004S', 85, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199899200, 'DMIT227', '2005J', 80, 'N', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199899200, 'DMIT223', '2004S', 78, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199899200, 'DMIT168', '2004J', 78, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199899200, 'DMIT152', '2004J', 89, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199899200, 'DMIT170', '2004J', 83, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199899200, 'DMIT224', '2005J', 89, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199899200, 'DMIT172', '2000S', 80, 'N', 5)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199899200, 'DMIT254', '2005M', 0, 'Y', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200578400, 'DMIT254', '2005M', 0, 'Y', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200312345, 'DMIT254', '2005M', 0, 'Y', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200122100, 'DMIT254', '2005M', 0, 'Y', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(199912010, 'DMIT254', '2005M', 0, 'Y', 6)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200688700, 'DMIT152', '2005S', null, 'N', 4)
Insert into Registration
	(StudentID, CourseID, Semester, Mark, WithdrawYN, StaffID)
Values
	(200645320, 'DMIT152', '2005S', null, 'N', 4)
go

set Identity_Insert PaymentType ON
Insert into PaymentType
	(PaymentTypeID, PaymentTypeDescription)
Values
	(5, 'American Express')
Insert into PaymentType
	(PaymentTypeID, PaymentTypeDescription)
Values
	(1, 'Cash')
Insert into PaymentType
	(PaymentTypeID, PaymentTypeDescription)
Values
	(2, 'Cheque')
Insert into PaymentType
	(PaymentTypeID, PaymentTypeDescription)
Values
	(4, 'MasterCard')
Insert into PaymentType
	(PaymentTypeID, PaymentTypeDescription)
Values
	(6, 'Debit Card')
Insert into PaymentType
	(PaymentTypeID, PaymentTypeDescription)
Values
	(3, 'VISA')
set Identity_Insert PaymentType OFF
go


-- need to turn off date check temporarily to allow for old dates
alter table Payment NOCHECK constraint CK_PAY_PDate_Not_Old

set Identity_Insert Payment ON

Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(24, 'May  1 2004 12:59PM', 900.00, 2, 200312345)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(17, 'May  1 2003 12:14PM', 450.00, 6, 200122100)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(25, 'May  1 2004  9:21AM', 450.00, 6, 200578400)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(22, 'Jan  1 2004 10:17AM', 450.00, 2, 200312345)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(9, 'Sep  1 2001  8:35AM', 900.00, 6, 199912010)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(32, 'May  1 2005  2:46PM', 1575.00, 2, 200312345)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(8, 'Jan  1 2001 12:10PM', 900.00, 4, 200495500)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(2, 'Sep  1 2000 11:18AM', 2250.00, 5, 199912010)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(13, 'Sep  1 2002 10:58AM', 900.00, 5, 200122100)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(21, 'Jan  1 2004  1:30PM', 1350.00, 4, 199899200)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(26, 'Sep  1 2004 12:36PM', 900.00, 1, 199899200)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(5, 'Sep  1 2000  9:55AM', 1800.00, 5, 200578400)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(16, 'Jan  1 2003  3:58PM', 450.00, 1, 200312345)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(29, 'May  1 2005  1:13PM', 1575.00, 4, 199899200)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(14, 'Sep  1 2002 12:05PM', 450.00, 3, 200312345)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(3, 'Sep  1 2000  2:49PM', 2250.00, 1, 200494470)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(28, 'Jan  1 2005 12:21PM', 900.00, 1, 199899200)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(6, 'Jan  1 2001 12:33PM', 2250.00, 6, 199912010)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(4, 'Sep  1 2000  1:30PM', 2250.00, 2, 200495500)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(18, 'May  1 2003  3:35PM', 450.00, 5, 200312345)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(1, 'Sep  1 2000 12:20PM', 450.00, 5, 199899200)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(7, 'Jan  1 2001  8:14AM', 2250.00, 5, 200494470)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(19, 'Sep  1 2003 10:19AM', 900.00, 4, 200122100)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(10, 'Sep  1 2001 11:18AM', 450.00, 2, 200494470)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(12, 'Jan  1 2002 10:05AM', 900.00, 4, 200494470)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(20, 'Sep  1 2003  3:06PM', 450.00, 5, 200312345)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(33, 'May  1 2005  2:01PM', 1575.00, 3, 200578400)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(27, 'Sep  1 2004  5:01PM', 450.00, 2, 200578400)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(23, 'Jan  1 2004  2:11PM', 450.00, 6, 200578400)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(30, 'May  1 2005 11:06AM', 1575.00, 1, 199912010)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(11, 'Jan  1 2002 11:16AM', 900.00, 4, 199912010)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(15, 'Jan  1 2003 10:25AM', 900.00, 6, 200122100)
Insert into Payment
	(PaymentID, PaymentDate, Amount, PaymentTypeID, StudentID)
Values
	(31, 'May  1 2005  6:27PM', 1575.00, 4, 200122100)

set Identity_Insert Payment OFF

-- need to turn date check back on
alter table Payment CHECK constraint CK_PAY_PDate_Not_Old
go

-- Additional data
INSERT INTO Course(CourseId, CourseName, CourseHours, MaxStudents, CourseCost)
VALUES  ('DMIT115', 'Visual SQL', 60, 12, 500),
        ('DMIT175', 'Database Programming', 60, 12, 500),
        ('DMIT228', 'Advanced Application Development', 60, 12, 500),
        ('DMIT215', 'Database Administration', 60, 12, 500)
