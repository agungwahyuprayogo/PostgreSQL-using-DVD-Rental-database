/* 
Operator OR adalah operator logika yang menggabungkan beberapa ekspresi boolean

dalam praktiknya, OR digunakan untuk mengecek apakah ada nilai TRUE dalam komparasi booleanalter */

-- 1. Contoh dasar operasi OR 

select true or true as result

select true or false as result

select false or true as result

select false or false as result

-- 2. Menggunakan operasi OR dalam where
-- mencari film yang biaya sewanya 0.99 atau 2.99
select 
	title,
	rental_rate 
from 
	film
where
	rental_rate = 0.99 or
	rental_rate = 2.99
-- akan menampilkan keseluruhan film yang memiliki biaya sewa 0.99 atau 2.99
-- karena memang sifat OR akan selalu tampil jika salah satu terpenuhi, bila ada semua maka akan ditampilkan semua

-- hasil akan kosong atau tidak tampil semisal tidak ada dalam database : 
select 
	title,
	rental_rate 
from 
	film
where
	rental_rate = 7.99 or
	rental_rate = 8.00
