/* TABLE ALIASES
 * 
 * jadi pada dasarnya table alias ini digunakan biar ga kebanyakan nulis
 * misal nama table "film_category", bisa disingkat jadi fc
 * mungkin biar jelas kita liatin deh dibawah :
 */
 
 select 
 	f.film_id, f.title, f.description 
 from 
 	film as f 
 order by 
 	film_id 
 limit 5
 -- "from film as f" buat gambaran aja
 -- kalo mau lebih singkat boleh langsung -> "from film f"
 
 /* TABLE ALIASES IN JOIN
  * 
  * kalo diatas kan udah nih contoh basicnya,
  * kali ini kita mau nyoba bagaimana implementasinya kalo pas join table yang berbeda 
  * 
  * oiya sebelum lanjut, liat dulu apakah 2 table tadi bisa gabung apa ga
  * caranya dengan klik di samping tuh, logo postgres sama gajah
  * postgres - localhost > Database > postgres > Schemas > public > Table
  * misal klik 3x di table "customer", trus di tab atas klik ER Diagram
  * 
  * disitu keliatan kalo "customer" foreign key nya customer_id
  * nah custome_id ini ada di table payment, berarti bisa nih 2 table digabungin
  */
 
select 
	customer.customer_id, 
	customer.first_name, 
	payment.amount, 
	payment.payment_date 
from 
	customer
inner join 
	payment on payment.customer_id = customer.customer_id 
order by 
	payment.payment_date 

-- bisa kita persingkat jadi :

select 
	c.customer_id, 
	c.first_name, 
	p.amount, 
	p.payment_date 
from 
	payment p 
inner join 
	customer c on p.customer_id = c.customer_id 
order by 
	p.payment_date

-- lebih singkat lagi make USING()

select 
	c.customer_id, 
	c.first_name, 
	p.amount, 
	p.payment_date 
from 
	payment p 
inner join 
	customer c using (customer_id)
order by 
	p.payment_date
	
-- 2 query diatas hasilnya sama karena emang pengen nyoba aja di bolak balik

select 
	c.first_name ||' '|| c.last_name nama_lengkap, 
	a.address, 
	a.district 
from 
	customer c 
	inner join address a on c.address_id = a.address_id;

-- 3 self join make table alias
-- misal menampilkan film yang memiliki durasi sama tetapi merupakan film yang berbeda.

SELECT
    f1.title,
    f2.title,
    f1.length
FROM
    film f1
INNER JOIN 
	film f2
    ON f1.film_id <> f2.film_id and -- jangan gabungkan film dengan dirinya sendiri
       f1.length = f2.length;  		-- hanya gabungkan film yang durasinya (length) sama.
