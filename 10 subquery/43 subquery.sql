/* di tutorial kali ini kita bakal belajar mengenai subquery yang memperbolhkan anda untuk membangung query yang komplek

INTRODUCTION TO POSTGRESQL SUBQUERY
subquery adalah query yang bersarang dengan query yg lain. 
sub query juga disebut sebagai inner query atau nested query

subquery akan sangat berguna saat mengambil data di query utama sebagai syarat pemilihan data selanjutnya

syntax basic dari subquery adalah sebagai berikut :
SELECT 
  select_list 
FROM 
  table1 
WHERE 
  columnA operator (
    SELECT 
      columnB 
    from 
      table2 
    WHERE 
      condition
  );

Dalam sintaksis ini, subkueri diapit dalam tanda kurung dan dieksekusi terlebih dahulu:

SELECT 
  columnB 
from 
  table2 
WHERE 
  condition

query utama adalah query yang menggunakan 'where'*/
--------------------------------------------------------------------------------------------------------------
-- BASIC POSTGRESQL SUBQUERY
-- pertama, coba tampilkan id dari 'United States' dari table 'country'

select country_id from country where country = 'United States'
-- hasil nya adalah 103

-- kedua, tampilkan kota dimana 'country_id' = 103 
select city from city c where country_id = 103
-- nah tampil semua kota2 yang ada di amerika serikat

-- kalo misah misah gitu kan lama, makanya subquery ini muncul
-- buat mempermudah kita kalo ga inget semua data yg ada di database
-- kedua syntax diatas dapat di gabung kaya gini
select 
	city 
from 
	city
where 
	country_id = ( 	-- jangan lupa kasih '=' biar ga error
		select							-- subquery dari baris ini
			country_id
		from 
			country
		where
			country = 'United States')	-- sampai baris ini
order by 
	city 
-- hasilnya sama kan
	
---------------------------------------------------------------------------------
	
-- USING SUBQUERY WITH IN OPERATOR
/* subquery bisa ngasilin 0 atau baris lebih misalnya gini nih biar langsung keliatan
	
--SELECT 
--  film_id, 
--  title 
--FROM 
--  film 
--WHERE 
--  film_id = (
--    SELECT 
--      film_id 
--    FROM 
--      film_category 
--      INNER JOIN category USING(category_id) 
--    WHERE 
--      name = 'Action'
--  ) 
--ORDER BY 
--  film_id;
  
abis dijalanin muncul error more than one row returned, padahal diatas make '=' bisa2 aja
untuk mengatasi hal itu bisa make operator 'in'

misal kita pengen liat film mana aja yg action
make inner bisa sih sebenernya, tapi misal kita pengen tau judul film nya aja gitu */

select 
	film_id 
from 
	film_category
	inner join 
		category 
	using 
		(category_id) 
where 
	name = 'Action'

-- nah tadi error tuh karena di subquery ada inner join makanya error, 
-- kita bisa make in biar ga error lagi
	
-- permisalan, kita pengen nampilin id film dan judul film-nya tapi yg genre action
-- action adanya di table category, dan di dalem table category cuman ada category id sama name
-- jadi harus di inner lagi sama film category
-- anjer lah kata gw mendingan langsung make inner yak
select 
	film_id, title 
from 
	film 
where film_id in (
	select 
		film_id 
	from 
		film_category 
		inner join 
			category 
		using 
			(category_id)
		where 
			name = 'Action'
		)
order by 
	film_id

-- kita coba make inner langsung
select 
	film_id, title 
from 
	film f 
inner join 
	film_category fc using(film_id) 
inner join 
	category c using (category_id)
-- tuh kan, tutorial mempersulit hidup ini mh :(