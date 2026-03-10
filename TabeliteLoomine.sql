--rida 1

--Etapp 1

create table Raamatud
(
Id int primary key,
pealkiri varchar(100),
autor varchar(100),
aasta int,
hind decimal(5,2),
)

--Etapp 2

insert into Raamatud (Id, pealkiri, autor, aasta, hind)
values (1, 'Harry Potter', 'J.K Rowling', 2001, 29.99),
(2, 'Kaka ja Kevad', 'Andrus Kivirähk', 2005, 14.99),
(3, 'Tom and Jerry', 'Tom Jerry', 1990, 9.99),
(4, 'Piibel', 'Jeesus Kristus', 1, 9.99),
(5, 'Kalevipoiss', 'Kalev Poiss', 1800, 29.99),
(6, 'The Art Of War', 'Sun Tzu', 1100, 39.99)

select * from Raamatud

--Etapp 3

update Raamatud
set hind = 24.99
where Id = 1

update Raamatud
set autor = 'Tommy Jer'
where Id = 3

--Etapp 4

alter table Raamatud
add laos_kogus int

update Raamatud
set laos_kogus = 3
where Id = 2

update Raamatud
set laos_kogus = 5
where Id = 4

update Raamatud
set laos_kogus = 1
where Id = 1

--Etapp 5

alter table Raamatud
drop column hind

--Etapp 6

delete from Raamatud
where Id = 6

select * from Raamatud



