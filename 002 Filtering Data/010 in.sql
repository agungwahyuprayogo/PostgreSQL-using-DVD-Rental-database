# sebenernya ini pernah di pelajarin di sebelum sebelumnya ya
# cuman biar lebih memperdalam lagi 
# jadi kita pengen latihan 'in'
# jadi 'in' itu operator yang digunakan untuk mengecek apapun hasil sesuai value yang dicari

# langsung ke contohnya aja biar ga pusing

select film_id, title from film f where film_id in (0, 2, 3)
-- disini emang sengaja make 0, biar ngeliatin kalo misalkan 0 itu ga ada ya gpp
-- ga ditampilin tapi ga error
-- tapi kalo selain 0 ada, ya itu doang yang di tampilin

select film_id, title from film f where film_id = 1 or film_id = 2 or film_id = 3
-- untuk hasilnya mah sama, cuman kan dari query disini terlihat lebih banyak dari pada diatas




# trus bagaimana kalo make string? 
# ya sama aja kaya diatas, bedanya cuman kasih tanda petik

select first_name, last_name from actor a where last_name in ('Allen', 'Chase', 'Davis') order by last_name 
-- ternyata banyak kan yg nama belakanya Allen, Chase dan Davis

select first_name, last_name from actor a where last_name = 'Allen' or last_name = 'Chase' or last_name = 'Davis' order by last_name 
-- hasilnya sama kan? cuman kalo make make string jauh lebih panjang, jadi make in aja biar ga terlalu banyak



# bisa juga tanggal 

select payment_id, amount, payment_date from payment p where payment_date::date in ('2007-02-15', '2007-02-16') order by payment_date 
-- dari rentang tanggal sekian sampe tanggal sekian




# not in, ya bedanya kalo in di atas kan minta di tampilin
# kalo ini kita justru ga pengen nampilin
# misal kita ga pengen nampilin 1,2 dan 3. ya brarti not in 1,2,3

select film_id, title from film f where film_id not in (1,2,3) order by film_id 
-- bisa kan yang 1, 2, dan 3 ga di tampilin
-- kalo contoh diatas in bisa make operator or dan =
-- kalo not in make operator and dan <>

select film_id, title from film f where film_id <> 1 and film_id <> 2 and film_id <> 3 order by film_id 
