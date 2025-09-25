# Student Information System (SQL Server)

This project is a simple **Student Information & Course Management System** built using Microsoft SQL Server (SSMS).

## 🎯 Objective
The goal is to design and implement a relational database that manages:
- Students
- Instructors
- Departments
- Courses
- Enrollments (students registered in courses)
- Class Schedules
- Grades

## 📂 Database Schema
The database includes the following tables:

1. **Departments** – Stores academic departments (e.g., Computer Science, Mathematics).
2. **Instructors** – Faculty members assigned to teach courses.
3. **Students** – Student records with personal information.
4. **Courses** – Courses offered under each department.
5. **Enrollments** – Junction table linking students and courses (many-to-many).
6. **CourseSchedule** – Class schedule (day, time, instructor, room).
7. **GradeAudit** – Tracks changes in student grades.

## 🔑 Features
- Primary keys and foreign keys to maintain referential integrity.
- One-to-many relationships (Departments → Courses / Instructors).
- Many-to-many relationships (Students ↔ Courses via Enrollments).
- Constraints: `UNIQUE`, `CHECK`, `NOT NULL`.
- Audit trail for grade changes.

## ▶️ How to Run
1. Open **SQL Server Management Studio (SSMS)**.
2. Create a new query window.
3. Copy and paste the script from `student_db.sql`.
4. Execute the script to create the database and tables.

## ✅ Deliverables
- A complete `.sql` file that:
  - Creates the `StudentDB` database.
  - Defines all tables with constraints and relationships.
