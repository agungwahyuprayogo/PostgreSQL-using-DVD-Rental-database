/* di tutorial ini kamu akan mempelajari bagaimana cara menggunakan operator 'ANY' di postgreSQL 
untuk mengkomparasikan skala value dengan set query yang ada di subquery

postgreSQL 'ANY' akan membandingkan value yang ada di query utama dengan subquery
kadang kala untuk mengkombinasikan dengan komparasi, menggunakan operator seperti :
=, >, <, >=, <=, dan <>

langsung aja buat table baru biar lebih gampang nangkepnya */

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

CREATE TABLE managers(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO employees (first_name, last_name, salary) 
VALUES
('Bob', 'Williams', 45000.00),
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

select * from employees e 

select * from managers m 

-----------------------------------------------------------------------------------------
-- 1. ANY DENGAN OPERATOR = 
-- buat contoh disini kita mau memndingkan gaji karywawan yang sama gedenya sama gaji manager

select * from employees e 
where salary = any (
	select salary from managers 
)

/* bagaimana cara kerja nya? 
pertama postgreSQL ngeksekusi table managers tersebut, 
lalu karena kita perbadingan salary, maka salari / gaji tiap manager akan di cek satu persatu, 
siapa yang = dengan gaji karyawan. 
karena manager hanya ada 3, perbandinganya gampang 60k, 55k, 58k
karena di employess atau karyawan ada yang 55k juga, maka hasilnya Charlie */
------------------------------------------------------------------------------------

/* 2. any DENGAN operator > 
nyari gaji karyawan mana yang lebih gede dari manager? */

SELECT * FROM employees 
WHERE salary > ANY (
    SELECT salary FROM managers
  );
 
/* bagaimana cara kerjanya? 
karena manager ada 55k, 58k dan 60k, maka gaji yang terkecil ini (manager 55k) sebagai acuan
nah kalo udah, bakal ngoreksi lagi nih, gaji karyawan mana yang gaji nya lebih gede dari 55k
ternyata Jack (56k) dan Liam (59k)
-----------------------------------------------------------------------------------
 
3. ANY DENGAN operator <
 nyari gaji karyawan yang lebih kecil dari manager */

select * from employees e 
where salary < any (
	select salary 
	from managers m)
-- maka hasilnya paling banyak muncul