/* kali ini kita bakal bahas update
update ini biasa digunain buat memperbarui data 
basic syntax nya seperti ini 

UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition;

pertama, spesifikan nama table yang pengen diubah datanya setelah keyword 'update'
kedua, spesifikan kolom dan value baru
ketiga, spesifikan kolom atau baris mana yang akan diubah mengikutin kondisi pada keyword 'where'

where ini sifatnya opsional, tapi kalo ga dipake bisa berpengaruh ke semua data pada suatu kolom
mirip sama kaya insert, abis ngubah atau update data, kita bisa liat perbedaanya make returning

UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition
RETURNING * | output_expression AS output_name;
 */

CREATE TABLE courses(
  course_id serial PRIMARY KEY, 
  course_name VARCHAR(255) NOT NULL, 
  price DECIMAL(10,2) NOT NULL,
  description VARCHAR(500), 
  published_date date
);


INSERT INTO courses(course_name, price, description, published_date) 
VALUES 
('PostgreSQL for Developers', 299.99, 'A complete PostgreSQL for Developers', '2020-07-13'), 
('PostgreSQL Admininstration', 349.99, 'A PostgreSQL Guide for DBA', NULL), 
('PostgreSQL High Performance', 549.99, NULL, NULL), 
('PostgreSQL Bootcamp', 777.99, 'Learn PostgreSQL via Bootcamp', '2013-07-11'), 
('Mastering PostgreSQL', 999.98, 'Mastering PostgreSQL in 21 Days', '2012-06-30');

SELECT * FROM courses c ;

-- basic update, ubah tanggal di baris 2 yg masih null
update courses 
set published_date = '2024-07-05'
where course_id = 2

select course_id, course_name, published_date from courses c 
-- dan pas di cek baris nomer 2 pindah ke paling bawah

-- mengupdate baris suatu kolom dan langsung menampilkan perubahan
UPDATE courses
SET published_date = '2020-07-01'
WHERE course_id = 3
RETURNING *;

-- misal lagi sepi ye kan, kita pengen ubah harga paket belajarnya jadi makin murah
-- dan ga make where, harusnya semuanya berubah, cek dulu deh harga sebelumnya berapa

select * from courses c 
--1. 299.99
--2. 777.99
--3. 999.98
--4. 349.99
--5. 549.99

-- masih segitu ye, kita ubah jadi lebih murah
UPDATE courses
SET price = price - price * 0.5;

select * from courses c 
-- setelah di diskon jadi lebih murah, hasilnya kek gini : 
--150.00
--389.00
--499.99
--175.00
--275.00

-- jadi bener ya, kalo ga make where semuanya berubah