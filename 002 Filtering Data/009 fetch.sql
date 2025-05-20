-- kali ini kita mau belajar mengenai 'fetch'
-- jadi mirip limit sih sebenernya
-- tapi dalam standarnya, untuk menampilkan beberapa baris menggunakan fetch
-- karena limit tidak selalu di dukung oleh semua RDBMS

-- di fetch ini lebih ribet tapi mayan berguna kalo sewaktu waktu ga bisa make limit

-- OFFSET row_to_skip { ROW | ROWS }
-- FETCH { FIRST | NEXT } [ row_count ] { ROW | ROWS } ONLY



select film_id, title from film order by film_id fetch first row only
-- kita pengen nampilin id film sama judul, tampilin 5 baris aja

select film_id, title from film order by film_id fetch first 1 row only
-- mirip diatas

select film_id, title from film order by film_id fetch first 5 row only
-- nampilin 5 baris paling atas

select film_id, title from film order by film_id offset 5 rows fetch first 5 row only
-- skip 5 baris awal, ambil 5 baris pertama saja

select film_id, title from film order by film_id offset 5 rows fetch first 10 row only

--FETCH FIRST kadang digunakan di awal paginasi (ambil baris pertama).
--FETCH NEXT sering digunakan untuk step berikutnya (paging selanjutnya), lebih semantik aja.
-- jadi mau make first atau next hasilnya sama aja
