/* intinya sih kalo operator AND bakal ngasilin False kalo ga terpenuhi semua
 * 
 */

select true and true as result -- hasil [v]

select true and false as result -- hasil [ ]

select true and null as result -- hasil [NULL]

-------------------------------------------------

select false and false as result -- hasil [ ]

select false and true as result -- [ ]

select false and null as result -- [ ]

-------------------------------------------------

select null and true as result -- hasil [NULL]

select null and false as result -- [ ]

select null and null as result -- [NULL]

/* secara urutan keliatan False > NULL > True
 * 
 */

-- MENGGUNAKAN AND OPERATOR DENGAN WHERE
select f.title, f.length, f.rental_rate from film f 

select f.title, f.length, f.rental_rate from film f where f.length > 100 and f.rental_rate > 4

