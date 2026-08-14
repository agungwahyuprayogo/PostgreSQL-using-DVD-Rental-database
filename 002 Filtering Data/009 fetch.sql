-- kali ini kita mau belajar mengenai 'fetch'
-- jadi mirip limit sih sebenernya
-- tapi dalam standarnya, untuk menampilkan beberapa baris menggunakan fetch karena limit tidak selalu di dukung oleh semua RDBMS

-- di fetch ini lebih ribet tapi mayan berguna kalo sewaktu waktu ga bisa make limit

-- OFFSET row_to_skip { ROW | ROWS }
-- FETCH { FIRST | NEXT } [ row_count ] { ROW | ROWS } ONLY

----------------------------------------------------------------------------------------------------------------------------------

-- 1. Nampilin baris paling atas aja
-- kita pengen nampilin id film sama judul, tampilin 1 baris aja
select 
	film_id, title 
from 
	film 
order by 
	film_id 
fetch first row only

-- cara diatas mirip kaya gini :
select 
	film_id, title 
from 
	film 
order by 
	film_id 
fetch first 1 row only
-- mirip diatas

----------------------------------------------------------------------------------------------------------------------------------
-- 2. Nampilin baris teratas tapi 5 aja
select 
	film_id, title 
from 
	film 
order by 
	film_id 
fetch first 5 row only
-- nampilin 5 baris paling atas


----------------------------------------------------------------------------------------------------------------------------------
-- 3. Kombinasi dengan OFFSET, melompati data
-- semisal kita mau ngambil 5 data berikutnya, tapi kita skip urutan 1-5 (langsung ke 6-10)

select 
	film_id, title 
from 
	film 
order by 
	film_id 
offset 5 rows -- skip 5 baris awal 
fetch first 5 row only -- limit 5 baris aja

-- mirip diatas, tapi kita nampilin 6-15
select 
	film_id, title 
from 
	film 
order by 
	film_id 
offset 5 rows 
fetch first 10 row only


--FETCH FIRST kadang digunakan di awal paginasi (ambil baris pertama).
--FETCH NEXT sering digunakan untuk step berikutnya (paging selanjutnya), lebih semantik aja.
-- jadi mau make first atau next hasilnya sama aja
