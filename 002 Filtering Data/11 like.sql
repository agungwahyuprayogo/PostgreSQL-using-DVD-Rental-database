/* kalo lu lagi pengen nyari nama seseorang cuman lu kaga yakin sama namanya
 * lu bisa make query 'like'
 * 
 * anggep lah nama temen lu itu ada 'Jen' nya di awal
 */*/
 
 select first_name, last_name from customer c where first_name like 'Jen%'
 -- maksud dari query ini, cari nama orang di customer yang nama awalnya tuh ada 'Jen',
 -- belakangnya make % biar hasil apapun di tampilin selama depanya 'Jen'
 -- 'Jen%' tuh disebut pola atau pattern
 
 select first_name, last_name from customer c where first_name like '%er%' order by first_name 
 -- atau mau nyari orang yang ada 'er' ditengah tengah nama 
 -- bisa juga make %er%
 
 -- misal lagi nih orang bule , namanya ada her her nya gitu
 select first_name, last_name from customer c where first_name like '_her%' order by first_name
 
 
 ----------------------------------------------------------------------------------
 
 
 /* operator like juga bisa buat deteksi apakah tulisanya dah mirip2 atau dah sama belom
  * misal ni ye :
  */*/

 select 'Apple' like 'Apple' as result
 -- kalo hasilnya t atau [v] berarti Apple sama dengan Apple 
 
 select 'Apple' like 'A%' as result
 -- apakah Apple mirip A...
 
 select 'A%' like 'Apple' as result
 -- ternyata disini hasilnya false atau [] 
 
 
 -----------------------------------------------------------------------------------
 
 
 /* kalo tadi kan kita buat contoh yang 'like'
  * sekarang kita buat yang 'not like'
  */*/
  
 select first_name, last_name from customer c where first_name not like 'Jen%'
 -- kalo diatas kan pen nyari Jen, dapet Jennifer dll
 -- nah sekarang Jennifer dah ilang karena kita make not like
 
 
 --------------------------------------------------------------------------------
 
 
 /* di postgreSQL 'ilike' mirip2 query mirip2 query 'like'
  * cuman 'ilike' ini lebih ga sensitive case
  * jadi kalo ada yg ga pas huruf gede kecilnya, make 'ilike' bantu banget
  */ 
 
 select first_name, last_name from customer c where first_name ilike '%bar%'
 -- yang ditampilin Barbara dan Barry (kapital)
 -- padahal kita masukin nya 'bar' huruf kecil semua