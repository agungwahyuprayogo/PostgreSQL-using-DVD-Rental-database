/* 
kali ini kita bakal belajar mengenai CTE 
atau Common Table Expression

jadi CTE ini biasa digunakan buat menyederhanakan queri yang kompleks
jadi dari pada bikin satu query panjang dan kompleks
CTE ini ibarat bagian bagian kecil yang digunakan buat bagi tugas dan bisa di gunakan kembali

syntax dasar buat CTE sebagai berikut : 
	
	WITH cte_name (column1, column2, ...) AS (
    	-- CTE query
    	SELECT ...
	)
	
	-- Main query using the CTE
	SELECT ...
	FROM cte_name;
	
1.) Klausa WITH : 
Memperkenalkan ekspresi tabel umum (CTE). 
Diikuti oleh nama CTE dan daftar nama kolom dalam tanda kurung. 
Daftar kolom bersifat opsional dan hanya diperlukan jika Anda ingin secara eksplisit 
menentukan kolom untuk CTE.

2.) Nama CTE : 
Tentukan nama CTE. 
Nama CTE ada dalam cakupan kueri. 
Pastikan nama CTE bersifat unik dalam kueri.

3.) Daftar Kolom (opsional) : 
Tentukan daftar nama kolom dalam tanda kurung setelah nama CTE. 
Jika tidak ditentukan, kolom secara implisit mewarisi nama kolom dari SELECT pernyataan 
di dalam CTE.

4.) Kata kunci AS : 
Kata kunci AS menunjukkan awal definisi CTE.

5.) Kueri CTE : Ini adalah kueri yang mendefinisikan CTE, 
yang dapat menyertakan klausa JOIN , WHERE , GROUP BY , dan konstruksi SQL valid lainnya.

6.) Kueri utama : Setelah menentukan CTE, 
Anda dapat merujuknya dalam kueri utama dengan namanya. 
Dalam kueri utama, Anda dapat menggunakan CTE seolah-olah itu adalah tabel biasa, 
yang menyederhanakan struktur kueri yang rumit.
 */

-- contoh CTE dasar 
WITH action_films AS (
  SELECT 
    f.title, 
    f.length,
    c.name as genre
  FROM 
    film f 
    INNER JOIN film_category fc USING (film_id) 
    INNER JOIN category c USING(category_id) 
  WHERE 
    c.name = 'Action' -- kok bisa ya category di masukin where, padahal ga ada di select
) 
SELECT * FROM action_films;


-- tes doang, bisa make where tanpa masukin kolomnya ke select
WITH film_goldie AS (
  SELECT 
    f.title, 
    a.first_name
  FROM 
    film f 
    INNER JOIN film_actor fa USING (film_id)
    inner join actor a using (actor_id)
  where 
  a.first_name = 'Goldie'
)
select * from film_goldie

-- tes CTE make table lain
-- kita buat cte dulu
with cte_rental as (
	select 
		staff_id,
		count(rental_id) total_rentalan
	from 
		rental 
	group by
		staff_id
)
select -- baru table lain yg kita inner join CTE
	s.staff_id, 
	s.first_name ||' '|| s.last_name as nama_staff,
	total_rentalan
from 
	staff s 
inner join 
	cte_rental using (staff_id)
-- CTE pertama target total rentalan, make staff id sebagai jembatan
-- query utama menggabungkan CTE rental dan table staff menggunakan staff_id
-- mirip inner join tapi ini dah ada itunganya dulu gitu
	

-- penggabungan CTE lebih dari satu
with film_status as (
	select 
		avg(f.rental_rate) as average_rental_rate,
		max(f.length) as max_length,
		min(f.length) as min_length
	from 
		film f
),
customers_status as (
	select
		count(distinct p.customer_id) as total_customers,
		sum(p.amount) as total_payments
	from
		payment p 
)
select
	round((select average_rental_rate from film_status), 2) as avg_rental_rate, -- koma 2 digit
	(select max_length from film_status) as durasi_film_terpanjang,
	(select min_length from film_status) as durasi_film_terpendek,
	(select total_customers from customers_status) as total_pelanggan,
	
/* 
 kesimpulannya
 CTE suka dibuat kalo ada hitung2an yang sulit dan rumit
 kalo ada itungan yang terbilang makan tempat query, di taronya di CTE
 