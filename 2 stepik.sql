use stepik

2.1 ����� ����� ���������

�������
������� ������� author ��������� ���������:
drop table author
create table author(
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
    );
    
��������� ������� author. � ��� �������� ��������� �������:
�������� �.�.
����������� �.�.
������ �.�.
��������� �.�.  
insert into author (name_author)
values
('�������� �.�.'),
('����������� �.�.'),
('������ �.�.'),
('��������� �.�.')
select * from author;


�������
���������� ������ �� �������� ������� book , ����� �� ��������� ��������������� ���������, ���������� �� ���������� ����� (������� genre ��� �������, ������� ���������� �������� - ��� �� ���������� ����� � ������� book, genre_id  - ������� ����) . ��� genre_id ����������� � �������������� ������ �������� �� ��������. � �������� ������� ������� ��� �������� ����  genre_id������������ ������� genre ��������� ���������:
drop table book;
drop table genre;
create table genre(
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name_genre VARCHAR(30)
    );
insert into genre (name_genre)
values   
('�����'),
('������')

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


�������
������� ������� book ��� �� ���������, ��� � �� ���������� ����. ����� �������, ��� ��� �������� ������ �� ������� author, ������ ��������� ��� ������ � ������ �� ������� book, ���������� ���� �������. � ��� �������� ����� �� ������� genre ��� ��������������� ������ book ���������� �������� Null � ������� genre_id. 
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

�������
�������� ��� ��������� ������ (� ��������� ���������� 6, 7, 8) � ������� book, ������ 5 ������� ��� ���������:

select * from book;

insert into book ( title, author_id, genre_id, price, amount)
values 
    ('������ � ���������', 1, 1, 670.99, 3),
	('����� �������', 1, 1, 540.50, 5),
	('�����', 2, 1, 460.00, 10),
	('������ ����������', 2, 1, 799.01, 3),
	('�����', 2, 1, 480.50, 10)


insert into book ( title, author_id, genre_id, price, amount)
values 
    ('������������� � �����', 3, 2, 650.00, 15),
    ( '������ �������', 3, 2, 570.20, 6),
    ( '������', 4, 2, 518.99, 2)
    
select * from book;    


2.2 ������� �� �������, ���������� ������

select * from author a 
insert into author (name_author)
values
('��������� �.�.')
select * from author;

select * from genre g 
insert into genre (name_genre)
values
('�����������')

select * from book b 

�������
������� ��������, ���� � ���� ��� ����, ���������� ������� ������ 8, � ��������������� �� �������� ���� ����.
select title, name_genre,price
from book inner join genre 
on book.genre_id=genre.genre_id
where amount>8
order by price desc;


������� ��� �����, ������� �� ������������ � ������ �� ������.
select name_genre
from genre left join book
on genre.genre_id=book.genre_id
where amount is null;


�������
���������� � ������ ������ �������� �������� ���� ������� ������ � ������� 2020 ����. ���� ���������� �������� ������� ��������� �������. ������� ������, ������� ������� �����, ������ � ���� ���������� ��������. ��������� ������� ������� ����. ���������� �������, ������������ ������� � ���������� ������� �� ��������� �������, � ����� �� �������� ��� ���������� ��������.
drop table city;
create table city(
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    name_city VARCHAR(30)
    );
insert into city(name_city)  
values 
('������'),
('�����-���������'),
('�����������')
select * from city;

select name_city, name_author,
DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND()*365) DAY) AS ����
from city, author 
order by name_city,���� desc


�������
 ������� ���������� � ������ (����, �����, �����), ����������� � �����, ����������� ����� ������ � ��������������� �� ��������� ���� ����.
 select name_genre, title, name_author
 from genre inner join book 
 on genre.genre_id=book.genre_id
 inner join author on author.author_id=book.author_id
 where name_genre='�����'
 order by title;
 

�������
��������� ���������� �����������  ���� ������� ������ �� ������� author.  ������� ��� �������,  ���������� ���� ������� ������ 10, � ��������������� �� ����������� ���������� ����. ��������� ������� ������� ����������.
select name_author, sum(amount) as ����������
from author left join book 
on author.author_id=book.author_id
group by name_author
having sum(amount)<10 or sum(amount) is null
order by ���������� 



�������
������� � ���������� ������� ���� �������, ������� ����� ������ � ����� �����. ��������� � ��� � �������� ��� �������� ������, ��� � ������� ������ ����� ������ � ����� �����,  ��� ����� ������� ������ ��������� � ������� book. ����� � ���  ����� ������� ������� ������� ��������� � ����� ������, � ����� ��������� ������ �������� � ������������� (��� ��������� � ������� ��� �������).

select name_author from book
inner join author
on author.author_id=book.author_id
group by name_author
having count(distinct genre_id) = 1


�������
������� ���������� � ������ (�������� �����, ������� � �������� ������, �������� �����, ���� � ���������� ����������� �����), ���������� � ����� ���������� ������, � ��������������� � ���������� ������� �� �������� ���� ����. ����� ���������� ������� ����, ����� ���������� ����������� ���� �������� �� ������ �����������.
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
         
         
 �������
���� � �������� supply  � book ���� ���������� �����, ������� ����� ������ ����,  ������� �� �������� � ������, � ����� ��������� ����� ���������� ����������� ���� � �������� supply � book,  ������� ������� ��������, �����  � ����������.

select * from supply
select * from author 
select * from book

select book.title as ��������, author.name_author as �����, supply.amount+ book.amount as ����������
from author
inner join book using (author_id)
inner join supply on book.title=supply.title
and author.name_author=supply.author 
where book.price=supply.price
group by book.title,author.author_id, supply.amount, book.amount
     

2.3 ������� �������������, ���������� ������

�������
��� ����, ������� ��� ���� �� ������ (� ������� book), �� �� ������ ����, ��� � �������� (supply),  ���������� � ������� book ��������� ���������� �� ��������, ��������� � ��������,  � ����������� ����. � � �������  supply �������� ���������� ���� ����. ������� ��� ��������� ����:

    
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

�������
�������� ����� ������� � ������� author � ������� ������� �� ����������, � ����� ������� ��� ������ �� ������� author.  ������ ��������� ������, ������� ���� � ������� supply, �� ��� � ������� author.
insert into author(author_id, name_author)
select supply_id as author_id, author from supply
left join author
on supply.author=author.name_author
where author_id is null
select * from author;

�������� ����� ����� �� ������� supply � ������� book �� ������ ��������������� ���� �������. ����� ������� ��� ��������� ������� book.
insert into book(title, author_id, price, amount)
select title, author_id, price, amount
from  
    author 
    inner join  supply on author.name_author = supply.author
where amount <> 0;
select * from book;

 ������� ��� ����� �������������� � ������ ���������� ���� ��������, � ��� ����� ������� ��������� ���������� - �������������. (������������ ��� �������).
 update book
 set genre_id=(
 select genre_id
 from genre
 where name_genre='������')
 where  genre_id is null and book_id=6
 
 update book
 set genre_id=(
 select genre_id
 from genre
 where name_genre='�����������')
 where genre_id is null and book_id=14
 select * from book
 select * from author
 
 
 �������
 ������� ���� ������� � ��� �� �����, ����� ���������� ���� ������� ������ 20.

 delete from author
 where author_id in ( select author_id from book
 group by author_id having sum(amount)<20);
 select * from author;

 
 �������                   
 ������� ��� �����, � ������� ��������� ������ 4-� ����. � ������� book ��� ���� ������ ���������� �������� Null.           
 select * from genre
 delete from genre
 where genre_id in(
select genre_id 
group by genre_id
having count(genre_id) <3
)
select * from genre;
�������
������� ���� �������, ������� ����� � ����� "������". �� ������� book ������� ��� ����� ���� �������. � ������� ��� ������ ������� ������������ ������ �������� �����, � �� ��� id.

delete from author
using author 
inner join  book on author.author_id = book.author_id
where book.genre_id in (select name_genre
from genre
where name_genre='������') 

select * from author;
select * from book;


2.4 ���� ������ ���������-������� ����, ������� �� �������
create table new_author(
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
    );
insert into new_author (name_author)
values
('�������� �.�.'),
('����������� �.�.'),
('������ �.�.'),
('��������� �.�.'),
('��������� �.�.')
select * from new_author;

CREATE TABLE new_genre(
    genre_id INT PRIMARY KEY AUTO_INCREMENT, 
    name_genre VARCHAR(30)
);

insert into new_genre (name_genre)
values
('�����'),
('������'),
('�����������')
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
    (1, '������ � ���������', 1, 1, 670.99, 3),
    (2, '����� �������', 1, 1, 540.50, 5),
    (3, '�����', 2, 1, 460.00, 10),
    (4, '������ ����������', 2, 1, 799.01, 2),
    (5, '�����', 2, 1, 	480.50, 10),
    (6, '������������� � �����', 3, 2, 650.00, 15),
    (7, '������ �������', 3, 2, 570.20, 6),
    (8, '������', 4, 2, 518.99, 2);
select * from new_book;    

create table new_city(
 	city_id INT PRIMARY KEY AUTO_INCREMENT, 
    name_city VARCHAR(30), 
    days_delivery INT
);

insert into new_city(city_id,name_city,days_delivery)
values
(1,'������',5),
(2,'�����-���������',3),
(3,'�����������',12);

select * from new_city; 

create table new_client(
	client_id INT PRIMARY key auto_increment,
	name_client VARCHAR(50),
	city_id int,
	email VARCHAR(30)
);

insert into new_client(client_id ,name_client,city_id,email)
values
(1,'������� �����',3,'baranov@test'),
(2,'�������� ����',1,'abramova@test'),
(3,'��������� ����',2,'semenov@test'),
(4,'�������� ������',1,'yakovleva@test');

select * from new_client;
drop table new_buy;
create table new_buy(
	buy_id INT PRIMARY key auto_increment,
	buy_description VARCHAR(100),
	client_id int
);
insert into new_buy(buy_id,buy_description,client_id)
values
(1,'�������� ������ �������',1),
(2,null,3),
(3,'��������� ������ ����� �� �����������',2),
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
(1,'������'),
(2,'��������'),
(3,'���������������'),
(4,'��������');
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


�������
������� ��� ������ �������� ����� (id ������, ����� �����, �� ����� ���� � � ����� ���������� �� �������) � ��������������� �� ������ ������ � ��������� ���� ����.

SELECT new_buy_book.buy_id ,new_book.title,new_book.price,new_buy_book.amount 
FROM 
    new_client
    INNER JOIN new_buy ON new_client.client_id = new_buy.client_id
    INNER JOIN new_buy_book ON new_buy_book.buy_id = new_buy.buy_id
    INNER JOIN new_book ON new_buy_book.book_id=new_book.book_id
WHERE new_client.client_id =1
order by new_buy_book.buy_id,new_book.title 

�������
���������, ������� ��� ���� �������� ������ �����, ��� ����� ������� �� ������ (����� ���������, � ����� ���������� ������� ���������� ������ �����).  ������� ������� � �������� ������, �������� �����, ��������� ������� ������� ����������. ��������� ������������� �������  �� �������� �������, � ����� �� ��������� ����.

select new_author.name_author,new_book.title, count(new_buy_book.amount) as ����������
from new_author 
inner join new_book on new_author.author_id =new_book.author_id 
left join new_buy_book on new_book.book_id =new_buy_book.book_id 
group by new_author.name_author,new_book.title
order by new_author.name_author;

������� 
������� ������, � ������� ����� �������, ����������� ������ � ��������-��������. ������� ���������� ������� � ������ �����, ���� ������� ������� ����������. ���������� ������� �� �������� ���������� �������, � ����� � ���������� ������� �� �������� �������.

select new_city.name_city ,count(new_city.name_city) as ����������
from new_city 
inner join new_client on new_city.city_id = new_client.city_id 
inner join new_buy on new_client.client_id=new_buy.client_id 
group by new_city.name_city;



�������
������� ������ ���� ���������� ������� � ����, ����� ��� ���� ��������.
select new_buy_step.buy_id ,new_buy_step.date_step_end 
from new_buy_step
where new_buy_step.step_id =1 and new_buy_step.date_step_end is not null ;

�������
������� ���������� � ������ ������: ��� �����, ��� ��� ����������� (������� ������������) � ��� ��������� (����� ������������ ���������� ���������� ���� � �� ����), � ��������������� �� ������ ������ ����. ��������� ������� ������� ���������.

select new_buy_book.buy_id , new_client.name_client ,sum(new_book.price *new_buy_book.amount) as ���������
from new_book 
left join new_buy_book on new_book.book_id =new_buy_book.book_id 
inner join new_buy on new_buy_book.buy_id=new_buy.buy_id 
left join new_client on new_buy.client_id =new_client.client_id  
group by new_buy_book.buy_id
order by new_buy_book.buy_id;

�������
������� ������ ������� (buy_id) � �������� ������,  �� ������� ��� � ������ ������ ���������. ���� ����� ��������� �  ���������� � ��� �� ��������. ���������� ������������� �� ����������� buy_id.

select new_buy_step.buy_id ,new_step.name_step
from new_buy_step 
right join new_step on new_buy_step.step_id =new_step.step_id 
where new_buy_step.date_step_end is null and new_buy_step.date_step_beg is not null
order by new_buy_step.buy_id ;

�������
� ������� city ��� ������� ������ ������� ���������� ����, �� ������� ����� ����� ���� ��������� � ���� ����� (��������������� ������ ���� ���������������). ��� ��� �������, ������� ������ ���� ���������������, ������� ���������� ���� �� ������� ����� ������� ��������� � �����. � �����, ���� ����� ��������� � ����������, ������� ���������� ���� ��������, � ��������� ������ ������� 0. � ��������� �������� ����� ������ (buy_id), � ����� ����������� ������� ����������_���� � ���������. ���������� ������� � ��������������� �� ������ ������ ����.

select new_buy.buy_id , 
datediff(new_buy_step.date_step_end,new_buy_step.date_step_beg) as ����������_���� ,
case when
(datediff(new_buy_step.date_step_end,new_buy_step.date_step_beg)-new_city.days_delivery)<1 then 0 else
(datediff(new_buy_step.date_step_end,new_buy_step.date_step_beg)-new_city.days_delivery) end as ���������
from new_city 
inner join new_client on new_city.city_id =new_client.city_id 
inner join new_buy on new_client.city_id =new_buy.client_id 
inner join new_buy_step on new_buy.buy_id =new_buy_step.buy_id 
inner join new_step on new_buy_step.step_id =new_step.step_id 
where new_step.name_step ='���������������' and new_buy_step.date_step_end is not null
group by new_buy.buy_id 

�������
������� ���� ��������, ������� ���������� ����� ������������, ���������� ������� � ��������������� �� �������� ����. � ������� ����������� ������� ������, � �� ��� id.

select new_client.name_client 
from new_author 
inner join new_book on new_author.author_id =new_book.author_id 
inner join new_buy_book on new_book.book_id=new_buy_book.book_id 
inner join new_buy on new_buy_book.buy_id =new_buy.buy_id 
inner join new_client on new_buy.client_id =new_client.client_id 
where new_author.name_author ='����������� �.�.'
group by new_client.name_client 
order by new_client.name_client ;

select * from new_author;
�������
������� ���� (��� �����), � ������� ���� �������� ������ ����� ����������� ����, ������� ��� ����������. ��������� ������� ������� ����������.

select new_genre.name_genre, sum(new_buy_book.amount) as ����������
from new_genre 
inner join new_book on  new_genre.genre_id =new_book.genre_id 
inner join new_buy_book on new_book.book_id=new_buy_book.book_id 
group by new_genre.name_genre 
;

select new_genre.name_genre, sum(new_buy_book.amount) as ����������
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

�������****
���� ��� �������� �� ������������� �������������: ����� Timmmyyy, Todor Illia, ˸�� Last name, ����� ������������ ������ � ��.
�������� ����������� ������� �� ������� ���� �� ������� � ���������� ����. ��� ����� ������� ���, �����, ����� ������� � ��������������� ������� �� ����������� �������, ����� �� ����������� ��� ����. �������� ��������: ���, �����, �����.

SELECT YEAR(date_payment) AS ���,
	   MONTHNAME(date_payment) AS �����,
	   SUM(amount*price) AS �����
FROM buy_archive
GROUP BY ���, �����

UNION ALL
SELECT YEAR(date_step_end) AS ���,
	   MONTHNAME(date_step_end) AS �����,
	   SUM(bb.amount*price) AS �����
FROM buy_book bb
      JOIN buy_step bs ON bb.buy_id = bs.buy_id 
  				  AND bs.date_step_end 
  				  AND bs.step_id = 1
      JOIN book USING(book_id)
GROUP BY ���, �����
ORDER BY �����, ���;

������� ***
��� ������ ��������� ����� ���������� ������� ���������� � ���������� ��������� ����������� � �� ��������� �� 2020 � 2019 ��� . ����������� ������� ������� ���������� � �����. ���������� ������������� �� �������� ���������.
WITH Title_sales AS (
SELECT title, buy_book.amount, price
FROM book
    INNER JOIN buy_book USING(book_id)
    INNER JOIN buy USING(buy_id) 
    INNER JOIN buy_step USING(buy_id)
    INNER JOIN step USING(step_id)
WHERE  date_step_end IS NOT Null and name_step = "������"
    
UNION ALL
    
SELECT title, buy_archive.amount, buy_archive.price
    FROM buy_archive
    INNER JOIN book USING(book_id)
)
SELECT title, SUM(amount) AS ����������, SUM(amount*price) AS �����
FROM Title_sales
GROUP BY title
ORDER BY ����� DESC;


2.5 ���� ������ ���������-������� ����, ������� �������������

�������
�������� ������ �������� � ������� � ���������. ��� ��� ����� ����, ��� email popov@test, ��������� �� � ������.


insert into new_client (name_client,city_id ,email)
SELECT '����� ����', city_id, 'popov@test'
FROM new_city
WHERE name_city = '������';
select * from new_client;

�������
������� ����� ����� ��� ������ ����. ��� ����������� ��� ������: ���������� �� ���� �� ������� ��������.

insert into new_buy (buy_description,client_id)
SELECT '��������� �� ���� �� ������� ��������',client_id
FROM new_client
WHERE name_client = '����� ����';
select * from new_buy;


�������
� ������� buy_book �������� ����� � ������� 5. ���� ����� ������ ��������� ����� ���������� ������� � ���������� ���� ����������� � ����� ��������� ������ �������� � ����� ����������.
insert into new_buy_book (buy_id, book_id,amount)
select 5, book_id ,2
from new_book , new_author 
where name_author like '���������%' and title ='������';

insert into new_buy_book (buy_id, book_id,amount)
select 5, book_id ,1
from new_book , new_author 
where name_author like '��������%' and title ='����� �������';


select * from new_buy_book;


�������
���������� ��� ���� �� ������, ������� ���� �������� � ����� � ������� 5, ��������� �� �� ����������, ������� � ������ � ������� 5  �������.
update new_book 
inner join new_buy_book on new_book.book_id =new_buy_book.book_id 
set new_book.amount =new_book.amount-new_buy_book.amount 
where new_buy_book.book_id =5;
select * from new_book;


�������
������� ���� (������� buy_pay) �� ������ ������ � ������� 5, � ������� �������� �������� ����, �� ������, ����, ���������� ���������� ���� �  ���������. ��������� ������� ������� ���������. ���������� � ������� ������� � ��������������� �� ��������� ���� ����.

create table new_buy_pay as
select new_book.title, new_author.name_author ,new_book.price,new_buy_book.amount ,new_book.price*new_buy_book.amount  as ���������
from new_author
inner join new_book using (author_id)
inner join new_buy_book using (book_id)
where new_buy_book.buy_id =5
order by title;
select * from new_buy_pay;

�������
������� ����� ���� (������� buy_pay) �� ������ ������ � ������� 5. ���� �������� ����� ������, ���������� ���� � ������ (�������� ������� ����������) � ��� ����� ��������� (�������� ������� �����). ��� ������� ����������� ���� ������.

drop table new_buy_pay;

create table new_buy_pay as
select new_buy_book.buy_id , sum(new_buy_book.amount) as ����������,
sum(new_book.price *new_buy_book.amount) as �����
from new_book 
inner join new_buy_book using (book_id)
where new_buy_book.buy_id =5

select *from new_buy_pay;


�������
� ������� buy_step ��� ������ � ������� 5 �������� ��� ����� �� ������� step, ������� ������ ������ ���� �����. � ������� date_step_beg � date_step_end ���� ������� ������� Null.
insert into new_buy_step(buy_id,step_id)
select new_buy.buy_id ,new_step.step_id
from new_buy 
cross join new_step 
where new_buy.buy_id=5;
select * from new_buy_step;


�������
� ������� buy_step ������� ���� 12.04.2020 ����������� ����� �� ������ ������ � ������� 5.

���������� ���� �� ������� �� ����������, � ������� ����. ��� ����� ������� � ������� ������� Now(). �� ��� ���� � ������ ��� ����� ����������� ������ ����, � ������� ������ ����� ���������, �������  ������� ���� 12.04.2020.

update new_buy_step
set date_step_beg='2020-04-12'
where buy_id=5 and step_id=1;
select * from new_buy_step;



�������
��������� ���� ������� ��� ������ � ������� 5, ������� � ������� date_step_end ���� 13.04.2020, � ������ ��������� ���� (���������), ����� � ������� date_step_beg ��� ����� ����� �� �� ����.
����������� ��� ������� ��� ���������� ����� � ������ ����������. ��� ������ ���� �������� � ����� ����, ����� ��� ����� ���� ��������� ��� ����� ������, ������� ������ ������� ����. ��� ������� ����� ��� ����� ���� �������.

update new_buy_step
set date_step_end='2020-04-13'
where buy_id=5 and step_id=1;

update new_buy_step
set date_step_beg='2020-04-13'
where buy_id=5 and step_id=2;
select * from new_buy_step
where buy_step_id in (17,18,20);