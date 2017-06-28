DROP TABLE Student_Section;
DROP TABLE Section;
DROP TABLE Location;
DROP TABLE Faculty;
DROP TABLE Course;
DROP TABLE Department;
DROP SEQUENCE Department_DeptID;
DROP TABLE Student;
DROP VIEW Catalog;
SET LINESIZE 100

CREATE TABLE Location (
	LocationID NUMBER(2) NOT NULL,
	LocationName VARCHAR2(12) NOT NULL,
	N_Seats NUMBER(3),
	CONSTRAINT Location_PRIMARY_KEY PRIMARY KEY (LocationID));

INSERT INTO LOCATION VALUES (10, 'Auditorium', 200);
INSERT INTO LOCATION VALUES (20, 'Lecture101', 100);
INSERT INTO LOCATION VALUES (30, 'Business', 120);
INSERT INTO LOCATION VALUES (40, 'Library', 100);
INSERT INTO LOCATION VALUES (50, 'Laboratory', 20);
INSERT INTO LOCATION VALUES (60, 'Study Hall', 80);

CREATE TABLE Department (
	DeptID NUMBER(4) NOT NULL,
	DeptName VARCHAR2(16) NOT NULL,
	CONSTRAINT Department_PRIMARY_KEY PRIMARY KEY (DeptID));

CREATE SEQUENCE Department_DeptID
	INCREMENT BY 100
	START WITH 900
	MAXVALUE 9999
	NOCACHE
	NOCYCLE;

INSERT INTO DEPARTMENT VALUES (Department_DeptID.NEXTVAL, 'Astronomy');
INSERT INTO DEPARTMENT VALUES (Department_DeptID.NEXTVAL, 'Biology');
INSERT INTO DEPARTMENT VALUES (Department_DeptID.NEXTVAL, 'Computer Science');
INSERT INTO DEPARTMENT VALUES (Department_DeptID.NEXTVAL, 'Economics');
INSERT INTO DEPARTMENT VALUES (Department_DeptID.NEXTVAL, 'Math');
INSERT INTO DEPARTMENT VALUES (Department_DeptID.NEXTVAL, 'Philosophy');

CREATE TABLE Faculty (
	FacultyID NUMBER(3) NOT NULL,
	DeptID NUMBER(4) NOT NULL,
	FacultyName VARCHAR2(16) NOT NULL,
	Position VARCHAR2(20),
	Salary NUMBER(6),
	CONSTRAINT Faculty_FOREIGN_KEY FOREIGN KEY (DeptID) REFERENCES Department (DeptID),
	CONSTRAINT Faculty_PRIM_KEY PRIMARY KEY (FacultyID));

INSERT INTO FACULTY VALUES (111, 1000, 'Smith', 'Professor', 100000);
INSERT INTO FACULTY VALUES (123, 1100, 'Lopez', 'Assistant Professor', 70000);
INSERT INTO FACULTY VALUES (456, 1200, 'McKee', 'Lecturer', 40000);
INSERT INTO FACULTY VALUES (567, 1300, 'Koo', 'Professor', 120000);
INSERT INTO FACULTY VALUES (777, 1400, 'Espinoza', 'Dean', 200000);
INSERT INTO FACULTY VALUES (920, 1500, 'Yager', 'Lecturer', 35000);

CREATE TABLE Student (
	StudentID NUMBER(5) NOT NULL,
	StuName VARCHAR2(16) NOT NULL,
	StuAddress VARCHAR2(20),
	ResidentStatus VARCHAR2(3),
	CONSTRAINT Student_PRIM_KEY PRIMARY KEY (StudentID));

INSERT INTO STUDENT VALUES (11111, 'Steve',  '123 Mulberry St', 'Yes');
INSERT INTO STUDENT VALUES (11234, 'Bob',    '100 Apricot Rd',  'Yes');
INSERT INTO STUDENT VALUES (22343, 'Amanda', '600 Secant St',   'No');
INSERT INTO STUDENT VALUES (98989, 'Sylvia', '396 Sycamore Dr', 'Yes');
INSERT INTO STUDENT VALUES (66666, 'Dan',    '456 Trinity Dr',  'No');
INSERT INTO STUDENT VALUES (33333, 'Laura',  '232 Tasman Ave',  'Yes');
INSERT INTO STUDENT VALUES (40000, 'Kevin',  '900 Oak Rd',      'No');
INSERT INTO STUDENT VALUES (43415, 'Maria',  '543 Cosgrove Ln', 'Yes');
INSERT INTO STUDENT VALUES (56345, 'Paul',   '234 Salvado St',  'Yes');
INSERT INTO STUDENT VALUES (89755, 'Lucy',   '654 Stelling Rd', 'Yes');

CREATE TABLE Course (
	CourseID NUMBER(3) NOT NULL,
	CourseName VARCHAR2(21),
	DeptID NUMBER(4) NOT NULL,
	CourseFee NUMBER(3),
	CONSTRAINT Course_FOREIGN_KEY FOREIGN KEY (DeptID) REFERENCES Department (DeptID),
	CONSTRAINT Course_PRIM_KEY PRIMARY KEY (CourseID));

INSERT INTO COURSE VALUES (1,   'Stargazing', 1000, 100);
INSERT INTO COURSE VALUES (444, 'Physiology', 1100, 150);
INSERT INTO COURSE VALUES (64,  'SQL for Mere Mortals', 1200, 100);
INSERT INTO COURSE VALUES (902, 'Freakonomics', 1300, 50);
INSERT INTO COURSE VALUES (394, 'Calculus', 1400, 80);
INSERT INTO COURSE VALUES (395, 'Even More Calculus', 1400, 80);
INSERT INTO COURSE VALUES (100, 'Ethics', 1500, 50);
INSERT INTO COURSE VALUES (200, 'History of Philosophy', 1500, 50);

CREATE TABLE Section (
	SectionID NUMBER(6) NOT NULL,
	CourseID NUMBER(3) NOT NULL,
	LocationID NUMBER(2) NOT NULL,
	DaysOfWeek VARCHAR2(10),
	Time NUMBER(4),
	FacultyID NUMBER(3) NOT NULL,
	CONSTRAINT Section_FOREIGN_KEY FOREIGN KEY (CourseID) REFERENCES Course (CourseID),
	CONSTRAINT Section_FOREIGN_KEY2 FOREIGN KEY (LocationID) REFERENCES Location (LocationID),
	CONSTRAINT Section_FOREIGN_KEY3 FOREIGN KEY (FacultyID) REFERENCES Faculty (FacultyID),
	CONSTRAINT Section_PRIM_KEY PRIMARY KEY (SectionID));

INSERT INTO SECTION VALUES (999999, 1,   10, 'MWF', 0800, 111);
INSERT INTO SECTION VALUES (888888, 64,  20, 'S',   0900, 456);
INSERT INTO SECTION VALUES (777777, 902, 10, 'TTh', 1200, 567);
INSERT INTO SECTION VALUES (666666, 444, 50, 'MW',  1600, 123);
INSERT INTO SECTION VALUES (555555, 100, 20, 'TTh', 1400, 920);
INSERT INTO SECTION VALUES (555556, 100, 20, 'MWF', 1200, 920);

CREATE TABLE Student_Section (
	StudentID NUMBER(5) NOT NULL,
	SectionID NUMBER(6) NOT NULL,
	CONSTRAINT Student_Section_FOREIGN_KEY FOREIGN KEY (StudentID) REFERENCES Student (StudentID),
	CONSTRAINT Student_Section_FOREIGN_KEY2 FOREIGN KEY (SectionID) REFERENCES Section (SectionID),
	CONSTRAINT Student_Section_PRIM_KEY PRIMARY KEY (StudentID, SectionID));

INSERT INTO STUDENT_SECTION VALUES (11111, 999999);
INSERT INTO STUDENT_SECTION VALUES (11111, 888888);
INSERT INTO STUDENT_SECTION VALUES (11234, 777777);
INSERT INTO STUDENT_SECTION VALUES (22343, 777777);
INSERT INTO STUDENT_SECTION VALUES (22343, 666666);
INSERT INTO STUDENT_SECTION VALUES (98989, 555555);
INSERT INTO STUDENT_SECTION VALUES (98989, 666666);
INSERT INTO STUDENT_SECTION VALUES (66666, 555556);
INSERT INTO STUDENT_SECTION VALUES (33333, 555556);
INSERT INTO STUDENT_SECTION VALUES (40000, 999999);
INSERT INTO STUDENT_SECTION VALUES (43415, 888888);
INSERT INTO STUDENT_SECTION VALUES (43415, 666666);
INSERT INTO STUDENT_SECTION VALUES (43415, 777777);

COLUMN SectionID CLEAR
COLUMN Days CLEAR
COLUMN Time CLEAR
COLUMN SectionID HEADING 'Course|Code' FORMAT 999999
COLUMN Days FORMAT A4
COLUMN Time FORMAT 9999


CREATE VIEW Catalog AS
SELECT 	d.DeptName "Department", s.SectionID, c.CourseName "Course",
	s.DaysOfWeek "Days", s.Time "Time", l.LocationName "Location", 
	f.FacultyName "Instructor" FROM Department d, Section s, Course c, 
	Location l, Faculty f WHERE d.DeptID = f.DeptID AND f.FacultyID = s.FacultyID
	AND l.LocationID = s.LocationID AND c.CourseID = s.CourseID;

SELECT * FROM Catalog;