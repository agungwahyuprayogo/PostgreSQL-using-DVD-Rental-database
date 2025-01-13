/* RIGHT JOIN
 * 
 * karena kita kemarin udah latihan left join dan paham gitu make table yang mana
 * sekarang kita nyoba make right join dan coba pindah posisi tablenya
 * 
 * jadi kemarin kan yg table satu atau left table film
 * dan yang table kedua alias kanan itu table inventory
 * sekarang kita coba balik table 2 diatas
 * table film jadi ke kanan dan table inventory jadi ke kiri
 * 
 */

select 
	f.film_id,
	f.title,
	i.inventory_id
from 
	inventory i 
right join 
	film f using(film_id)
order by
	f.title 
-- kalian cari disitu film_id = 41, title = Arsenic Independence ada yang null
-- karena film ada di table kedua dan kita pengen nyoba right join, disini harusnya dah berhasil
	
-- sekarang kita nyari null nya
select 
	f.film_id,
	f.title,
	i.inventory_id
from 
	inventory i 
right join 
	film f using(film_id)
where
	i.inventory_id is null
order by
	f.title 
-- kalo kalian ngeh, di left juga ada alice, disini juga ada alice
	
