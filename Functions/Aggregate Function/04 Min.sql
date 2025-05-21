/* 
-- PostgreSQL MIN() --

kita akan belajar cara menggunakan min() untuk mencari value terkecil dari sekumpulan data

kali ini kita akan menggunakan table : film, film_category, dan category
*/

select * from film f 

select * from film_category fc 

select * from category c 

-- 1) Contoh dasar penggunaan fungsi PostgreSQL MIN()
-- semisal kita ingin mencari tarif sewa terendah dalam kolom rental rate dari table film
SELECT
   MIN(rental_rate)
FROM
   film;
-- harga sewa terkecil adalah 0.99


-- 2) Menggunakan fungsi PostgreSQL MIN() dalam subquery
-- setelah mengetahui harga sewa terkecil, kita cari cari film apa saja yg harga sewanya kecil
select
	film_id, title, description, rental_rate 
from 
	film f 
where rental_rate = (
				select min(rental_rate) from film
			);
-- ternyata ada banyak film dengan harga sewa 0.99
			

-- 3) Menggunakan fungsi PostgreSQL MIN() dengan klausa GROUP BY
-- Contoh berikut menggunakan fungsi MIN() dengan klausa GROUP BY 
-- untuk menemukan biaya penggantian terendah dari film berdasarkan kategori:
SELECT
  name AS category,
  MIN(replacement_cost) AS replacement_cost
FROM
  category
  INNER JOIN film_category USING (category_id)
  INNER JOIN film USING (film_id)
GROUP BY
  name
ORDER BY
  name;

-- 4) Menggunakan fungsi PostgreSQL MIN() dengan klausa HAVING
-- biaya penggantian terendah dari film yang dikelompokkan berdasarkan kategori, 
-- hanya menampilkan kelompok dengan biaya penggantian lebih dari 9.99:
SELECT
  name AS category,
  MIN(replacement_cost) AS replacement_cost
FROM
  category
  INNER JOIN film_category USING (category_id)
  INNER JOIN film USING (film_id)
GROUP BY
  name
HAVING
  MIN(replacement_cost) > 9.99
ORDER BY
  name;

-- 5) Menggunakan fungsi PostgreSQL MIN() dengan fungsi agregat lainnya
-- durasi film terpendek dan terpanjang berdasarkan kategori:
SELECT
  name AS category,
  MIN(length) AS min_length,
  MAX(length) AS max_length
FROM
  category
  INNER JOIN film_category USING (category_id)
  INNER JOIN film USING (film_id)
GROUP BY
  name
ORDER BY
  name;