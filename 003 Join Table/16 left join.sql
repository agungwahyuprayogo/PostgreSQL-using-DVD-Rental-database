-- LEFT JOIN
/* ya inti dari left join adalah
 * semua yang ada di table kiri (table 1)
 * yang ada di table 2 juga di tampilin (kalo matching di table 1 dan 2)
 * yang datanya ga ada di table 2 otomatis jadi null
 * 
 * biar ga pusing kita latihan left join berikut :
 * langsung metode expert aja ya biar ga kebanyakan nulis
 */

select 
	f.film_id,
	f.title,
	i.inventory_id 
from 
	film f 
left join 
	inventory i 
using
	(film_id) 
order by 
	title 
	
/* kalo kalian cek itu di film_id = 14, title = Alice Fantasia, 
 * inventory id nya ga ada di table inventory
 * maksudnya di table inventory ga ada film_id 14
 * kita cek dah yuk biar ga penasaran 
*/

select distinct film_id from inventory i order by film_id
-- pas di cek ternyata bener, film

-- biar ga ribet cek atu atu, kita tampilin aja yang null
select 
	f.film_id,
	f.title,
	i.inventory_id 
from 
	film f 
left join 
	inventory i 
using
	(film_id) 
where 
	i.inventory_id is null
order by 
	title 
-- pas di cek banyak juga njer awkoaok ada 42 film yg null alias ga ada di inventory