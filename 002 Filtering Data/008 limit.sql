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
	film_id limit 10
	
-- 2. menggunakan limit dan offset 
select 
  film_id,
  title,
  release_year
from 
  film
order by 
  film_id -- urutkan berdasarkan film_id
limit 4 offset 3; -- skip bari 1 sampai 3, makanya langsung ke 4 hasilnya

-- 3) Menggunakan 'LIMIT OFFSET' untuk Mendapatkan N Baris Teratas/Bawah

SELECT
  film_id,
  title,
  rental_rate
FROM
  film
ORDER BY
  rental_rate DESC
LIMIT
  10;

--Dengan perintah ini, kita mengambil 10 film paling mahal berdasarkan 'rental_rate', 
--diurutkan dalam urutan menurun (dari harga tertinggi ke terendah). 
--Jika ingin mendapatkan 10 film termurah, cukup ubah 'DESC' menjadi 'ASC' dalam klausa 'ORDER BY'.
