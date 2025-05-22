/* di 00 Window Function ini kita akan belajar mengenai

-- WINDOW FUNCTION --

sebelum lebih lanjut kita persiapkan table terlebih dahulu */

CREATE TABLE product_groups (
	group_id serial PRIMARY KEY,
	group_name VARCHAR (255) NOT NULL
);

CREATE TABLE products (
	product_id serial PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	price DECIMAL (11, 2),
	group_id INT NOT NULL,
	FOREIGN KEY (group_id) REFERENCES product_groups (group_id)
);

-- Kedua, masukkan beberapa baris data ke dalam tabel:

INSERT INTO product_groups (group_name)
VALUES
	('Smartphone'),
	('Laptop'),
	('Tablet');

INSERT INTO products (product_name, group_id, price)
VALUES
	('Microsoft Lumia', 1, 200),
	('HTC One', 1, 400),
	('Nexus', 1, 500),
	('iPhone', 1, 900),
	('HP Elite', 2, 1200),
	('Lenovo Thinkpad', 2, 700),
	('Sony VAIO', 2, 700),
	('Dell Vostro', 2, 800),
	('iPad', 3, 700),
	('Kindle Fire', 3, 150),
	('Samsung Galaxy Tab', 3, 200);

select * from products

select * from product_groups


/* 
Cara termudah untuk memahami fungsi window adalah dengan terlebih dahulu meninjau fungsi agregat. 
Fungsi agregat menggabungkan data dari sekumpulan baris menjadi satu baris.

Contoh berikut menggunakan fungsi agregat AVG() 
untuk menghitung harga rata-rata dari semua produk dalam tabel products: */
SELECT
	AVG(price)
FROM
	products;

-- Untuk menerapkan fungsi agregat pada subset baris, gunakan klausa GROUP BY. 
-- Contoh berikut mengembalikan harga rata-rata untuk setiap kelompok produk:
SELECT
	group_name,
	AVG(price)
FROM
	products
INNER JOIN
	product_groups USING (group_id)
GROUP BY
	group_name;

/*
Seperti yang terlihat jelas dari outputnya, 
fungsi AVG() mengurangi jumlah baris yang dikembalikan oleh query dalam kedua contoh.

Mirip dengan fungsi agregat, fungsi window bekerja pada sekumpulan baris. 
Namun, ia tidak mengurangi jumlah baris yang dikembalikan oleh query.

Istilah window menggambarkan sekumpulan baris tempat fungsi window beroperasi. 
Fungsi window mengembalikan nilai dari baris dalam window.

Sebagai contoh, query berikut mengembalikan nama produk, harga, nama kelompok produk, 
serta harga rata-rata dari setiap kelompok produk: */
SELECT
	product_name,
	price,
	group_name,
	AVG(price) OVER (
	   PARTITION BY group_name
	)
FROM
	products
INNER JOIN
	product_groups USING (group_id);

/* 
Dalam query ini, fungsi AVG() berfungsi sebagai fungsi window yang bekerja pada sekumpulan baris  
yang ditentukan oleh klausa OVER. Setiap sekumpulan baris disebut window.



------------------------------------------------------------------------------------------------------------



Fungsi ROW_NUMBER(), RANK(), dan DENSE_RANK()

Fungsi ROW_NUMBER(), RANK(), dan DENSE_RANK() menetapkan bilangan bulat ke setiap baris 
berdasarkan urutannya dalam hasil query.

Fungsi ROW_NUMBER() memberikan nomor urut secara berurutan kepada 
setiap baris dalam setiap partisi. Lihat query berikut: */

SELECT
 	product_name,
	group_name,
	price,
	ROW_NUMBER() OVER (
		PARTITION BY group_name
		ORDER BY price
		)
FROM
	products
INNER JOIN
	product_groups USING (group_id);

-- kalo kalian lihat, row_number selalu berubah setiap berganti group_name

-- Fungsi RANK() memberikan peringkat dalam partisi yang diurutkan. 
-- Jika beberapa baris memiliki nilai yang sama, fungsi RANK() akan memberikan peringkat yang sama, 
-- sementara peringkat berikutnya akan dilewati (ada gap)

select 
	p.product_name,
	pg.group_name,
	p.price,
	rank() over (partition by group_name order by price)
from 
	products p 
inner join 
	product_groups pg using (group_id)	
-- Dalam kelompok produk laptop, baik Sony VAIO maupun Lenovo Thinkpad memiliki harga yang sama, 
-- sehingga keduanya mendapatkan peringkat 1. 
-- Baris berikutnya dalam kelompok tersebut adalah Dell Vostro, 
-- yang mendapatkan peringkat 3 karena peringkat 2 dilewati.
	

-- Mirip dengan fungsi RANK(), 
-- fungsi DENSE_RANK() memberikan peringkat pada setiap baris dalam partisi yang diurutkan, tetapi tanpa celah. 
-- Dengan kata lain, beberapa baris bisa mendapatkan peringkat yang sama, 
-- tetapi tidak ada peringkat yang dilewati.
	
select 
	p.product_name,
	pg.group_name,
	p.price,
	dense_rank() over (partition by group_name order by price)
from 
	products p 
inner join 
	product_groups pg using (group_id);
-- Dalam kelompok produk laptop, peringkat 1 diberikan kepada Sony VAIO dan Lenovo Thinkpad. 
-- Peringkat berikutnya adalah 2, yang diberikan kepada Dell Vostro.
	
----------------------------------------------------------------------------------------------------

	
/*
Fungsi FIRST_VALUE dan LAST_VALUE

Fungsi FIRST_VALUE() mengembalikan nilai yang dievaluasi terhadap baris pertama dalam partisi, 
sedangkan fungsi LAST_VALUE() mengembalikan nilai yang dievaluasi terhadap baris terakhir dalam partisi.	

Pernyataan berikut menggunakan FIRST_VALUE() untuk mendapatkan harga terendah di setiap kelompok produk:
*/

SELECT
	product_name,
	group_name,
	price,
	FIRST_VALUE(price) OVER (
		PARTITION BY group_name
		ORDER BY
			price
		) AS lowest_price_per_group
FROM
	products
INNER JOIN
	product_groups USING (group_id);

-- Pernyataan berikut menggunakan fungsi LAST_VALUE() untuk mendapatkan harga tertinggi di setiap kelompok produk:
SELECT
	product_name,
	group_name,
	price,
	LAST_VALUE(price) OVER (
		PARTITION BY group_name
		ORDER BY
			price RANGE BETWEEN UNBOUNDED PRECEDING
			AND UNBOUNDED FOLLOWING
	) AS highest_price_per_group
FROM
	products
INNER JOIN
	product_groups USING (group_id);

/* 
Perhatikan bahwa kita menambahkan klausa frame RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING, 
karena secara default klausa frame adalah RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW.

--------------------------------------------------------------------------------------------------------

-- Fungsi LAG dan LEAD --

Fungsi LAG() memungkinkan akses ke data dari baris sebelumnya, 
sedangkan fungsi LEAD() memungkinkan akses ke data dari baris berikutnya.

Pernyataan berikut menggunakan fungsi LAG() untuk mendapatkan harga dari baris sebelumnya 
dan menghitung selisih antara harga baris saat ini dan harga baris sebelumnya: */

SELECT
	product_name,
	group_name,
	price,
	LAG(price, 1) OVER (
		PARTITION BY group_name
		ORDER BY price
	) AS prev_price,
	price - LAG(price, 1) OVER (
		PARTITION BY group_name
		ORDER BY
			price
	) AS cur_prev_diff
FROM
	products
INNER JOIN
	product_groups USING (group_id);

-- Pernyataan berikut menggunakan fungsi LEAD() 
-- untuk mendapatkan harga dari baris berikutnya dan menghitung selisih antara harga baris saat ini 
-- dan harga baris berikutnya:

SELECT
	product_name,
	group_name,
	price,
	LEAD(price, 1) OVER (
		PARTITION BY group_name
		ORDER BY price
	) AS next_price,
	price - LEAD(price, 1) OVER (
		PARTITION BY group_name
		ORDER BY price
	) AS cur_next_diff
FROM
	products
INNER JOIN
	product_groups USING (group_id);