--------------------------------------------------------------------
CREATE PROCEDURE Update_Graduate_Info 
    @Grad_ID INT = NULL,
    @Grad_Name VARCHAR(255) = NULL,
    @Git_URL VARCHAR(255) = NULL,
    @LinkedIn_URL VARCHAR(255) = NULL,
    @Graduate_Date DATE = NULL,
    @Track_ID INT = NULL
AS
BEGIN TRY
    IF @Grad_ID IS NULL
    BEGIN
        PRINT 'ENTER Grad_ID'
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Graduates WHERE Grad_ID = @Grad_ID)
    BEGIN
        PRINT 'Graduate not found'
        RETURN
    END

    UPDATE Graduates
    SET 
        Grad_Name = ISNULL(@Grad_Name, Grad_Name),
        Git_URL = ISNULL(@Git_URL, Git_URL),
        LinkedIn_URL = ISNULL(@LinkedIn_URL, LinkedIn_URL),
        Graduate_Date = ISNULL(@Graduate_Date, Graduate_Date),
        Track_ID = ISNULL(@Track_ID, Track_ID)
    WHERE Grad_ID = @Grad_ID

    PRINT 'Graduate updated successfully'

END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH


select * from Graduates 
where Grad_ID = 1

Update_Graduate_Info 1, hamo

----------------------------------------------
--------------------Student TABLE -----------------------------------------
alter proc Update_STUDENT 
	@St_ID int=null,
	@Fname varchar(255)=null,
	@Lname varchar(255)=null,
	@Phonenumber varchar(20)=null,
	@Email varchar(255)=null,
	@City varchar(255)=null,
	@Street varchar(255)=null,
	@Zip_Code varchar(10)=null,
	@Gender varchar(50)=null,
	@BirthDate date=null,
	@LinkedIn_URL varchar(255)=null,
	@Graduation_Year int=null,
	@Grade decimal(4,2)=null

as 
begin try
	IF @St_ID is null
	BEGIN
		PRINT 'ENTER St_ID'
	END
	else
		begin
				UPDATE Student
				SET 
				Fname = ISNULL(@Fname , Fname),
				Lname = ISNULL(@Lname, Lname),
				Email = ISNULL(@Email, Email),
				City = ISNULL(@City, City),
				Street = ISNULL(@Street, Street),
				Zip_Code = ISNULL(@Zip_Code, Zip_Code),
				Gender = ISNULL(@Gender, Gender),
				BirthDate = ISNULL(@BirthDate, BirthDate),
				LinkedIn_URL = ISNULL(@LinkedIn_URL, LinkedIn_URL),
				Graduation_Year = ISNULL(@Graduation_Year, Graduation_Year),
				Grade = ISNULL(@Grade, Grade)
				WHERE St_ID = @St_ID
			end
end try 
begin catch 
	PRINT 'An error occurred: ' + ERROR_MESSAGE()
end catch

select * from Student 

Update_STUDENT 2 , hamo 

-------------------------------------------------------------------------------
CREATE PROCEDURE Update_intake_Info 
    @intake_ID INT = NULL,
    @intake_Name VARCHAR(255) = NULL,
    @Start_date date = NULL, 
	@end_date date = NULL
AS
BEGIN TRY
    IF @intake_ID  IS NULL
    BEGIN
        PRINT 'ENTER intake_ID '
        RETURN
    END
    IF NOT EXISTS (SELECT 1 FROM Intake WHERE Intake_ID = @intake_ID)
    BEGIN
        PRINT 'intake not found'
        RETURN
    END

    UPDATE Intake
    SET 
        Intake_Name = ISNULL(@intake_Name, Intake_Name),
        StartDate = ISNULL(@Start_date, StartDate),
		EndDate = ISNULL(@end_date, EndDate)
    WHERE Intake_ID = @intake_ID

    PRINT 'intake updated successfully'

END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH


select * from Intake
Update_intake_Info 1 , hamo

------------------------------------------------------------------------------------------
CREATE PROCEDURE Update_Certificate_Info 
    @cer_ID INT = NULL,
    @cer_Name varchar(55) = NULL,
    @Acquired_Date date = NULL, 
	@Provider_Name varchar(55) = NULL
AS
BEGIN TRY
    IF @cer_ID  IS NULL
    BEGIN
        PRINT 'ENTER @cer_ID '
        RETURN
    END
    IF NOT EXISTS (SELECT 1 FROM Certificates WHERE @cer_ID = Cer_ID)
    BEGIN
        PRINT 'Certificate not found'
        RETURN
    END

    UPDATE Certificates
    SET 
        Cer_Name = ISNULL(@Cer_Name, Cer_Name),
        Acquired_Date = ISNULL(@Acquired_Date, Acquired_Date),
		Provider_Name = ISNULL(@Provider_Name, Provider_Name)
    WHERE @cer_ID = Cer_ID

    PRINT 'Certificate updated successfully'

END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH


select * from Certificates
Update_Certificate_Info 1 , hamo
-------------------------------------------------------------------------------
alter PROCEDURE Update_Round_Info 
    @round_ID INT = NULL,
    @Round_Name VARCHAR(255) = NULL,
    @Start_date date = NULL, 
	@end_date date = NULL
AS
BEGIN TRY
    IF @round_ID  IS NULL
    BEGIN
        PRINT 'ENTER round_ID '
        RETURN
    END
    IF NOT EXISTS (SELECT 1 FROM Round WHERE Round_ID = @round_ID)
    BEGIN
        PRINT 'round not found'
        RETURN
    END

    UPDATE round
    SET 
        Round_Name = ISNULL(@Round_Name, Round_Name),
        StartDate = ISNULL(@Start_date, StartDate),
		EndDate = ISNULL(@end_date, EndDate)
    WHERE @round_ID = Round_ID

    PRINT 'Round updated successfully'

END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH


select * from Round

Update_Round_Info 1 , hamo
------------------------------------------------------------------------------
create PROCEDURE Update_faculties_Info 
    @f_code INT = NULL,
    @f_name varchar(55) = NULL,
    @city varchar(55) = NULL
	
AS
BEGIN TRY
    IF @f_code  IS NULL
    BEGIN
        PRINT 'ENTER f_code '
        RETURN
    END
    IF NOT EXISTS (SELECT 1 FROM Faculties WHERE F_code = @f_code)
    BEGIN
        PRINT 'faculty not found'
        RETURN
    END

    UPDATE Faculties
    SET 
        f_name = ISNULL(@f_name, f_name),
        city = ISNULL(@city, city)
    WHERE F_code = @f_code

    PRINT 'Round updated successfully'

END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH


select * from Faculties

Update_faculties_Info 11 , hamo
--------------------------------------
create PROCEDURE Update_freelance_Info 
    @Task_title varchar(55) = NULL,
    @St_ID int = NULL,
    @Related_Field varchar(55) = NULL,
	@Task_Duration varchar(55) = NULL,
	@Cost int = NULL
AS
BEGIN TRY
    IF @Task_title  IS NULL or @St_ID IS NULL
    BEGIN
        PRINT 'ENTER @Task_title and @St_ID  '
        RETURN
    END
    IF NOT EXISTS (SELECT 1 FROM Freelance WHERE @Task_title = Task_title and @St_ID =St_ID)
    BEGIN
        PRINT 'freelance not found'
        RETURN
    END

    UPDATE Faculties
    SET 
        Related_Field = ISNULL(@Related_Field, Related_Field),
        Task_Duration = ISNULL(@Task_Duration, Task_Duration),
		Cost = ISNULL(@Cost, Cost)
    WHERE @Task_title = Task_title and @St_ID =St_ID

    PRINT 'freelance updated successfully'
	
END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH


select * from Freelance

--------------------------------------------------------------
create PROCEDURE Update_Company_Info 
    @Grad_ID int = NULL,
    @Com_ID int = NULL,
    @Com_Name varchar(55) = NULL,
    @C_City varchar(55) = NULL,
	@Job_Type varchar(55) = NULL,
	@Hiring_date date= NULL,
	@Job_title varchar(55) = NULL,
	@Salary_Range varchar(55) = NULL

	AS
BEGIN TRY
    IF @Grad_ID  IS NULL or @Com_ID IS NULL
    BEGIN
        PRINT 'ENTER Grad_ID and Com_ID '
        RETURN
    END
    IF NOT EXISTS (SELECT 1 FROM Company WHERE @Grad_ID = Grad_ID and @Com_ID =Com_ID)
    BEGIN
        PRINT 'company not found'
        RETURN
    END

    UPDATE Company
    SET 
        Com_Name = ISNULL(@Com_Name, Com_Name),
        C_City = ISNULL(@C_City, C_City),
		Job_Type = ISNULL(@Job_Type, Job_Type),
		Hiring_date = ISNULL(@Hiring_date, Hiring_date),
		Job_title = ISNULL(@Job_title, Job_title),
		Salary_Range = ISNULL(@Salary_Range, Salary_Range)

    WHERE @Grad_ID = Grad_ID and @Com_ID =Com_ID

    PRINT 'company updated successfully'
	
END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH


--------------------------------------------------------------
create PROCEDURE Update_Feedback_Info 
    @st_ID int = NULL,
    @instructorID int = NULL,
    @Course_ID int = NULL,
	@instructorRating int = NULL,
	@courserating int = NULL,
	@Date date = NULL
	AS
BEGIN TRY
    IF @st_ID  IS NULL or @instructorID IS NULL or @Course_ID IS NULL
    BEGIN
        PRINT 'ENTER st_id and instructor id and course id '
        RETURN
    END
    IF NOT EXISTS (SELECT 1 FROM Feedback WHERE @st_ID = st_id and @instructorID =instructorID and @Course_ID = Course_ID)
    BEGIN
        PRINT 'feedback not found'
        RETURN
    END

    UPDATE Feedback
    SET 
        instructorRating = ISNULL(@instructorRating, instructorRating),
        courserating = ISNULL(@courserating, courserating),
		@Date = ISNULL(@Date, Date)
     WHERE @st_ID = st_id and @instructorID =instructorID and @Course_ID = Course_ID

    PRINT 'feedback updated successfully'
	
END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH

--------------------------------------------------------------------------
create proc Update_instructor
	@instructorID int=null,
	@Fname varchar(255)=null,
	@Lname varchar(255)=null,
	@Email varchar(255)=null,
	@City varchar(255)=null,
	@Street varchar(255)=null,
	@Zip_Code varchar(10)=null,
	@Gender varchar(50)=null,
	@BirthDate date=null,
	@hiringDate date=null,
	@Salary int=null,
	@Mangerid int =null,
	@Phonenumber varchar(20)=null
as 
begin try
	IF @instructorID is null
	BEGIN
		PRINT 'ENTER instructor ID'
	END
	else
		begin
				UPDATE Instructor
				SET 
				Fname = ISNULL(@Fname , Fname),
				Lname = ISNULL(@Lname, Lname),
				Email = ISNULL(@Email, Email),
				City = ISNULL(@City, City),
				Street = ISNULL(@Street, Street),
				Zip_Code = ISNULL(@Zip_Code, Zip_Code),
				Gender = ISNULL(@Gender, Gender),
				BirthDate = ISNULL(@BirthDate, BirthDate),
				hiringDate = ISNULL(@BirthDate, BirthDate),
				salary = ISNULL(@salary, salary),
				phonenumber = ISNULL(@phonenumber, phonenumber)
				WHERE @instructorID = instructorID
			end
end try 
begin catch 
	PRINT 'An error occurred: ' + ERROR_MESSAGE()
end catch

select * from instructor 

Update_instructor 1 , hamo 
-------------------------------------------
CREATE PROC Update_Branch
	@Branch_ID INT = NULL,
	@Branch_Name VARCHAR(255) = NULL,
	@Branch_Location VARCHAR(255) = NULL,
	@MNG_Name VARCHAR(255) = NULL,
	@Founded_Date DATE = NULL
AS
BEGIN TRY
	IF @Branch_ID IS NULL
	BEGIN
		PRINT 'ENTER Branch ID'
		RETURN
	END
	ELSE
	BEGIN
		UPDATE Branch
		SET 
			Branch_Name = ISNULL(@Branch_Name, Branch_Name),
			Branch_Location = ISNULL(@Branch_Location, Branch_Location),
			MNG_Name = ISNULL(@MNG_Name, MNG_Name),
			Founded_Date = ISNULL(@Founded_Date, Founded_Date)
		WHERE Branch_ID = @Branch_ID
	END
END TRY
BEGIN CATCH
	PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH

select * from Branch
Update_Branch 1 , hamo

---------------------------------------------------
alter PROC Update_Course
    @Course_ID INT = NULL,
    @Course_Name VARCHAR(255) = NULL,
    @C_Status VARCHAR(50) = NULL,
    @C_duration VARCHAR(50) = NULL,
    --@InstructorID INT = NULL
AS
BEGIN TRY
    IF @Course_ID IS NULL
    BEGIN
        PRINT 'ENTER Course_ID'
        RETURN
    END

    UPDATE Courses
    SET
        Course_Name = ISNULL(@Course_Name, Course_Name),
        C_Status = ISNULL(@C_Status, C_Status),
        C_duration = ISNULL(@C_duration, C_duration),
        --InstructorID = ISNULL(@InstructorID, InstructorID)
    WHERE Course_ID = @Course_ID
END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH

select * from Courses 
Update_Course 1 , hamo 

-----------------------------------------------------------
CREATE PROC Update_Topic
    @Topic_ID INT = NULL,
    @Topic_Name VARCHAR(255) = NULL,
    --@Course_ID INT = NULL
AS
BEGIN TRY
    IF @Topic_ID IS NULL
    BEGIN
        PRINT 'ENTER Topic_ID'
        RETURN
    END

    UPDATE Topics
    SET
        Topic_Name = ISNULL(@Topic_Name, Topic_Name),
        --Course_ID = ISNULL(@Course_ID, Course_ID)
    WHERE Topic_ID = @Topic_ID
END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH

select * from Topics 
Update_Topic 1 , hamo  
----------------------------------------------------------------------------
CREATE PROC Update_Attendance
    @Course_ID INT = NULL,
    @St_ID INT = NULL,
    @Date DATE = NULL,
    @Degree INT = NULL
AS
BEGIN TRY
    IF @Course_ID IS NULL OR @St_ID IS NULL
    BEGIN
        PRINT 'ENTER BOTH Course_ID and St_ID'
        RETURN
    END

    UPDATE Attendance
    SET
        Date = ISNULL(@Date, Date),
        Degree = ISNULL(@Degree, Degree)
    WHERE Course_ID = @Course_ID AND St_ID = @St_ID
END TRY
BEGIN CATCH
    PRINT 'An error occurred: ' + ERROR_MESSAGE()
END CATCH
-------------------------------------------
CREATE PROC Update_Dependents
    @Dep_ID INT,           -- Part of composite PK (required)
    @InstructorID INT,     -- Part of composite PK (required)
    @Dep_Name NVARCHAR(100) = NULL,
    @Gender NVARCHAR(10) = NULL,
    @Age INT = NULL
AS
BEGIN TRY
    -- Validate both composite key components
    IF @Dep_ID IS NULL OR @InstructorID IS NULL
    BEGIN
        PRINT 'Both Dep_ID and InstructorID are required'
        RETURN
    END

    -- Update only non-key fields
    UPDATE Dependents
    SET
        Dep_Name = ISNULL(@Dep_Name, Dep_Name),
        Gender = ISNULL(@Gender, Gender),
        Age = ISNULL(@Age, Age)
    WHERE Dep_ID = @Dep_ID AND InstructorID = @InstructorID
END TRY
BEGIN CATCH
    PRINT 'Error updating Dependents: ' + ERROR_MESSAGE()
END CATCH

select * from Dependents 
Update_Dependents 1 ,1 , hamo 
-------------------------
CREATE PROC Update_Master
    @Grad_ID INT,           
    @Mas_title NVARCHAR(100), 
    @Country NVARCHAR(100) = NULL,
    @University NVARCHAR(100) = NULL,
    @Field NVARCHAR(100) = NULL
AS
BEGIN TRY
    IF @Grad_ID IS NULL OR @Mas_title IS NULL
    BEGIN
        PRINT 'Both Grad_ID and Mas_title are required'
        RETURN
    END

    UPDATE Master
    SET
        Country = ISNULL(@Country, Country),
        University = ISNULL(@University, University),
        Field = ISNULL(@Field, Field)
    WHERE Grad_ID = @Grad_ID AND Mas_title = @Mas_title
END TRY
BEGIN CATCH
    PRINT 'Error updating Master: ' + ERROR_MESSAGE()
END CATCH 

select * from Master 
Update_Master 41 , 'MA in Anthropology' , hamo 
--------------------------------
CREATE PROC Update_Questions
    @Question_ID INT,          
    @Question_txt NVARCHAR(MAX) = NULL,
    @Correct_Answer NVARCHAR(MAX) = NULL,
    @Question_Level NVARCHAR(50) = NULL,
    @Question_Type NVARCHAR(50) = NULL
AS
BEGIN TRY
    IF @Question_ID IS NULL
    BEGIN
        PRINT 'Question_ID is required'
        RETURN
    END

    UPDATE Questions
    SET
        Question_txt = ISNULL(@Question_txt, Question_txt),
        Correct_Answer = ISNULL(@Correct_Answer, Correct_Answer),
        Question_Level = ISNULL(@Question_Level, Question_Level),
        Question_Type = ISNULL(@Question_Type, Question_Type)
    WHERE Question_ID = @Question_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Questions: ' + ERROR_MESSAGE()
END CATCH

select * from Questions
Update_Questions 1 , hamo
------------------------------------------------------------
CREATE PROC Update_Stud_answers
    @St_ID INT,                
    @Question_ID INT,           
    @Exam_ID INT,              
    @St_Answer NVARCHAR(MAX) = NULL,
    @Ques_Grade INT = NULL
AS
BEGIN TRY
    IF @St_ID IS NULL OR @Question_ID IS NULL OR @Exam_ID IS NULL
    BEGIN
        PRINT 'St_ID, Question_ID, and Exam_ID are all required'
        RETURN
    END

    UPDATE Stud_answers
    SET
        St_Answer = ISNULL(@St_Answer, St_Answer),
        Ques_Grade = ISNULL(@Ques_Grade, Ques_Grade)
    WHERE St_ID = @St_ID 
      AND Question_ID = @Question_ID
      AND Exam_ID = @Exam_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Stud_answers: ' + ERROR_MESSAGE()
END CATCH

select * from Stud_answers

----------------------------------------------
alter PROC Update_Exam
    @Exam_ID INT,              
    @Exam_Name NVARCHAR(100) = NULL,
    @Exam_Duration varchar(50) = NULL,
    @Exam_Date DATE = NULL,
    @Exam_Mark INT = NULL,
    @Exam_Level NVARCHAR(50) = NULL
AS
BEGIN TRY
    IF @Exam_ID IS NULL
    BEGIN
        PRINT 'Exam_ID is required'
        RETURN
    END

    UPDATE Exam
    SET
        Exam_Name = ISNULL(@Exam_Name, Exam_Name),
        Exam_Duration = ISNULL(@Exam_Duration, Exam_Duration),
        Exam_Date = ISNULL(@Exam_Date, Exam_Date),
        Exam_Mark = ISNULL(@Exam_Mark, Exam_Mark),
        Exam_Level = ISNULL(@Exam_Level, Exam_Level)
    WHERE Exam_ID = @Exam_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Exam: ' + ERROR_MESSAGE()
END CATCH

select * from Exam 
Update_Exam 1 , hamo 

------------------------------------------------
alter PROC Update_Tracks
    @Track_ID INT,              
    @Track_Name NVARCHAR(100) = NULL,
    @Track_Duration NVARCHAR(100) = NULL
AS
BEGIN TRY
    IF @Track_ID IS NULL
    BEGIN
        PRINT 'Track_ID is required'
        RETURN
    END
    UPDATE Tracks
    SET
        Track_Name = ISNULL(@Track_Name, Track_Name),
        Track_Duration = ISNULL(@Track_Duration, Track_Duration)
    WHERE Track_ID = @Track_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Tracks: ' + ERROR_MESSAGE()
END CATCH 

select * from Tracks
Update_Tracks 1, hamo 

-------------------------------------------------
CREATE PROC Update_Freelance
    @Task_title NVARCHAR(100),    
    @St_ID INT,                  
    @Related_Field NVARCHAR(100) = NULL,
    @Task_Duration INT = NULL,
    @Cost DECIMAL(10,2) = NULL
AS
BEGIN TRY
    IF @Task_title IS NULL OR @St_ID IS NULL
    BEGIN
        PRINT 'Both Task_title and St_ID are required'
        RETURN
    END
    UPDATE Freelance
    SET
        Related_Field = ISNULL(@Related_Field, Related_Field),
        Task_Duration = ISNULL(@Task_Duration, Task_Duration),
        Cost = ISNULL(@Cost, Cost)
    WHERE Task_title = @Task_title AND St_ID = @St_ID
END TRY
BEGIN CATCH
    PRINT 'Error updating Freelance: ' + ERROR_MESSAGE()
END CATCH

select * from Freelance 
