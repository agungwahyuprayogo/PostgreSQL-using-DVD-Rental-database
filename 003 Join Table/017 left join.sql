-- LEFT JOIN
/* ya inti dari left join adalah
 * nampilin semua yang ada di table kiri setelah from
 * beberapa table kanan table setelah left join ada yg null
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
	inventory i using (film_id) 
order by 
	title 
	
/* kalo kalian cek itu di film_id = 14, title = Alice Fantasia, 
 * inventory id nya ga ada di table inventory
 * karena ga ada yg nyewa film Alice Fantasia
 * kasian bet njir
*/
	
-- kita cek lagi, make count
select 
	f.film_id,
	f.title,
	count(i.inventory_id) total_sewa
from 
	film f 
left join 
	inventory i using (film_id) 
group by 1
having count(i.inventory_id) = 0
order by 2


select distinct film_id from inventory i order by film_id
-- pas di cek ternyata bener, film_id 14 ga ada

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
