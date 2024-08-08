SELECT version();

/* kali ini kita bakal belajar mengenai 'select into' untuk membuat table baru berdasarkan
hasil query yang didapatkan berdasarkan query

table baru tersebut akan memiliki kolom dan baris sesuai apa hasil dari query yang dimasukan dalam
'select into'. ga kaya query 'select', query 'select into' ga ngirim perintah ke database client, karena 
table yang datanya dari hasil 'select into' sudah hasil akhir tanpa inputan perintah ke database client.

berikut basic query dari select into :


SELECT 
  select_list I
INTO [ TEMPORARY | TEMP ] [ TABLE ] new_table_name 
FROM 
  table_name 
WHERE 
  search_condition;

- table baru dibuat setelah query 'into' keyword
- query 'temp' atau 'temporary' bersifat opsional, hanya saja table yang menggunakan temp akan hilang 
	bila koneksi dbeaver dengan client sudah habis, biasanya ada di pojok kanan bawah
- query 'where' memperbolehkan anda untuk lebih menspesifikan lagi hasil querynya, anda juga bisa menggunakan
 query lain seperti 'inner join', 'left join', 'group by', dan 'having'
 
----------------------------------------------------------------------------------------------------------
sebagai demonstrasi kita akan membuat table 'film_r' menggunakan query hasil query dari table 'film',
dimana datanya adalah film yang berisi rating 'R' dengan durasi sewa 5 hari
**/

SELECT
    film_id,
    title,
    rental_rate
INTO TABLE film_r -- table baru
FROM
    film
WHERE
    rating = 'R'
AND rental_duration = 5
ORDER BY
    title;
-- ketika sudah di run, dan refresh table, maka ada table baru yaitu film_r
-- yang isinya film rating R dengan durasi sewa 5 hari

-- buat ngetes kita bisa coba
select * from film_r
-- table ini ga ngasih perintah ke client karena 
----------------------------------------------------------------------------------------------------------

/* demonstrasi kedua, kita coba buat table temorary (sementara) dengan nama short_film dimana
film tersebut adalah film dengan durasi di bawah 60 menit */

select 
	film_id,
	title,
	length
into temp table short_film
from film 
where length < 60
order by title
-- ga muncul di table samping,  tapi pas dijalanin 2x error :|

SELECT * FROM short_film
ORDER BY length DESC;
-- karena hanya sementara, ga kesimpen jadi table baru, bisa jadi error lagi 
-- hingga koneksi ke client database sudah terputus