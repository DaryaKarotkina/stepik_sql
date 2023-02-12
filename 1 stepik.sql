use stepik;
drop table book ;

1.1 �������� �������

�������
������������� SQL ������ ��� �������� ������� book
create table book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price numeric (8, 2),
    amount INT);
   

2.������� ������ � �������   
�������
�������� ����� ������ � ������� book

insert into book (title,author,price,amount)
values('������ � ���������','�������� �.�.',670.99,3)


3.�������
�������� ��� ��������� ������ � �������book
insert into book(title,author,price ,amount)
values 
('����� �������','�������� �.�.',540.50,5),
('�����','����������� �.�.',460.00,10),
('������ ����������','����������� �.�.',799.01,3),
('������������� � �����','������ �.�.',650.00,15)


1.2 ������� ������
�������
������� ���������� � ���� ������, ���������� �� ������
select * from book ;

�������
������� �������, �������� ���� � �� ���� �� ������� book
select author,title,price
from book;

�������
������� �������� ���� � ������� �� ������� book, ��� ���� title ������ ���(���������) ��������, ��� ���� author �  �����
select title as �������� ,author as �����
from book;

�������
��� �������� ������ ����� ��������� ���� ���� ������, ���� �������� 1 ����� 65 ������. ��������� ��������� �������� ��� ������ ����� (������� ����� �����������, ����� ��������� ��� ���������� �����). � ������� ������� �������� �����, �� ���������� � ��������� ��������, ��������� ������� ������� pack
select title,amount,
amount*1.65 as pack
from book ;

�������
� ����� ���� ���� ���� ���� �� ������ ������������� � ������� �� �� 30%. �������� SQL ������, ������� �� ������� book �������� ��������, �������, ���������� � ��������� ����� ���� ����. ������� � ����� ����� ������� new_price, ���� ��������� �� 2-� ������ ����� �������.
select title, author,amount,
ROUND((price*70/100),2) AS new_price
from book ;

�������
��� ������� ������ ���� ����������, ��� ���������� ������������� ���������� ����� ������� ���������, �� ������ ����� ����� ������ �������. ������ �� ����� ������ ������� ���� ���� ��������� �� 10%, � ���� ���� ������� - �� 5%. �������� ������, ���� �������� ������, �������� ����� � ����� ����, ��������� ������� ������� new_price. �������� ��������� �� ���� ������ ����� �������.
select author,title,
round(case 
	when author ='�������� �.�.' then price * 1.1
	when author ='������ �.�.' then price * 1.05
	else price end
	,2) as new_price
from book;

�������
������� ������, ��������  � ���� ��� ����, ���������� ������� ������ 10.
select author, title,price
from book  
where amount <10;

�������
������� ��������, ������,  ����  � ���������� ���� ����, ���� ������� ������ 500 ��� ������ 600, � ��������� ���� ����������� ���� ���� ������ ��� ����� 5000.

select title, author,price,amount
from book b 
where (price<500 or price>600) and price*amount>=5000

������� �������� � ������� ��� ����, ���� ������� ����������� ��������� �� 540.50 �� 800 (������� �������),  � ���������� ��� 2, ��� 3, ��� 5, ��� 7 .
select title, author 
from book b 
where price between 540.5 and 8000
and amount in (2,3,5,7);

�������
�������  ������ � ��������  ����, ���������� ������� ����������� ��������� �� 2 �� 14 (������� �������). ����������  ������������� ������� �� ������� (� �������� ���������� �������), � ����� �� ��������� ���� (�� ��������).
select author, title
from book b 
where amount between 2 and 14
order by author desc,title

�������
������� �������� � ������ ��� ����, �������� ������� ������� �� ���� � ����� ����, � �������� ������ �������� ����� �ѻ. �������, ��� � �������� ����� ���������� ���� �� ����� ��������� � �� �������� ������ ����������, ����� �������� ������ � ���������� ���������� ������, �������� ������������ ��� ������� � �������: �����, �����, �����, �����. ���������� ������������� �� �������� ����� � ���������� �������.
insert into book (title,author,price ,amount)
values 
(NULL,'������ �.�.',50.00,10),
('���� ��������' ,'����� ������' , 950.00 , 5    ),
('������',  '������� �.�.'   , 460.00 ,10     ),
('�����', '�������� �.�.'   , 460.00 , 10  ),
('����������� �����',      '������ �.�.'     , 520.50 , 7 )

select *from book ;
select title, author 
from book b 
where title like '_% _%'
and author like '_%�.%'
order by title ;


1.3 �������, ��������� ��������


insert into book (title,author,price ,amount)
values 
('����� ','����������� �.�.',480.50,10)

�������
�������� ��������� (����������) �������� ������� amount ������� book.

select distinct amount
from book
order by amount;

�������
���������, ���������� ��������� ���� � ���������� ����������� ���� ������� ������ , ���������� �� ������.  ������� ������� �����, ���������_���� � ����������_����������� ��������������.
select distinct author as ����� ,
count( distinct title ) as ���������_����,
sum(amount) as ����������_�����������
from book
group by author
order by author;

�������
������� ������� � �������� ������, �����������, ������������ � ������� ���� ���� ������� ������ . ����������� ������� ������� �����������_����, ������������_���� � �������_���� ��������������.
select author,
min(price) as �����������_����,
max(price) as ������������_����,
avg(price) as �������_����
from book 
group by author
order by author;

�������
��� ������� ������ ��������� ��������� ��������� ���� S (��� ������� ���������), � ����� ��������� ����� �� ����������� ���������  ��� ���������� ���� (��� ������� ��� ) , ������� ������� � ��������� � ���������� k = 18%,  � ����� ��������� ����  (���������_���_���) ��� ����. �������� ��������� �� ���� ������ ����� �������. � ������� ��� ������� ���(tax)  � ��������� ��� ���(S_without_tax) ������������ ��������� �������:

select author, 
  sum(price*amount) as ���������, 
  round(sum(price*amount)*0.18/1.18, 2) as ���, 
  round(sum(price*amount)/1.18, 2) as ���������_���_���
from book      
group by author
order by author

�������
�������  ���� ����� ������� �����, ���� ����� ������� � ������� ���� ���������� ���� �� ������. �������� �������� �����������_����, ������������_����, �������_���� ��������������. ������� ���� ��������� �� ���� ������ ����� �������.
select min(price) as �����������_����,
max(price) as ������������_����,
round(avg(price),2) as �������_���� 
from book b 

��������� ������� ���� � ��������� ��������� ��� ����, ���������� ����������� ������� ����������� ��������� �� 5 �� 14, ������������. ������� ������� �������_���� � ���������, �������� ��������� �� 2-� ������ ����� �������.
select round(avg(price),2) as �������_���� ,
round(sum(price*amount),2) as ���������
from book b 
where amount between 5 and 14;

�������
��������� ��������� ���� ����������� ������� ������ ��� ����� ���� ������ � ������ ��������. � ��������� �������� ������ ��� �������, � ������� ��������� ��������� ���� (��� ����� ���� ������ � ������ ��������) ����� 5000 ���. ����������� ������� ������� ���������. ��������� ������������� �� �������� ���������.
select author ,
sum(price*amount) as ���������
from book b 
where title not in ('�����','����� �������')
group by author
having sum(price*amount)>5000
order by ��������� desc;


1.4 ��������� �������

�������
������� ���������� (������, �������� � ����) �  ������, ���� ������� ������ ��� ����� ������� ���� ���� �� ������. ���������� ������� � ��������������� �� �������� ���� ����. ������� ��������� ��� ������� �� ���� �����.


select author,title,price
from book
where price<=(
select avg(price)
from book)
order by price desc;

�������
������� ���������� (������, �������� � ����) � ��� ������, ���� ������� ��������� ����������� ���� ����� �� ������ �� ����� ��� �� 150 ������ � ��������������� �� ����������� ���� ����.

insert into book (title,author,price ,amount)
values 
('������� ������ ','������ �.�.',610.00,10)
select author,title,price
from book
where price<=(
select min(price)+150
from book)
order by price;

�������
������� ���������� (������, ����� � ����������) � ��� ������, ���������� ����������� ������� � ������� book �� �����������.

select * from book b 

select author,title,amount
from book
where amount in(
select amount
from book b
group by amount
having count(amount)=1)

�������
������� ���������� � ������(�����, ��������, ����), ���� ������� ������ ����� ������� �� ����������� ���, ����������� ��� ������� ������.

select author,title,price
from book 
where price < any(
select min(price)
from book 
group by author
)

�������
��������� ������� � ����� ����������� ���� ����� �������� �����������, ����� �� ������ ����� ���������� ���������� ����������� ������ �����, ������ �������� ������ �������� ���������� ����������� ����� ����� �� ������. ������� �������� �����, �� ������, ������� ���������� ����������� �� ������ � ���������� ������������ ����������� ����. ���������� ������� ��������� ��� �����. � ��������� �� �������� �����, ������� ���������� �� �����.
select title, author, amount ,
(select max(amount)
from book) -amount as �����
from book b 
where amount < (select max(amount)
from book)


1.5 ������� ������������� ������

�������
������� ������� �������� (supply), ������� ����� �� �� ���������, ��� � ������ book.
drop table supply;
create table supply(
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price numeric (8, 2),
    amount INT);

�������
�������� � ������� supply ������ ������, ����� ���������� ��������� �������:
insert into supply( title, author, price, amount)
values 
('������','��������� �.�.',518.99,2),
('������ �������','������ �.�.',570.20,6),
('����� �������','�������� �.�.',540.50,7),
('�����','����������� �.�.',360.80,3)
select * from supply;

�������
�������� �� ������� supply � ������� book, ��� �����, ����� ����, ���������� ���������� �.�. � ����������� �.�.

insert into book(title, author, price, amount)
select title, author, price, amount
from supply 
where author not in ('�������� �.�.' , '����������� �.�.')
order by author
select * from book 

�������
������� �� ������� supply � ������� book ������ �� �����, ������� ������� ��� �  book.
insert into book(title, author, price, amount)
select title, author, price, amount
from supply 
where author not in (
select author
from book)
select * from book;

�������
��������� �� 10% ���� ��� ���� � ������� book, ���������� ������� ����������� ��������� �� 5 �� 10, ������� �������.
update book 
set price =0.9*price 
where amount between 5 and 10;
select * from book;

�������
� ������� book ���������� ��������������� �������� ��� ���������� � ������� buy ����� �������, ����� ��� �� ��������� ���������� ����������� ����, ��������� � ������� amount. � ���� ��� ����, ������� ���������� �� ���������, ������� �� 10%.
update book 
set buy=if(buy>amount, amount, buy),
price=if(buy=0, price*0.9,price)
select * from book;

��� ��� ���� � ������� book , ������� ���� � ������� supply, �� ������ ��������� �� ���������� � ������� book ( ��������� �� ���������� �� �������� ������� amount������� supply), �� � ����������� �� ���� (��� ������ ����� ����� ����� ��� �� ������ book � supply � ��������� �� 2).
update book,supply
set book.amount=supply.amount+book.amount, 
book.price=(book.price+supply.price)/2
where book.title=supply.title
select * from book;

�������
������� �� ������� supply ����� ��� �������, ����� ���������� ����������� ���� ������� � ������� book ��������� 10.
delete from supply 
where author in(
select author 
from book b 
group by author 
having sum(amount)>10
)

select * from supply; 

�������
������� ������� ����� (ordering), ���� �������� ������� � �������� ��� ����, ���������� ����������� ������� � ������� book ������ �������� ���������� ����������� ���� � ������� book. � ������� �������� �������   amount, � ������� ��� ���� ���� ������� ���������� �������� - ������� ���������� ����������� ���� � ������� book.
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


1.6 ������� "������������", ������� �� �������
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
('������� �.�.',	'������',	700,	'2020-01-12',	'2020-01-17'),
('�������� �.�.',	'�����������',	450,	'2020-01-14',	'2020-01-27'),
('������� �.�.',	'������',	700,	'2020-01-23',	'2020-01-31'),
('������� �.�.',	'�����������',	450,	'2020-01-12',	'2020-02-02'),
('������� �.�.',	'������',	700,	'2020-02-01',	'2020-02-06'),
('������� �.�.',	'������',	700,	'2020-02-14',	'2020-02-22'),
('�������� �.�.',	'������',	700,	'2020-02-23',	'2020-03-01'),
('������� �.�.',	'������',	700,	'2020-03-03',	'2020-03-06'),
('������� �.�.',	'�����������',	450,	'2020-02-27',	'2020-03-12'),
('������� �.�.',	'�����-���������',	700,	'2020-03-29',	'2020-04-05'),
('�������� �.�.',	'������',	700,	'2020-04-06',	'2020-04-14'),
('������� �.�.',	'�����������',	450,	'2020-04-18',	'2020-05-04'),
('������� �.�.',	'�����',	450,	'2020-05-20',	'2020-05-31'),
('������� �.�.',	'�����-���������',	700,	'2020-06-01',	'2020-06-03'),
('�������� �.�.',	'�����-���������',	700,	'2020-05-28',	'2020-06-04'),
('�������� �.�.',	'�����������',	450,	'2020-05-25',	'2020-06-04'),
('������� �.�.',	'�����������',	450,	'2020-06-03',	'2020-06-12'),
('�������� �.�.',	'�����',	450,	'2020-06-20',	'2020-06-26'),
('�������� �.�.',	'�����������',	450,	'2020-07-02',	'2020-07-13'),
('������� �.�.',	'�������',	450,	'2020-07-19',	'2020-07-25')

select * from trip 

�������
������� �� ������� trip ���������� � ������������� ��� �����������, ������� ������� ������������� �� ����� ��, � ��������������� �� �������� ���� ���������� ��� ������������ ����. � ��������� �������� ������� name, city, per_diem, date_first, date_last.

select name, city, per_diem,date_first, date_last
from trip 
where name like '_______�%'
order by date_last desc;


�������
������� � ���������� ������� ������� � �������� ��� �����������, ������� ���� � ������������ � ������.
select distinct name 
from trip 
where city='������'
order by name;


�������
��� ������� ������ ���������, ������� ��� ���������� � ��� ����.  ���������� ������� � ��������������� � ���������� ������� �� �������� �������. ����������� ������� ������� ����������. 
select city, count(city) as  ����������
from trip 
group by city
order by city;

�������
������� ��� ������, � ������� ���� ����� ���� � ������������� ����������. ����������� ������� ������� ����������.
select city, count(city) as  ����������
from trip 
group by city
order by ���������� desc
limit 2;


�������
������� ���������� � ������������� �� ��� ������ ����� ������ � �����-���������� (������� � �������� �����������, ����� ,  ������������ ������������ � ����, ��� ���� ������ � ��������� ���� ��������� � ������� ������������). ��������� ������� ������� ������������. ���������� ������� � ������������� �� �������� ������������ �������, � ����� �� �������� �������� ������� (� �������� ���������� �������).
select name, city,
datediff(date_last, date_first)+1 as ������������
from trip
where city not in ('������','�����-���������')
order by ������������ desc

�������
������� ���������� � ������������� ����������(��), ������� ���� ������ ��������� �� �������. � ��������� �������� ������� name, city, date_first, date_last.

select name, city, date_first, date_last
from trip
where datediff(date_last, date_first) = (
    select MIN(datediff(date_last, date_first))
    from trip
);


������� ���������� � �������������, ������ � ����� ������� ��������� � ������ ������ (��� ����� ���� �����). � ��������� �������� ������� name, city, date_first, date_last. ������ ������������� �������  � ���������� ������� �� �������� ������, � ����� �� ������� ���������� .

select name,city,date_first,date_last
from trip
where month(date_first)=month(date_last)
order by city,name;


�������
������� �������� ������ � ���������� ������������ ��� ������� ������. �������, ��� ������������ ��������� � ���������� ������, ���� ��� �������� � ���� ������. ���������� ������� ������� � ��������������� �� �������� ����������, � ����� � ���������� ������� �� �������� ������ ����. �������� �������� � ����� � ����������.

select monthname(date_first) as  �����  ,
count(month ( date_first)=1) as ����������
from trip 
group by ����� 
order by ���������� desc;


�������
������� ����� �������� (������������ ���������� ���� ������������ � ������� ��������) ��� ������������, ������ ���� ������� �������� �� ������� ��� ���� 2020 ����. �������� �������� ��� ������ ������������ �������� � ������� per_diem. ������� ������� � �������� ����������, �����, ������ ���� ������������ � ����� ��������. ��������� ������� ������� �����. ���������� ������������� �������  � ���������� ������� �� �������� �����������, � ����� �� �������� ����� ��������.
select name , city, date_first,
per_diem*(datediff(date_last, date_first)+1) as �����
from trip 
where month (date_first) between 2 and 3
order by name, ����� desc

�������
������� ������� � ���������� � ����� ����� ��������, ���������� �� ��� ������������ ��� ��� �����������, ������� ���� � ������������� ������ ��� 3 ����, � ��������������� �� �������� ���� �������� ����. ��������� ������� ������� �����.
select name ,
sum((datediff (date_last, date_first) + 1) * per_diem) AS �����
from trip 
group by name
having count(date_first) >3
order by name;


1.7 ������� "��������� ���", ������� �������������
drop table fine

�������
������� ������� fine ��������� ���������:

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

�������
� ������� fine ������ 5 ����� ��� ��������. �������� � ������� ������ � ��������� ���������� 6, 7, 8.

INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES ('������� �.�.', '�523��', '���������� ��������(�� 40 �� 60)', 500, '2020-01-12 ', '2020-01-17'),
       ('�������� �.�.', '�111��', '������ �� ����������� ������', 1000.00, '2020-01-14', '2020-02-27'),
       ('������� �.�.', '�330��', '���������� ��������(�� 20 �� 40)', 500.00, '2020-01-23', '2020-02-23'),
       ('������� �.�.', '�701��', '���������� ��������(�� 20 �� 40)', NULL, '2020-01-12', NULL),
       ('������� �.�.', '�892��', '���������� ��������(�� 20 �� 40)', NULL, '2020-02-01', NULL)
INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES       
       ('������� �.�.', '�523��', '���������� ��������(�� 40 �� 60)', NULL, '2020-02-14', NULL),
       ('�������� �.�.', '�111��', '������ �� ����������� ������', NULL, '2020-02-23', NULL),
       ('������� �.�.', '�330��', '������ �� ����������� ������', NULL, '2020-03-03', NULL)

INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES ('������� �.�.', '�523��', '���������� ��������(�� 40 �� 60)', NULL, '2020-02-14 ', NULL),
       ('�������� �.�.', '�111��', '������ �� ����������� ������', NULL, '2020-02-23', NULL),
       ('������� �.�.', '�330��', '������ �� ����������� ������', NULL, '2020-03-03', NULL),
       ('������� �.�.', '�701��', '���������� ��������(�� 20 �� 40)', NULL, '2020-01-12', NULL),
       ('������� �.�.', '�892��', '���������� ��������(�� 20 �� 40)', NULL, '2020-02-01', NULL),
       ('������� �.�.', '�523��', '���������� ��������(�� 40 �� 60)', 500.00, '2020-01-12', '2020-01-17'),
       ('�������� �.�.', '�111��', '������ �� ����������� ������', 1000.00, '2020-01-14', '2020-02-27'),
       ('������� �.�.', '�330��', '���������� ��������(�� 20 �� 40)', 500.00, '2020-01-23', '2020-02-23'),
       
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
VALUES ('���������� ��������(�� 20 �� 40)', 500),
       ('���������� ��������(�� 40 �� 60)', 1000),
       ('������ �� ����������� ������', 1000);
       
select * from     traffic_violation; 

�������
������� � ������� fine ����� �������, ������� ������ �������� ��������, � ������������ � ������� �� ������� traffic_violation. ��� ���� ����� �������� ������ � ������ ���� �������  sum_fine.

������� traffic_violation������� � ���������.

�����! ��������� �������� ������� � ������ ��������� �������������� � ������� ��������� IS NULL.

update fine, traffic_violation
set fine.sum_fine=traffic_violation.sum_fine
where fine.violation=traffic_violation.violation and fine.sum_fine is null;
select * from fine;



�������
������� �������, ����� ������ � ��������� ������ ��� ��� ���������, ������� �� ����� ������ �������� ���� � �� �� �������   ��� � ����� ���. ��� ���� ��������� ��� ���������, ���������� �� ���� �������� ��� ��� ���. ���������� ������������� � ���������� �������, ������� �� ������� ��������, ����� �� ������ ������ �, �������, �� ���������.

select name, number_plate, violation
from fine 
group by name, number_plate, violation
having count(*)>1
order by name;

�������
� ������� fine ��������� � ��� ���� ����� ������������ ������� ��� ���������� �� ���������� ���� �������. 

��������� !!! ���� �� ���������� ������ ��� ��������� ������ ������, ��������� ��� ���������!!!
�����! ���� � ������� ������������ ��������� ������ ��� ��������, ���������� ���������� ����, �� ����������� ������ ��� �������, ����������� �������� ������� ����� ������ �.�. ��������,  fine.name  �  query_in.name.


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
VALUES ('������� �.�.', '�701��', '���������� ��������(�� 20 �� 40)',  '2020-01-12', '2020-01-22'),
	('������� �.�.', '�523��', '���������� ��������(�� 40 �� 60',  '2020-02-14', '2020-03-06'),
('������� �.�.', '�330��', '������ �� ����������� �����',  '2020-03-03', '2020-03-23')
select * from payment;

�������
�������� ���������� ���� ������. � ������� payment �������� ���� �� ������:

update fine, payment
set fine.date_payment=payment.date_payment,
fine.sum_fine=if(datediff(payment.date_payment, fine.date_violation) <= 20, fine.sum_fine/2, fine.sum_fine)
where fine.name=payment.name and 
fine.number_plate=payment.number_plate and 
fine.violation=payment.violation and  
fine.date_payment is null;

select * from fine;

�������
������� ����� ������� back_payment, ���� ������ ���������� � ������������ ������� (������� � �������� ��������, ����� ������, ���������, ����� ������  �  ���� ���������) �� ������� fine.
drop table back_payment
create table back_payment as
(select fine.name , fine.number_plate,fine.violation,fine.sum_fine,fine.date_violation,date_payment
from fine
where fine.date_payment is null);
select * from back_payment;
