/* --------- INNER JOIN  ---------
 * 
 * dalam relasi database, data terdistribusi ke beberapa table sekaligus.
 * untuk mengambil data yang komprehensif, butuh query yang untuk mengambil dari multi table tersebut
 * 
 * kali ini kita bakal belajar inner join, dimana inner join itu menggabungkan 2 tabel
 * secara generic, query inner join seperti ini :
 * 
 * 		SELECT 
 * 			nama_kolom 
 * 		FROM
 * 			table1  			-- table utama
 * 		INNER JOIN table 2		-- table yang ingin digabung
 * 			on table1.nama_kolom = table2.nama_kolom;
 * 
 * syntax diatas :
 * pertama, spesifikan kolom mana aja yang pengen ditampilin
 * kedua, spesifikan table utama (main table) dari "FROM"
 * ketiga, spesifikan table kedua yang ingin digabung datanya dengan "INNER JOIN"
 * keempat, sambung menggunakan kolom yang sama diatara 2 tabel diatas
 * 
 * karena kita udah belajas alias kemarin, 
 * secara harfiah query nya gini :
 * 
 * 		SELECT 
 * 			select_list 
 * 		FROM 
 * 			table1 t1
 * 		INNER JOIN table2 t2 
 * 			ON t1.column_name = t2.column_name;
 * 
 * dalam syntax diatas, t1 menggantikan table1 dan t2 menggantikan table2
 * 
 * lalu ilmu baru, bila 2 table menggabungkan data menggunakan table yang sama
 * tidak perlu on table1.column_name = table2.column_name lagi
 * bisa make using (column_name)
 * 
 * yudeh kita kasih liat semua contohnya ye
 */

-------------------------------------------------------------------------------------

-- cara kuno (tapi paham basic)
select 
	customer.customer_id, 
	customer.first_name,
	payment.amount,
	payment.payment_date 
from 
	customer inner join payment on payment.customer_id = customer.customer_id
order by 
	payment.payment_date 
-- disini nama table belum make alias 
-- dan cara gabungin kolom yang sama diantara table masih make on

-------------------------------------------------------------------------------------

-- table aliases
select 
	 c.customer_id, c.first_name, p.amount, p.payment_date 
from 
	customer c inner join payment p on p.customer_id = c.customer_id 
-- penggunaan table alias sangat amat membantu syntax yang awalnya begitu banyak
	
-------------------------------------------------------------------------------------

-- penggunaan table alias dan using(same column in 2 or more table)
select 
	c.customer_id, c.first_name, p.amount, p.payment_date
from 
	customer c inner join payment p using(customer_id)
	

/* kesimpulanya, inner join itu gabungin data yang sama antara 2 table
 * kalo penggunaan query basic, boros tempat
 * penggunaa table aliases membantu pengurangan ketikan nama table
 * penggunaan using(column_name in 2 or more table) sangat mengurain secara drastis query 
 */
	
-- INNER JOIN THREE TABLE
-- kita kali ini pengen nyoba nampilin data, 
-- customer dilayani oleh siapa dan pengeluarannya berapa, di jam berapa
	
select
	c.first_name ||' '|| c.last_name as nama_customer,
	s.first_name || ' ' || s.last_name as nama_staff,
	p.amount,
	p.payment_date
from
	customer c 
	inner join payment p using(customer_id)
	inner join staff s using(staff_id)
order by
	p.payment_date 