-- kali ini kita akan mempelajari MAX() untuk mencari nilai maksimum dari sekumpulan nilai
-- kita akan menggunakan table payment kembali

select * from payment p 

-- 1) Contoh dasar penggunaan fungsi PostgreSQL MAX()
select 
  	max(amount) 
from 
  	payment;
-- hasil dari query diatas adalah, total pembayaran terbesar dalam satu kali transaksi adalah sebesar 11.99


-- 2) Menggunakan fungsi PostgreSQL MAX() dalam subquery
select 
	customer_id, 
	payment_id, 
	payment_date,
	amount
from 
	payment p 
where 
	amount >= (
		select 
			max(amount)
		from 
			payment p2 
	)
-- Pertama subquery menggunakan fungsi MAX() untuk mengembalikan jumlah pembayaran tertinggi.
-- Kedua, query utama mengambil semua pembayaran yang jumlahnya sama dengan nilai tertinggi 
--        yang dikembalikan oleh subquery.
	

-- 3) Menggunakan fungsi PostgreSQL MAX() dengan klausa GROUP BY
select
  	customer_id,
  	max(amount) pengeluaran_terbesar
from 
  	payment
group by
  	customer_id
order by 
	pengeluaran_terbesar desc
	
-- 4) Menggunakan fungsi PostgreSQL MAX() dengan klausa HAVING
-- pelanggan yang melakukan transaksi dengan jumlah lebih dari 8.99:
select 
  customer_id,
  max(amount)
from
  payment
group by 
  customer_id
having
  max(amount) > 8.99;
