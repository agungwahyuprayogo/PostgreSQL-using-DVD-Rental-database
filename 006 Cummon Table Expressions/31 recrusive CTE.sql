/* oke sekarang kita belajar soal Recursive CTE
maksud dari Recursive CTE tuh begimane maksudnya?

maksud dari rekursiv adalah pemograman bersarang, atau bercabang, kaya akar gitu konsepnya
kalo masih bingung kita liat dulu syntax recursive nya :

WITH RECURSIVE cte_name (column1, column2, ...)
AS(
    -- anchor member
    SELECT select_list FROM table1 WHERE condition

    UNION [ALL]

    -- recursive term
    SELECT select_list FROM cte_name WHERE recursive_condition
) 
SELECT * FROM cte_name;

dimana :
* cte_name: Tentukan nama CTE. 
  Anda dapat merujuk nama CTE ini di bagian kueri berikutnya.
* column1, column2, … 
  Tentukan kolom yang dipilih pada anggota jangkar dan rekursif. 
  Kolom-kolom ini menentukan struktur CTE.
* anchor member : 
**/

CREATE TABLE employee (
  employee_id SERIAL PRIMARY KEY, 
  full_name VARCHAR NOT NULL, 
  manager_id INT
);

INSERT INTO employee (employee_id, full_name, manager_id) 
VALUES 
  (1, 'Michael North', NULL), 
  (2, 'Megan Berry', 1), 
  (3, 'Sarah Berry', 1), 
  (4, 'Zoe Black', 1), 
  (5, 'Tim James', 1), 
  (6, 'Bella Tucker', 2), 
  (7, 'Ryan Metcalfe', 2), 
  (8, 'Max Mills', 2), 
  (9, 'Benjamin Glover', 2), 
  (10, 'Carolyn Henderson', 3), 
  (11, 'Nicola Kelly', 3), 
  (12, 'Alexandra Climo', 3), 
  (13, 'Dominic King', 3), 
  (14, 'Leonard Gray', 4), 
  (15, 'Eric Rampling', 4), 
  (16, 'Piers Paige', 7), 
  (17, 'Ryan Henderson', 7), 
  (18, 'Frank Tucker', 8), 
  (19, 'Nathan Ferguson', 8), 
  (20, 'Kevin Rampling', 8);
  
 with recursive subordinates as (
  select employee_id, manager_id, full_name
  from
  	employee
  where
    employee_id = 2
  union 
  select e.employee_id, e.manager_id, e.full_name
  from
    employee e 
    inner join subordinates s on s.employee_id = e.manager_id -- biar bisa cek bawahan manager, cara kerja self join
) -- tadi nya mau liatin nama manager, cuman itu harus dari table yang sama
select * from subordinates;

insert into employee (employee_id, full_name, manager_id)
values 
	(21, 'Agung Wahyu Prayogo', 5),
	(22, 'Dedi Kusnandar', 5),
	(23, 'Nugroho bin Nugi', 5);
	
-- jadi kesimpulanya, CTE diatas pengen liatin siapa aja anak buah dari 2 (Megan Berry)
-- bisa bercabang karena si manager id = 2 ini punya bawahan, 
-- yg dimana bawahanya tadi punya bawahan lagi
-- jadi secara ga langsung anak buahnya mereka jadi anak buah si 2 ini