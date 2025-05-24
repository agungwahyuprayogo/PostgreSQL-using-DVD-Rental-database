/*
PostgreSQL ROW_NUMBER function

Ringkasan: Dalam tutorial ini, Anda akan belajar cara menggunakan fungsi PostgreSQL ROW_NUMBER() 
untuk menetapkan nilai integer unik ke setiap baris dalam hasil query.

Fungsi ROW_NUMBER() adalah fungsi window yang memberikan nomor urut secara berurutan kepada setiap baris 
dalam hasil query.

contoh penggunaan row number menggunakan table products*/

select 
  product_id,
  product_name,
  group_id,
  row_number () over (order by product_id)
from 
  products;

/*
Karena kita tidak menggunakan klausa PARTITION BY, 
fungsi ROW_NUMBER() menganggap seluruh hasil query sebagai satu partisi.

Klausa ORDER BY mengurutkan hasil query berdasarkan product_id, 
sehingga fungsi ROW_NUMBER() menetapkan nilai integer ke setiap baris berdasarkan urutan product_id.

Dalam query berikut, kita mengubah kolom dalam klausa ORDER BY menjadi product_name, 
sehingga fungsi ROW_NUMBER() menetapkan nilai integer ke setiap baris berdasarkan urutan nama produk.
*/

SELECT
  product_id,
  product_name,
  group_id,
  ROW_NUMBER () OVER (ORDER BY product_name)
FROM
	products;

SELECT
  product_id,
  product_name,
  group_id,
  price,
  ROW_NUMBER () OVER (ORDER BY price)
FROM
	products;

/* hasil dari order by product_name, mengurutkan baris berdasarkan nama produk dari urutan A-Z

Dalam query berikut, kita menggunakan klausa PARTITION BY untuk membagi window menjadi subset berdasarkan 
nilai dalam kolom group_id. Dalam hal ini, fungsi ROW_NUMBER() menetapkan angka satu ke baris awal setiap 
partisi dan meningkat satu untuk setiap baris berikutnya dalam partisi yang sama.

Klausa ORDER BY mengurutkan baris dalam setiap partisi group_id berdasarkan nilai dalam kolom product_name
*/

SELECT
	product_id,
  	product_name,
  	group_id,
  	ROW_NUMBER() OVER (PARTITION by group_id ORDER by price)
FROM
  	products;

/* dari hasil diatas terlihat, angka akan kembali menjadi 1 setiap berganti group_id


--------------------------------------------------------------------------------------



Fungsi PostgreSQL ROW_NUMBER() dan Operator distinct

Query berikut menggunakan fungsi ROW_NUMBER() untuk menetapkan angka berurutan pada harga yang unik 
dari tabel products: */

SELECT
	DISTINCT price,
	ROW_NUMBER() OVER (ORDER BY price)
FROM
  	products
ORDER BY
  	price;

/*
Namun, hasilnya tidak sesuai dengan yang diharapkan karena masih terdapat harga yang duplikat. 
Alasannya adalah fungsi ROW_NUMBER() beroperasi pada hasil query sebelum DISTINCT diterapkan.
*/

with prices_distinct as (
select 
	distinct price 
from 
	products
)
select
	price,
	ROW_NUMBER() OVER (ORDER BY price asc) AS row_num
FROM
  	prices_distinct;

-- Atau kita bisa menggunakan subquery dalam klausa FROM untuk mendapatkan daftar harga unik, 
-- lalu menerapkan fungsi ROW_NUMBER() dalam query luar.

select
	price,
	ROW_NUMBER() OVER (ORDER BY price) AS row_num
FROM (
	SELECT DISTINCT
		price
	FROM
		products
) AS prices;

/* 
Menggunakan Fungsi ROW_NUMBER() untuk Paginasi

Dalam pengembangan aplikasi, teknik paginasi digunakan untuk menampilkan sebagian baris daripada menampilkan 
semua baris dalam tabel.

Selain menggunakan klausa LIMIT, Anda dapat menggunakan fungsi ROW_NUMBER() untuk paginasi.

Sebagai contoh, query berikut memilih lima baris yang dimulai dari nomor baris ke-6: */

SELECT *
FROM (
  SELECT
    product_id,
    product_name,
    price,
    ROW_NUMBER() OVER (ORDER BY product_name) AS rn
  FROM products
) AS ranked
WHERE rn BETWEEN 6 AND 10;

/*
Menggunakan Fungsi ROW_NUMBER() untuk Mendapatkan Baris ke-n Tertinggi/Terendah

Sebagai contoh, untuk mendapatkan produk dengan harga tertinggi ketiga, 
pertama, kita mengambil harga yang unik dari tabel products dan memilih harga dengan nomor baris ke-3. 
Kemudian, dalam query luar, kita mengambil produk dengan harga yang sama dengan harga tertinggi ketiga.
*/

SELECT 
	product_name,
	price,
	ROW_NUMBER() OVER (ORDER BY price DESC) AS nth
from 
	products
	
-- lalu kita buat subquery 

SELECT *
FROM products
WHERE price = (
  SELECT price
  FROM (
    SELECT price,
           ROW_NUMBER() OVER (ORDER BY price DESC) AS nth
    FROM (SELECT DISTINCT price FROM products)
  )
  WHERE nth = 3
);