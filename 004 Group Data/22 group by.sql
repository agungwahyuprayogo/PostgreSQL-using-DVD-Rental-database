/* GROUP BY
 * 
 * kita kali ini akan belajar group by, dimana membuat / memisah hasil data dalam bentuk grup
 * 
 * query 'group by' lah hasil dari query 'select'
 * 
 * tiap kita pengen buat grup dari hasil data, kita bisa make 'sum()' untuk jumlah item 
 * dan 'count()' untuk jumlah item dalam postgreSQL
 * 
 * secara basic, query nya seperti berikut :
 * 
 * SELECT
 * 		kolom1,
 * 		kolom2,
 * 		... ,
 * 		FUNGSI(kolom)
 * FROM
 * 		nama_table
 * GROUP BY
 * 		kolom1,
 * 		kolom2,
 * 
 * pertama, pilih kolom mana saja yang akan ditampilkan dari query dan function di select 
 * kedua, mengurutkan hasil berdasarkan group by
 * 
 * dalam postgreSQL, query 'GROUP BY' akan di jalankan setelah query from dan where
 * 
 * untuk lebih detailnyam urutanya seperti ini :
 * 1. from
 * 2. where
 * 3. group by
 * 4. having
 * 5. select
 * 6. distinct
 * 7. order by
 * 8. limit
 */

-- GROUP BY tanpa function
select customer_id from payment group by customer_id order by customer_id 

-- setiap customer pasti memiliki riwayat transaksi, mau berapa pun itu transaksinya
-- sekarang kita coba make function sum()
select customer_id, sum(amount) from payment group by customer_id order by customer_id 
-- disini keliatan tiap customer berapa aja transaksinya
-- masih urut berdasarkan customer id, sekarang kita pengen cek siapa yang belanjanya paling banyak

select customer_id, sum(amount) from payment group by customer_id order by sum(amount) desc

-- group by dengan join table
select 
	c.first_name ||' '|| c.last_name as full_name, 
	sum(p.amount) amount 
from 
	customer c inner join payment p using(customer_id) 
group by 
	full_name 
order by 
	amount desc
	
-- menghitung jumlah transaksi dari kasir
select staff_id, count(amount) from payment p group by staff_id 

-- kalo mau liat total transaksi dari kedua kasir tersbut dengan
select staff_id, sum(amount) from payment p group by staff_id 

-- make group by dengan kolom lebih dari satu
select staff_id, customer_id, sum(amount) from payment p group by staff_id, customer_id order by customer_id 

-- group by make date atau tanggal
select payment_date::date payment_date, sum(amount) total_transaksi from payment group by payment_date::date order by payment_date desc
-- perhatikan secara seksama, payment_date::date
-- transaksi (amount) kita buat jadi total transaksi