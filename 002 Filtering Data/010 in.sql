-- Gampangnya sih IN disini mempermudah kita buat nge list
-- dari pada make OR atau AND

-- LANGSUNG PRAKTEK AJA

-- 1. IN untuk daftar angka
-- semisal kita pengen nyari film berdasarkan id 1, 2 dan 3

select 
	film_id , title
from 
	film
where 
	film_id in (1, 2, 3)
	
	
-- cara diatas kalo ga make in, make `or` dan `=` kaya gini :

select 
	film_id, title 
from 
	film
where 
	film_id = 1 or
	film_id = 2 or
	film_id = 3
	
-- silahkan run ulang, hasilnya sama dengan query sebelumnya.
	
/*
 Keuntungan Make IN :
 - lebih enak dilihat dan lebih mudah dibaca 
 - dari performa lebih cepat make in dari pada make or satu per satu
 */
	
---------------------------------------------------------------------------------------------
	
-- 2. Penggunaan IN make string atau teks
-- semisal kita pengen cari aktor yang nama belakangnya adalah `Allen`,, `Chase` atau `Davis`
	
select 
	first_name, last_name 
from 
	actor 
where 
	last_name in ('Allen', 'Chase', 'Davis') 
order by 
	last_name 
	
---------------------------------------------------------------------------------------------
	
-- 3. IN dalam daftar tanggal
-- sekarang make table payment,, kita pengen cari transaksi yang ada di tanggal '2007-02-15' atau '2007-02-16'
	
select 
	payment_id, amount, payment_date
from 
	payment
where
	payment_date::date in ('2007-02-15', '2007-02-16')

/*

Penjelasan tambahan soal tipe data waktu :
- tipe data date kaya di 'payment_date' tuh biasanya lengkap dari tanggal + waktu (Jam/Menit/Detik)
- biar jam nya di abaikan,, kita make tanggal aja dengan cara ::date di belakang kolom :

payment_date::date
 
dari yang sebelumnya '2007-02-15 22:25:46.996577' jadi '2007-02-15'
*/
	
	
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
	
/*
NOT IN
kebalikan dari in, not in digunakan untuk pengecualian atau di hilangkan dari daftar

Langsung ke contoh penggunan-nya :
semisal kita pengen GA NAMPILIN film dengan ID 1, 2 dan 3
*/

select 
	film_id, title
from 
	film
where
	film_id not in (1, 2, 3)
order by
	film_id 
	
-- query diatas ada cara lain, tapi ribet karena make operato <> serta AND

select 
	film_id, title
from 
	film
where
	film_id <> 1 and 
	film_id <> 2 and
	film_id <> 3 
order by 
	film_id 
	

	
