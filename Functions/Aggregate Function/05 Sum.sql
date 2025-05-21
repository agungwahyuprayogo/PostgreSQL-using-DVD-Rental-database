/*

-- SUM function --
Fungsi PostgreSQL SUM() adalah fungsi agregat yang mengembalikan jumlah dari sekumpulan nilai.

Berikut sintaks dasar dari fungsi SUM():


SUM(DISTINCT expression)


- Fungsi SUM() mengabaikan nilai NULL, yang berarti nilai NULL tidak diperhitungkan dalam proses perhitungan.

- Jika Anda menggunakan opsi DISTINCT, fungsi SUM() hanya akan menghitung jumlah dari nilai unik.
  Sebagai contoh, tanpa opsi DISTINCT, SUM() dari nilai 1, 1, dan 2 akan menghasilkan 4. Namun, jumlah dari nilai unik 1, 1, dan 2 akan menghasilkan 3 (1 + 2) karena fungsi SUM() mengabaikan satu nilai duplikat (1).

- Fungsi SUM() dari sekumpulan data kosong akan menghasilkan NULL, bukan nol.

Kita akan menggunakan tabel payment dari database sampel. */

select * from payment p 




-- 1) Menggunakan fungsi PostgreSQL SUM() dalam pernyataan SELECT
-- Contoh berikut menggunakan fungsi SUM() untuk menghitung total semua pembayaran dalam tabel payment:

SELECT
  SUM(amount)
FROM
  payment;




-- 2) Menggunakan fungsi PostgreSQL SUM() dengan kumpulan hasil kosong
-- menghitung total pembayaran dari pelanggan dengan customer_id 2000:

SELECT
  SUM(amount)
FROM
  payment
WHERE
  customer_id = 2000;

-- Dalam contoh ini, fungsi SUM() mengembalikan NULL 
-- karena tabel payment tidak memiliki baris dengan customer_id 2000.



-- 3) Menggunakan fungsi SUM() dengan fungsi COALESCE()
-- Jika Anda ingin fungsi SUM() mengembalikan nol alih-alih NULL ketika tidak ada baris yang sesuai, 
-- gunakan fungsi COALESCE().
-- Fungsi COALESCE() mengembalikan argumen pertama yang tidak NULL. 
-- Dengan kata lain, jika argumen pertama adalah NULL, maka ia mengembalikan argumen kedua.
SELECT
  COALESCE(SUM(amount), 0) AS total
FROM
  payment
WHERE
  customer_id = 2000;

-- jika ingin dalam bentuk text, 
SELECT
  COALESCE(CAST(SUM(amount) AS TEXT), 'no row') AS total -- casting menjadi text terlebih dahulu
FROM
  payment
WHERE
  customer_id = 2000;



-- 4) Menggunakan fungsi PostgreSQL SUM() dengan klausa GROUP BY

select
	customer_id,
	sum(amount) as total_belanja
from 
	payment p 
group by 
	customer_id 
order by 
	total_belanja desc;
	

	
-- 5) Menggunakan fungsi PostgreSQL SUM() dengan klausa HAVING
select
	customer_id,
	sum(amount) as total_belanja
from 
	payment p 
group by 
	customer_id 
having sum(amount) > 200
	


-- 6) Menggunakan fungsi PostgreSQL SUM() dengan ekspresi
SELECT
  sum(return_date - rental_date)
FROM
  rental;

select * from rental

-- Pertama, menghitung durasi penyewaan dengan mengurangi tanggal penyewaan dari tanggal pengembalian.
-- Kedua, menerapkan fungsi SUM() pada ekspresi tersebut.

SELECT
  first_name || ' ' || last_name AS full_name,
  SUM(return_date - rental_date) AS rental_duration
FROM
  rental
  INNER JOIN customer USING(customer_id)
GROUP BY
  customer_id
ORDER BY
  rental_duration desc
  

-- return_date - rental_date akan menghasilkan jumlah hari peminjaman per baris.
-- Fungsi SUM() menjumlahkan seluruh durasi tersebut untuk setiap customer.
-- Hasil akhirnya adalah total hari semua peminjaman customer tersebut.
  
select 
	c.customer_id,
	c.first_name || ' ' || c.last_name as full_name,
	r.rental_date, 
	r.return_date
from 
	rental r
join 
	customer c using (customer_id)
where c.first_name = 'Karl'
order by rental_date 