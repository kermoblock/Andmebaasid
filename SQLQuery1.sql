 -- teeme andmebaasi ehk db
 create database IKT25tar

  -- andmebaasi valimine
  use IKT25tar

  -- andmebaasi kustutamine
  drop database IKT25tar

  -- teeme uuesti andmebaasi IKT25tar
  create database IKT25tar

  -- teeme tabeli
  create table Gender
  (
  --Meil on muutuja Id,
  --mis on täisarv andmetüüp,
  --kui sisetad andmed, siis see veerg peab olema täidetud
  --tegemist on primaarvõtmega
  Id int not null primary key,
  --Veeru nimi on Gender,
  --10 tähemärki on max pikkus
  --andmed peavad olema sisestatud ehk
  -- ei tohi olla tühi
  Gender nvarchar(10) not null
  )

  --andmete sisestamine
  --proovige ise teha
  -- Id 1, Gender Male
  -- Id 2, Gender Female
  insert into Gender (Id, Gender)
  Values (1, 'Male'),
  (2, 'Female');

  --vaatame tabeli sisu
  -- * tähendab, et näita kõike seal sees olevat infot
  select * from Gender

  --teeme tabeli nimega Person
  --veeru nimed: Id Int not null primary key
  --Name nvarchar (30)
  --Email nvarchar (30)
  --Genderid int
  drop table Person

  Create Table Person
  (
  Id int not null primary key,
  Age nvarchar(10),
  Name nvarchar(30),
  Email nvarchar(30),
  GenderId int
  )

  insert into Person (Id, Name, Email, GenderId)
  values (1, 'Superman', 's@s.com', 2),
  (2, 'Wonderwoman', 'w@w.com', 1),
  (3, 'Batman', 'b@b.com', 2),
  (4, 'Aquaman', 'a@a.com', 2),
  (5, 'Catwoman', 'c@c.com', 1),
  (6, 'Antman', 'ant"ant.com', 2),
  (8, NULL, NULL, 2)

  --näen tabelis olevat infot
  select * from Person

  --võõrvõtme ühenduse loomine kahe tabeli vahel
  alter table Person add constraint tblPerson_GenderId_FK
  foreign key (GenderId) references Gender(Id)

  --kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla
  --väärtust, siis automaatselt sisestab sellele reale väärtuse 3
  -- ehk unknown
  alter table Person
  add constraint DF_Persons_GenderId
  Default 3 for GenderId

  insert into Gender (Id, Gender)
  values (3, 'Unknown')

  insert into Person (Id, Name, Email, GenderId)
  values (7, 'Black Panther', 'b@b.com', NULL)

  insert into Person (Id, Name, Email)
  values (9, 'Spiderman', 'spider@m.com')

  select * from Person

  --prriangu kustutamine
  alter table Person
  drop constraint DF_Persons_GenderId

  --kuidas lisada veergu tabelile Person
  --Veeru nimi on Age nvarchar(10)
  alter table Person
  add constraint CK_Person_Age check (Age > 0 and Age < 155)

  --kuidas uuendada andmeid
  update Person
  set Age = 159
  where Id = 7

  select * from Person

  --soovin kustutada ühe rea
  --kuidas seda teha
  delete from Person
  where Id = 8

  -- lisame uue veeru City nvarchar(50)
  alter table Person
  add City nvarchar(50)

  --kõik, kes elavad Gothami linnas
  select * from Person where City = 'Gotham'
  --kõik, kes ei ela Gothamis
  select * from Person Where City != 'Gotham'
  --variant nr2. kõik, kes ei ela Gothamis
  select * from Person where City <> 'Gotham'

  --näitab teatud vanusega inimesi
  --valime 151, 35, 25
  select * from Person Where Age In (151, 35, 23)
  --Teine võimalus
  select * from Person Where Age = 151 or Age = 35 or Age = 23

  --soovin näha inimesi vahemikus 22 kuni 41
  select * from Person Where Age between 22 and 41

  --wildcard ehk näitab kõik g-tähega linnad
  select * from Person Where City Like 'g%';
  --otsib emailid @-märgiga
  select * from Person Where Email like '%@%';

  --tahan näga, kellel on emailis ees ja peale @-märki üks täht
  select * from Person Where Email like '_@_.com'

  --kõik, kelle nimes ei ole esimene täht W, A, S
  select * from Person Where Name like '[^WAS]%'

  --kõik kes elavad gothamis ja new yorkis
    select * from Person Where (City = 'Gotham City' or City = 'New York')

	--kõik, kes elavad gothamis ja new yeorkis ning peavad olema vanemad kui 29
	select * from Person Where (City = 'Gotham City' or City = 'New York' and Age > 29)

	--kuvad tähestikulises järjekorras inimesi ja võtab aluseks
	--name veeru
	select * from Person
	select * from Person order by Name

	--võtab kolm esimest rida person tabelist
	select TOP 3 * from Person;

	--kolm esimest, aga tabeli järjestus on Age ja siis Name
	select TOP 3 Age, Name from Person

	--näita esimsed 50% tabelist
	select TOP 50 PERCENT * from Person

	--järjesta vanuse järgi isikud
	select * from Person order By Age desc

	--muudab Age muutuja int-ks ja näitab vanuselises järjestuses
	--cast abil saab andmetüüpi muuta
	select * from Person order by cast(Age as int) desc

	--kõikide isikue koondvanus ehk liidab kõik kokku
	select Sum(cast(Age as int)) from Person

	--kõige noorem isik tuleb leida üles
	select min(cast(Age as int)) from Person

	--kõige vanim isik
	select max(cast(Age as int)) from Person

	--muudame Age muutuja int peale
	--näeme konkreetsetes linnades olevate ikikute koondvanust
	select City, SUM(Age) as TotalAge from Person group By City

	--kuidas saab koodiga muuta andmetüüpin ja selle pikkust
	alter table Person
	alter column Name nvarchar(25)

	--kuvab esimeses real välja toodud järjestuses ja kuvab Age-i
	--TotalAge-ks
	--järjest City-s olevate nimede järgi ja siis GenderId järgi
	--kasutada group by-d ja order by-d
	select City, GenderId, SUM(Age) as TotalAge from Person
	group by City, GenderId
	order by City

	--näitab mitu rida andmeid on selles tabelis
	Select COUNT(*) From Person

	--näitab tulemust, et mitu inimest on GenderId väärtusega 2
	--konkreetses linnas
	--arvutab vanuse kokku selles linnas
	select GenderId, City, sum(Age) as TotalAge, count(Id) as
	[Total Person(s)] from Person
	Where GenderId = '2'
	group by GenderId, City

	--näitab ära inimeste koondvanuse, mis üle 41a ja
	--kui palju neid igas linnas elab
	--eristab inimese soo ära
	select GenderId, City, sum(Age) as TotalAge, count(Id) as
	[Total Person(s)] from Person
	where GenderId = '2'
	group by GenderId, City having SUM(Age) > 41

	--loome tabelid Employees ja Department
	create table Department
	(
	Id int primary key,
	DepartmentName nvarchar(50),
	Location nvarchar(50),
	DepartmentHead nvarchar(50)
	)

	create table Employees
	(
	Id int primary key,
	Name nvarchar(50),
	Gender nvarchar(50),
	Salary nvarchar(50),
	DepartmentId int
	)

	insert into Employees (Id, Name, Gender, Salary, DepartmentId)
	values (1, 'Tom', 'Male', 4000, 1),
	(2, 'Pam', 'Female', 3000, 3),
	(3, 'John', 'Male', 3500, 1),
	(4, 'Sam', 'Male', 4500, 2),
	(5, 'Todd', 'Male', 2800, 2),
	(6, 'Ben', 'Male', 7000, 1),
	(7, 'Sara', 'Female', 4800, 3),
	(8, 'Valarie', 'Female', 5500, 1),
	(9, 'James', 'Male', 6500, NULL),
	(10, 'Russell', 'Male', 8800, NULL)

	select * from Employees

	insert into Department (Id, DepartmentName, Location, DepartmentHead)
	values (1, 'IT', 'London', 'Rick'),
	(2, 'Payroll', 'Delhi', 'Ron'),
	(3, 'HR', 'New York', 'Christie'),
	(4, 'Other Department', 'Sydney', 'Cindrella')

	select * from Department

	---
	select Name, Gender, Salary, DepartmentName
	from Employees
	left join Department
	on Employees.DepartmentId = Department.Id
	---

	--arvutab kõikide palgad kokku
	select Sum(cast(Salary as int)) from Employees

	--kõige väiksema palga saaja
	select min(cast(Salary as int)) from Employees

	--näitab veerge Location ja Salary. Salary veerg kuvtakse TotalSalary-ks
	--teha left join Department tabeliga
	--grupitab Locationiga

	select Location, Sum(cast(Salary as int)) as TotalSalary from Employees
	left join Department
	on Employees.DepartmentId = Department.Id
	group by Location

	select * from Employees
	select SUM(cast(Salary as int)) from Employees

	--lisame veeru City ja pikkus on 30

	alter table Employees
	add City nvarchar(30)

	select City, Gender, SUM(cast(Salary as int)) as TotalSalary
	from Employees
	group by City, Gender

	--peaaegu sama päring, aga linnad on tähestikulises järjestuses
	select City, Gender, SUM(cast(Salary as int)) as TotalSalary
	from Employees
	group by City, Gender order by City

	--on vaja teada, etmitu inimest on nimekirjas

	Select COUNT(*) From Employees

	--mitu töötajat on soo ja linna kaupa töötamas
	select City, Gender, SUM(cast(Salary as int)) as TotalSalary,
	COUNT(Id) as [Total Employee(s)]
	from Employees
	group by Gender, City

	--kuvab kas naised või mehed linnade kaupa
	--kasutage where

	select City, Gender, SUM(cast(Salary as int)) as TotalSalary,
	COUNT(Id) as [Total Employee(s)]
	from Employees
	Where Gender = 'Male'
	group by Gender, City

	--sama tulemus nagu eelmine, aga kasutame having

	select City, Gender, SUM(cast(Salary as int)) as TotalSalary,
	COUNT(Id) as [Total Employee(s)]
	from Employees
	group by Gender, City
	Having Gender = 'Male'

	--kõik kes teenivad rohkem kui 4000 (variandis peab error tulema)
	select * from Employees
	where SUM(cast(Salary as int)) > 4000

	--teeme variandi, kus saame tulemuse
	select  Gender, City, SUM(cast(Salary as int)) as TotalSalary,
	COUNT(Id) as [Total Employee(s)]
	from Employees
	group by Gender, City
	having SUM(CAST(salary as int)) > 4000

	--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
	create table Test1
	(
	Id int identity(1,1),
	Value nvarchar(20)
	)

	insert into Test1 values('X')
	select * from Test1


