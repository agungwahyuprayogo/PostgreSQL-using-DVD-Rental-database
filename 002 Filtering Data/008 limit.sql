# kali ini kita bakal bahas soal 'limit'
# sesuai namanya, kita bakal batesin hasil yang keluar dari database yang pengen kita tampilin
# kalo masukin limitnya 1, ya bakal nampilin 1 doang
# kalo masukin limit 0? berarti sama sekali ga ada yang ditampilin

--SELECT 
--  select_list 
--FROM 
--  table_name 
--ORDER BY 
--  sort_expression 
--LIMIT 
--  row_count (jumlah baris yang pengen ditampilin)
--OFFSET 
--  row_to_skip; (jumlah baris yang mau di skip berapa nomer)

select film_id, title, release_year from film order by film_id limit 10

select film_id, title, release_year from film order by film_id limit 4 offset 3
# pertama ngurutin hasil dari id (terkecil ke terbesar), 
# kedua, skip baris dari 1 sampe 3
# ketiga, nampilin 4 baris
