select c.first_name, c.last_name from customer c order by c.last_name 
-- menampilkan first name dan last name, namun dengan urutan A - Z dari last name

select c.first_name, c.last_name from customer c order by c.first_name desc
-- menampilkan first dan last name, dan mengurutkan first name dari Z - A

-- kita kombinasikan
select c.first_name, c.last_name from customer c order by c.first_name asc, c.last_name desc

/* PostgreSQL null 

Dalam dunia database, NULL adalah penanda yang menunjukkan data yang hilang atau data yang tidak 
diketahui pada saat pencatatan.

Ketika Anda mengurutkan baris yang mengandung NULL, Anda bisa menentukan urutan NULL dengan nilai 
lain yang tidak null menggunakan opsi NULLS FIRST atau NULLS LAST dalam klausa ORDER BY:
*/

-- membuat tabel baru
CREATE TABLE sort_demo(num INT);

-- memasukkan beberapa data
INSERT INTO sort_demo(num)
VALUES
  (1),
  (2),
  (3),
  (null);

select num from sort_demo
-- secara default, ngururin dari terkecil [asc]

-- bisa juga kalo mau ditampilin lebih dulu
select num from sort_demo sd order by num nulls first
-- biar ga error, masukin nama kolom baru null first / las

select num from sort_demo sd order by num nulls last

