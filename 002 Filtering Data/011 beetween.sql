-- BETWEEN itu gampangnya 'diantara'
-- semisal between 1 and 10, berarti diantara 1 sampai 10


-- ada juga 	NOT BETWEEN, jadi tuh yang di keluarin diluar angka tersebut
-- semisal NOT BETWEEN 1 and 10, berati yang keluar bisa 0, -1 dan diatas 10 kaya 10.00001 gitu

----------------------------------------------------------------------------------------------

-- 1. between dengan angka
-- semisal kita pengen nge test ngambil data payment_id diantara 17503 sampai 17505

select
	payment_id, amount 
from 
	payment	
where 
	payment_id between 17503 and 17505
order by
	payment_id 
	
-- batas bawah 17503,, batas atas 17505
	
----------------------------------------------------------------------------------------------
	
-- 2. not between dengan angka
-- sebaliknya aja deh, GA PENGEN NAMPILIN payment_id diantara 12503 sampai 17505

select
	payment_id, amount
from 
	payment
where 
	payment_id not between 17503 and 17505
order by
	payment_id
	
-- dibawah 17503 emang ga ada, tapi diatas 17505 banyak
	
----------------------------------------------------------------------------------------------
	
-- 3. between dengan tanggal
-- kita make standar international ISO 8601 yaitu yyyy-mm-dd (tahun-bulan-tanggal)
-- semisal kita pengen liat pembayaran dari tanggal '2007-02-15' sampai '2007-02-20' 
-- yang pembayarannya (amount) lebih dari 10
	
select 
	customer_id, payment_id, amount, payment_date
from 
	payment
where 
	payment_date 
		between '2007-02-15' and '2007-02-20'
	and 
		amount > 10
order by 
	payment_date 
