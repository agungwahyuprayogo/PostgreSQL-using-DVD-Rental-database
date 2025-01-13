/* -------- SELF JOIN ------
 *
 * sesuai namanya, self join disini perbandingan hanya dengan table itu sendiri
 * dalam artian, kalo misalkan kamu punya table film, 
 * ya yang dibandingkan adalah data dengan data di table film
 * 
 * penggambaran query self join
 * 
 * SELECT 
 * 		select list,
 * 		select list,
 * from
 * 		table_name t1
 * inner join
 * 		table_name t2 on join_predicate
 * 
 * di syntax ini, si 'table' yang di join dengan dirinya sendiri bisa make 'inner join'
 * alternative lainya bisa make 'left join' atau 'right join'
 * 
 * SELECT 
 * 		select list,
 * 		select list,
 * from
 * 		table_name t1
 * left join
 * 		table_name t2 on join_predicate
 * 
 * 
 * langsung ke contoh kasus ya.
 * jadi anggeplah pak Hartono sebagai direktur punya 2 manager :
 * 
 * 2 manager tadi ada pak Chandra dan pak Reza
 * 
 * nah Pak Chandra punya anak buah : Dedi, Nugi, dan Agung
 * sedangkan Pak Reza punya anak buah : Qisty, Azizi, dan Irvan
 * 
 * penggambaranya seperti ini
 * Direktur 			 		Hartono
 * manager	 		 Chandra 		|			    Reza
 * anak buah    Agung, Dedi, Nugi	|		Qisty, Azizi, Irvan
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

SELECT 
  e.first_name || ' ' || e.last_name employee, 
  m.first_name || ' ' || m.last_name manager 
FROM 
  employee e 
  INNER JOIN employee m ON m.employee_id = e.manager_id 
ORDER BY 
  manager;
  
SELECT 
  e.first_name || ' ' || e.last_name employee, 
  m.first_name || ' ' || m.last_name manager 
FROM 
  employee e 
  LEFT JOIN employee m ON m.employee_id = e.manager_id 
ORDER BY 
  manager desc
  
 