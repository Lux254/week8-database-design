-- Drop & create DB
IF DB_ID('StudentDB') IS NOT NULL
    DROP DATABASE StudentDB;
GO

CREATE DATABASE StudentDB;
GO

USE StudentDB;
GO

-- Departments
CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Office NVARCHAR(50)
);

-- Instructors
CREATE TABLE Instructors (
    InstructorID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    HireDate DATE NOT NULL,
    DepartmentID INT NOT NULL,
    CONSTRAINT FK_Instructor_Department FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Students
CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M','F')),
    EnrollmentDate DATE NOT NULL DEFAULT GETDATE()
);

-- Courses
CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Credits INT NOT NULL CHECK (Credits > 0),
    DepartmentID INT NOT NULL,
    CONSTRAINT FK_Course_Department FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Many-to-Many: Students <-> Courses (Enrollments)
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL DEFAULT GETDATE(),
    Grade CHAR(2) NULL CHECK (Grade IN ('A','B','C','D','F')),
    CONSTRAINT UQ_Student_Course UNIQUE (StudentID, CourseID),
    CONSTRAINT FK_Enrollment_Student FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Enrollment_Course FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Course Schedule (time/room)
CREATE TABLE CourseSchedule (
    ScheduleID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL,
    InstructorID INT NOT NULL,
    DayOfWeek NVARCHAR(10) NOT NULL CHECK (DayOfWeek IN ('Mon','Tue','Wed','Thu','Fri','Sat')),
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    Room NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Schedule_Course FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Schedule_Instructor FOREIGN KEY (InstructorID)
        REFERENCES Instructors(InstructorID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Simple Audit Table for Grades
CREATE TABLE GradeAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    OldGrade CHAR(2),
    NewGrade CHAR(2),
    ChangedAt DATETIME DEFAULT GETDATE(),
    ChangedBy NVARCHAR(100),
    CONSTRAINT FK_GradeAudit_Enrollment FOREIGN KEY (EnrollmentID)
        REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE
);
