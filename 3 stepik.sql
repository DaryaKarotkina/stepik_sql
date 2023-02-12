3.1 ���� ������ �������������, ������� �� �������

CREATE TABLE subject (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    name_subject varchar(30)
);

INSERT INTO subject (subject_id,name_subject) VALUES 
    (1,'������ SQL'),
    (2,'������ ��� ������'),
    (3,'������');

CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name_student varchar(50)
);

INSERT INTO student (student_id,name_student) VALUES
    (1,'������� �����'),
    (2,'�������� ����'),
    (3,'������� ����'),
    (4,'�������� ������');

CREATE TABLE attempt (
    attempt_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    date_attempt date,
    result INT,
    FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subject (subject_id) ON DELETE CASCADE
);

INSERT INTO attempt (attempt_id,student_id,subject_id,date_attempt,result) VALUES
    (1,1,2,'2020-03-23',67),
    (2,3,1,'2020-03-23',100),
    (3,4,2,'2020-03-26',0),
    (4,1,1,'2020-04-15',33),
    (5,3,1,'2020-04-15',67),
    (6,4,2,'2020-04-21',100),
    (7,3,1,'2020-05-17',33);

CREATE TABLE question (
    question_id INT PRIMARY KEY AUTO_INCREMENT,
    name_question varchar(100), 
    subject_id INT,
    FOREIGN KEY (subject_id) REFERENCES subject (subject_id) ON DELETE CASCADE
);

INSERT INTO question (question_id,name_question,subject_id) VALUES
    (1,'������ �� ������� ���������� � ��������� �����:',1),
    (2,'�������, �� �������� ���������� ������, �������� ����� ��������� �����:',1),
    (3,'��� ���������� ������������:',1),
    (4,'����� ������ �������� ��� ������ �� ������� student:',1),
    (5,'��� ����������� ���������� ������ ������������ ��������:',1),
    (6,'���� ������ - ���:',2),
    (7,'��������� - ���:',2),
    (8,'�������������� ������ ������������ ���',2),
    (9,'����� ��� ������ �� �������� � ����������� �������?',2);

CREATE TABLE answer (
    answer_id INT PRIMARY KEY AUTO_INCREMENT,
    name_answer varchar(100),
    question_id INT,
    is_correct BOOLEAN,
    CONSTRAINT answer_ibfk_1 FOREIGN KEY (question_id) REFERENCES question (question_id) ON DELETE CASCADE
);

INSERT INTO answer (answer_id,name_answer,question_id,is_correct) VALUES
    (1,'UPDATE',1,FALSE),
    (2,'SELECT',1,TRUE),
    (3,'INSERT',1,FALSE),
    (4,'GROUP BY',2,FALSE),
    (5,'FROM',2,FALSE),
    (6,'WHERE',2,TRUE),
    (7,'SELECT',2,FALSE),
    (8,'SORT',3,FALSE),
    (9,'ORDER BY',3,TRUE),
    (10,'RANG BY',3,FALSE),
    (11,'SELECT * FROM student',4,TRUE),
    (12,'SELECT student',4,FALSE),
    (13,'INNER JOIN',5,TRUE),
    (14,'LEFT JOIN',5,FALSE),
    (15,'RIGHT JOIN',5,FALSE),
    (16,'CROSS JOIN',5,FALSE),
    (17,'������������ ������, �������������� �� ������������ ��������',6,TRUE),
    (18,'������������ �������� ��� �������� � ��������� ������� �������� ����������',6,FALSE),
    (19,'������',7,FALSE),
    (20,'�������',7,FALSE),
    (21,'�������',7,TRUE),
    (22,'���������� ������������� ������������� � ������',8,TRUE),
    (23,'�������� ������������� ������ � ������ ����������',8,FALSE),
    (24,'���� ������',8,FALSE),
    (25,'file',9,TRUE),
    (26,'INT',9,FALSE),
    (27,'VARCHAR',9,FALSE),
    (28,'DATE',9,FALSE);

CREATE TABLE testing (
    testing_id INT PRIMARY KEY AUTO_INCREMENT,
    attempt_id INT,
    question_id INT,
    answer_id INT,
    FOREIGN KEY (attempt_id) REFERENCES attempt (attempt_id) ON DELETE CASCADE
);

INSERT INTO testing (testing_id,attempt_id,question_id,answer_id) VALUES
    (1,1,9,25),
    (2,1,7,19),
    (3,1,6,17),
    (4,2,3,9),
    (5,2,1,2),
    (6,2,4,11),
    (7,3,6,18),
    (8,3,8,24),
    (9,3,9,28),
    (10,4,1,2),
    (11,4,5,16),
    (12,4,3,10),
    (13,5,2,6),
    (14,5,1,2),
    (15,5,4,12),
    (16,6,6,17),
    (17,6,8,22),
    (18,6,7,21),
    (19,7,1,3),
    (20,7,4,11),
    (21,7,5,16);
    
   
   
�������
������� ���������, ������� ������� ���������� ������� ��� �������, ������� ���� ������� � ���������. ���������� ������� �� �������� ����������� ������������.

select student.name_student ,attempt.date_attempt,attempt.result
from subject 
inner join attempt using(subject_id)
inner join student using(student_id)
where subject.name_subject ='������ ��� ������'
order by attempt.result desc;



�������
�������, ������� ������� ������� �������� �� ������ ����������, � ����� ������� ��������� �������, ������� ��������� �� 2 ������ ����� �������. ��� ����������� ������� ���������� ������� ���������� ������� �� ������� �����, ������� ������� � ������� result.  � ��������� �������� �������� ����������, � ����� ����������� ������� ���������� � �������. ���������� ������� �� �������� ������� �����������.

select subject.name_subject ,count(attempt.result) as ���������� , round( avg(attempt.result),2) as �������
from subject 
left join attempt using(subject_id)
group by subject.name_subject ;



�������
������� ��������� (��������� ���������), ������� ������������ ���������� �������. ���������� ������������� � ���������� ������� �� ������� ��������.

������������ ��������� �� ����������� ����� 100%, ������� ���� ��� �������� � ������� �� ��������.


select student.name_student ,result
from student 
inner join attempt using(student_id)
where result=(
select max(attempt.result) 
from attempt)
order by student.name_student;


�������
���� ������� �������� ��������� ������� �� ����� � ��� �� ����������, �� ������� ������� � ���� ����� ������ � ��������� ��������. � ��������� �������� ������� � ��� ��������, �������� ���������� � ����������� ������� ��������. ���������� ������� �� ����������� �������. ���������, ��������� ���� ������� �� ����������, �� ���������. 

select student.name_student ,subject.name_subject  , datediff(max(attempt.date_attempt),min(attempt.date_attempt) ) as ��������
from subject 
inner join attempt using(subject_id)
inner join student using(student_id)
group by student.name_student ,subject.name_subject 
having count(attempt.date_attempt)>1
order by �������� ;


�������
�������� ����� ������������� �� ����� ��� ���������� ����������� (�� ����������� �� ����). ������� ���������� � ���������� ���������� ��������� (������� ������� ����������), ������� �� ��� ��������� ������������ . ���������� ������������� ������� �� �������� ����������, � ����� �� �������� ����������. � ��������� �������� � ����������, ������������ �� ������� �������� ��� �� ���������, � ���� ������ ������� ���������� ��������� 0.

select subject.name_subject , count(distinct student_id) as ����������
from subject 
left join attempt using(subject_id)
group by subject.name_subject 
order by subject.name_subject;

�������
��������� ������� �������� 3 ������� �� ���������� ������� ��� �������. � ��������� �������� ������� question_id � name_question.

select question.question_id, question.name_question
from subject 
inner join question using(subject_id)
where subject.name_subject ='������ ��� ������'
order by rand()
limit 3;


�������
������� �������, ������� ���� �������� � ���� ��� �������� ����� �� ���������� ������� SQL� 2020-05-17  (�������� attempt_id ��� ���� ������� ����� 7). �������, ����� ����� ��� ������� � ���������� �� ��� ��� (������� ����� ��� �������). � ��������� �������� ������, ����� � ����������� �������  ���������.

select question.name_question ,answer.name_answer ,
case 
when answer.is_correct =0 then '�������' 
else '�����'
end as ���������
from answer 
inner join testing using(answer_id)
inner join question on testing.question_id =question.question_id 
where testing.attempt_id =7;


�������
��������� ���������� ������������. ��������� ������� ��������� ��� ���������� ���������� �������, �������� �� 3 (���������� �������� � ������ �������) � ���������� �� 100. ��������� ��������� �� ���� ������ ����� �������. ������� ������� ��������, �������� ��������, ���� � ���������. ��������� ������� ������� ���������. ���������� ������������� ������� �� ������� ��������, ����� �� �������� ���� �������.

select student.name_student ,subject.name_subject ,attempt.date_attempt,
round(sum(is_correct)*100/3,2) as ���������
from answer 
inner join testing using (answer_id)
inner join attempt using(attempt_id)
inner join subject using(subject_id)
inner join student using(student_id)
group by student.name_student ,subject.name_subject ,attempt.date_attempt 
order by student.name_student, attempt.date_attempt desc;



������� 
��� ������� ������� ������� ������� �������� �������, �� ���� ��������� ���������� ������ ������� � ������ ���������� �������, �������� ��������� �� 2-� ������ ����� �������. ����� ������� �������� ��������, � �������� ��������� ������, � ����� ���������� ������� �� ���� ������. � ��������� �������� �������� ����������, ������� �� ��� (������� ������� ������), � ����� ��� ����������� ������� �����_������� � ����������. ���������� ������������� ������� �� �������� ����������, ����� �� �������� ����������, � ����� �� ������ ������� � ���������� �������.

��������� ������ �������� ����� ���� ��������, �������� �� 30 �������� � �������� ���������� "...".

select subject.name_subject ,
concat(left(question.name_question,30),'...') as ������ ,
count(distinct testing.attempt_id) as  �����_������� , 
round(sum(answer.is_correct)/count(testing.answer_id)*100,2) as ���������� 
from subject 
inner join question using(subject_id)
inner join testing using(question_id)
left join answer using (answer_id)
group by subject.name_subject ,question.name_question
order by subject.name_subject,���������� desc, question.name_question

3.2 ���� ������ �������������, ������� �������������

�������
� ������� attempt �������� ����� ������� ��� �������� �������� ����� �� ���������� ������� ��� �������. ���������� ������� ���� � �������� ���� ���������� �������.

select student_id 
from student s 
where name_student like '����%'

select subject_id 
from subject s 
where name_subject like '������ ��� ��%'

select * from attempt a 

insert into attempt (student_id, subject_id,date_attempt,result)
select
(select student_id from student s 
where name_student like '����%'),
(select subject_id 
from subject s 
where name_subject like '������ ��� ��%'),
now(),
null;
select * from attempt a ;


������� 
��������� ������� ������� ��� ������� (������) �� ����������, ������������ �� ������� ���������� ��������� �������, ���������� � ������� attempt ���������, � �������� �� � ������� testing. id ��������� ������� �������� ��� ������������ �������� id �� ������� attempt.

insert into testing (attempt_id,question_id)
select attempt.attempt_id,question.question_id 
from question 
inner join attempt using (subject_id)
join subject using (subject_id) 
where attempt_id=(select max(attempt_id) from attempt )
order by rand()
limit 3


�������
������� ������ ������������ (�� ���� ��� ��� ������ �������� � ������� testing), ����� ���������� ��������� ���������(������) � ������� ��� � ������� attempt ��� ��������������� �������.  ��������� ������� ��������� ��� ���������� ���������� �������, �������� �� 3 (���������� �������� � ������ �������) � ���������� �� 100. ��������� ��������� �� ������.

 ����� �������, ��� �� ����� id �������,  ��� ������� ����������� ���������, � ����� ������ ��� 8. � ������� testing �������� ��������� ������ ������������:

 update attempt ,
 (select attempt.attempt_id,student.student_id,subject.subject_id, attempt.date_attempt , round(sum(answer.is_correct)/3*100) as result
 from answer  
 inner join testing using (answer_id)
 inner join attempt on testing.attempt_id =attempt.attempt_id 
 inner join subject on attempt.subject_id =subject.subject_id 
 inner join student on attempt.student_id =student.student_id 
 where attempt.attempt_id=8
 group by student.student_id ,subject.subject_id , attempt.date_attempt 
 ) as r 
 set attempt.result=r.result
 where attempt.attempt_id=8;
select * from attempt;


�������
������� �� ������� attempt ��� �������, ����������� ������ 1 ��� 2020 ����. ����� ������� � ��� ��������������� ���� �������� ������� �� ������� testing, ������� ����������� ��������� ��������:

delete from attempt 
where date_attempt <'2020-05-01';
select * from attempt ;
select * from testing ;


3.3 ���� ������ �����������, ������� �� �������


DROP TABLE IF EXISTS enrollee_subject;
DROP TABLE IF EXISTS program_enrollee;
DROP TABLE IF EXISTS program_subject;
DROP TABLE IF EXISTS enrollee_achievement;
DROP TABLE IF EXISTS achievement;
DROP TABLE IF EXISTS enrollee;
DROP TABLE IF EXISTS program;
DROP TABLE IF EXISTS department;

CREATE TABLE department (
    `department_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name_department` VARCHAR(30)
);
INSERT INTO department (`department_id`, `name_department`)
VALUES (1, '���������� �����'), (2, '����� ������������ ����');

CREATE TABLE subject_abit (
    `subject_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name_subject` VARCHAR(30)
);
INSERT INTO subject_abit (`subject_id`, `name_subject`)
VALUES (1, '������� ����'), (2, '����������'), (3, '������'), (4, '�����������');

CREATE TABLE program (
    `program_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name_program` VARCHAR(50),
    `department_id` INT,
    `plan` INT,
    FOREIGN KEY (`department_id`) REFERENCES `department`(`department_id`) ON DELETE CASCADE
);
INSERT INTO program (`program_id`, `name_program`, `department_id`, `plan`)
VALUES (1, '���������� ���������� � �����������', 2, 2),
(2, '���������� � ������������ �����', 2, 1),
(3, '���������� ��������', 1, 2),
(4, '����������� � �������������', 1, 3);

CREATE TABLE enrollee (
    `enrollee_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name_enrollee` VARCHAR(50)
);
INSERT INTO enrollee (`enrollee_id`, `name_enrollee`)
VALUES (1, '������� �����'), (2, '�������� ����'), (3, '������� ����'),
(4, '�������� ������'), (5, '����� ����'), (6, '��������� �����');

CREATE TABLE achievement (
    `achievement_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name_achievement` VARCHAR(30),
    `bonus` INT
);
INSERT INTO achievement (`achievement_id`, `name_achievement`, `bonus`)
VALUES (1, '������� ������', 5), (2, '���������� ������', 3),
    (3, '������� ������ ���', 3),(4, '���������� ������ ���', 1);

CREATE TABLE enrollee_achievement (
    `enrollee_achiev_id` INT PRIMARY KEY AUTO_INCREMENT,
    `enrollee_id` INT,
    `achievement_id` INT,
    FOREIGN KEY (`enrollee_id`) REFERENCES `enrollee`(`enrollee_id`) ON DELETE CASCADE,
    FOREIGN KEY (`achievement_id`) REFERENCES `achievement`(`achievement_id`) ON DELETE CASCADE
);
INSERT INTO enrollee_achievement (`enrollee_achiev_id`, `enrollee_id`, `achievement_id`)
VALUES (1, 1, 2), (2, 1, 3), (3, 3, 1), (4, 4, 4), (5, 5, 1),(6, 5, 3);

CREATE TABLE program_subject (
    `program_subject_id` INT PRIMARY KEY AUTO_INCREMENT,
    `program_id` INT,
    `subject_id` INT,
    `min_result` INT,
    FOREIGN KEY (`program_id`) REFERENCES `program`(`program_id`)  ON DELETE CASCADE,
    FOREIGN KEY (`subject_id`) REFERENCES `subject_abit`(`subject_id`) ON DELETE CASCADE
);
INSERT INTO program_subject (`program_subject_id`, `program_id`, `subject_id`, `min_result`)
VALUES (1, 1, 1, 40),(2, 1, 2, 50), (3, 1, 4, 60), (4, 2, 1, 30),
       (5, 2, 2, 50),(6, 2, 4, 60), (7, 3, 1, 30),(8, 3, 2, 45),
       (9, 3, 3, 45),(10, 4, 1, 40), (11, 4, 2, 45), (12, 4, 3, 45);

CREATE TABLE program_enrollee (
    `program_enrollee_id` INT PRIMARY KEY AUTO_INCREMENT,
    `program_id` INT,
    `enrollee_id` INT,
    FOREIGN KEY (`program_id`) REFERENCES `program`(`program_id`) ON DELETE CASCADE,
    FOREIGN KEY (`enrollee_id`) REFERENCES enrollee(`enrollee_id`) ON DELETE CASCADE
);
INSERT INTO program_enrollee (`program_enrollee_id`, `program_id`, `enrollee_id`)
VALUES (1, 3, 1), (2, 4, 1), (3, 1, 1), (4, 2, 2), (5, 1, 2),
       (6, 1, 3), (7, 2, 3), (8, 4, 3), (9, 3, 4), (10, 3, 5),
       (11, 4, 5), (12, 2, 6), (13, 3, 6), (14, 4, 6);

CREATE TABLE enrollee_subject (
    `enrollee_subject_id` INT PRIMARY KEY AUTO_INCREMENT,
    `enrollee_id` INT,
    `subject_id` INT,
    `result` INT,
    FOREIGN KEY (`enrollee_id`) REFERENCES `enrollee`(`enrollee_id`) ON DELETE CASCADE,
    FOREIGN KEY (`subject_id`) REFERENCES `subject_abit`(`subject_id`) ON DELETE CASCADE
);
INSERT INTO enrollee_subject (`enrollee_subject_id`, `enrollee_id`, `subject_id`, `result`)
VALUES (1, 1, 1, 68), (2, 1, 2, 70), (3, 1, 3, 41), (4, 1, 4, 75), (5, 2, 1, 75), (6, 2, 2, 70),
       (7, 2, 4, 81), (8, 3, 1, 85), (9, 3, 2, 67), (10, 3, 3, 90), (11, 3, 4, 78), (12, 4, 1, 82),
       (13, 4, 2, 86), (14, 4, 3, 70), (15, 5, 1, 65), (16, 5, 2, 67), (17, 5, 3, 60),
       (18, 6, 1, 90), (19, 6, 2, 92), (20, 6, 3, 88), (21, 6, 4, 94);
       
      
�������
������� ������������, ������� ����� ��������� �� ��������������� ��������� ������������ � ������������� � ��������������� �� �������� ����.

select enrollee.name_enrollee
from enrollee 
inner join program_enrollee using (enrollee_id)
inner join program using (program_id)
where program.name_program like '����������� � ���%'
order by enrollee.name_enrollee


�������
������� ��������������� ���������, �� ������� ��� ����������� ��������� ������� ������������. ��������� ������������� � �������� ���������� �������

select program.name_program 
from subject_abit 
inner join program_subject using (subject_id)
inner join program using (program_id)
where subject_abit.name_subject like '��������%' 


�������
�������� ���������� ������������, ������� ��� �� ������� ��������, ������������, ����������� � ������� �������� ������ �� �������� ���. ����������� ������� ������� ����������, ��������, �������, �������. ���������� ������������� �� �������� �������� � ���������� �������, ������� �������� ��������� �� ������ ����� ����� �������.

select subject_abit.name_subject  , count(subject_abit.name_subject) as ����������, max(enrollee_subject.result) as ��������, min(enrollee_subject.result) as �������, round(avg(enrollee_subject.result),1) as �������
from subject_abit 
inner join enrollee_subject using (subject_id)
group by subject_abit.name_subject 
order by subject_abit.name_subject ;


�������
������� ��������������� ���������, ��� ������� ����������� ���� ��� �� ������� �������� ������ ��� ����� 40 ������. ��������� ������� � ��������������� �� �������� ����.

select program.name_program 
from program 
inner join program_subject using (program_id)
group by program.name_program 
having min(program_subject.min_result) >=40
order by program.name_program 

�������
������� ��������������� ���������, ������� ����� ����� ������� ���� ������,  ������ � ���� ���������.

select name_program ,plan
from program 
where plan= (select max(plan)
from program);

�������
���������, ������� �������������� ������ ������� ������ ����������. ������� � ��������������� ������� ������� �����. ���������� ������� � ��������������� �� �������� ����.

select enrollee.name_enrollee , ifnull(sum( achievement.bonus),0) as �����
from enrollee 
left join enrollee_achievement on enrollee.enrollee_id =enrollee_achievement.enrollee_id 
left join achievement using(achievement_id)
group by enrollee.name_enrollee 
order by enrollee.name_enrollee 

�������
�������� ������� ������� ������ ��������� �� ������ ��������������� ��������� � ������� �� ��� (����� �������� ��������� �������� �� ���������� ���� �� �����), ����������� �� 2-� ������ ����� �������. � ������� ������� �������� ����������, � �������� ��������� ��������������� ���������, �������� ��������������� ���������, ���� ������ ������������ �� ��������������� ��������� (plan), ���������� �������� ��������� (����������) � �������. ���������� ������������� � ������� �������� ��������.

select department.name_department, program.name_program,program.plan,
count(program_enrollee.enrollee_id) as ����������,
round(count(program_enrollee.enrollee_id)/(sum(program.plan)/count(program_enrollee.enrollee_id)),2) as �������
from program_enrollee
inner join program using(program_id)
inner join department using(department_id)
group by department.name_department ,program.program_id
order by ������� desc;


�������
������� ��������������� ���������, �� ������� ��� ����������� ���������� ������� ������������ � ����������� � ��������������� �� �������� �������� ����.

select program.name_program 
from subject_abit 
inner join program_subject using(subject_id)
inner join program using( program_id)
where subject_abit.name_subject in ('�����������','����������')
group by program.name_program 
having count(*)=2
order by program.name_program 

�������
��������� ���������� ������ ������� ����������� �� ������ ��������������� ���������, �� ������� �� ����� ���������, �� ����������� ���. � ��������� �������� �������� ��������������� ���������, ������� � ��� �����������, � ����� ������� � ������ ������, ������� ������� itog. ���������� ������� � ��������������� ������� �� ��������������� ���������, � ����� �� �������� ����� ������ ����.


select program.name_program,enrollee.name_enrollee , sum(enrollee_subject.result) as itog
from program_subject 
inner join program using(program_id) 
inner join program_enrollee using(program_id)
inner join enrollee using(enrollee_id)
inner join enrollee_subject using(subject_id,enrollee_id) 
group by program.name_program,enrollee.name_enrollee 
order by program.name_program, itog desc


�������
������� �������� ��������������� ��������� � ������� ��� ������������, ������� �������� ��������� �� ��� ��������������� ���������, �� �� ����� ���� ��������� �� ���. ��� ����������� ����� ��������� �� ������ ��� ���������� ��������� ���, ����������� ��� ����������� �� ��� ��������������� ���������, ������ ������������ �����. ���������� ������� � ��������������� ������� �� ����������, � ����� �� �������� ������������ ����.

INSERT INTO enrollee_subject (enrollee_id, subject_id, result) VALUES (2, 3, 41);

select program.name_program ,enrollee.name_enrollee 
from enrollee  
inner join program_enrollee using(enrollee_id)
inner join program using(program_id)
inner join program_subject using(program_id)
inner join subject_abit using(subject_id)
inner join enrollee_subject using(subject_id)
where enrollee_subject.result<program_subject.min_result and 
enrollee_subject.enrollee_id = enrollee.enrollee_id
order by program.name_program ,enrollee.name_enrollee 

3.4 ���� ������ �����������, ������� �������������

�������
������� ��������������� ������� applicant,  ���� �������� id ��������������� ���������, id �����������, ����� ������ ������������ (������� itog) � ��������������� ������� �� id ��������������� ���������, � ����� �� �������� ����� ������ ���� (������������ ������ �� ����������� �����).

create table applicant as
select program.program_id,enrollee.enrollee_id , sum(enrollee_subject.result) as itog
from program_subject 
inner join program using(program_id) 
inner join program_enrollee using(program_id)
inner join enrollee using(enrollee_id)
inner join enrollee_subject using(subject_id,enrollee_id) 
group by program.program_id,enrollee.enrollee_id
order by program.program_id, itog desc;
select * from applicant;

�������
�� ������� applicant, ��������� �� ���������� ����, ������� ������, ���� ���������� �� ��������� ��������������� ��������� �� ������ ������������ ����� ���� �� �� ������ �������� (������������ ������ �� ����������� �����).


delete from applicant
where (program_id,enrollee_id) in 
(select program.program_id,enrollee.enrollee_id
from enrollee  
inner join program_enrollee using(enrollee_id)
inner join program using(program_id)
inner join program_subject using(program_id)
inner join subject using(subject_id)
inner join enrollee_subject using(subject_id)
where enrollee_subject.result<program_subject.min_result and 
enrollee_subject.enrollee_id = enrollee.enrollee_id
order by program.program_id,enrollee.enrollee_id) ;
select * from applicant;



�������
�������� �������� ����� ������������ � ������� applicant �� �������� �������������� ������ (������������ ������ �� ����������� �����).
update applicant
inner join(
select enrollee.enrollee_id , ifnull(sum( achievement.bonus),0) as �����
from enrollee 
left join enrollee_achievement on enrollee.enrollee_id =enrollee_achievement.enrollee_id 
left join achievement using(achievement_id)
group by enrollee.enrollee_id 
order by enrollee.enrollee_id) as res using (enrollee_id)
set applicant.itog= itog+ �����;
select * from applicant;


�������
��������� ��� ���������� �������������� ������, ����������� �� ������ ��������������� ��������� ����� ��������� �� � ������� �������� ��������� ������, ���������� ������� ����� ������� applicant_order �� ������ ������� applicant. ��� �������� ������� ������ ����� ������������� ������� �� id ��������������� ���������, ����� �� �������� ��������� �����. � ������� applicant, ������� ���� ������� ��� ���������������, ���������� �������.

create table applicant_order
select *
from applicant 
order by program_id, itog desc ;
drop table applicant;
select * from applicant_order;


�������
�������� � ������� applicant_order ����� ������� str_id ������ ���� , ����������� ��� ����� ������.

alter table applicant_order add str_id int FIRST;
select * from applicant_order;

�������
������� � ������� str_id ������� applicant_order ��������� ������������, ������� ���������� � 1 ��� ������ ��������������� ���������.

set @row_num := 1;
set @num_pr := 0;
update applicant_order
    set str_id = IF(program_id = @num_pr, @row_num := @row_num + 1, @row_num := 1 AND @num_pr := @num_pr + 1);
select * from applicant_order;

������� ������� student,  � ������� �������� ������������, ������� ����� ���� ������������� � ����������  � ������������ � ������ ������. ���������� ������������� ������� � ���������� ������� �� �������� ��������, � ����� �� �������� ��������� �����.
drop table st_ab
create table st_ab
select program.name_program ,enrollee.name_enrollee ,applicant_order.itog
from enrollee 
inner join applicant_order using(enrollee_id)
inner join program using (program_id)
where applicant_order.str_id<=program.plan
order by program.name_program, applicant_order.itog desc;
select * from st_ab;

3.5 ���� ������ "������� ��������� �� �����"


CREATE TABLE module
(
    module_id   INT PRIMARY KEY AUTO_INCREMENT,
    module_name VARCHAR(64)
);

INSERT INTO module (module_name)
VALUES ('������ ����������� ������ � SQL'),
       ('������� SQL � ��������� ��������');

CREATE TABLE lesson
(
    lesson_id       INT PRIMARY KEY AUTO_INCREMENT,
    lesson_name     VARCHAR(50),
    module_id       INT,
    lesson_position INT,
    FOREIGN KEY (module_id) REFERENCES module (module_id) ON DELETE CASCADE
);

INSERT INTO lesson(lesson_name, module_id, lesson_position)
VALUES ('���������(�������)', 1, 1),
       ('������� ������', 1, 2),
       ('������� "������������", ������� �� �������', 1, 6),
       ('��������� �������', 1, 4);

CREATE TABLE step
(
    step_id       INT PRIMARY KEY AUTO_INCREMENT,
    step_name     VARCHAR(256),
    step_type     VARCHAR(16),
    lesson_id     INT,
    step_position INT,
    FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id) ON DELETE CASCADE
);

INSERT INTO step(step_name, step_type, lesson_id, step_position)
VALUES ('��������� ������ �����', 'text', 1, 1),
       ('���������� �����', 'text', 1, 2),
       ('����������� ������, �������� ���������', 'table', 1, 3),
       ('���������, ����������� ������', 'choice', 1, 4);

CREATE TABLE keyword
(
    keyword_id   INT PRIMARY KEY AUTO_INCREMENT,
    keyword_name VARCHAR(16)
);

INSERT INTO keyword(keyword_name)
VALUES ('SELECT'),
       ('FROM');

CREATE TABLE step_keyword
(
    step_id    INT,
    keyword_id INT,
    PRIMARY KEY (step_id, keyword_id),
    FOREIGN KEY (step_id) REFERENCES step (step_id) ON DELETE CASCADE,
    FOREIGN KEY (keyword_id) REFERENCES keyword (keyword_id) ON DELETE CASCADE
);

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO step_keyword (step_id, keyword_id) VALUE (38, 1);
INSERT INTO step_keyword (step_id, keyword_id) VALUE (81, 3);

CREATE TABLE student_an
(
    student_id   INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(64)
);

INSERT INTO student_an(student_name)
VALUES ('student_1'),
       ('student_2');

CREATE TABLE step_student
(
    step_student_id INT PRIMARY KEY AUTO_INCREMENT,
    step_id         INT,
    student_id      INT,
    attempt_time    INT,
    submission_time INT,
    result          VARCHAR(16),
    FOREIGN KEY (student_id) REFERENCES student_an (student_id) ON DELETE CASCADE,
    FOREIGN KEY (step_id) REFERENCES step (step_id) ON DELETE CASCADE
);

INSERT INTO step_student (step_id, student_id, attempt_time, submission_time, result)
VALUES (10, 52, 1598291444, 1598291490, 'correct'),
       (10, 11, 1593291995, 1593292031, 'correct'),
       (10, 19, 1591017571, 1591017743, 'wrong'),
       (10, 4, 1590254781, 1590254800, 'correct');

/*�������� ��������*/
SET FOREIGN_KEY_CHECKS = 1;


�������
�������� ��� ����, � ������� ��������������� ��������� ������� (�� ���� � �������� ���� ����������� ��������� �������). ������� � ������ ����� � ������ ��� ���������. ��� ����� ������� 3 ����:

� ���� ������ ������� ����� ������ � ��� �������� ����� ������;
� ���� ���� ������� ����� ������, ���������� ����� ����� (lesson_position) ����� ����� � �������� ����� ����� ������;
� ���� ��� ������� ����� ������, ���������� ����� ����� (lesson_position) ����� �����, ���������� ����� ���� (step_position) ����� ����� � �������� ���� ����� ������.
����� ����� ������ � ���� ���������� 19 ���������, ��� ���� ������� ������� ������� ���������� ����������� � ����� (16 �������� - ��� ����� ������ ��� �����, ������ �  �������� ����� ��� ������ � ��� ������������ "..."). ���������� ������������� �� ����������� ������� �������, ���������� ������� ������ � ���������� ������� �����.

select * from module 
select * from lesson l2 
select * from step

select 
concat(left(concat(module_id,' ', module_name),16),'...') as  ������ ,
concat(left(concat(module_id,'.', lesson_position,' ',lesson_name),16),'...') as  ���� ,
concat(module_id,'.', lesson_position,'.',step_position,' ',step_name) as  ��� 
from module 
inner join lesson using(module_id)
inner join step using(lesson_id)
WHERE step_name LIKE '%������% ������%'
order by module_id , lesson_id, step_id



