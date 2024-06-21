/* FULL OUTER JOIN
 * 
 * jadi FULL OUTER JOIN mengkobinasikan data dari 2 tabel 
 * dan mengeluarkan semua data dari 2 table berbedea 
 * termasuk yg matching dan yang ga maching
 * 
 * gampangnya full outer ini combinasi antara left join dan right join
 * secara basic, syntaxnya kaya gini :
 * SELECT
 * 	list_kolom
 * from 
 * 	table1 
 * full outer join table2
 * 	on table1.nama_kolom on table2.nama_kolom
 * 
 * bagaimana sih cara kerja dari FULL OUTER JOIN ?
 * 1.) dimulai dari hasil kosong
 * 2.) mengidentifikasi baris di table1 dan table2 yang kolomnya sama
 * 3.) menampilkan yang sama, left join dulu, baru right join
 * 4.) menampilkan baris yg matcing, left join, dan right join
 * 
 * saatnya buat contoh :
 * 
 */

create table departments (
	departments_id serial primary key,
	departments_name varchar (255) not null
);

create table employees (
	employee_id serial primary key,
	employee_name varchar (255),
	department_id integer 
);

-- kita tambahin 

insert into departments (departments_name)
values 
		('Sales'),
		('Marketing'),
		('HR'),
		('IT'),
		('Production');
 
INSERT INTO employees (employee_name, department_id) 
VALUES 
	('Bette Nicholson', 1), 
 	('Christian Gable', 1), 
 	('Joe Swank', 2), 
  	('Fred Costner', 3), 
  	('Sandra Kilmer', 4), 
  	('Julia Mcqueen', NULL);

 
 -- sekarang kita coba tampilin dulu table department
 select * from departments d 
 
 select * from employees e 
 
 -- BASIC FULL OUTER JOIN
 -- pake yang gampang ae ye biar bisa keliatan bedanya
 
 select 
 	e.employee_name, 
 	d.departments_name 
 from 
 	employees e 
 full outer join departments d 
 	on d.departments_id = e.department_id 
-- dari sini keliatan, kalo pertama nyocokin dulu baris yang sama (inner)
-- trus kalo abis ke left dulu, baru ke right
 	
-- sekarang latihan kalo make null
 
 select 
 	e.employee_name, 
 	d.departments_name 
 from 
 	employees e 
 full outer join departments d 
 	on d.departments_id = e.department_id 
 where e.employee_name is null
 
 select 
 	e.employee_name, 
 	d.departments_name 
 from 
 	employees e 
 full outer join departments d 
 	on d.departments_id = e.department_id 
 where d.departments_name is null