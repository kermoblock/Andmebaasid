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

  Create Table Person
  (
  id int not null primary key,
  name nvarchar(30),
  Email nvarchar(30),
  GenderId int
  )

 


