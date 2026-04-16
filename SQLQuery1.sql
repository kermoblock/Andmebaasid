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

	--näitab ära mitu rida vastab nõuetele

	--deklareerime muutuja @TotalCount, mis on int andmetüüp
	declare @TotalCount int
	--käivitame stored procedure spGetEmployeeCountByGender, kus on parameetrid
	--@EmployeeCount = @TotalCount out ja @Gender
	exec spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
	--prindib konsooli välja, kui TotalCount on null või mitte null
	print @TotalCount

	--sp sisu vaatamine
	sp_help spGetEmployeeCountByGender
	--tabeli info vaatamine
	sp_help
	--kui soovid sp teksti näha
	sp_helptext spGetEmployeeCountByGender

	--vaatame, millest sõltub meie valitud sp
	sp_depends spGetEmployeeCountByGender
	--näitab, et sõltub Employees tabelist, kuna seal on count(Id)
	-- ja Id on Employees tabelis

	--vaatame tabelit
	sp_depends Employees

	--teeme sp, mis annab andmeid Id ja Name veergude kohta Employees tabelis
	create procedure spGetNamebyId
	@Id int,
	@Name nvarchar(20) output
	as begin
	select @Id = Id, @Name = FirstName from Employees
	end

	--annab kogu tabeli ridade arvu
	create proc spTotalCount2
	@TotalCount int output
	as begin
	select @TotalCount = COUNT(Id) from Employees
	end

	--on vaja teha uus päring, kus kasutame SpTotalCount2 sp-d, 
	--et saada tabelite ridade arv
	--tuleb deklareerida muutuja @TotalCount, mis on int andmetüüp
	--tuleb execute spTotalCount2, kus parameeter @TotalCount = @TotalCount out
	declare @TotalCount int

	execute spTotalCount2
	@TotalCount = @TotalCount out
	select @TotalCount

	--mis Id all on keegi nime järgi
	create proc spGetNameById1
	@Id int,
	@FirstName nvarchar(20) output
	as begin
	select @FirstName = FirstName From Employees where Id = @Id
	end

	--annab tulemuse, kus id 1 (seda numbrit saab muuta) real on keegi koos nimega
	--print tuleb kasutada, et näidata tulemust

	declare @FirstName nvarchar(20)

	execute spGetNameById1 7,
	@FirstName output
	print 'Name of the employee = ' +  @FirstName

	--tehke sama mis eelmine, aga kasutage spGetNameById sp-d
	--FirstName lõpus on out

	declare @Name nvarchar(20)
	execute spGetNameById 1,
	@Name Out
	print 'Name of the Employee = ' + @Name

	--output tagastab muudetud read kohe päringu tulemusena
	--see on salvestatud protseduuris ja ühe väärtuse tagastamine
	--out ei anna mitte midagi, kui seda ei määra execute käsus

	sp_help spGetNameById

	create proc spGetNameById2
	@Id int
	--kui on begin, siis on ka end kuskil olemas
	as begin
		return (select FirstName from Employees where Id = @Id)
	end

	--tuleb veateade kuna kutsusime välja int-i, aga "Tom" on nvarchar
	declare @EmployeeName nvarchar(50)
	exec @EmployeeName = spGetNameById2 1
	print 'Name of The Employee = ' + @EmployeeName

	--sisseehitatud string funktsioonid
	--see konverteerib ASCII tähe väärtuse numbriks
	select ASCII('A')

	select CHAR(122)

	--prindime kogu tähestiku välja
	--kasutate while, et näidata kogu tähestik ette
	declare @Start int
	set @Start = 97 
	while (@Start <= 122)
	begin
		select CHAR(@Start)
		set @Start = @Start + 1
	end

	--eemaldame tühjad kohad sulgudes
	select LTRIM('                    Hello')
	select ('                    Hello')

	--tühikute eemaldamine veerust, mis on tabelis
	select FirstName, MiddleName, LastName from Employees
	select lTRIM(FirstName) as FirstName, MiddleName, LastName from Employees

	--paremalt poolt tühjad stringid lõikab ära
	select RTRIM('               Hello                    ')
	select ('             Hello                    ')

	--keerab kooloni sees olevad andmed vastupidiseks
	--vastavalt lower-ga ja upper-ga saan muuta märkide suurust
	--reverse funktsioon pöörab kõik ümber
	select REVERSE(upper(ltrim(FirstName))) as FirstName, MiddleName, LOWER(LastName),
	rtrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
	from Employees

	--left, right, substring
	--vasakult poolt neli esimest tähte
	select LEFT('ABCDEF', 4)
	--paremalt poolt kolm esimest tähte
	select right('ABCDEF', 3)

	--kuvab @-tähemärgi asetust ehk mitmes on @-märk
	select CHARINDEX('@', 'sara@aaa.com')

	--esimene nr peale komakohta näitab, et mitmendast alustab ja
	--siis mitu nr peale seda kuvab
	select SUBSTRING('pam@bbb.com', 5, 4)

	-- @-märgist kuvab kolm tähemärki. Viimase nr-ga saab määrata pikkust
	select SUBSTRING('pam@bbb.com', charindex('@', 'pam@bbb.com') + 1, 3)

	--peale @-märki hakkab kuvama tulemst, nr saab kaugust seadistada
	select SUBSTRING('pam@bbb.com', charindex('@', 'pam@bbb.com') + 2,
	LEN('pam@bbb.com') - charindex('@', 'pam@bbb.com'))

	alter table Employees
	add Email nvarchar(20)

	insert into Employees (Email)
	values ('Tom@aaa.com'),
	('Pam@bbb.com'),
	('John@aaa.com'),
	('Sam@bbb.com'),
	('Todd@bbb.com'),
	('Ben@ccc.com'),
	('Sara@cc.com'),
	('Valarie@aaa.com'),
	('James@bbb.com'),
	('Russel@bbb.com'),
	update Employees
	set Email = Case Id
	when 1 then 'Tom@aaa.com'
	when 2 then'Pam@bbb.com'
	when 3 then 'John@aaa.com'
	when 4 then 'Sam@bbb.com'
	when 5 then 'Todd@bbb.com'
	when 6 then 'Ben@ccc.com'
	when 7 then 'Sara@cc.com'
	when 8 then 'Valarie@aaa.com'
	when 9 then 'James@bbb.com'
	when 10 then 'Russel@bbb.com'
	end
	select * from Employees

	--soovime teada saada domeenimesid emailides
	select substring (Email, Charindex('@', Email) + 1,
	len(Email) - charindex('@', Email)) as EmailDomain
	from Employees

	--alates teisest tähest emailis kuni @ märgini on tärnid
	select FirstName, LastName,
	substring(Email, 1, 2) +
	REPLICATE('*', 5) +
	substring (Email, charindex('@', Email), len(Email) - charindex('@' Email)+1) as Emails

	from Employees

	--kolm korda näitab stringis olevat väärtust
	selecct REPLICATE('asd', 3)
	c
	--tühiku sisestacmine
	select SPACE(5)c
	ncncncncncncncc
	--tühiku sisestamine FirstName ja LastName vahele
	SELECT FirstName + SPACE(25) + LastName AS FullName
	FROM Employees;
	
	--PATINDEX
	--sama, mis charindex, aga dünaamilisem ja saab kasutada wildcardi
	select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
	from Employees
	where PATINDEX('%@aaa.com', Email) > 0
	--leian kõik selle domeeni esindajad ja alates mitmendast märgist algab @

	--kõik .com emailid asendab .net-ga
	SELECT Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
	FROM Employees;
	
	--soovin asendada peale esimest märki kolm tähte viie tärniga
	Select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
	from Employees

	create table DateTime
	(
		c_time time,
		c_date date,
		c_smalldatetime smalldatetime,
		c_datetime datetime,
		c_datetime2 datetime2,
		c_datetimeoffset datetimeoffset
	)

	select * from DateTime

	--konkreetse masina kellaaeg
	select GETDATE(), 'GETDate()'

	insert into DateTime
	values (GETDATE(), GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())

	select * from DateTime

	update DateTime set c_datetimeoffset = '2027-03-19 14:25:28.7533333 +10:00'
	where c_datetimeoffset = '2026-03-19 14:25:28.7533333 +00:00'

	select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' --aja päring
	select SYSDATETIME(), 'SYSDATETIME' --veel täpsem aja päring
	select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --täpne aeg koos ajalise nihkega
	select GETUTCDATE(), 'GETUTCDATE' --UTC aeg

	--saab kontrollida, kas on õige andmetüüp
	select ISDATE('asd') -- tagastab 0 kuna string ei ole date

	--kuidas saada vastuseks 1 isdate puhul
	select ISDATE('2029-03-19')
	select ISDATE(getdate())

	select ISDATE('2026-03-19 14:25:28.7533333') --tagastab 0 kuna max kolm komakohta võib olla
	select ISDATE('2026-03-19 14:25:28.753') --tagastab 1

	select DAY(getdate()) --annab tänase päeva numbri

	select DAY('04/01/2026') --annab stringis oleva kuupäeva ja järjestus peab olema õige
	--(päev/kuu/aasta)

	select month(getdate()) --annab jooksva kuu numbri
	select month('01/04/2026') --annab stringis oleva kuu ja järjestus peab olema õige

	select year(getdate()) --annab jooksva aasta numbri
	select year('01/04/2026') --annab stringis oleva aasta ja järjestus peab olema õige

	select DATENAME(day, '2026-03-19 14:25:28.753') --tuvastab ära päeva numbri
	select DATENAME(weekday, '2026-03-19 14:25:28.753') --annab stringis oleva päeva sõnana
	select DATENAME(month, '2026-03-19 14:25:28.753') --annab stringis oleva kuu sõnana

	create table EmployeesWithDates
	(
		Id nvarchar(2),
		Name nvarchar(20),
		DateOfBirth datetime
	)

	select * from EmployeesWithDates
	insert into EmployeesWithDates (Id, Name, DateOfBirth)
	values ('1', 'Sam', '1980-12-30 00:00:00.000'),
	('2', 'Pam', '1982-09-01 12:02:36.260'),
	('3', 'John', '1985-08-22 12:03:30.370'),
	('4', 'Sara', '1979-11-29 12:59:30.670')

	select * from EmployeesWithDates
truncate table EmployeesWithDates
--- rida 861
--- tund 9

--kuidas võtta ühest veerust andmeid ja selle abil luua uued veerud
 
--vaatab DoB veerust päeva ja kuvab päeva nimetuse sõnana
select Name, DateOfBirth, Datename(weekday, DateOfBirth) as [Day],
	--vaatab VoB veerust kuupäevasid ja kuvab kuu nr 
	Month(DateOfBirth) as MonthNumber,
	--vaatab DoB veerust kuud ja kuvab sõnana
	DateName(Month, DateOfBirth) as [MonthName], 
	--võtab DoB veerust aasta
	Year(DateOfBirth) as [Year]
from EmployeesWithDates

--kuvab 3 kuna USA nädal algab pühapäevaga
select Datepart(weekday, '2026-03-24 12:59:30.670')
--tehke sama, aga kasutage kuu-d
select Datepart(month, '2026-03-24 12:59:30.670')
--liidab stringis olevale kp 20 p'eva juurde
select Dateadd(day, 20, '2026-03-24 12:59:30.670')
--lahutab 20 päeva maha
select Dateadd(day, -20, '2026-03-24 12:59:30.670')
--kuvab kahe stringis oleva kuudevahelist aega nr-na
select datediff(month, '11/20/2026', '01/20/2024')
--tehke sama, aga kasutage aastat
select datediff(year, '11/20/2026', '01/20/2028')

-- alguses uurite, mis on funktsioon MS SQL
-- eelkirjutatud toimingud, salvestatud tegevus
-- miks seda on vaja
--pakkuda DB-s korduvkasutatud funktsionaalsust
-- mis on selle eelised ja puudused
--saad kiiresti kasutada toiminguid ja ei pea uuesti koodi kirjutama
--funktsioon ei tohi muuta DB olekut

create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
	select @tempdate = @DOB

	select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) >
	month(getdate())) or (month(@DOB) = month(getdate()) and day(@DOB) > day(getdate()))
	then 1 else 0 end
	select @tempdate = dateadd(year, @Years, @tempdate)

	select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) 
	then 1 else 0 end
	select @tempdate = dateadd(MONTH, @months, @tempdate)

	select @days = datediff(day, @tempdate, getdate())

	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2))
		+ ' Months ' + cast(@days as nvarchar(2)) + ' Days old '
	return @Age
end

select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age from EmployeesWithDates

--rida 902
--tund 10
--31.03.2026

--kui kasutame seda funktsiooni, siis saame teada tänase päeva vahet stringis välja tooduga
select dbo.fnComputeAge('02/24/2010') as Age

-- nr peale DOB muutujat näitab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 108) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] from EmployeesWithDates

select cast(getdate() as date) --tänane kp
--tänane kp, aga kasutate convert-i, et kuvada stringina
select convert(date, getdate())

--matemaatilised funktsioonid
select ABS(-5) --abs on absoluutväärtusega number ja tulemuseks saame ilma miinus märgita 5
select CEILING(4.2) --ceiling on funktsioon, mis ümardab ülespoole ja tulemuseks saame 5
select CEILING(-4.2) --ceiling ümardab ka miinus numbrid ülespoole, mis tähendab, et saame -4
select floor(15.2) --floor on funktsioon, mis ümardab alla ja tulemuseks saame 15
select floor(-15.2) --floor ümardab ka miinus numbrid alla, mis tähendab, et saame -16
select power(2, 4) --kaks astmes neli
select square(9) --antud juhul 9 ruudus
select sqrt(16) --antud juhul 16 ruutjuur

select rand() --rand on funktsioon, mis genereerib 
--juhusliku numbri vahemikus 0 kuni 1
--kuidas saada täisnumber iga kord
select floor(rand() * 100) --korrutab sajaga iga suvalise numbri

--iga kord näitab 10 suvalist numbrit
declare @counter int
set @counter = 1
while (@counter <= 10)
begin
	print floor(rand() * 100)
	set @counter = @counter + 1
end

select ROUND(850.556, 2) 
--round on funktsioon, mis ümardab kaks komakohta 
--ja tulemuseks saame 850.56
select ROUND(850.556, 2, 1) 
--round on funktsioon, mis ümardab kaks komakohta ja 
--kui kolmas parameeter on 1, siis ümardab alla
select ROUND(850.556, 1)
--round on funktsioon, mis ümardab ühe komakoha ja
--tulemuseks saame 850.6
select ROUND(850.556, 1, 1) --ümardab alla ühe komakoha pealt 
--ja tulemuseks saame 850.5
select ROUND(850.556, -2) --ümardab täisnr ülessepoole ja tulemus on 900
select ROUND(850.556, -1) --ümardab täisnr alla ja tulemus on 850

---
create function dbo.CalculateAge(@DOB date)
returns int
as begin 
declare @Age int

	set @Age = DATEDIFF(year, @DOB, GETDATE()) - 
	case 
		when (MONTH(@DOB) > MONTH(GETDATE())) or 
			 (MONTH(@DOB) = MONTH(GETDATE()) and DAY(@DOB) > DAY(GETDATE())) 
			 then 1 else 0 end
	return @Age
end

--kui valmis, siis proovige seda funktsiooni 
--ja vaadake, kas annab õige vanuse
exec dbo.CalculateAge '1980-12-30'

--arvutab välja, kui vana on isik ja võtab arvesse kuud ning päevad
--antud juhul näitab kõike, kes on üle 36 a vanad
select Id, Name,  dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 36

--- rida 970
--- tund 11
--- 02.04.2026

--- inline table valued functions
alter table EmployeesWithDates
add DepartmentId int
alter table EmployeesWithDates
add Gender nvarchar(10)

select * from EmployeesWithDates

update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 1
update EmployeesWithDates set Gender = 'Female', DepartmentId = 2
where Id = 2
update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 3
update EmployeesWithDates set Gender = 'Female', DepartmentId = 3
where Id = 4
insert into EmployeesWithDates (Id, Name, DateOfBirth, DepartmentId, Gender)
values (5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')

-- scalar function annab mingis vahemikus olevaid andmeid, 
-- inline table values ei kasuta begin ja end funktsioone
-- scalar annab väärtused ja inline annab tabeli
create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
		from EmployeesWithDates
		where Gender = @Gender)

--kuidas leida kõik naised tabelis EmployeesWithDates
-- ja kasutada funktsiooni fn_EmployeesByGender
select * from fn_EmployeesByGender('female')

--tahaks ainult Pami nime näha
select * from fn_EmployeesByGender('female')
where Name = 'Pam'

select * from Department

--kahest erinevast tabelist andmete võtmine ja 
--koos kuvamine 
--esimene on funktsioon ja teine tabel

select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D on D.Id = E.DepartmentId

--multi tabel statement
--inline funktsioon
create function fn_GetEmployees()
returns table as
return (select Id, Name, cast(DateOfBirth as date)
		as DOB
		from EmployeesWithDates)

select * from fn_GetEmployees()

--multi-state puhul peab defineerima uue tabeli veerud koos muutujatega
--funktsiooni nimi on fn_MS_GetEmployees()
--peab edastama meile Id, Name, DOB tabelist EmployeesWithDates
create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, CAST(DateOfBirth as date) from EmployeesWithDates
	return
end

select * from fn_MS_GetEmployees()

--- inline tabeli funktsioonid on paremini töötamas kuna käsitletakse vaatena
--- multi puhul on pm tegemist stored proceduriga ja kulutab ressurssi rohkem

--	muudame andmeid ja vaatame, kas inline funktsioonis on muutused kajastatud
update fn_GetEmployees() set Name = 'Sam1' where Id = 1 
select * from fn_GetEmployees() --saab muuta andmeid

update fn_MS_GetEmployees() set Name = 'Sam2' where Id = 1
--	ei saa muuta andmeid multi state funktsioonis, 
--	kuna see on nagu stored procedure

--deterministic vs non-deterministic functions
--deterministic funktsioonid annavad alati sama tulemuse, kui sisend on sama
select count(*) from EmployeesWithDates
select SQUARE(4)

--non-deterministic funktsioonid annavad erineva tulemuse, kui sisend on sama
select getdate()
select CURRENT_TIMESTAMP
select rand()

--loome funktsioni
create function fn_GetNameById(@Id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

--kasutame funktsiooni, leides Id 1 all oleva inimene
select dbo.fn_GetNameById(1)

select * from EmployeesWithDates

sp_helptext fn_GetNameById

--nüüd muudate funktsiooni nimega fn_GetNameById
--ja panete sinna encryptioni, etkeegi peale teie ei nääks sisu

alter function fn_GetNameById(@Id int)
returns nvarchar(30)
with encryption
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

--kasutame schemebindingut, et näha, mis on funktsiooni sisu
alter function fn_GetNameById(@Id int)
returns nvarchar(30)
with schemabinding
as begin
	return (select Name from dbo.EmployeesWithDates where Id = @Id)
end
--schemabinding tähendab, et kui keegi üritab muuta EmployeesWithDates
--tabelit, siis ei lase seda teha, kuna see on seotud
--fn_GetNameById funkstiooniga

--ei saa kustutada ega muuta tabelit EmployeesWithDates,
--kunda see on seotud fn_GetNameById funktsiooniga
drop table dbo.EmployeesWithDates

--temporary tables
--see on olemas ainult selle sessiooni jooksul
--kasutatakse # sümbolit, et saada aru, et tegemist on temporary tabeliga

create table #PersonDetails
(
	Id int,
	Name nvarchar(20)
)

insert into #PersonDetails values
(1, 'Sam'),
(2, 'Pam'),
(3, 'John')

select * from #PersonDetails

--Temporary tabelite nimekirja ei näe, kui kasutada sysobjects
--tabelit, kuna need on ajutised
select Name from sysobjects
where name like '#PersonDetails%'

--kustutada temporary table
drop table #PersonDetails

--loome sp, mis loob temporary tabeli ja paneb sinna andmed
create proc spCreateLocalTempTable
as begin
	create table #PersonDetails (Id int, Name nvarchar(20)

	insert into #PersonDetails values (1, 'Sam')
	insert into #PersonDetails values (2, 'Pam')
	insert into #PersonDetails values (3, 'John')

	select * from #PersonDetails
end

--globaalne temp tabel on olemas kogu
--serveris ja kõigile kasutajatele, kes on ühendatud
create table ##GlobalPersonDetails (Id int, Name nvarchar(20))

--index
create table EmployeeWithSalary
(
	Id int primary key,
	Name nvarchar(20),
	Salary int,
	Gender nvarchar(10)
)

insert into EmployeeWithSalary values
(1, 'Sam', 2500, 'Male'),
(2, 'Pam', 6500, 'Female'),
(3, 'John', 4500, 'Male'),
(4, 'Sara', 5500, 'Female'),
(5, 'Todd', 3100, 'Male')

select * from EmployeeWithSalary

--otsime inimesi, kelle palgavahemik on 5000 kuni 7000
select * from EmployeeWithSalary
where
Salary between 5000 and 7000

--loome indexi Salary veerule, et kiirendada otsingut
--mis asetab andmed Salary veeru järgi järjestatud
create index IX_EmployeeSalary 
on EmployeeWithSalary(Salary asc)

--saame teada, et mis on selle tabeli primaarvõti ja index
exec sys.sp_helpindex @objname = 'EmployeeWithSalary'

--tahaksin indeki kasutada, et otsing oleks kiirem
select * from EmployeeWithSalary
where
Salary between 5000 and 7000

--näitab, et kasutatakse indeksi IX_EmployeeSalary,
--kuna see on järjestatud Salary veeru järgi
select * from EmployeeWithSalary with (index(IX_EmployeeSalary))

--indeksi kustutamine
drop index IX_EmployeeSalary on EmployeeWithSalary --1 variant
drop index EmployeeWithSalary.IX_EmployeeSalary --2 variant

---- Indeksi tüübid:
--1. Klastrites olevad
--2. Mitte-Klastrites olevad
--3. Unikaalsed
--4. Filtreeritud
--5. XML
--6. Täistekst
--7. Ruumiline
--8. Veerusäilitav
--9. Veergude indeksid
--10. Välja arvatud veergudega indeksid

--Klastirs olev indeks määrab ära tabelis oleva füüsilise järjestuse
-- ja selle tulemusel saab tabelis olla ainult üks klastris olev indeks

create table EmployeeCity
(
	Id int primary key,
	Name nvarchar(20),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeCity
--andmete õige järjestuse loovad klastris olevad indeksid
-- ja kasutab selleks Id nr-t
-- sest antud juhul on Id primaarvõti
Insert into EmployeeCity values(3, 'John', 4500, 'Male', 'New York')
Insert into EmployeeCity values(1, 'Sam', 2500, 'Male', 'London')
Insert into EmployeeCity values(4, 'Sara', 5500, 'Female', 'Tokyo')
Insert into EmployeeCity values(5, 'Todd', 3100, 'Male', 'Toronto')
Insert into EmployeeCity values(2, 'Pam', 6500, 'Female', 'Sydney')

--Klastris olevad indeksid dikteerivad säilitatud andmete järjestuse tabelis
-- ja seda saab klastrite puhul olla ainult üks

select * from EmployeeCity
create clustered index IX_EmployeCityName
on EmployeeCity(Name)
--põhjus, miks ei saa luua klastris olevat
--indeksit Name veerule on see, et tabelis on juba klastris
--olev indeks Id veerul, kuna see on primaarvõti

--loome composite indeksi, mis tähendab, et see on mitme veeru indeks
--enne tuleb kustutada klastris olev indeks, kuna composite indeks
-- on klastris olev indeksi tüüp
create clustered index IX_EmployeeGenderSalary
on EmployeeCity(Gender desc, Salary asc)
--kui teed select päringu sellele tabelile, siis peaksid nägema andmeid,
-- mis on järjestatud selliselt: Esimeseks võetakse aluseks Gender veerg
-- kahanevad järjestuses ja siis Salary veerg tõusvas järjestuses
select * from EmployeeCity

--mitte klastris olev indeks on eraldi struktuur,
-- mis hoiab indeksi veeru väärtusi
create nonclustered index IX_EmployeeCityName
on EmployeeCity(Name)
-- kui nüüd teed select päringu, siis näed, et andmed on
--järjestatud Id veeru järgi
select * from EmployeeCity

--erinevused kahe indeksi vahel
-- 1. ainult üks klastris olev indeks saab olla tabeli peale,
-- mitte klastris olevaid indeksid saab olla mitu
-- 2. Klastris olevad indeksid on kiiremad kuna indeks peab tagasi
-- viitama tabelile juhul, ki selekteeritud veerg ei ole olemas indeksis
-- 3. Klastris ole indeks määratleb ära tabeli ridade salvestusjärjestuse
-- ja ei nõua kettal lisa ruumi. Samas mitte klastirs olevad indeksid on
-- salvestatud tabelist eraldi ja nõuab lisa ruumi

create table EmployeeFirstName
(
	iD int Primary key,
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName

Insert into EmployeeFirstName values(1, 'John', 'Smith', 4500, 'Male', 'New York')
Insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 2500, 'Male', 'London')

drop index EmployeeFirstName.PK__Employee__3213E81F95B2AB44
-- kui käivitad ülevalpool oleva koodi, siis tuleb veateade
-- et SQL server kasutab UNIQUE ineksit jõustamaks väärtuste
-- unikaalsust ja primaarvõtit koodiga Unikaalseid Indekseid
-- ei saa kustutada, aga käsitsi saab

create unique nonclustered index UIX_Employee_FirstName_LastName
on EmployeeFirstName(FirstName, LastName)

--lisame uue piirangu peale
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstNameCity
unique nonclustered (City)

--sisestage kolmas ride andmetega, mis on Id-s 3, FirstName-s John,
--LastName-s Menco ja Linn on London
insert into EmployeeFirstName values(3, 'John', 'Menco', NULL, NULL, 'London')

--saab vaadata indeksite infot
exec sp_helpconstraint EmployeeFirstName

--1. vaikimisi primaarvõti loob unikaalse klastris oleva indeksi,
--samas unikaalne piirang loob unikaalse mitte-klastris oleva indeksi
--2. unikaalset indeksit või piirangut ei saa luua olemasolevasse tabelis
-- kui tabel juba sisaldab väärtusi võtmeveerus
--3. Vaikimisi korduvaid väärtuseid ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks või piirang. Nt, kui tahad sisestada
-- 10 rida andmeid, millest 5 sisaldavad korduvaid andmeid,
-- siis kõik 10 lükatakse tagasi. Kui soovin ainult 5
-- rea tagasi lükkamist ja ülejäänud 5 rea sisestamist, siis selleks
-- kasutatakse IGNORE_DUP_KEY

--Näide
create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

Insert into EmployeeFirstName values(3, 'John', 'Menco', 3512, 'Male', 'London')
Insert into EmployeeFirstName values(3, 'John', 'Menco', 3123, 'Male', 'London1')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3220, 'Male', 'London1')
--enne ignore käsku oleks kõik kolm rida tagasi lükatud, aga
-- nüüd läks keskmine rida läbi kuna linna nimi oli unikaalne

--view on virtuaalne tabel, mis on loodud ühe või mitme tabeli põhjal
select FirstName Salary, Gender, DepartmentName
from Employees
join Department
on Department.Id = Employees.DepartmentId

create view vw_EmployeesByDetails
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Department.Id = Employees.DepartmentId
--otsige ülesse view

--kuidas view-d kasutada: vw_EmployeesByDetails
select * from vw_EmployeesByDetails
-- view ei salvesta andmeid vaikimisi
-- seda tasib võtta, kui salvestatud virtuaalse tabelina

--milleks vaja:
-- saab kasutada andmebaasi skeemi keerukuse lihtsustamiseks
-- mitte IT-inimesele
-- piiratud ligipääs andmetele, ei näe kõiki veerge

--teeme view, kus näeb ainult IT töötajaid
create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Department.Id = Employees.DepartmentId
where Department.DepartmentName = 'IT'
--ülevalpool olevat päringut saab liigitada reataseme turvalisuse
-- alla. Tahan ainult näidata IT osakonna töötajaid
select * from vITEmployeesInDepartment


