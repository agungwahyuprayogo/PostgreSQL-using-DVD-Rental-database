like yang kita tahu adalah untuk mencari value 
semisal kamu ingin mengetahu nama customer, 
namun kamu hanya ingat nama depanya saja , 'Jen'
kamu bisa menggunakan like 'Jen%'

select 
  first_name,
  last_name
from 
  customer
where 
  first_name like 'Jen%';

-- 1. contoh penggunaan dasar like
SELECT 'Apple' LIKE 'Apple' AS result; -- hasilnya true karena plek numplek sama

SELECT 'Apple' LIKE 'A%' AS result; -- hasilnya true karena setelah A bebas mau huruf apa

-- 2. menggunakan operator like dalam table
select 
  first_name,
  last_name
from 
  customer
where 
  first_name like  '%er%' -- (huruf bebas) er (huruf bebas)
order by 
  first_name;

-- 3. menggunakan operator like dengan pola '%' dan '_'
select 
  first_name,
  last_name
from 
  customer
where 
  first_name like  '_her%' -- mengandung huruf pertama di depan 'her', dan berakhiran bebas
order  by 
  first_name;

-- 4. penggunakan not like
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name NOT LIKE 'Jen%' -- cari first name selain Jen_ _
ORDER BY
  first_name;

-- ILIKE
-- ada cara lain kalo semisal kita gatau data dan ga pengen ada insensitive case
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name ILIKE 'BAR%';
-- disini terlihat kalo make ilike, ga ngaruh ke hasilnya, 
-- selama mengandung huruf bar baik huruf besar atau kecil tetap ditampilkan

-- berbeda jika menggunakan like biasa
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'BAR%';
-- hasilnya kosong



--	Operator	Setara Dengan
--	~~			LIKE
--	~~*			ILIKE
--	!~~			NOT LIKE
--	!~~*		NOT ILIKE

SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name ~~ 'Dar%'
ORDER BY
  first_name;
