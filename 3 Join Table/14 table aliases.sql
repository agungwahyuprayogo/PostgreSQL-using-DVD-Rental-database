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
 -- kalo mau lebih singkat boleh langsung "from film f"
 
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
	c.customer_id, 
	c.first_name, 
	p.amount, 
	p.payment_date 
from 
	customer c 
	inner join payment p on p.customer_id = c.customer_id 
order by 
	p.payment_date 


select 
	c.customer_id, 
	c.first_name, 
	p.amount, 
	p.payment_date 
from 
	payment p 
	inner join customer c on p.customer_id = c.customer_id 
order by 
	p.payment_date

-- 2 query diatas hasilnya sama karena emang pengen nyoba aja di bolak balik

select 
	c.first_name ||' '|| c.last_name nama_lengkap, 
	a.address, 
	a.district 
from 
	customer c 
	inner join address a on c.address_id = a.address_id 