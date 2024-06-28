/*kali ini kita bakal belajar mengenai having
 * having disini biasanya digunakan untuk menspesifikan pencarian dalam query mas
 * dipake pas habis query 'group by' buat filter berdasarkan hal tertentu
 * 
 * berdasarkan ilustrasi basic query nya kaya begini :
 * SELECT
 * 		kolom1,
 * 		kolom1,
 * 		... ,
 * 		function
 * FROM
 * 		nama_table
 * GROUP BY
 * 		kolom1
 * HAVING
 * 		kondisi
 * 
 * jadi pertama kan pilih dulu, kolom mana aja yang pengen di tampilin
 * tulis juga dari table mana 
 * lalu data tersebut diminta di bagi dalam sebuah grup berdasarkan kolom tertentu
 * 
 * selain query 'group by', kamu juga bisa masukin query kaya 'join' dan 'limit' di query yg ada 'having' nya
 * 
 * postgreSQL mengeksekusi 'having' sesudah query 'after', 'where' dan 'group by' dijalankan
 * 
 * FROM -> WHERE -> GROUP BY -> HAVING -> DISTINCT -> SELECT -> ORDER BY -> LIMIT
 * 
 * karena wuery 'having' dijalankan sebelum 'select', kita ga bisa column alias di query 'having'
 * 
 * WHERE VS HAVING 
 * where digunakan untuk memfilter hasil data berdasarkan kondisi tertentu
 * where juga ga bisa make function, 
 * sedangkan having baru bisa digunakan kalo ada query 'group by', kalo ga ada 'group by' ga bisa
 * having juga bisa buat function, kalo where ga
 * 
 * langsung ke contohnya aja yaa
 *  */

-- Having dengan Function Sum
-- contoh belum make Function
select customer_id, sum(amount) total_transaksi from payment p group by customer_id order by total_transaksi desc

-- contoh make having
select customer_id, sum(amount) transaksi_keseluruhan from payment p group by customer_id having sum(amount) > 200 order by transaksi_keseluruhan desc

-- kita coba make where deh
-- select customer_id, sum(amount) transaksi_keseluruhan from payment p where sum(amount) > 200 group by customer_id order by transaksi_keseluruhan desc
-- oalahh function ga bisa di where, makanya ada having

-- Having make function Count
select store_id, count(customer_id) total_pelanggan from customer c group by store_id 

-- make having (having bisa make function njir)
select store_id, count(customer_id) total_pelanggan from customer c group by store_id having count(customer_id) > 300