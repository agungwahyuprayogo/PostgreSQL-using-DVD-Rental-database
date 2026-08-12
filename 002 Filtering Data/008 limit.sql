-- kali ini kita bakal bahas soal 'limit'
-- sesuai namanya, kita bakal batesin hasil yang keluar dari database yang pengen kita tampilin
-- kalo masukin limitnya 1, ya bakal nampilin 1 doang
-- kalo masukin limit 0? berarti sama sekali ga ada yang ditampilin

-- 1. menampilkan film_id, title, dan release year, hanya 10 data
select 
	film_id, title, release_year 
from 
	film 
order by 
	film_id 
limit 
	10
	
-- 2. menggunakan limit dan offset 
-- semisal kita pengen nampilin 4 film, tapi dimulai dari film keempat ( melewati 3 film pertama ), 
-- kalo diurutin berdasarkan film_id, bisa make cara gini :
	
select 
  film_id, title, release_year
from 
  film
order by 
  film_id -- urutkan berdasarkan film_id
limit 4 -- bates 4 baris aja
offset 3 -- 3 film pertama di skip


-- 3) Menggunakan 'LIMIT OFFSET' untuk Mendapatkan N Baris Teratas/Bawah
-- semisal nampilin daftar film yang harga serwanya paling mahal

SELECT
  film_id, title, rental_rate
FROM
  film
ORDER BY
  rental_rate DESC
limit 10;

-- kalau mau nampilin harga sewa film termurah, tinggal ganti 'desc' jadi asc

select 
	film_id , title , rental_rate 
from 
	film
order by 
	rental_rate asc
limit 10
