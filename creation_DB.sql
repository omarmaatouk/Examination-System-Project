

CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY,
    Fname VARCHAR(255),
    Lname VARCHAR(255),
    Email VARCHAR(255),
    City VARCHAR(255),
    Street VARCHAR(255),
    Zip_Code VARCHAR(10),
    Gender VARCHAR(50),
    BirthDate DATE,
    HiringDate DATE,
    Salary DECIMAL(10, 2),
    ManagerID INT,
    Phonenumber VARCHAR(20) )


CREATE TABLE Dependents (
    Dep_ID int,
	InstructorID int
	constraint c1 PRIMARY KEY (Dep_ID , InstructorID ),
    Dep_Name VARCHAR(255),
    Gender VARCHAR(50),
    Age INT)


CREATE TABLE Student (
    St_ID INT PRIMARY KEY,
    Fname VARCHAR(255),
    Lname VARCHAR(255),
    Phonenumber VARCHAR(20),
    Email VARCHAR(255),
    City VARCHAR(255),
    Street VARCHAR(255),
    Zip_Code VARCHAR(10),
    Gender VARCHAR(50),
    BirthDate DATE,
    LinkedIn_URL VARCHAR(255),
    Graduation_Year INT,
    Grade DECIMAL(4, 2),
    F_codeFK INT,
    Track_IDFK INT )

CREATE TABLE St_Intake (
    St_ID INT,
    Intake_ID INT,
    PRIMARY KEY (St_ID, Intake_ID))
   


CREATE TABLE Attendance (
    Course_ID INT,
    St_ID INT,
    Date DATE,
    degree INT,
    PRIMARY KEY (Course_ID, St_ID))


CREATE TABLE Intake (
    Intake_ID INT PRIMARY KEY,
    Intake_Name VARCHAR(255),
    StartDate DATE,
    EndDate DATE)

CREATE TABLE Round (
    Round_ID INT PRIMARY KEY,
    Round_Name VARCHAR(255),
    StartDate DATE,
    EndDate DATE)

CREATE TABLE St_Round (
    St_ID INT,
    Round_ID INT,
    PRIMARY KEY (St_ID, Round_ID))

CREATE TABLE Freelance (
    Task_title VARCHAR(255),
    St_ID INT,
	PRIMARY KEY (Task_title,St_ID ),
    Related_Field VARCHAR(255),
    Task_Duration VARCHAR(50),
    Cost DECIMAL(10, 2))

CREATE TABLE Certificates (
    Cer_ID INT PRIMARY KEY,
    Cer_Name VARCHAR(255),
    Acquired_Date DATE,
    Provider_Name VARCHAR(255))

CREATE TABLE Stud_get_certificate (
    St_ID INT,
    Cer_ID INT,
    PRIMARY KEY (St_ID, Cer_ID))

CREATE TABLE Faculties (
    F_code INT PRIMARY KEY,
    F_Name VARCHAR(255),
    City VARCHAR(255))

CREATE TABLE Tracks (
    Track_ID INT PRIMARY KEY,
    Track_Name VARCHAR(255),
    Track_Duration VARCHAR(50),
    InstructorID INT);

CREATE TABLE Graduates (
    Grad_ID INT PRIMARY KEY,
    Grad_Name VARCHAR(255),
    Git_URL VARCHAR(255),
    LinkedIn_URL VARCHAR(255),
    Graduate_Date DATE,
    Track_ID INT)

CREATE TABLE Company (
    Com_ID INT ,
	Grad_ID INT,
	PRIMARY KEY (Com_ID,Grad_ID),
    Com_Name VARCHAR(255),
    C_City VARCHAR(255),
    Job_Type VARCHAR(255),
    Hiring_date DATE,
    Job_title VARCHAR(255),
    Salary_Range VARCHAR(100))

CREATE TABLE Master (
    Grad_ID INT,
	Mas_title VARCHAR(255), 
	PRIMARY KEY (Mas_title,Grad_ID),
    Country VARCHAR(255),
    University VARCHAR(255),
    Field VARCHAR(255))

CREATE TABLE Branch (
    Branch_ID INT PRIMARY KEY,
    Branch_Name VARCHAR(255),
    Branch_Location VARCHAR(255),
    MNG_Name VARCHAR(255),
    Founded_Date DATE)

CREATE TABLE Branch_instructor (
    InstructorID INT,
    Branch_ID INT,
    PRIMARY KEY (InstructorID, Branch_ID))

CREATE TABLE Branch_Track (
    Track_ID INT,
    Branch_ID INT,
    PRIMARY KEY (Track_ID, Branch_ID))

CREATE TABLE Courses (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(255),
    C_Status VARCHAR(50),
    C_duration VARCHAR(50),
    InstructorID INT)

CREATE TABLE Track_couseurs (
    Track_ID INT,
    Course_ID INT,
    PRIMARY KEY (Track_ID, Course_ID))

CREATE TABLE Topics (
    Topic_ID INT PRIMARY KEY,
    Topic_Name VARCHAR(255),
    Course_ID INT);

CREATE TABLE Feedback (
    St_ID INT,
    InstructorID INT,
	Course_ID INT,
    InstructorRating INT,
    CourseRating INT,
    Date DATE,
    PRIMARY KEY (St_ID, InstructorID,Course_ID))

CREATE TABLE Questions (
    Question_ID INT PRIMARY KEY,
    Question_txt TEXT,
    Correct_Answer VARCHAR(255),
    Question_Level VARCHAR(50),
    Question_Type VARCHAR(50),
    Course_ID INT)

CREATE TABLE Answer_Choices (
    Question_ID INT,
    Answer_Choice VARCHAR(255),
    PRIMARY KEY (Question_ID, Answer_Choice))

CREATE TABLE Exam (
    Exam_ID INT PRIMARY KEY,
    Exam_Name VARCHAR(255),
    Exam_Duration VARCHAR(50),
    Exam_Date DATE,
    Exam_Mark DECIMAL(5, 2),
    Exam_Level VARCHAR(50))

CREATE TABLE Exam_Ques (
    Exam_ID INT,
    Question_ID INT,
    PRIMARY KEY (Exam_ID, Question_ID))
   

CREATE TABLE Exam_Result (
    St_ID INT,
    Exam_ID INT,
    Course_ID INT,
    Exam_Date DATE,
    Exam_Percentage DECIMAL(5, 2),
    Result VARCHAR(50),
    PRIMARY KEY (St_ID, Exam_ID, Course_ID));

CREATE TABLE Stud_answers (
    St_ID INT,
    Question_ID INT,
    St_Answer VARCHAR(255),
    Ques_Grade DECIMAL(5, 2),
    Exam_ID INT,
    PRIMARY KEY (St_ID, Question_ID,St_Answer))



ALTER TABLE Student
add F_code INT ,
CONSTRAINT FK_Student_Faculties
FOREIGN KEY (F_code) REFERENCES Faculties(F_code)

ALTER TABLE Student
add Track_ID INT ,
CONSTRAINT FK_Student_Tracks
FOREIGN KEY (Track_ID) REFERENCES Tracks(Track_ID);

ALTER TABLE St_Intake
ADD CONSTRAINT FK_StIntake_Student
FOREIGN KEY (St_ID) REFERENCES Student(St_ID);

ALTER TABLE St_Intake
ADD CONSTRAINT FK_StIntake_Intake
FOREIGN KEY (Intake_ID) REFERENCES Intake(Intake_ID);

ALTER TABLE Attendance
ADD CONSTRAINT FK_Attendance_Course
FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID);

ALTER TABLE Attendance
ADD CONSTRAINT FK_Attendance_Student
FOREIGN KEY (St_ID) REFERENCES Student(St_ID);

ALTER TABLE St_Round
ADD CONSTRAINT FK_StRound_Student
FOREIGN KEY (St_ID) REFERENCES Student(St_ID);

ALTER TABLE St_Round
ADD CONSTRAINT FK_StRound_Round
FOREIGN KEY (Round_ID) REFERENCES Round(Round_ID);

ALTER TABLE Stud_get_certificate
ADD CONSTRAINT FK_StudGetCert_Student
FOREIGN KEY (St_ID) REFERENCES Student(St_ID);

ALTER TABLE Stud_get_certificate
ADD CONSTRAINT FK_StudGetCert_Certificates
FOREIGN KEY (Cer_ID) REFERENCES Certificates(Cer_ID);

ALTER TABLE Branch_instructor
ADD CONSTRAINT FK_BranchInstructor_Instructor
FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID);



-- Foreign Keys for Branch_Track table
ALTER TABLE Branch_Track
ADD CONSTRAINT FK_BranchTrack_Tracks
FOREIGN KEY (Track_ID) REFERENCES Tracks(Track_ID);

ALTER TABLE Branch_Track
ADD CONSTRAINT FK_BranchTrack_Branch
FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID);

-- Foreign Keys for Track_couseurs table
ALTER TABLE Track_couseurs
ADD CONSTRAINT FK_TrackCouseurs_Tracks
FOREIGN KEY (Track_ID) REFERENCES Tracks(Track_ID);

ALTER TABLE Track_couseurs
ADD CONSTRAINT FK_TrackCouseurs_Courses
FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID);

-- Foreign Keys for Feedback table
ALTER TABLE Feedback
ADD CONSTRAINT FK_Feedback_Student
FOREIGN KEY (St_ID) REFERENCES Student(St_ID);

ALTER TABLE Feedback
ADD CONSTRAINT FK_Feedback_Instructor
FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID);


ALTER TABLE Feedback
ADD CONSTRAINT FK_Feedback_course
FOREIGN KEY (Course_ID) REFERENCES Courses (Course_ID);

 

-- Foreign Keys for Exam_Ques table
ALTER TABLE Exam_Ques
ADD CONSTRAINT FK_ExamQues_Exam
FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID);

ALTER TABLE Exam_Ques
ADD CONSTRAINT FK_ExamQues_Questions
FOREIGN KEY (Question_ID) REFERENCES Questions(Question_ID);

--------------------------------------------------------------
alter TABLE Instructor 
   ADD CONSTRAINT c2 
   FOREIGN KEY (ManagerID) REFERENCES Instructor(InstructorID)



alter TABLE Dependents 
ADD CONSTRAINT c3
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)



alter TABLE Freelance 
ADD CONSTRAINT c4
    FOREIGN KEY (St_ID) REFERENCES Student(St_ID)



alter TABLE Tracks 
ADD CONSTRAINT c5
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)



alter TABLE Graduates 
ADD CONSTRAINT c6
 
    FOREIGN KEY (Track_ID) REFERENCES Tracks(Track_ID)



alter TABLE Master 

ADD CONSTRAINT c8
    FOREIGN KEY (Grad_ID) REFERENCES Graduates(Grad_ID)



alter TABLE Courses 
ADD CONSTRAINT c9
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)





alter TABLE Topics 
ADD CONSTRAINT c10
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)





alter TABLE Questions 
ADD CONSTRAINT c11
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)


alter TABLE Answer_Choices 
ADD CONSTRAINT c12
    
    FOREIGN KEY (Question_ID) REFERENCES Questions(Question_ID)





alter TABLE Exam_Result 
ADD CONSTRAINT c13

    FOREIGN KEY (St_ID) REFERENCES Student(St_ID)

	alter TABLE Exam_Result 
	ADD CONSTRAINT c14
    FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID)

	alter TABLE Exam_Result 
	ADD CONSTRAINT c15
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)


alter TABLE Stud_answers 
ADD CONSTRAINT c16
    FOREIGN KEY (St_ID) REFERENCES Student(St_ID),

	alter TABLE Stud_answers 
	ADD CONSTRAINT c17
    FOREIGN KEY (Question_ID) REFERENCES Questions(Question_ID)

	alter TABLE Stud_answers 
	ADD CONSTRAINT c18
    FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID)

