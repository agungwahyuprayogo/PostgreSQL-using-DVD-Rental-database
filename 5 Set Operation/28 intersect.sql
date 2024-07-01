/* kali ini kita bakal belajar mengenai intersect
 * cara kerjanya mirip mirip sama inner join
 * jadi nampilin yang datanya sama aja
 * langsung ke praktek aja ya
 */

select * from most_popular_films mpf 
intersect
select * from top_rated_films trf 
-- secara sekilas mirip inner join, bedanya disini ga perlu foreign key

-- kalo mau ngurutin berdasarkan taun bisa?
select * from most_popular_films mpf 
intersect
select * from top_rated_films trf 
order by release_year desc -- dari film paling baru