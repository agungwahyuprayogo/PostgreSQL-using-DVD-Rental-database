/* -------- SELF JOIN ------
 
 Cara paling gampang untuk ilustrasi self join adalah table karyawan
 yang terdiri dari id_employee, name, id_manager
 
 dalam bentuk data seperti ini biasanya
 	(1, 'Director', 'Hartono', 'Sutejo', null),
	(2, 'Manager IT', 'Chandra', 'Alexandre', 1),
	(3, 'Manager Marketing', 'Reza', 'Rahardian', 1)

misal manager marketing, pak reza, kalo dilihat sekilas id_manager dia adalah Hartono, karena dia direkturnya
tapi kalo data kaya gitu gaenak banget diliat, kek misal ditanya "siapa manager/atasanya?" "yg id karyawanya 1"
kan kaga enak tuh, makanya untuk perapihan data, alangkah baiknya dibikin self join
buat nampilin siapa nama manager masing2 karyawan
 
 penggambaranya seperti ini
 Direktur 			 		Hartono
 manager	 		 Chandra 		|			    Reza
 anak buah    Agung, Dedi, Nugi	|		Qisty, Azizi, Irvan
 */

create table employee (
	employee_id int primary key, 
	position varchar (255) not null, 
	first_name varchar (255) not null, 
	last_name varchar (255) not null, 
	manager_id int, 
	foreign key (manager_id) references employee (employee_id) on delete cascade
);

/* FOREIGN KEY (manager_id) REFERENCES employee (employee_id) ON DELETE CASCADE: 
 * Ini adalah bagian dari definisi kolom manager_id. 
 * Ini menunjukkan bahwa nilai dalam kolom manager_id harus ada dalam kolom employee_id tabel “employee”. 
 * Juga, ketika baris dengan ID manajer dihapus, 
 * baris yang terkait dengan ID manajer tersebut juga akan dihapus (CASCADE). 
 */

-- lupa anjer ada first name last name
insert into employee (employee_id, position, first_name, last_name, manager_id)
values 
	(1, 'Director', 'Hartono', 'Sutejo', null),
	(2, 'Manager IT', 'Chandra', 'Alexandre', 1),
	(3, 'Manager Marketing', 'Reza', 'Rahardian', 1),
	(4, 'IT Support', 'Dedi', 'Cahyadi', 2),
	(5, 'Technique Specialist', 'Nugi', 'Purnomo', 2),
	(6, 'Programming', 'Agung', 'Wahyu', 2),
	(7, 'Marketing Serena', 'Qisty', 'Amanda', 3),
	(8, 'Marketing Khong Guan', 'Azizi', 'Putriani', 3),
	(9, 'Marketing Jacobis', 'Irvan', 'Faturahman', 3);

select * from employee e 
-- tadi kita udah buat column manager dan konek sama kolom employee
-- jadi kalo manager ke hapus, anak buahnya ikut ke hapus
-- nah maksud dari Hartono manager_idnya null karena, dia udah diposisi direktur,
-- paling atas diperusahaan

select
	karyawan.position,
  	karyawan.first_name || ' ' || karyawan.last_name nama_karyawan, 
  	manager.first_name || ' ' || manager.last_name manager 
FROM 
  	employee karyawan 
 INNER JOIN 
 	employee manager ON manager.employee_id = karyawan.manager_id -- joinnya make id 
ORDER BY 
 	manager;
  
-- 2. nyoba make data dvd rental
-- misal kita pengen tau, film mana aja yg durasi filmnya sama
SELECT
  	f1.title,
  	f2.title,
  	f1.length
FROM
  	film f1
INNER JOIN 
	film f2 ON f1.film_id <> f2.film_id -- selama ga = gpp, penggunaan <> agar menghindari film dengan id yg sama
	AND f1.length = f2.length			-- 2 film dengan durasi yg sama
order by 3
