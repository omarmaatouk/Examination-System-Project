

-- =============================================
-- 1. Stored Procedure to Generate Exam Questions
-- =============================================
CREATE PROCEDURE sp_GenerateExamQuestions
    @CourseName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT TOP 10 
        q.Question_ID, 
        q.Question_txt, 
        q.Correct_Answer, 
        q.Question_Level, 
        q.Question_Type
    FROM Questions q
    JOIN Courses c ON q.Course_ID = c.Course_ID
    ORDER BY NEWID()
END
GO

-- =============================================
-- 2. Stored Procedure to Insert Student Answer (without grade)
-- =============================================
CREATE PROCEDURE sp_InsertStudentAnswer
    @St_ID INT,
    @Question_ID INT,
    @St_Answer NVARCHAR(500),
    @Exam_ID INT
AS
BEGIN
    
    INSERT INTO Stud_answers (St_ID, Question_ID, St_Answer, Ques_Grade, Exam_ID)
    VALUES (@St_ID, @Question_ID, @St_Answer, null, @Exam_ID);
    
END
GO

-- =============================================
-- 3. Stored Procedure to Correct Answers and Update Grades
-- =============================================
CREATE PROCEDURE sp_CorrectAnswersAndUpdateGrades
    @St_ID INT,
    @Exam_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TotalQuestions INT = 0;
    DECLARE @CorrectAnswers INT = 0;
    
    -- Update grades for all answers in this exam
    UPDATE sa
    SET sa.Ques_Grade = CASE 
        WHEN sa.St_Answer = q.Correct_Answer THEN 10
        ELSE 0
    END
    FROM Stud_answers sa
    JOIN Questions q ON sa.Question_ID = q.Question_ID
    WHERE sa.St_ID = @St_ID AND sa.Exam_ID = @Exam_ID;
    
    -- Get total questions and correct answers count
    SELECT 
        @TotalQuestions = COUNT(*),
        @CorrectAnswers = SUM(CASE WHEN sa.St_Answer = q.Correct_Answer THEN 1 ELSE 0 END)
    FROM Stud_answers sa
    JOIN Questions q ON sa.Question_ID = q.Question_ID
    WHERE sa.St_ID = @St_ID AND sa.Exam_ID = @Exam_ID;
    
    -- Return results
    SELECT 
        @TotalQuestions AS TotalQuestions,
        @CorrectAnswers AS CorrectAnswers,
        CASE 
            WHEN @TotalQuestions > 0 
            THEN CAST((@CorrectAnswers * 100.0) / @TotalQuestions AS DECIMAL(5,2))
            ELSE 0
        END AS Percentage;
END
GO

-- =============================================
-- 4. Stored Procedure to Insert Exam Result
-- =============================================
CREATE PROCEDURE sp_InsertExamResult
    @St_ID INT,
    @Exam_ID INT,
    @Course_ID INT,
    @Exam_Percentage DECIMAL(5,2)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Result NVARCHAR(10);
    SET @Result = CASE 
        WHEN @Exam_Percentage >= 60 THEN 'Pass'
        ELSE 'Fail'
    END;
    
    INSERT INTO Exam_Result (St_ID, Exam_ID, Course_ID, Exam_Date, Exam_Percentage, Result)
    VALUES (@St_ID, @Exam_ID, @Course_ID, GETDATE(), @Exam_Percentage, @Result);
    
    SELECT 
        @Exam_Percentage AS Percentage,
        @Result AS Result;
END
GO

