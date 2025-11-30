/* 
AND digunakan untuk menggabungkan dua atau lebih kondisi. 
Hasilnya hanya akan TRUE jika SEMUA kondisi yang digabungkan terpenuhi.

bisa juga digunakan untuk menampilkan hasil boolean

*/


-------------------------------------------------------------------------------------------------------


-- 1. Operator AND dalam boolean di postgreSQL

select true and true as result -- hasil centang karena true and true = true

select true and false as result -- tidak ada centak karena true and false = false

select true and null as result -- karena null data kosong, tidak ada yang dibandingkan, hasilnya null

----

select false and true as result -- false karena salah satu false

select false and false as result -- false semua

select false and null as result -- jika salah satu false, tidak peduli dia null atau true, jika dibandingkan false hasilnya false

---

select null and null as result -- akan true jika keduanya true, akan false jika salah satu false, maka akan null jika keduanya null

/* 
 
 sehingga urutannya : 
 1. false
 2. null
 3. true
 
 */



-------------------------------------------------------------------------------------------------------




-- 2. Penggunaan operator AND dengan klausa WHERE

-- kita akan mencari film yang durasinya lebih dari 180 menit dan tarif sewa kurang dari 1
select 
	title,
	length,
	rating
from 
	film
where 
	length > 180 and rental_rate < 1
	
