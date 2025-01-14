/* ya mirip and operator
 * tapi kalo di or ini, kalo salah satu nilai terpenuhi nilainya true
 */

select true or true as result -- hasil true [v]

select true or false as result -- hasil true [v]

select true or null as result -- hasil true [v]

---------------------------------------------------------------------

select false or true as result -- hasil true [v]

select false or false as result -- hasil false [ ]

select false or null as result -- hasil true [NULL]

--------------------------------------------------------------------

select null or true as result -- hasil [v]

select null or false as result -- hasil [NULL]

select null or null as result -- hasil [NULL]

--------------------------------------------------------------------

select f.title, f.length, f.rental_rate from film f where f.rental_rate = 0.99 or f.rental_rate = 1.99
