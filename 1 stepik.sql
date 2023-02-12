use stepik;
drop table book ;

1.1 Создание таблицы

Задание
Сформулируйте SQL запрос для создания таблицы book
create table book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price numeric (8, 2),
    amount INT);
   

2.Вставка записи в таблицу   
Задание
Занесите новую строку в таблицу book

insert into book (title,author,price,amount)
values('Мастер и Маргарита','Булгаков М.А.',670.99,3)


3.Задание
Занесите три последние записи в таблицуbook
insert into book(title,author,price ,amount)
values 
('Белая гвардия','Булгаков М.А.',540.50,5),
('Идиот','Достоевский Ф.М.',460.00,10),
('Братья Карамазовы','Достоевский Ф.М.',799.01,3),
('Стихотворения и поэмы','Есенин С.А.',650.00,15)


1.2 Выборка данных
Задание
Вывести информацию о всех книгах, хранящихся на складе
select * from book ;

Задание
Выбрать авторов, название книг и их цену из таблицы book
select author,title,price
from book;

Задание
Выбрать названия книг и авторов из таблицы book, для поля title задать имя(псевдоним) Название, для поля author –  Автор
select title as Название ,author as Автор
from book;

Задание
Для упаковки каждой книги требуется один лист бумаги, цена которого 1 рубль 65 копеек. Посчитать стоимость упаковки для каждой книги (сколько денег потребуется, чтобы упаковать все экземпляры книги). В запросе вывести название книги, ее количество и стоимость упаковки, последний столбец назвать pack
select title,amount,
amount*1.65 as pack
from book ;

Задание
В конце года цену всех книг на складе пересчитывают – снижают ее на 30%. Написать SQL запрос, который из таблицы book выбирает названия, авторов, количества и вычисляет новые цены книг. Столбец с новой ценой назвать new_price, цену округлить до 2-х знаков после запятой.
select title, author,amount,
ROUND((price*70/100),2) AS new_price
from book ;

Задание
При анализе продаж книг выяснилось, что наибольшей популярностью пользуются книги Михаила Булгакова, на втором месте книги Сергея Есенина. Исходя из этого решили поднять цену книг Булгакова на 10%, а цену книг Есенина - на 5%. Написать запрос, куда включить автора, название книги и новую цену, последний столбец назвать new_price. Значение округлить до двух знаков после запятой.
select author,title,
round(case 
	when author ='Булгаков М.А.' then price * 1.1
	when author ='Есенин С.А.' then price * 1.05
	else price end
	,2) as new_price
from book;

Задание
Вывести автора, название  и цены тех книг, количество которых меньше 10.
select author, title,price
from book  
where amount <10;

Задание
Вывести название, автора,  цену  и количество всех книг, цена которых меньше 500 или больше 600, а стоимость всех экземпляров этих книг больше или равна 5000.

select title, author,price,amount
from book b 
where (price<500 or price>600) and price*amount>=5000

Вывести название и авторов тех книг, цены которых принадлежат интервалу от 540.50 до 800 (включая границы),  а количество или 2, или 3, или 5, или 7 .
select title, author 
from book b 
where price between 540.5 and 8000
and amount in (2,3,5,7);

Задание
Вывести  автора и название  книг, количество которых принадлежит интервалу от 2 до 14 (включая границы). Информацию  отсортировать сначала по авторам (в обратном алфавитном порядке), а затем по названиям книг (по алфавиту).
select author, title
from book b 
where amount between 2 and 14
order by author desc,title

Задание
Вывести название и автора тех книг, название которых состоит из двух и более слов, а инициалы автора содержат букву «С». Считать, что в названии слова отделяются друг от друга пробелами и не содержат знаков препинания, между фамилией автора и инициалами обязателен пробел, инициалы записываются без пробела в формате: буква, точка, буква, точка. Информацию отсортировать по названию книги в алфавитном порядке.
insert into book (title,author,price ,amount)
values 
(NULL,'Иванов С.С.',50.00,10),
('Дети полуночи' ,'Рушди Салман' , 950.00 , 5    ),
('Лирика',  'Гумилев Н.С.'   , 460.00 ,10     ),
('Поэмы', 'Бехтерев С.С.'   , 460.00 , 10  ),
('Капитанская дочка',      'Пушкин А.С.'     , 520.50 , 7 )

select *from book ;
select title, author 
from book b 
where title like '_% _%'
and author like '_%С.%'
order by title ;


1.3 Запросы, групповые операции


insert into book (title,author,price ,amount)
values 
('Игрок ','Достоевский Ф.М.',480.50,10)

Задание
Отобрать различные (уникальные) элементы столбца amount таблицы book.

select distinct amount
from book
order by amount;

Задание
Посчитать, количество различных книг и количество экземпляров книг каждого автора , хранящихся на складе.  Столбцы назвать Автор, Различных_книг и Количество_экземпляров соответственно.
select distinct author as Автор ,
count( distinct title ) as Различных_книг,
sum(amount) as Количество_экземпляров
from book
group by author
order by author;

Задание
Вывести фамилию и инициалы автора, минимальную, максимальную и среднюю цену книг каждого автора . Вычисляемые столбцы назвать Минимальная_цена, Максимальная_цена и Средняя_цена соответственно.
select author,
min(price) as Минимальная_цена,
max(price) as Максимальная_цена,
avg(price) as Средняя_цена
from book 
group by author
order by author;

Задание
Для каждого автора вычислить суммарную стоимость книг S (имя столбца Стоимость), а также вычислить налог на добавленную стоимость  для полученных сумм (имя столбца НДС ) , который включен в стоимость и составляет k = 18%,  а также стоимость книг  (Стоимость_без_НДС) без него. Значения округлить до двух знаков после запятой. В запросе для расчета НДС(tax)  и Стоимости без НДС(S_without_tax) использовать следующие формулы:

select author, 
  sum(price*amount) as Стоимость, 
  round(sum(price*amount)*0.18/1.18, 2) as НДС, 
  round(sum(price*amount)/1.18, 2) as Стоимость_без_НДС
from book      
group by author
order by author

Задание
Вывести  цену самой дешевой книги, цену самой дорогой и среднюю цену уникальных книг на складе. Названия столбцов Минимальная_цена, Максимальная_цена, Средняя_цена соответственно. Среднюю цену округлить до двух знаков после запятой.
select min(price) as Минимальная_цена,
max(price) as Максимальная_цена,
round(avg(price),2) as Средняя_цена 
from book b 

Вычислить среднюю цену и суммарную стоимость тех книг, количество экземпляров которых принадлежит интервалу от 5 до 14, включительно. Столбцы назвать Средняя_цена и Стоимость, значения округлить до 2-х знаков после запятой.
select round(avg(price),2) as Средняя_цена ,
round(sum(price*amount),2) as Стоимость
from book b 
where amount between 5 and 14;

Задание
Посчитать стоимость всех экземпляров каждого автора без учета книг «Идиот» и «Белая гвардия». В результат включить только тех авторов, у которых суммарная стоимость книг (без учета книг «Идиот» и «Белая гвардия») более 5000 руб. Вычисляемый столбец назвать Стоимость. Результат отсортировать по убыванию стоимости.
select author ,
sum(price*amount) as Стоимость
from book b 
where title not in ('Идиот','Белая гвардия')
group by author
having sum(price*amount)>5000
order by Стоимость desc;


1.4 Вложенные запросы

Задание
Вывести информацию (автора, название и цену) о  книгах, цены которых меньше или равны средней цене книг на складе. Информацию вывести в отсортированном по убыванию цены виде. Среднее вычислить как среднее по цене книги.


select author,title,price
from book
where price<=(
select avg(price)
from book)
order by price desc;

Задание
Вывести информацию (автора, название и цену) о тех книгах, цены которых превышают минимальную цену книги на складе не более чем на 150 рублей в отсортированном по возрастанию цены виде.

insert into book (title,author,price ,amount)
values 
('Евгений Онегин ','Пушкин А.С.',610.00,10)
select author,title,price
from book
where price<=(
select min(price)+150
from book)
order by price;

Задание
Вывести информацию (автора, книгу и количество) о тех книгах, количество экземпляров которых в таблице book не дублируется.

select * from book b 

select author,title,amount
from book
where amount in(
select amount
from book b
group by amount
having count(amount)=1)

Задание
Вывести информацию о книгах(автор, название, цена), цена которых меньше самой большой из минимальных цен, вычисленных для каждого автора.

select author,title,price
from book 
where price < any(
select min(price)
from book 
group by author
)

Задание
Посчитать сколько и каких экземпляров книг нужно заказать поставщикам, чтобы на складе стало одинаковое количество экземпляров каждой книги, равное значению самого большего количества экземпляров одной книги на складе. Вывести название книги, ее автора, текущее количество экземпляров на складе и количество заказываемых экземпляров книг. Последнему столбцу присвоить имя Заказ. В результат не включать книги, которые заказывать не нужно.
select title, author, amount ,
(select max(amount)
from book) -amount as Заказ
from book b 
where amount < (select max(amount)
from book)


1.5 Запросы корректировки данных

Задание
Создать таблицу поставка (supply), которая имеет ту же структуру, что и таблиц book.
drop table supply;
create table supply(
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price numeric (8, 2),
    amount INT);

Задание
Занесите в таблицу supply четыре записи, чтобы получилась следующая таблица:
insert into supply( title, author, price, amount)
values 
('Лирика','Пастернак Б.Л.',518.99,2),
('Черный человек','Есенин С.А.',570.20,6),
('Белая гвардия','Булгаков М.А.',540.50,7),
('Идиот','Достоевский Ф.М.',360.80,3)
select * from supply;

Задание
Добавить из таблицы supply в таблицу book, все книги, кроме книг, написанных Булгаковым М.А. и Достоевским Ф.М.

insert into book(title, author, price, amount)
select title, author, price, amount
from supply 
where author not in ('Булгаков М.А.' , 'Достоевский Ф.М.')
order by author
select * from book 

Задание
Занести из таблицы supply в таблицу book только те книги, авторов которых нет в  book.
insert into book(title, author, price, amount)
select title, author, price, amount
from supply 
where author not in (
select author
from book)
select * from book;

Задание
Уменьшить на 10% цену тех книг в таблице book, количество которых принадлежит интервалу от 5 до 10, включая границы.
update book 
set price =0.9*price 
where amount between 5 and 10;
select * from book;

Задание
В таблице book необходимо скорректировать значение для покупателя в столбце buy таким образом, чтобы оно не превышало количество экземпляров книг, указанных в столбце amount. А цену тех книг, которые покупатель не заказывал, снизить на 10%.
update book 
set buy=if(buy>amount, amount, buy),
price=if(buy=0, price*0.9,price)
select * from book;

Для тех книг в таблице book , которые есть в таблице supply, не только увеличить их количество в таблице book ( увеличить их количество на значение столбца amountтаблицы supply), но и пересчитать их цену (для каждой книги найти сумму цен из таблиц book и supply и разделить на 2).
update book,supply
set book.amount=supply.amount+book.amount, 
book.price=(book.price+supply.price)/2
where book.title=supply.title
select * from book;

Задание
Удалить из таблицы supply книги тех авторов, общее количество экземпляров книг которых в таблице book превышает 10.
delete from supply 
where author in(
select author 
from book b 
group by author 
having sum(amount)>10
)

select * from supply; 

Задание
Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, количество экземпляров которых в таблице book меньше среднего количества экземпляров книг в таблице book. В таблицу включить столбец   amount, в котором для всех книг указать одинаковое значение - среднее количество экземпляров книг в таблице book.
drop table ordering;
create table ordering as
select author, title,
(select round(avg(amount))
from book) as amount 
from book b 
where amount <(select round(avg(amount))
from book
);
select * from ordering ;


1.6 Таблица "Командировки", запросы на выборку
drop table trip;
create table trip (
    trip_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    city VARCHAR(20),
    per_diem decimal (8, 2),
    date_first date,
   date_last date);

insert into trip ( name, city, per_diem, date_first,date_last)
values 
('Баранов П.Е.',	'Москва',	700,	'2020-01-12',	'2020-01-17'),
('Абрамова К.А.',	'Владивосток',	450,	'2020-01-14',	'2020-01-27'),
('Семенов И.В.',	'Москва',	700,	'2020-01-23',	'2020-01-31'),
('Ильиных Г.Р.',	'Владивосток',	450,	'2020-01-12',	'2020-02-02'),
('Колесов С.П.',	'Москва',	700,	'2020-02-01',	'2020-02-06'),
('Баранов П.Е.',	'Москва',	700,	'2020-02-14',	'2020-02-22'),
('Абрамова К.А.',	'Москва',	700,	'2020-02-23',	'2020-03-01'),
('Лебедев Т.К.',	'Москва',	700,	'2020-03-03',	'2020-03-06'),
('Колесов С.П.',	'Новосибирск',	450,	'2020-02-27',	'2020-03-12'),
('Семенов И.В.',	'Санкт-Петербург',	700,	'2020-03-29',	'2020-04-05'),
('Абрамова К.А.',	'Москва',	700,	'2020-04-06',	'2020-04-14'),
('Баранов П.Е.',	'Новосибирск',	450,	'2020-04-18',	'2020-05-04'),
('Лебедев Т.К.',	'Томск',	450,	'2020-05-20',	'2020-05-31'),
('Семенов И.В.',	'Санкт-Петербург',	700,	'2020-06-01',	'2020-06-03'),
('Абрамова К.А.',	'Санкт-Петербург',	700,	'2020-05-28',	'2020-06-04'),
('Федорова А.Ю.',	'Новосибирск',	450,	'2020-05-25',	'2020-06-04'),
('Колесов С.П.',	'Новосибирск',	450,	'2020-06-03',	'2020-06-12'),
('Федорова А.Ю.',	'Томск',	450,	'2020-06-20',	'2020-06-26'),
('Абрамова К.А.',	'Владивосток',	450,	'2020-07-02',	'2020-07-13'),
('Баранов П.Е.',	'Воронеж',	450,	'2020-07-19',	'2020-07-25')

select * from trip 

Задание
Вывести из таблицы trip информацию о командировках тех сотрудников, фамилия которых заканчивается на букву «а», в отсортированном по убыванию даты последнего дня командировки виде. В результат включить столбцы name, city, per_diem, date_first, date_last.

select name, city, per_diem,date_first, date_last
from trip 
where name like '_______а%'
order by date_last desc;


Задание
Вывести в алфавитном порядке фамилии и инициалы тех сотрудников, которые были в командировке в Москве.
select distinct name 
from trip 
where city='Москва'
order by name;


Задание
Для каждого города посчитать, сколько раз сотрудники в нем были.  Информацию вывести в отсортированном в алфавитном порядке по названию городов. Вычисляемый столбец назвать Количество. 
select city, count(city) as  Количество
from trip 
group by city
order by city;

Задание
Вывести два города, в которых чаще всего были в командировках сотрудники. Вычисляемый столбец назвать Количество.
select city, count(city) as  Количество
from trip 
group by city
order by Количество desc
limit 2;


Задание
Вывести информацию о командировках во все города кроме Москвы и Санкт-Петербурга (фамилии и инициалы сотрудников, город ,  длительность командировки в днях, при этом первый и последний день относится к периоду командировки). Последний столбец назвать Длительность. Информацию вывести в упорядоченном по убыванию длительности поездки, а потом по убыванию названий городов (в обратном алфавитном порядке).
select name, city,
datediff(date_last, date_first)+1 as Длительность
from trip
where city not in ('Москва','Санкт-Петербург')
order by Длительность desc

Задание
Вывести информацию о командировках сотрудника(ов), которые были самыми короткими по времени. В результат включить столбцы name, city, date_first, date_last.

select name, city, date_first, date_last
from trip
where datediff(date_last, date_first) = (
    select MIN(datediff(date_last, date_first))
    from trip
);


Вывести информацию о командировках, начало и конец которых относятся к одному месяцу (год может быть любой). В результат включить столбцы name, city, date_first, date_last. Строки отсортировать сначала  в алфавитном порядке по названию города, а затем по фамилии сотрудника .

select name,city,date_first,date_last
from trip
where month(date_first)=month(date_last)
order by city,name;


Задание
Вывести название месяца и количество командировок для каждого месяца. Считаем, что командировка относится к некоторому месяцу, если она началась в этом месяце. Информацию вывести сначала в отсортированном по убыванию количества, а потом в алфавитном порядке по названию месяца виде. Название столбцов – Месяц и Количество.

select monthname(date_first) as  Месяц  ,
count(month ( date_first)=1) as Количество
from trip 
group by Месяц 
order by Количество desc;


Задание
Вывести сумму суточных (произведение количества дней командировки и размера суточных) для командировок, первый день которых пришелся на февраль или март 2020 года. Значение суточных для каждой командировки занесено в столбец per_diem. Вывести фамилию и инициалы сотрудника, город, первый день командировки и сумму суточных. Последний столбец назвать Сумма. Информацию отсортировать сначала  в алфавитном порядке по фамилиям сотрудников, а затем по убыванию суммы суточных.
select name , city, date_first,
per_diem*(datediff(date_last, date_first)+1) as Сумма
from trip 
where month (date_first) between 2 and 3
order by name, Сумма desc

Задание
Вывести фамилию с инициалами и общую сумму суточных, полученных за все командировки для тех сотрудников, которые были в командировках больше чем 3 раза, в отсортированном по убыванию сумм суточных виде. Последний столбец назвать Сумма.
select name ,
sum((datediff (date_last, date_first) + 1) * per_diem) AS Сумма
from trip 
group by name
having count(date_first) >3
order by name;


1.7 Таблица "Нарушения ПДД", запросы корректировки
drop table fine

Задание
Создать таблицу fine следующей структуры:

CREATE TABLE fine
    (
        fine_id INT PRIMARY key AUTO_INCREMENT,
        name varchar(30),
        number_plate varchar(6),
        violation varchar(50),
        sum_fine decimal(8, 2),
        date_violation date,
        date_payment date
    );

Задание
В таблицу fine первые 5 строк уже занесены. Добавить в таблицу записи с ключевыми значениями 6, 7, 8.

INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', 500, '2020-01-12 ', '2020-01-17'),
       ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', 1000.00, '2020-01-14', '2020-02-27'),
       ('Яковлев Г.Р.', 'Т330ТТ', 'Превышение скорости(от 20 до 40)', 500.00, '2020-01-23', '2020-02-23'),
       ('Яковлев Г.Р.', 'М701АА', 'Превышение скорости(от 20 до 40)', NULL, '2020-01-12', NULL),
       ('Колесов С.П.', 'К892АХ', 'Превышение скорости(от 20 до 40)', NULL, '2020-02-01', NULL)
INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES       
       ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', NULL, '2020-02-14', NULL),
       ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL),
       ('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL)

INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', NULL, '2020-02-14 ', NULL),
       ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL),
       ('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL),
       ('Яковлев Г.Р.', 'М701АА', 'Превышение скорости(от 20 до 40)', NULL, '2020-01-12', NULL),
       ('Колесов С.П.', 'К892АХ', 'Превышение скорости(от 20 до 40)', NULL, '2020-02-01', NULL),
       ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', 500.00, '2020-01-12', '2020-01-17'),
       ('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', 1000.00, '2020-01-14', '2020-02-27'),
       ('Яковлев Г.Р.', 'Т330ТТ', 'Превышение скорости(от 20 до 40)', 500.00, '2020-01-23', '2020-02-23'),
       
       ;
select * from fine;

drop table traffic_violation
CREATE TABLE traffic_violation
    (
        violation_id INT PRIMARY key AUTO_INCREMENT,
        violation varchar(50),
        sum_fine decimal(8, 2)
    );

INSERT INTO traffic_violation (violation, sum_fine)
VALUES ('Превышение скорости(от 20 до 40)', 500),
       ('Превышение скорости(от 40 до 60)', 1000),
       ('Проезд на запрещающий сигнал', 1000);
       
select * from     traffic_violation; 

Задание
Занести в таблицу fine суммы штрафов, которые должен оплатить водитель, в соответствии с данными из таблицы traffic_violation. При этом суммы заносить только в пустые поля столбца  sum_fine.

Таблица traffic_violationсоздана и заполнена.

Важно! Сравнение значения столбца с пустым значением осуществляется с помощью оператора IS NULL.

update fine, traffic_violation
set fine.sum_fine=traffic_violation.sum_fine
where fine.violation=traffic_violation.violation and fine.sum_fine is null;
select * from fine;



Задание
Вывести фамилию, номер машины и нарушение только для тех водителей, которые на одной машине нарушили одно и то же правило   два и более раз. При этом учитывать все нарушения, независимо от того оплачены они или нет. Информацию отсортировать в алфавитном порядке, сначала по фамилии водителя, потом по номеру машины и, наконец, по нарушению.

select name, number_plate, violation
from fine 
group by name, number_plate, violation
having count(*)>1
order by name;

Задание
В таблице fine увеличить в два раза сумму неоплаченных штрафов для отобранных на предыдущем шаге записей. 

Пояснение !!! если не получается запрос или валидатор выдает ошибки, раскройте это пояснение!!!
Важно! Если в запросе используется несколько таблиц или запросов, включающих одинаковые поля, то применяется полное имя столбца, включающего название таблицы через символ «.». Например,  fine.name  и  query_in.name.


update fine, (select name, number_plate, violation
from fine
group by name, number_plate, violation
having count(*) > 1
order by name) as new_fine
set fine.sum_fine=fine.sum_fine*2
where date_payment is null and 
           new_fine.name=fine.name and 
           new_fine.number_plate=fine.number_plate and 
           new_fine.violation=fine.violation
select * from fine;     


drop table payment;
CREATE TABLE payment
    (
        payment_id INT PRIMARY key AUTO_INCREMENT,
        name varchar(30),
        number_plate varchar(6),
        violation varchar(50),
        date_violation date,
        date_payment date
    );
INSERT INTO payment (name, number_plate, violation,  date_violation, date_payment)
VALUES ('Яковлев Г.Р.', 'М701АА', 'Превышение скорости(от 20 до 40)',  '2020-01-12', '2020-01-22'),
	('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60',  '2020-02-14', '2020-03-06'),
('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигна',  '2020-03-03', '2020-03-23')
select * from payment;

Задание
Водители оплачивают свои штрафы. В таблице payment занесены даты их оплаты:

update fine, payment
set fine.date_payment=payment.date_payment,
fine.sum_fine=if(datediff(payment.date_payment, fine.date_violation) <= 20, fine.sum_fine/2, fine.sum_fine)
where fine.name=payment.name and 
fine.number_plate=payment.number_plate and 
fine.violation=payment.violation and  
fine.date_payment is null;

select * from fine;

Задание
Создать новую таблицу back_payment, куда внести информацию о неоплаченных штрафах (Фамилию и инициалы водителя, номер машины, нарушение, сумму штрафа  и  дату нарушения) из таблицы fine.
drop table back_payment
create table back_payment as
(select fine.name , fine.number_plate,fine.violation,fine.sum_fine,fine.date_violation,date_payment
from fine
where fine.date_payment is null);
select * from back_payment;
