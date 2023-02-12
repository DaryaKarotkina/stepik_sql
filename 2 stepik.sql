use stepik

2.1 Связи между таблицами

Задание
Создать таблицу author следующей структуры:
drop table author
create table author(
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
    );
    
Заполнить таблицу author. В нее включить следующих авторов:
Булгаков М.А.
Достоевский Ф.М.
Есенин С.А.
Пастернак Б.Л.  
insert into author (name_author)
values
('Булгаков М.А.'),
('Достоевский Ф.М.'),
('Есенин С.А.'),
('Пастернак Б.Л.')
select * from author;


Задание
Перепишите запрос на создание таблицы book , чтобы ее структура соответствовала структуре, показанной на логической схеме (таблица genre уже создана, порядок следования столбцов - как на логической схеме в таблице book, genre_id  - внешний ключ) . Для genre_id ограничение о недопустимости пустых значений не задавать. В качестве главной таблицы для описания поля  genre_idиспользовать таблицу genre следующей структуры:
drop table book;
drop table genre;
create table genre(
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name_genre VARCHAR(30)
    );
insert into genre (name_genre)
values   
('Роман'),
('Поэзия')

select * from genre;
drop table book;
CREATE TABLE book (
      book_id INT PRIMARY KEY AUTO_INCREMENT , 
      title VARCHAR(50), 
      author_id INT NOT NULL, 
      genre_id INT,
      price DECIMAL(8,2), 
      amount INT, 
      FOREIGN KEY (author_id)  REFERENCES author (author_id),
      FOREIGN KEY (genre_id)  REFERENCES genre (genre_id)
)
select * from book;


Задание
Создать таблицу book той же структуры, что и на предыдущем шаге. Будем считать, что при удалении автора из таблицы author, должны удаляться все записи о книгах из таблицы book, написанные этим автором. А при удалении жанра из таблицы genre для соответствующей записи book установить значение Null в столбце genre_id. 
drop table book;
CREATE TABLE book (
      book_id  INT PRIMARY KEY AUTO_INCREMENT , 
      title VARCHAR(50), 
      author_id INT, 
      genre_id INT,
      price DECIMAL(8,2), 
      amount INT, 
      FOREIGN KEY (author_id)  REFERENCES author (author_id) ON DELETE CASCADE,
      FOREIGN KEY (genre_id)  REFERENCES genre (genre_id) ON DELETE set null
);

CREATE TABLE book (
      book_id INT PRIMARY KEY AUTO_INCREMENT, 
      title VARCHAR(50), 
      author_id INT NOT NULL, 
      genre_id INT,
      price DECIMAL(8,2), 
      amount INT, 
      FOREIGN KEY (author_id)  REFERENCES author (author_id),
      FOREIGN KEY (genre_id)  REFERENCES genre (genre_id)
)
select * from book;
select * from genre;
select * from author;

Задание
Добавьте три последние записи (с ключевыми значениями 6, 7, 8) в таблицу book, первые 5 записей уже добавлены:

select * from book;

insert into book ( title, author_id, genre_id, price, amount)
values 
    ('Мастер и Маргарита', 1, 1, 670.99, 3),
	('Белая гвардия', 1, 1, 540.50, 5),
	('Идиот', 2, 1, 460.00, 10),
	('Братья Карамазовы', 2, 1, 799.01, 3),
	('Игрок', 2, 1, 480.50, 10)


insert into book ( title, author_id, genre_id, price, amount)
values 
    ('Стихотворения и поэмы', 3, 2, 650.00, 15),
    ( 'Черный человек', 3, 2, 570.20, 6),
    ( 'Лирика', 4, 2, 518.99, 2)
    
select * from book;    


2.2 Запросы на выборку, соединение таблиц

select * from author a 
insert into author (name_author)
values
('Лермонтов М.Ю.')
select * from author;

select * from genre g 
insert into genre (name_genre)
values
('Приключения')

select * from book b 

Задание
Вывести название, жанр и цену тех книг, количество которых больше 8, в отсортированном по убыванию цены виде.
select title, name_genre,price
from book inner join genre 
on book.genre_id=genre.genre_id
where amount>8
order by price desc;


Вывести все жанры, которые не представлены в книгах на складе.
select name_genre
from genre left join book
on genre.genre_id=book.genre_id
where amount is null;


Задание
Необходимо в каждом городе провести выставку книг каждого автора в течение 2020 года. Дату проведения выставки выбрать случайным образом. Создать запрос, который выведет город, автора и дату проведения выставки. Последний столбец назвать Дата. Информацию вывести, отсортировав сначала в алфавитном порядке по названиям городов, а потом по убыванию дат проведения выставок.
drop table city;
create table city(
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    name_city VARCHAR(30)
    );
insert into city(name_city)  
values 
('Москва'),
('Санкт-Петербург'),
('Владивосток')
select * from city;

select name_city, name_author,
DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND()*365) DAY) AS Дата
from city, author 
order by name_city,Дата desc


Задание
 Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман» в отсортированном по названиям книг виде.
 select name_genre, title, name_author
 from genre inner join book 
 on genre.genre_id=book.genre_id
 inner join author on author.author_id=book.author_id
 where name_genre='Роман'
 order by title;
 

Задание
Посчитать количество экземпляров  книг каждого автора из таблицы author.  Вывести тех авторов,  количество книг которых меньше 10, в отсортированном по возрастанию количества виде. Последний столбец назвать Количество.
select name_author, sum(amount) as Количество
from author left join book 
on author.author_id=book.author_id
group by name_author
having sum(amount)<10 or sum(amount) is null
order by Количество 



Задание
Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре. Поскольку у нас в таблицах так занесены данные, что у каждого автора книги только в одном жанре,  для этого запроса внесем изменения в таблицу book. Пусть у нас  книга Есенина «Черный человек» относится к жанру «Роман», а книга Булгакова «Белая гвардия» к «Приключениям» (эти изменения в таблицы уже внесены).

select name_author from book
inner join author
on author.author_id=book.author_id
group by name_author
having count(distinct genre_id) = 1


Задание
Вывести информацию о книгах (название книги, фамилию и инициалы автора, название жанра, цену и количество экземпляров книги), написанных в самых популярных жанрах, в отсортированном в алфавитном порядке по названию книг виде. Самым популярным считать жанр, общее количество экземпляров книг которого на складе максимально.
select  book.title, author.name_author, genre.name_genre, book.price, book.amount
from author 
inner join book on author.author_id = book.author_id
inner join genre on  book.genre_id = genre.genre_id
group by name_author,name_genre, genre.genre_id,book.title,book.price, book.amount
having genre.genre_id in
         (select query_in_1.genre_id
          from 
              (select  genre_id, sum(amount) as sum_amount
                from book
                group by genre_id
               )query_in_1
          inner join
              ( select genre_id, sum(amount) as sum_amount
                from book
                group by genre_id
                order by sum_amount desc
                limit 1
               ) query_in_2
          on query_in_1.sum_amount= query_in_2.sum_amount
         )
         order by book.title
         
         
 Задание
Если в таблицах supply  и book есть одинаковые книги, которые имеют равную цену,  вывести их название и автора, а также посчитать общее количество экземпляров книг в таблицах supply и book,  столбцы назвать Название, Автор  и Количество.

select * from supply
select * from author 
select * from book

select book.title as Название, author.name_author as Автор, supply.amount+ book.amount as Количество
from author
inner join book using (author_id)
inner join supply on book.title=supply.title
and author.name_author=supply.author 
where book.price=supply.price
group by book.title,author.author_id, supply.amount, book.amount
     

2.3 Запросы корректировки, соединение таблиц

Задание
Для книг, которые уже есть на складе (в таблице book), но по другой цене, чем в поставке (supply),  необходимо в таблице book увеличить количество на значение, указанное в поставке,  и пересчитать цену. А в таблице  supply обнулить количество этих книг. Формула для пересчета цены:

    
select * from book 
select * from supply 
select * from author
select * from genre


update book 
inner join author on book.author_id=author.author_id
inner join supply on book.title=supply.title and supply.author = author.name_author
                         
set book.price = if (book.price != supply.price ,(book.amount * book.price + supply.amount * supply.price)/(book.amount + supply.amount),book.price ),
    book.amount =book.amount + supply.amount ,
    supply.amount = 0   
where book.price != supply.price;

select * from book;

select * from supply;              

Задание
Включить новых авторов в таблицу author с помощью запроса на добавление, а затем вывести все данные из таблицы author.  Новыми считаются авторы, которые есть в таблице supply, но нет в таблице author.
insert into author(author_id, name_author)
select supply_id as author_id, author from supply
left join author
on supply.author=author.name_author
where author_id is null
select * from author;

Добавить новые книги из таблицы supply в таблицу book на основе сформированного выше запроса. Затем вывести для просмотра таблицу book.
insert into book(title, author_id, price, amount)
select title, author_id, price, amount
from  
    author 
    inner join  supply on author.name_author = supply.author
where amount <> 0;
select * from book;

 Занести для книги «Стихотворения и поэмы» Лермонтова жанр «Поэзия», а для книги «Остров сокровищ» Стивенсона - «Приключения». (Использовать два запроса).
 update book
 set genre_id=(
 select genre_id
 from genre
 where name_genre='Поэзия')
 where  genre_id is null and book_id=6
 
 update book
 set genre_id=(
 select genre_id
 from genre
 where name_genre='Приключения')
 where genre_id is null and book_id=14
 select * from book
 select * from author
 
 
 Задание
 Удалить всех авторов и все их книги, общее количество книг которых меньше 20.

 delete from author
 where author_id in ( select author_id from book
 group by author_id having sum(amount)<20);
 select * from author;

 
 Задание                   
 Удалить все жанры, к которым относится меньше 4-х книг. В таблице book для этих жанров установить значение Null.           
 select * from genre
 delete from genre
 where genre_id in(
select genre_id 
group by genre_id
having count(genre_id) <3
)
select * from genre;
Задание
Удалить всех авторов, которые пишут в жанре "Поэзия". Из таблицы book удалить все книги этих авторов. В запросе для отбора авторов использовать полное название жанра, а не его id.

delete from author
using author 
inner join  book on author.author_id = book.author_id
where book.genre_id in (select name_genre
from genre
where name_genre='Поэзия') 

select * from author;
select * from book;


2.4 База данных «Интернет-магазин книг», запросы на выборку
create table new_author(
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
    );
insert into new_author (name_author)
values
('Булгаков М.А.'),
('Достоевский Ф.М.'),
('Есенин С.А.'),
('Пастернак Б.Л.'),
('Лермонтов М.Ю.')
select * from new_author;

CREATE TABLE new_genre(
    genre_id INT PRIMARY KEY AUTO_INCREMENT, 
    name_genre VARCHAR(30)
);

insert into new_genre (name_genre)
values
('Роман'),
('Поэзия'),
('Приключения')
select * from new_genre ;

CREATE TABLE new_book (
      book_id INT PRIMARY KEY AUTO_INCREMENT, 
      title VARCHAR(50), 
      author_id INT, 
      genre_id INT,
      price DECIMAL(8,2), 
      amount INT, 
      FOREIGN KEY (author_id)  REFERENCES new_author (author_id) ON DELETE CASCADE,
      FOREIGN KEY (genre_id)  REFERENCES new_genre (genre_id) ON DELETE set null
);
insert into new_book (book_id, title, author_id, genre_id, price, amount)
values 
    (1, 'Мастер и Маргарита', 1, 1, 670.99, 3),
    (2, 'Белая гвардия', 1, 1, 540.50, 5),
    (3, 'Идиот', 2, 1, 460.00, 10),
    (4, 'Братья Карамазовы', 2, 1, 799.01, 2),
    (5, 'Игрок', 2, 1, 	480.50, 10),
    (6, 'Стихотворения и поэмы', 3, 2, 650.00, 15),
    (7, 'Черный человек', 3, 2, 570.20, 6),
    (8, 'Лирика', 4, 2, 518.99, 2);
select * from new_book;    

create table new_city(
 	city_id INT PRIMARY KEY AUTO_INCREMENT, 
    name_city VARCHAR(30), 
    days_delivery INT
);

insert into new_city(city_id,name_city,days_delivery)
values
(1,'Москва',5),
(2,'Санкт-Петербург',3),
(3,'Владивосток',12);

select * from new_city; 

create table new_client(
	client_id INT PRIMARY key auto_increment,
	name_client VARCHAR(50),
	city_id int,
	email VARCHAR(30)
);

insert into new_client(client_id ,name_client,city_id,email)
values
(1,'Баранов Павел',3,'baranov@test'),
(2,'Абрамова Катя',1,'abramova@test'),
(3,'Семенонов Иван',2,'semenov@test'),
(4,'Яковлева Галина',1,'yakovleva@test');

select * from new_client;
drop table new_buy;
create table new_buy(
	buy_id INT PRIMARY key auto_increment,
	buy_description VARCHAR(100),
	client_id int
);
insert into new_buy(buy_id,buy_description,client_id)
values
(1,'Доставка только вечером',1),
(2,null,3),
(3,'Упаковать каждую книгу по отдельности',2),
(4,null,1);
select * from new_buy;

create table new_buy_book(
	buy_book_id INT PRIMARY key auto_increment,
	buy_id int,
	book_id int, 
	amount int
);
insert into new_buy_book(buy_book_id,buy_id,book_id,amount)
values
(1,1,1,1),
(2,1,7,2),
(3,1,3,1),
(4,2,8,2),
(5,3,3,2),
(6,3,2,1),
(7,3,1,1),
(8,4,5,1);
select * from new_buy_book;

create table new_step(
	step_id INT PRIMARY key auto_increment,
	name_step VARCHAR(30)
);
insert into new_step(step_id,name_step)
values
(1,'Оплата'),
(2,'Упаковка'),
(3,'Транспортировка'),
(4,'Доставка');
select * from new_step;
drop table new_buy_step;
create table new_buy_step(
	buy_step_id INT PRIMARY key auto_increment,
	buy_id int,
	step_id int,
	date_step_beg	date,
	date_step_end date
);
insert into new_buy_step(buy_step_id,buy_id,step_id,date_step_beg,date_step_end)
values
(1,1,1,'2020-02-20','2020-02-20'),
(2,1,2,'2020-02-20','2020-02-21'),
(3,1,3,'2020-02-22','2020-03-07'),
(4,1,4,'2020-03-08','2020-03-08'),
(5,2,1,'2020-02-28','2020-02-28'),
(6,2,2,'2020-02-29','2020-03-01'),
(7,2,3,'2020-03-02',null),
(8,2,4,null,null),
(9,3,1,'2020-03-05','2020-03-05'),
(10,3,2,'2020-03-05','2020-03-06'),
(11,3,3,'2020-03-06','2020-03-10'),
(12,3,4,'2020-03-11',null),
(13,4,1,'2020-03-20',null),
(14,4,2,null,null),
(15,4,3,null,null),
(16,4,4,null,null);
select * from new_buy_step;


Задание
Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал) в отсортированном по номеру заказа и названиям книг виде.

SELECT new_buy_book.buy_id ,new_book.title,new_book.price,new_buy_book.amount 
FROM 
    new_client
    INNER JOIN new_buy ON new_client.client_id = new_buy.client_id
    INNER JOIN new_buy_book ON new_buy_book.buy_id = new_buy.buy_id
    INNER JOIN new_book ON new_buy_book.book_id=new_book.book_id
WHERE new_client.client_id =1
order by new_buy_book.buy_id,new_book.title 

Задание
Посчитать, сколько раз была заказана каждая книга, для книги вывести ее автора (нужно посчитать, в каком количестве заказов фигурирует каждая книга).  Вывести фамилию и инициалы автора, название книги, последний столбец назвать Количество. Результат отсортировать сначала  по фамилиям авторов, а потом по названиям книг.

select new_author.name_author,new_book.title, count(new_buy_book.amount) as Количество
from new_author 
inner join new_book on new_author.author_id =new_book.author_id 
left join new_buy_book on new_book.book_id =new_buy_book.book_id 
group by new_author.name_author,new_book.title
order by new_author.name_author;

Задание 
Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине. Указать количество заказов в каждый город, этот столбец назвать Количество. Информацию вывести по убыванию количества заказов, а затем в алфавитном порядке по названию городов.

select new_city.name_city ,count(new_city.name_city) as Количество
from new_city 
inner join new_client on new_city.city_id = new_client.city_id 
inner join new_buy on new_client.client_id=new_buy.client_id 
group by new_city.name_city;



Задание
Вывести номера всех оплаченных заказов и даты, когда они были оплачены.
select new_buy_step.buy_id ,new_buy_step.date_step_end 
from new_buy_step
where new_buy_step.step_id =1 and new_buy_step.date_step_end is not null ;

Задание
Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) и его стоимость (сумма произведений количества заказанных книг и их цены), в отсортированном по номеру заказа виде. Последний столбец назвать Стоимость.

select new_buy_book.buy_id , new_client.name_client ,sum(new_book.price *new_buy_book.amount) as Стоимость
from new_book 
left join new_buy_book on new_book.book_id =new_buy_book.book_id 
inner join new_buy on new_buy_book.buy_id=new_buy.buy_id 
left join new_client on new_buy.client_id =new_client.client_id  
group by new_buy_book.buy_id
order by new_buy_book.buy_id;

Задание
Вывести номера заказов (buy_id) и названия этапов,  на которых они в данный момент находятся. Если заказ доставлен –  информацию о нем не выводить. Информацию отсортировать по возрастанию buy_id.

select new_buy_step.buy_id ,new_step.name_step
from new_buy_step 
right join new_step on new_buy_step.step_id =new_step.step_id 
where new_buy_step.date_step_end is null and new_buy_step.date_step_beg is not null
order by new_buy_step.buy_id ;

Задание
В таблице city для каждого города указано количество дней, за которые заказ может быть доставлен в этот город (рассматривается только этап Транспортировка). Для тех заказов, которые прошли этап транспортировки, вывести количество дней за которое заказ реально доставлен в город. А также, если заказ доставлен с опозданием, указать количество дней задержки, в противном случае вывести 0. В результат включить номер заказа (buy_id), а также вычисляемые столбцы Количество_дней и Опоздание. Информацию вывести в отсортированном по номеру заказа виде.

select new_buy.buy_id , 
datediff(new_buy_step.date_step_end,new_buy_step.date_step_beg) as Количество_дней ,
case when
(datediff(new_buy_step.date_step_end,new_buy_step.date_step_beg)-new_city.days_delivery)<1 then 0 else
(datediff(new_buy_step.date_step_end,new_buy_step.date_step_beg)-new_city.days_delivery) end as Опоздание
from new_city 
inner join new_client on new_city.city_id =new_client.city_id 
inner join new_buy on new_client.city_id =new_buy.client_id 
inner join new_buy_step on new_buy.buy_id =new_buy_step.buy_id 
inner join new_step on new_buy_step.step_id =new_step.step_id 
where new_step.name_step ='Транспортировка' and new_buy_step.date_step_end is not null
group by new_buy.buy_id 

Задание
Выбрать всех клиентов, которые заказывали книги Достоевского, информацию вывести в отсортированном по алфавиту виде. В решении используйте фамилию автора, а не его id.

select new_client.name_client 
from new_author 
inner join new_book on new_author.author_id =new_book.author_id 
inner join new_buy_book on new_book.book_id=new_buy_book.book_id 
inner join new_buy on new_buy_book.buy_id =new_buy.buy_id 
inner join new_client on new_buy.client_id =new_client.client_id 
where new_author.name_author ='Достоевский Ф.М.'
group by new_client.name_client 
order by new_client.name_client ;

select * from new_author;
Задание
Вывести жанр (или жанры), в котором было заказано больше всего экземпляров книг, указать это количество. Последний столбец назвать Количество.

select new_genre.name_genre, sum(new_buy_book.amount) as Количество
from new_genre 
inner join new_book on  new_genre.genre_id =new_book.genre_id 
inner join new_buy_book on new_book.book_id=new_buy_book.book_id 
group by new_genre.name_genre 
;

select new_genre.name_genre, sum(new_buy_book.amount) as Количество
from new_genre 
inner join new_book on  new_genre.genre_id =new_book.genre_id 
inner join new_buy_book on new_book.book_id=new_buy_book.book_id 
group by new_genre.name_genre 
having sum(new_buy_book.amount)=(
select sum(new_buy_book.amount) 
from new_book 
inner join new_buy_book on  new_book.book_id =new_buy_book.book_id 
group by new_book.genre_id 
limit 1
);

Задание****
Этот шаг добавлен по рекомендациям пользователей: Тимур Timmmyyy, Todor Illia, Лёха Last name, Игорь Владимирович Лапшин и др.
Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы. Для этого вывести год, месяц, сумму выручки в отсортированном сначала по возрастанию месяцев, затем по возрастанию лет виде. Название столбцов: Год, Месяц, Сумма.

SELECT YEAR(date_payment) AS Год,
	   MONTHNAME(date_payment) AS Месяц,
	   SUM(amount*price) AS Сумма
FROM buy_archive
GROUP BY Год, Месяц

UNION ALL
SELECT YEAR(date_step_end) AS Год,
	   MONTHNAME(date_step_end) AS Месяц,
	   SUM(bb.amount*price) AS Сумма
FROM buy_book bb
      JOIN buy_step bs ON bb.buy_id = bs.buy_id 
  				  AND bs.date_step_end 
  				  AND bs.step_id = 1
      JOIN book USING(book_id)
GROUP BY Год, Месяц
ORDER BY Месяц, Год;

Задание ***
Для каждой отдельной книги необходимо вывести информацию о количестве проданных экземпляров и их стоимости за 2020 и 2019 год . Вычисляемые столбцы назвать Количество и Сумма. Информацию отсортировать по убыванию стоимости.
WITH Title_sales AS (
SELECT title, buy_book.amount, price
FROM book
    INNER JOIN buy_book USING(book_id)
    INNER JOIN buy USING(buy_id) 
    INNER JOIN buy_step USING(buy_id)
    INNER JOIN step USING(step_id)
WHERE  date_step_end IS NOT Null and name_step = "Оплата"
    
UNION ALL
    
SELECT title, buy_archive.amount, buy_archive.price
    FROM buy_archive
    INNER JOIN book USING(book_id)
)
SELECT title, SUM(amount) AS Количество, SUM(amount*price) AS Сумма
FROM Title_sales
GROUP BY title
ORDER BY Сумма DESC;


2.5 База данных «Интернет-магазин книг», запросы корректировки

Задание
Включить нового человека в таблицу с клиентами. Его имя Попов Илья, его email popov@test, проживает он в Москве.


insert into new_client (name_client,city_id ,email)
SELECT 'Попов Илья', city_id, 'popov@test'
FROM new_city
WHERE name_city = 'Москва';
select * from new_client;

Задание
Создать новый заказ для Попова Ильи. Его комментарий для заказа: «Связаться со мной по вопросу доставки».

insert into new_buy (buy_description,client_id)
SELECT 'Связаться со мной по вопросу доставки',client_id
FROM new_client
WHERE name_client = 'Попов Илья';
select * from new_buy;


Задание
В таблицу buy_book добавить заказ с номером 5. Этот заказ должен содержать книгу Пастернака «Лирика» в количестве двух экземпляров и книгу Булгакова «Белая гвардия» в одном экземпляре.
insert into new_buy_book (buy_id, book_id,amount)
select 5, book_id ,2
from new_book , new_author 
where name_author like 'Пастернак%' and title ='Лирика';

insert into new_buy_book (buy_id, book_id,amount)
select 5, book_id ,1
from new_book , new_author 
where name_author like 'Булгаков%' and title ='Белая гвардия';


select * from new_buy_book;


Задание
Количество тех книг на складе, которые были включены в заказ с номером 5, уменьшить на то количество, которое в заказе с номером 5  указано.
update new_book 
inner join new_buy_book on new_book.book_id =new_buy_book.book_id 
set new_book.amount =new_book.amount-new_buy_book.amount 
where new_buy_book.book_id =5;
select * from new_book;


Задание
Создать счет (таблицу buy_pay) на оплату заказа с номером 5, в который включить название книг, их автора, цену, количество заказанных книг и  стоимость. Последний столбец назвать Стоимость. Информацию в таблицу занести в отсортированном по названиям книг виде.

create table new_buy_pay as
select new_book.title, new_author.name_author ,new_book.price,new_buy_book.amount ,new_book.price*new_buy_book.amount  as Стоимость
from new_author
inner join new_book using (author_id)
inner join new_buy_book using (book_id)
where new_buy_book.buy_id =5
order by title;
select * from new_buy_pay;

Задание
Создать общий счет (таблицу buy_pay) на оплату заказа с номером 5. Куда включить номер заказа, количество книг в заказе (название столбца Количество) и его общую стоимость (название столбца Итого). Для решения используйте ОДИН запрос.

drop table new_buy_pay;

create table new_buy_pay as
select new_buy_book.buy_id , sum(new_buy_book.amount) as Количество,
sum(new_book.price *new_buy_book.amount) as Итого
from new_book 
inner join new_buy_book using (book_id)
where new_buy_book.buy_id =5

select *from new_buy_pay;


Задание
В таблицу buy_step для заказа с номером 5 включить все этапы из таблицы step, которые должен пройти этот заказ. В столбцы date_step_beg и date_step_end всех записей занести Null.
insert into new_buy_step(buy_id,step_id)
select new_buy.buy_id ,new_step.step_id
from new_buy 
cross join new_step 
where new_buy.buy_id=5;
select * from new_buy_step;


Задание
В таблицу buy_step занести дату 12.04.2020 выставления счета на оплату заказа с номером 5.

Правильнее было бы занести не конкретную, а текущую дату. Это можно сделать с помощью функции Now(). Но при этом в разные дни будут вставляться разная дата, и задание нельзя будет проверить, поэтому  вставим дату 12.04.2020.

update new_buy_step
set date_step_beg='2020-04-12'
where buy_id=5 and step_id=1;
select * from new_buy_step;



Задание
Завершить этап «Оплата» для заказа с номером 5, вставив в столбец date_step_end дату 13.04.2020, и начать следующий этап («Упаковка»), задав в столбце date_step_beg для этого этапа ту же дату.
Реализовать два запроса для завершения этапа и начала следующего. Они должны быть записаны в общем виде, чтобы его можно было применять для любых этапов, изменив только текущий этап. Для примера пусть это будет этап «Оплата».

update new_buy_step
set date_step_end='2020-04-13'
where buy_id=5 and step_id=1;

update new_buy_step
set date_step_beg='2020-04-13'
where buy_id=5 and step_id=2;
select * from new_buy_step
where buy_step_id in (17,18,20);