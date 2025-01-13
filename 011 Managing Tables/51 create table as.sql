/* ok kita bakal latihan 'create table ... as' 
mirip sama select into, hanya saja kita disini bisa ganti nama table dan kolomnya 

CREATE TABLE new_table_name
AS query;
- query create table akan membuatkan table baru
- new_table_name adalah nama table baru tersebut
- AS query .. query yang ingin anda masukan ke dalam table baru
---------------------------------------------------------------------------------------------------------
CREATE TEMP TABLE new_table_name 
AS query; 
-- query untuk membuat table sementara

CREATE TABLE new_table_name ( column_name_list)
AS query;
-- kalo ada table yang sama, bisa dibedain berdasarkan nama kolomnya

CREATE TABLE IF NOT EXISTS new_table_name
AS query;
-- buat jaga2 kalo nama dengan table yang sama udah ada, buat nimpa table yg ada

-------------------------------------------------------------------------------------------------------

sebagai contoh kita buat table baru dengan nama action_film, dimana itu daftar film dengan kategori action
karena ada di table film dan film_category
**/

CREATE TABLE action_film 
AS
SELECT
    film_id,
    title,
    release_year,
    length,
    rating
FROM
    film
INNER JOIN film_category USING (film_id)
WHERE
    category_id = 1;
-- karena ga sementara atau temporer, table muncul di samping ketika kita refresh    

-- buat verifikasi apakah sudah berhasil, kita run
SELECT * FROM action_film
ORDER BY title;
-- ternyata ada

---------------------------------------------------------------------------------------------------

/* contoh lain, jika hasil query yg kita buat mengandung angka ekspresi hasil perhitungan, lebih baik 
ganti nama kolomnya biar ga ambigu */

CREATE TABLE IF NOT EXISTS film_rating (rating, film_count) 
AS 
SELECT
    rating,
    COUNT (film_id)
FROM
    film
GROUP BY
    rating;
    
-- sekarang kita jalanin 
select * from film_rating fr 

-- kita coba kalo ga ganti nama table
CREATE TABLE IF NOT EXISTS film_count
AS 
SELECT
    rating,
    COUNT (film_id)
FROM
    film
GROUP BY
    rating;
    
select * from film_count fc 
-- ganapa2 juga sih sebenernya