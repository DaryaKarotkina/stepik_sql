3.1 База данных «Тестирование», запросы на выборку

CREATE TABLE subject (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    name_subject varchar(30)
);

INSERT INTO subject (subject_id,name_subject) VALUES 
    (1,'Основы SQL'),
    (2,'Основы баз данных'),
    (3,'Физика');

CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name_student varchar(50)
);

INSERT INTO student (student_id,name_student) VALUES
    (1,'Баранов Павел'),
    (2,'Абрамова Катя'),
    (3,'Семенов Иван'),
    (4,'Яковлева Галина');

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
    (1,'Запрос на выборку начинается с ключевого слова:',1),
    (2,'Условие, по которому отбираются записи, задается после ключевого слова:',1),
    (3,'Для сортировки используется:',1),
    (4,'Какой запрос выбирает все записи из таблицы student:',1),
    (5,'Для внутреннего соединения таблиц используется оператор:',1),
    (6,'База данных - это:',2),
    (7,'Отношение - это:',2),
    (8,'Концептуальная модель используется для',2),
    (9,'Какой тип данных не допустим в реляционной таблице?',2);

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
    (17,'совокупность данных, организованных по определенным правилам',6,TRUE),
    (18,'совокупность программ для хранения и обработки больших массивов информации',6,FALSE),
    (19,'строка',7,FALSE),
    (20,'столбец',7,FALSE),
    (21,'таблица',7,TRUE),
    (22,'обобщенное представление пользователей о данных',8,TRUE),
    (23,'описание представления данных в памяти компьютера',8,FALSE),
    (24,'база данных',8,FALSE),
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
    
   
   
Задание
Вывести студентов, которые сдавали дисциплину «Основы баз данных», указать дату попытки и результат. Информацию вывести по убыванию результатов тестирования.

select student.name_student ,attempt.date_attempt,attempt.result
from subject 
inner join attempt using(subject_id)
inner join student using(student_id)
where subject.name_subject ='Основы баз данных'
order by attempt.result desc;



Задание
Вывести, сколько попыток сделали студенты по каждой дисциплине, а также средний результат попыток, который округлить до 2 знаков после запятой. Под результатом попытки понимается процент правильных ответов на вопросы теста, который занесен в столбец result.  В результат включить название дисциплины, а также вычисляемые столбцы Количество и Среднее. Информацию вывести по убыванию средних результатов.

select subject.name_subject ,count(attempt.result) as Количество , round( avg(attempt.result),2) as Среднее
from subject 
left join attempt using(subject_id)
group by subject.name_subject ;



Задание
Вывести студентов (различных студентов), имеющих максимальные результаты попыток. Информацию отсортировать в алфавитном порядке по фамилии студента.

Максимальный результат не обязательно будет 100%, поэтому явно это значение в запросе не задавать.


select student.name_student ,result
from student 
inner join attempt using(student_id)
where result=(
select max(attempt.result) 
from attempt)
order by student.name_student;


Задание
Если студент совершал несколько попыток по одной и той же дисциплине, то вывести разницу в днях между первой и последней попыткой. В результат включить фамилию и имя студента, название дисциплины и вычисляемый столбец Интервал. Информацию вывести по возрастанию разницы. Студентов, сделавших одну попытку по дисциплине, не учитывать. 

select student.name_student ,subject.name_subject  , datediff(max(attempt.date_attempt),min(attempt.date_attempt) ) as Интервал
from subject 
inner join attempt using(subject_id)
inner join student using(student_id)
group by student.name_student ,subject.name_subject 
having count(attempt.date_attempt)>1
order by Интервал ;


Задание
Студенты могут тестироваться по одной или нескольким дисциплинам (не обязательно по всем). Вывести дисциплину и количество уникальных студентов (столбец назвать Количество), которые по ней проходили тестирование . Информацию отсортировать сначала по убыванию количества, а потом по названию дисциплины. В результат включить и дисциплины, тестирование по которым студенты еще не проходили, в этом случае указать количество студентов 0.

select subject.name_subject , count(distinct student_id) as Количество
from subject 
left join attempt using(subject_id)
group by subject.name_subject 
order by subject.name_subject;

Задание
Случайным образом отберите 3 вопроса по дисциплине «Основы баз данных». В результат включите столбцы question_id и name_question.

select question.question_id, question.name_question
from subject 
inner join question using(subject_id)
where subject.name_subject ='Основы баз данных'
order by rand()
limit 3;


Задание
Вывести вопросы, которые были включены в тест для Семенова Ивана по дисциплине «Основы SQL» 2020-05-17  (значение attempt_id для этой попытки равно 7). Указать, какой ответ дал студент и правильный он или нет (вывести Верно или Неверно). В результат включить вопрос, ответ и вычисляемый столбец  Результат.

select question.name_question ,answer.name_answer ,
case 
when answer.is_correct =0 then 'Неверно' 
else 'Верно'
end as Результат
from answer 
inner join testing using(answer_id)
inner join question on testing.question_id =question.question_id 
where testing.attempt_id =7;


Задание
Посчитать результаты тестирования. Результат попытки вычислить как количество правильных ответов, деленное на 3 (количество вопросов в каждой попытке) и умноженное на 100. Результат округлить до двух знаков после запятой. Вывести фамилию студента, название предмета, дату и результат. Последний столбец назвать Результат. Информацию отсортировать сначала по фамилии студента, потом по убыванию даты попытки.

select student.name_student ,subject.name_subject ,attempt.date_attempt,
round(sum(is_correct)*100/3,2) as Результат
from answer 
inner join testing using (answer_id)
inner join attempt using(attempt_id)
inner join subject using(subject_id)
inner join student using(student_id)
group by student.name_student ,subject.name_subject ,attempt.date_attempt 
order by student.name_student, attempt.date_attempt desc;



Задание 
Для каждого вопроса вывести процент успешных решений, то есть отношение количества верных ответов к общему количеству ответов, значение округлить до 2-х знаков после запятой. Также вывести название предмета, к которому относится вопрос, и общее количество ответов на этот вопрос. В результат включить название дисциплины, вопросы по ней (столбец назвать Вопрос), а также два вычисляемых столбца Всего_ответов и Успешность. Информацию отсортировать сначала по названию дисциплины, потом по убыванию успешности, а потом по тексту вопроса в алфавитном порядке.

Поскольку тексты вопросов могут быть длинными, обрезать их 30 символов и добавить многоточие "...".

select subject.name_subject ,
concat(left(question.name_question,30),'...') as Вопрос ,
count(distinct testing.attempt_id) as  Всего_ответов , 
round(sum(answer.is_correct)/count(testing.answer_id)*100,2) as Успешность 
from subject 
inner join question using(subject_id)
inner join testing using(question_id)
left join answer using (answer_id)
group by subject.name_subject ,question.name_question
order by subject.name_subject,Успешность desc, question.name_question

3.2 База данных «Тестирование», запросы корректировки

Задание
В таблицу attempt включить новую попытку для студента Баранова Павла по дисциплине «Основы баз данных». Установить текущую дату в качестве даты выполнения попытки.

select student_id 
from student s 
where name_student like 'Бара%'

select subject_id 
from subject s 
where name_subject like 'Основы баз да%'

select * from attempt a 

insert into attempt (student_id, subject_id,date_attempt,result)
select
(select student_id from student s 
where name_student like 'Бара%'),
(select subject_id 
from subject s 
where name_subject like 'Основы баз да%'),
now(),
null;
select * from attempt a ;


Задание 
Случайным образом выбрать три вопроса (запрос) по дисциплине, тестирование по которой собирается проходить студент, занесенный в таблицу attempt последним, и добавить их в таблицу testing. id последней попытки получить как максимальное значение id из таблицы attempt.

insert into testing (attempt_id,question_id)
select attempt.attempt_id,question.question_id 
from question 
inner join attempt using (subject_id)
join subject using (subject_id) 
where attempt_id=(select max(attempt_id) from attempt )
order by rand()
limit 3


Задание
Студент прошел тестирование (то есть все его ответы занесены в таблицу testing), далее необходимо вычислить результат(запрос) и занести его в таблицу attempt для соответствующей попытки.  Результат попытки вычислить как количество правильных ответов, деленное на 3 (количество вопросов в каждой попытке) и умноженное на 100. Результат округлить до целого.

 Будем считать, что мы знаем id попытки,  для которой вычисляется результат, в нашем случае это 8. В таблицу testing занесены следующие ответы пользователя:

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


Задание
Удалить из таблицы attempt все попытки, выполненные раньше 1 мая 2020 года. Также удалить и все соответствующие этим попыткам вопросы из таблицы testing, которая создавалась следующим запросом:

delete from attempt 
where date_attempt <'2020-05-01';
select * from attempt ;
select * from testing ;


3.3 База данных «Абитуриент», запросы на выборку


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
VALUES (1, 'Инженерная школа'), (2, 'Школа естественных наук');

CREATE TABLE subject_abit (
    `subject_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name_subject` VARCHAR(30)
);
INSERT INTO subject_abit (`subject_id`, `name_subject`)
VALUES (1, 'Русский язык'), (2, 'Математика'), (3, 'Физика'), (4, 'Информатика');

CREATE TABLE program (
    `program_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name_program` VARCHAR(50),
    `department_id` INT,
    `plan` INT,
    FOREIGN KEY (`department_id`) REFERENCES `department`(`department_id`) ON DELETE CASCADE
);
INSERT INTO program (`program_id`, `name_program`, `department_id`, `plan`)
VALUES (1, 'Прикладная математика и информатика', 2, 2),
(2, 'Математика и компьютерные науки', 2, 1),
(3, 'Прикладная механика', 1, 2),
(4, 'Мехатроника и робототехника', 1, 3);

CREATE TABLE enrollee (
    `enrollee_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name_enrollee` VARCHAR(50)
);
INSERT INTO enrollee (`enrollee_id`, `name_enrollee`)
VALUES (1, 'Баранов Павел'), (2, 'Абрамова Катя'), (3, 'Семенов Иван'),
(4, 'Яковлева Галина'), (5, 'Попов Илья'), (6, 'Степанова Дарья');

CREATE TABLE achievement (
    `achievement_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name_achievement` VARCHAR(30),
    `bonus` INT
);
INSERT INTO achievement (`achievement_id`, `name_achievement`, `bonus`)
VALUES (1, 'Золотая медаль', 5), (2, 'Серебряная медаль', 3),
    (3, 'Золотой значок ГТО', 3),(4, 'Серебряный значок ГТО', 1);

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
       
      
Задание
Вывести абитуриентов, которые хотят поступать на образовательную программу «Мехатроника и робототехника» в отсортированном по фамилиям виде.

select enrollee.name_enrollee
from enrollee 
inner join program_enrollee using (enrollee_id)
inner join program using (program_id)
where program.name_program like 'Мехатроника и роб%'
order by enrollee.name_enrollee


Задание
Вывести образовательные программы, на которые для поступления необходим предмет «Информатика». Программы отсортировать в обратном алфавитном порядке

select program.name_program 
from subject_abit 
inner join program_subject using (subject_id)
inner join program using (program_id)
where subject_abit.name_subject like 'Информат%' 


Задание
Выведите количество абитуриентов, сдавших ЕГЭ по каждому предмету, максимальное, минимальное и среднее значение баллов по предмету ЕГЭ. Вычисляемые столбцы назвать Количество, Максимум, Минимум, Среднее. Информацию отсортировать по названию предмета в алфавитном порядке, среднее значение округлить до одного знака после запятой.

select subject_abit.name_subject  , count(subject_abit.name_subject) as Количество, max(enrollee_subject.result) as Максимум, min(enrollee_subject.result) as Минимум, round(avg(enrollee_subject.result),1) as Среднее
from subject_abit 
inner join enrollee_subject using (subject_id)
group by subject_abit.name_subject 
order by subject_abit.name_subject ;


Задание
Вывести образовательные программы, для которых минимальный балл ЕГЭ по каждому предмету больше или равен 40 баллам. Программы вывести в отсортированном по алфавиту виде.

select program.name_program 
from program 
inner join program_subject using (program_id)
group by program.name_program 
having min(program_subject.min_result) >=40
order by program.name_program 

Задание
Вывести образовательные программы, которые имеют самый большой план набора,  вместе с этой величиной.

select name_program ,plan
from program 
where plan= (select max(plan)
from program);

Задание
Посчитать, сколько дополнительных баллов получит каждый абитуриент. Столбец с дополнительными баллами назвать Бонус. Информацию вывести в отсортированном по фамилиям виде.

select enrollee.name_enrollee , ifnull(sum( achievement.bonus),0) as Бонус
from enrollee 
left join enrollee_achievement on enrollee.enrollee_id =enrollee_achievement.enrollee_id 
left join achievement using(achievement_id)
group by enrollee.name_enrollee 
order by enrollee.name_enrollee 

Задание
Выведите сколько человек подало заявление на каждую образовательную программу и конкурс на нее (число поданных заявлений деленное на количество мест по плану), округленный до 2-х знаков после запятой. В запросе вывести название факультета, к которому относится образовательная программа, название образовательной программы, план набора абитуриентов на образовательную программу (plan), количество поданных заявлений (Количество) и Конкурс. Информацию отсортировать в порядке убывания конкурса.

select department.name_department, program.name_program,program.plan,
count(program_enrollee.enrollee_id) as Количество,
round(count(program_enrollee.enrollee_id)/(sum(program.plan)/count(program_enrollee.enrollee_id)),2) as Конкурс
from program_enrollee
inner join program using(program_id)
inner join department using(department_id)
group by department.name_department ,program.program_id
order by Конкурс desc;


Задание
Вывести образовательные программы, на которые для поступления необходимы предмет «Информатика» и «Математика» в отсортированном по названию программ виде.

select program.name_program 
from subject_abit 
inner join program_subject using(subject_id)
inner join program using( program_id)
where subject_abit.name_subject in ('Информатика','Математика')
group by program.name_program 
having count(*)=2
order by program.name_program 

Задание
Посчитать количество баллов каждого абитуриента на каждую образовательную программу, на которую он подал заявление, по результатам ЕГЭ. В результат включить название образовательной программы, фамилию и имя абитуриента, а также столбец с суммой баллов, который назвать itog. Информацию вывести в отсортированном сначала по образовательной программе, а потом по убыванию суммы баллов виде.


select program.name_program,enrollee.name_enrollee , sum(enrollee_subject.result) as itog
from program_subject 
inner join program using(program_id) 
inner join program_enrollee using(program_id)
inner join enrollee using(enrollee_id)
inner join enrollee_subject using(subject_id,enrollee_id) 
group by program.name_program,enrollee.name_enrollee 
order by program.name_program, itog desc


Задание
Вывести название образовательной программы и фамилию тех абитуриентов, которые подавали документы на эту образовательную программу, но не могут быть зачислены на нее. Эти абитуриенты имеют результат по одному или нескольким предметам ЕГЭ, необходимым для поступления на эту образовательную программу, меньше минимального балла. Информацию вывести в отсортированном сначала по программам, а потом по фамилиям абитуриентов виде.

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

3.4 База данных «Абитуриент», запросы корректировки

Задание
Создать вспомогательную таблицу applicant,  куда включить id образовательной программы, id абитуриента, сумму баллов абитуриентов (столбец itog) в отсортированном сначала по id образовательной программы, а потом по убыванию суммы баллов виде (использовать запрос из предыдущего урока).

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

Задание
Из таблицы applicant, созданной на предыдущем шаге, удалить записи, если абитуриент на выбранную образовательную программу не набрал минимального балла хотя бы по одному предмету (использовать запрос из предыдущего урока).


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



Задание
Повысить итоговые баллы абитуриентов в таблице applicant на значения дополнительных баллов (использовать запрос из предыдущего урока).
update applicant
inner join(
select enrollee.enrollee_id , ifnull(sum( achievement.bonus),0) as Бонус
from enrollee 
left join enrollee_achievement on enrollee.enrollee_id =enrollee_achievement.enrollee_id 
left join achievement using(achievement_id)
group by enrollee.enrollee_id 
order by enrollee.enrollee_id) as res using (enrollee_id)
set applicant.itog= itog+ Бонус;
select * from applicant;


Задание
Поскольку при добавлении дополнительных баллов, абитуриенты по каждой образовательной программе могут следовать не в порядке убывания суммарных баллов, необходимо создать новую таблицу applicant_order на основе таблицы applicant. При создании таблицы данные нужно отсортировать сначала по id образовательной программы, потом по убыванию итогового балла. А таблицу applicant, которая была создана как вспомогательная, необходимо удалить.

create table applicant_order
select *
from applicant 
order by program_id, itog desc ;
drop table applicant;
select * from applicant_order;


Задание
Включить в таблицу applicant_order новый столбец str_id целого типа , расположить его перед первым.

alter table applicant_order add str_id int FIRST;
select * from applicant_order;

Задание
Занести в столбец str_id таблицы applicant_order нумерацию абитуриентов, которая начинается с 1 для каждой образовательной программы.

set @row_num := 1;
set @num_pr := 0;
update applicant_order
    set str_id = IF(program_id = @num_pr, @row_num := @row_num + 1, @row_num := 1 AND @num_pr := @num_pr + 1);
select * from applicant_order;

Создать таблицу student,  в которую включить абитуриентов, которые могут быть рекомендованы к зачислению  в соответствии с планом набора. Информацию отсортировать сначала в алфавитном порядке по названию программ, а потом по убыванию итогового балла.
drop table st_ab
create table st_ab
select program.name_program ,enrollee.name_enrollee ,applicant_order.itog
from enrollee 
inner join applicant_order using(enrollee_id)
inner join program using (program_id)
where applicant_order.str_id<=program.plan
order by program.name_program, applicant_order.itog desc;
select * from st_ab;

3.5 База данных "Учебная аналитика по курсу"


CREATE TABLE module
(
    module_id   INT PRIMARY KEY AUTO_INCREMENT,
    module_name VARCHAR(64)
);

INSERT INTO module (module_name)
VALUES ('Основы реляционной модели и SQL'),
       ('Запросы SQL к связанным таблицам');

CREATE TABLE lesson
(
    lesson_id       INT PRIMARY KEY AUTO_INCREMENT,
    lesson_name     VARCHAR(50),
    module_id       INT,
    lesson_position INT,
    FOREIGN KEY (module_id) REFERENCES module (module_id) ON DELETE CASCADE
);

INSERT INTO lesson(lesson_name, module_id, lesson_position)
VALUES ('Отношение(таблица)', 1, 1),
       ('Выборка данных', 1, 2),
       ('Таблица "Командировки", запросы на выборку', 1, 6),
       ('Вложенные запросы', 1, 4);

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
VALUES ('Структура уроков курса', 'text', 1, 1),
       ('Содержание урока', 'text', 1, 2),
       ('Реляционная модель, основные положения', 'table', 1, 3),
       ('Отношение, реляционная модель', 'choice', 1, 4);

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

/*включаем проверку*/
SET FOREIGN_KEY_CHECKS = 1;


Задание
Отобрать все шаги, в которых рассматриваются вложенные запросы (то есть в названии шага упоминаются вложенные запросы). Указать к какому уроку и модулю они относятся. Для этого вывести 3 поля:

в поле Модуль указать номер модуля и его название через пробел;
в поле Урок указать номер модуля, порядковый номер урока (lesson_position) через точку и название урока через пробел;
в поле Шаг указать номер модуля, порядковый номер урока (lesson_position) через точку, порядковый номер шага (step_position) через точку и название шага через пробел.
Длину полей Модуль и Урок ограничить 19 символами, при этом слишком длинные надписи обозначить многоточием в конце (16 символов - это номер модуля или урока, пробел и  название Урока или Модуля к ним присоединить "..."). Информацию отсортировать по возрастанию номеров модулей, порядковых номеров уроков и порядковых номеров шагов.

select * from module 
select * from lesson l2 
select * from step

select 
concat(left(concat(module_id,' ', module_name),16),'...') as  Модуль ,
concat(left(concat(module_id,'.', lesson_position,' ',lesson_name),16),'...') as  Урок ,
concat(module_id,'.', lesson_position,'.',step_position,' ',step_name) as  Шаг 
from module 
inner join lesson using(module_id)
inner join step using(lesson_id)
WHERE step_name LIKE '%ложенн% запрос%'
order by module_id , lesson_id, step_id



