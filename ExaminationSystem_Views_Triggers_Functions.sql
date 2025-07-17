
-- =============================================
-- VIEWS
-- =============================================

------------------------------------------------ Student Exam Results
CREATE VIEW vw_StudentExamResults AS
SELECT 
    s.St_ID,
    s.Fname + ' ' + s.Lname AS StudentName,
    c.Course_Name,
    e.Exam_Name,
    er.Exam_Percentage,
    er.Result
FROM Exam_Result er
JOIN Student s ON s.St_ID = er.St_ID
JOIN Exam e ON e.Exam_ID = er.Exam_ID
JOIN Courses c ON c.Course_ID = er.Course_ID

select * from vw_StudentExamResults


----------------------------------------------- Course Exam Averages
CREATE VIEW vw_CourseExamAverages AS
SELECT 
    c.Course_ID,
    c.Course_Name,
    AVG(er.Exam_Percentage) AS Avg_Percentage
FROM Exam_Result er
JOIN Courses c ON c.Course_ID = er.Course_ID
GROUP BY c.Course_ID, c.Course_Name


select * from vw_CourseExamAverages

-----------------------------------------------------Passed Students
CREATE VIEW vw_PassedStudents AS
SELECT 
    er.St_ID,
    s.Fname + ' ' + s.Lname AS StudentName,
    c.Course_Name,
    er.Exam_Percentage
FROM Exam_Result er
JOIN Student s ON s.St_ID = er.St_ID
JOIN Courses c ON c.Course_ID = er.Course_ID
WHERE er.Result = 'Pass'


select * from vw_PassedStudents
select count(*) from vw_PassedStudents

-----------------------------------------------------Failed Students
CREATE VIEW vw_FailedStudents AS
SELECT 
    er.St_ID,
    s.Fname + ' ' + s.Lname AS StudentName,
    c.Course_Name,
    er.Exam_Percentage
FROM Exam_Result er
JOIN Student s ON s.St_ID = er.St_ID
JOIN Courses c ON c.Course_ID = er.Course_ID
WHERE er.Result = 'Fail'


select * from vw_FailedStudents
select count(*) from vw_FailedStudents



------------------------------------------------- Student Attendance
alter VIEW vw_StudentAttendance AS
SELECT 
    s.St_ID,
    s.Fname + ' ' + s.Lname AS StudentName,
    avg(degree) as avg_attendance_degree
FROM Attendance a , Student s
group by s.St_ID,s.Fname,s.Lname



select * from vw_StudentAttendance


------------------------------------------------------- Tracks Supervisor
create VIEW vw_TracksSupervisor AS
SELECT
    t.Track_Name,
    i.Fname + ' ' + i.Lname AS Instructor_Supervisor
FROM Tracks t
JOIN Instructor i ON i.InstructorID = t.Manager_id


select * from vw_TracksSupervisor

------------------------------------------------------- Instructor Tracks
alter VIEW vw_InstructorTracks AS
SELECT
    i.InstructorID,
    i.Fname + ' ' + i.Lname AS InstructorName,
    t.Track_Name
FROM Tracks t
JOIN Instructor i ON i.InstructorID = t.InstructorID


-- =============================================
-- FUNCTIONS
-- =============================================

-- 1. Function: Calculate Result from percentage
CREATE FUNCTION fn_CalculateResult (@percentage DECIMAL(5,2))
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @result VARCHAR(10)
    SET @result = CASE WHEN @percentage >= 50 THEN 'Passed' ELSE 'Failed' END
    RETURN @result
END
GO

-- 2. Function: Track Pass Rate
CREATE FUNCTION fn_TrackPassRate (@TrackID INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @total INT, @passed INT, @rate DECIMAL(5,2)

    SELECT @total = COUNT(*)
    FROM Exam_Result er
    JOIN Student s ON s.St_ID = er.St_ID
    WHERE s.Track_IDFK = @TrackID

    SELECT @passed = COUNT(*)
    FROM Exam_Result er
    JOIN Student s ON s.St_ID = er.St_ID
    WHERE s.Track_IDFK = @TrackID AND er.Result = 'Passed'

    SET @rate = CASE WHEN @total = 0 THEN 0 ELSE (@passed * 100.0 / @total) END
    RETURN @rate
END
GO

-- =============================================
-- TRIGGERS
-- =============================================

-- 1. Trigger: Prevent insert if exam doesn't exist
CREATE TRIGGER trg_CheckExamExists
ON Stud_answers
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN Exam e ON i.Exam_ID = e.Exam_ID
        WHERE e.Exam_ID IS NULL
    )
    BEGIN
        RAISERROR ('Cannot insert answer: Exam does not exist.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    INSERT INTO Stud_answers
    SELECT * FROM inserted
END
GO

-- 2. Trigger: Auto update Exam_Result on insert/update in Stud_answers
CREATE TRIGGER trg_UpdateExamResult
ON Stud_answers
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @St_ID INT, @Exam_ID INT, @Course_ID INT

    SELECT TOP 1 @St_ID = St_ID, @Exam_ID = Exam_ID
    FROM inserted

    SELECT @Course_ID = q.Course_ID
    FROM Stud_answers sa
    JOIN Questions q ON sa.Question_ID = q.Question_ID
    WHERE sa.St_ID = @St_ID AND sa.Exam_ID = @Exam_ID

    EXEC sp_InsertExamResult @St_ID, @Exam_ID, @Course_ID
END
GO

-- 3. Trigger: Audit updates on Exam_Result
CREATE TABLE ExamResult_Audit (
    AuditID INT IDENTITY PRIMARY KEY,
    St_ID INT,
    Exam_ID INT,
    Old_Percentage DECIMAL(5,2),
    New_Percentage DECIMAL(5,2),
    ChangeDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TRIGGER trg_AuditExamResultUpdate
ON Exam_Result
AFTER UPDATE
AS
BEGIN
    INSERT INTO ExamResult_Audit (St_ID, Exam_ID, Old_Percentage, New_Percentage)
    SELECT
        d.St_ID,
        d.Exam_ID,
        d.Exam_Percentage,
        i.Exam_Percentage
    FROM deleted d
    JOIN inserted i ON d.St_ID = i.St_ID AND d.Exam_ID = i.Exam_ID
    WHERE d.Exam_Percentage <> i.Exam_Percentage
END
GO
