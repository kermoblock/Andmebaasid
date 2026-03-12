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
	
	--kustutame veeru nimega City Employee tabelist
	alter table Employees 
	drop column City

	--inner join
	--kuvab neid, kellel on DepartmentName all olemas väärtus
	--mitte kattuvad read eemaldatakse tulemusest
	--ja sellepärast ei näidata Jamesi ja Russelit tabelis
	select Name, Gender, Salary, DepartmentName
	from Employees
	inner join Department
	on Employees.DepartmentId = Department.Id

	--left join

	select Name, Gender, Salary, DepartmentName
	from Employees
	left join Department  --võib kasutada ka LEFT OUTER JOIN-i
	on Employees.DepartmentId = Department.Id
	--mis on left join
	--näitab paremas tabelis olevaid väärtuseid,
	--mis ei ühti vasaku (Department) tabeliga

	--right join
	select Name, Gender, Salary, DepartmentName
	from Employees
	right join Department
	on Employees.DepartmentId = Department.Id
	--mis on right join
	--näitab paremas tabelis olevaid väärtuseid,
	--mis ei ühti vasaku (Employees) tabeliga

	--outer join
	select Name, Gender, Salary, DepartmentName
	from Employees
	full outer join Department
	on Employees.DepartmentId = Department.Id
	--mõlema tabeli read kuvab

	--teha cross join
	select Name, Gender, Salary, DepartmentName
	from Employees
	cross join Department
	--korrutab kõik omavahel läbi

	--teha left join, kus Employees tabelist DepartmentId on NULL
	select Name, Gender, Salary, DepartmentName
	from Employees
	left join Department
	on Employees.DepartmentId = Department.Id
	where Employees.DepartmentId is NULL

	--teine variant ja sama tulemus
	select Name, Gender, Salary, DepartmentName
	from Employees
	left join Department
	on Employees.DepartmentId = Department.Id
	where Department.Id is NULL
	--näitab ainult neid, kellel on vasakus tabelis (Employees)
	--DepartmentId NULL

	select Name, Gender, Salary, DepartmentName
	from Employees
	right join Department
	on Employees.DepartmentId = Department.Id
	where Employees.DepartmentId is NULL
	--näitab ainult paremas tabelis olevat rida,
	--mis ei kattu Employees-ga

	--full join
	--peab näitama mõlema tabeli mitte-kattuvate väärtustega read kuvab välja
	select Name, Gender, Salary, DepartmentName
	from Employees
	full join Department
	on Employees.DepartmentId = Department.Id
	where Employees.DepartmentId is NULL
	or DepartmentId is NULL

	--teete AdventureWorksLT2019 andmebassile join päringud
	--inner join, left join, right join, cross join, full join
	--tabeleid selle andmebaasi juurde ei tohi teha

	--Inner Join
	USE AdventureWorksLT2019
	select NameStyle, Title, FirstName
	from SalesLT.Customer
	inner join SalesLT.CustomerAddress
	on SalesLT.CustomerAddress.CustomerId = SalesLT.Customer.CustomerId

	--Left Join
	USE AdventureWorksLT2019
	select NameStyle, Title, FirstName
	from SalesLT.Customer
	left join SalesLT.CustomerAddress
	on SalesLT.CustomerAddress.CustomerId = SalesLT.Customer.CustomerId

	--Right Join
	USE AdventureWorksLT2019
	select NameStyle, Title, FirstName
	from SalesLT.Customer
	right join SalesLT.CustomerAddress
	on SalesLT.CustomerAddress.CustomerId = SalesLT.Customer.CustomerId
	 
	 --Cross Join
	USE AdventureWorksLT2019
	select NameStyle, Title, FirstName
	from SalesLT.Customer
	cross join SalesLT.CustomerAddress

	--Full Join
	USE AdventureWorksLT2019
	select NameStyle, Title, FirstName
	from SalesLT.Customer
	full  join SalesLT.CustomerAddress
	on SalesLT.CustomerAddress.CustomerId = SalesLT.Customer.CustomerId

	--mõnikord peab muutuja ette kirjutama tabeli nimetuse nagu on Product.Name
	--et editor saaks aru, et kumma tabeli muutujat soovitakse kasutada ja ei tekiks
	--segadust
	select Product.Name as [Product Name], ProductNumber, ListPrice, ProductModel.Name as [Product Model Name]
	--mõnikord peab ka tabeli ette kirjutama täpsustama info
	--nagu on Sales.LT Producti ees
	from SalesLT.Product
	inner join SalesLT.ProductModel
	--antud juhul producti tabelis ProductModelId võõrvõti,
	--mis ProfuctModeli tabelis on primaarvõti
	on Product.ProductModelId = ProductModel.ProductModelId

	--isnull funktisiooni kasutamine
	select ISNULL('Ingvar', 'No Manager') as Manager

	-- null asemel kuvab No Manager
	select coalesce(NULL, 'No Manager') as Manager

	alter table Employees
	add ManagerId int

	--neile kellel ei ole ülemust, siis paneb neile No Manager teksti
	--kasutage left joini
	select E.Name as Employee, ISNULL(m.Name, 'No Manager') as Manager
	from Employees E
	left join Employees M
	on E.ManagerId = M.Id

	--kasutame inner join
	--kuvab ainult ManagerId all olevate isikute väärtused
	select E.Name as Employee, ISNULL(m.Name, 'No Manager') as Manager
	from Employees E
	inner join Employees M
	on E.ManagerId = M.Id

	--kõik saavad kõikide ülemused olla
	select E.Name as Employee, ISNULL(m.Name, 'No Manager') as Manager
	from Employees E
	cross join Employees M

	--lisame tabelisse uued veerud
	Alter Table Employees
	add MiddleName nvarchar(30)

	alter table Employees
	add LastName nvarchar(30)

	select * from Employees

	--muudame olemas oleva veeru nimetust
	sp_rename 'Employees.Name', 'FirstName'

	update Employees
	set MiddleName = 'Nick'
	where Id = 1

	update Employees
	set LastName = 'Jones'
	where Id = 1

	update Employees
	set LastName = 'Anderson'
	where Id = 2

	update Employees
	set LastName = 'Smith'
	where Id = 4

	update Employees
	set FirstName = NULL
	Where Id = 5

	update Employees
	set MiddleName = 'Todd'
	where Id = 5

	update Employees
	set LastName = 'Someone'
	where Id = 5

	update Employees
	set MiddleName = 'Ten'
	where Id = 6

	update Employees
	set LastName = 'Sven'
	where Id = 6

	update Employees
	set LastName  = 'Connor'
	where Id = 7

	update Employees
	set MiddleName = 'Balerine'
	where Id = 8

	update Employees
	set MiddleName = '007'
	where Id = 9

	update Employees
	set LastName = 'Bond'
	where Id = 9

	Update Employees
	set FirstName = NULL
	where Id = 10

	update Employees
	set LastName = 'Crowe'
	where Id = 10

	select * from Employees

	--igast reast võtab esimesena täidetud lähtri ja kuvab ainult seda
	--
	select Id, coalesce(FirstName, MiddleName, LastName) as Name
	from Employees

	--loome kaks tabelit

	create table IndianCustomers
	(
	Id int identity(1,1),
	Name nvarchar(25),
	Email nvarchar(25),
	)

	create table UKCustomers
	(
	Id int identity(1,1),
	Name nvarchar(25),
	Email nvarchar(25),
	)

	--sisetame tabelisse andmeid
	insert into IndianCustomers (Name,Email)
	values ('Raj', 'R@R.COM'),
	('Sam', 'S@S.COM')

	insert into UKCustomers (Name,Email)
	values ('Ben', 'B@B.COM'),
	('Sam', 'S@S.COM')

	SELECT * from IndianCustomers
	SELECT * from UKCustomers

	--Kasutame union all, mis näitab kõiki ridu
	--union all ühendab tabelite andmeid ja näitab sisu
	Select Id, Name, Email From IndianCustomers
	union all
	Select Id, Name, Email From UKCustomers

	--korduvate väärtustega read pannakse ühte ja ei korrata
	Select Id, Name, Email From IndianCustomers
	union
	Select Id, Name, Email From UKCustomers

	--kasutad union all, aga sorteerid nime järgi
	Select Id, Name, Email From IndianCustomers
	union all
	Select Id, Name, Email From UKCustomers
	Order by name

	--stored procedure
	--tavaliselt pannakse nimetuse ette sp, mis tähendab storedprocedure
	create procedure spGetEmployees
	as begin
		select FirstName, Gender from Employees
	end

	--nüüd saab seda kasutada alati, et näha genderi firstname-i ja genderit
	spGetEmployees
	exec spGetEmployees
	execute spGetEmployees
	--kõik annavad sama tulemuse

	create procedure spGetEmployeesByGenderAndDepartment
	--@ tähendab muutujat
	@Gender nvarchar(20),
	@DepartmentId int
	as begin
	select FirstName, Gender, DepartmentId from Employees 
	where Gender = @Gender
	and DepartmentId = @DepartmentId
	end

	--kui nüüd allolevat käsklust käima panna, siis nõuab gender paremeetrit
	spGetEmployeesByGenderAndDepartment

	--õige variant
	spGetEmployeesByGenderAndDepartment 'Male', 1

	--niimoodi saab sp kirja pandud järjekorda mõõda minna, kui ise paned muutja paika
	spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

	--saab vaadata sp sisu result vaates
	sp_helptext spGetEmployeesByGenderAndDepartment

	--kuidas muuta sp-d ja panna sinna võti peale, et keegi teine peale teie ei saaks muuta
	--kuskile tuleb lisada with encryption
	alter procedure spGetEmployeesByGenderAndDepartment
	@Gender nvarchar(20),
	@DepartmentId int
	with encryption
	as begin
	select FirstName, Gender, DepartmentId from Employees 
	where Gender = @Gender
	and DepartmentId = @DepartmentId
	end

	create proc spGetEmployeeCountByGender
	@Gender nvarchar(20),
	@EmployeeCount int output
	as begin
	select @EmployeeCount = COUNT(Id) from Employees where Gender = @Gender
	end
	--annab tulemuse, kus loendab nõuetele vastavad read
	--prindib ka tulemuse kirja teel
	--tuleb teha declare muutuja @TotalCount, mis on int
	--execute spGetEmployeeCountByGender sp, kus on parameetrid Male ja TotalCount
	--id ja else, kui TotalCount = 0, siis tuleb tekst TotalCount is null
	--lõpus kasuta print @TotalCounti puhul

	declare @TotalCount int

	execute spGetEmployeeCountByGender 'Male', @TotalCount out
	if(@TotalCount = 0)
	print '@TotalCount is null'
	else
	print '@Total is not null'
	print @TotalCount
	






