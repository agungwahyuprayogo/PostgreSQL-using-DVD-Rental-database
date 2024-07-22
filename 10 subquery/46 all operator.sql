/* POSTGRESQL ALL OPERATOR

di tutorial ini kita akan belajar bagaimana menggunakan PostgreSQL 'all' operator 
untuk membandingkan value dengan daftar list dari subquery

---------------------------------------------------------------------------------------------
Overview

PostgreSQL 'All' operator mengizinkan anda untuk membandingkan sebuah value dengan semua value
yang dibuat oleh subquery

basic syntax-nya adalah sebagai berikut :
expression operator ALL(subquery)

* operator 'All' harus didahului dengan operator perbandingan seperti sama dengan (=), tidak sama 
  dengan (<>), lebih besar dari (>), lebih kecil dari (<), lebih dari sama dengan (>=), dan kurang
  dari sama dengan (<=)
* operator 'All' harus diikuti subquery yang diawali dengan tanda kurung

kalo hasil bisa mirip kaya any, tapi cara kerjanya beda 
kalo cara kerja any, dibandingin satu satu
kalo all langsung di bandingin antara valuden dengan list dari sub query */

drop table if exists employess

create table karyawan (
	id serial primary key,
	first_name varchar (30) not null,
	last_name varchar(30) not null,
	salary decimal(10,2) not null
);

drop table if exists managers 

create table managers (
	id serial primary key,
	first_name varchar (30) not null,
	last_name varchar(30) not null,
	salary decimal(10,2) not null
);
----------------------------------------------------------------------------------------------
INSERT INTO karyawan (first_name, last_name, salary) 
VALUES
('Bob', 'Williams', 75000.00),
('Charlie', 'Davis', 55000.00),
('David', 'Jones', 50000.00),
('Emma', 'Brown', 48000.00),
('Frank', 'Miller', 52000.00),
('Grace', 'Wilson', 49000.00),
('Harry', 'Taylor', 53000.00),
('Ivy', 'Moore', 47000.00),
('Jack', 'Anderson', 56000.00),
('Kate', 'Hill',  44000.00),
('Liam', 'Clark', 59000.00),
('Mia', 'Parker', 42000.00);

INSERT INTO managers(first_name, last_name, salary) 
VALUES
('John', 'Doe',  60000.00),
('Jane', 'Smith', 55000.00),
('Alice', 'Johnson',  58000.00);
----------------------------------------------------------------------------------------
/* menggunakan all operator dengan operator '>' lebih besar dari
 contoh penggunaan operator > dengan contoh kasus :
 karyawan mana yang gaji nya lebih besar dari semua manager (inget, make operator >)
 */

SELECT 
  * 
FROM 
  karyawan k 
WHERE 
  salary > ALL(
    select 
      salary 
    from 
      managers
  );
 -- dari sini keliatan, Bob Williams gajinya diatas para manager karena gajinya 75k
 -- sedangkan para manager hanya 60k, 50k dan 58k
 -- otomatis 'True' kalo yg tampil Bob Williams karena gajinya 75k bemjir 

 ------------------------------------------------------------------------------------------

 /* kebalikanya dari tadi, sekarang kita pen nyari gaji karyawan mana yg sama kaya manager */

SELECT 
  * 
FROM 
  karyawan
WHERE 
  salary = ALL(
    select 
      salary 
    from 
      managers
  )
ORDER BY salary DESC;
-- wkkwk ga ada

select * from managers
------------------------------------------------------------------------------------------

SELECT * FROM karyawan 
WHERE salary <= ALL( select salary from managers ) 
ORDER BY salary DESC;
/* di subquery all, subquery nyimpen 55k, 58k, 60k
kalo udah, semua gaji yang ada di karyawan cek satu persatu ada yg sama ga (karena <=)
kalo ada yg sama, disimpen (misal Charlie Davis gajinya 55k, sama kaya manager jane Smith) 

trus cari yg di bawah 55k, tentu banyak hasilnya */