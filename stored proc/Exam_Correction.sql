create proc Exaam_Correction @Exam_ID int ,@St_ID int 
as
declare c1 cursor 
for select Question_ID,St_Answer,Ques_Grade from Stud_answers where Exam_ID=@Exam_ID and St_ID=@St_ID
for update 
declare @Question_ID int ,@St_Answer varchar(255),@Ques_Grade int 
open c1 
fetch c1 into  @Question_ID  ,@St_Answer ,@Ques_Grade 
while @@FETCH_STATUS=0
begin 
if @St_Answer=(select Correct_Answer from Questions where Question_ID=@Question_ID)
update Stud_answers
set Ques_Grade = 1 
where current of c1 
else 
update Stud_answers
set Ques_Grade = 0 
where current of c1
fetch c1 into  @Question_ID  ,@St_Answer ,@Ques_Grade 
end 
close c1 
deallocate c1

Exaam_Correction 1,423

------------------------------------
alter proc Exam_Result_proc  @Exam_ID int ,@St_ID int 
as
declare @exam_percantage decimal(5, 2)
select @exam_percantage =SUM(Ques_Grade)/count(Question_ID) from Stud_answers where Exam_ID=@Exam_ID and St_ID=@St_ID



declare @result varchar(50)
if @exam_percantage >= 60 
select @result = 'PASS'
else 
select @result = 'FAIL'

declare @Course_ID int 
select @Course_ID= Course_ID from Courses where Course_Name=(select Exam_Name from Exam where Exam_ID=@Exam_ID)


insert into Exam_Result 
VALUES (@St_ID,@Exam_ID,@Course_ID,getdate(),@exam_percantage,@result)



Exam_Result_proc 1,1

select * from Exam_Result where Exam_ID=1 and St_ID=1
delete from Exam_Result where Exam_ID=1 and St_ID=1

update Stud_answers
set Ques_Grade= 1
where St_ID=423 and Exam_ID=1

select * from Stud_answers
where St_ID=423 and Exam_ID=1

