/* select distinct digunakan untuk menampilkan data yang unique pada suatu kolom 
singkatnya, jika ada 2 data 'merah' dalam, hanya akan menampilkan 1 merah */

-- kita buat table colors dulu
INSERT INTO
  colors (bcolor, fcolor)
VALUES
  ('red', 'red'),
  ('red', 'red'),
  ('red', NULL),
  (NULL, 'red'),
  (NULL, NULL),
  ('green', 'green'),
  ('blue', 'blue'),
  ('blue', 'blue');

-- kita tampilkan seluruh data di table colors
select * from colors c 

--------------------------------------------------------------------------------------------------

-- 1. Select distinct pada satu kolom
select 
	distinct bcolor -- awas jangan typo
from 
	colors
	
-- coba kita bandingkan tampa distinct pada kolom bcolor
select 
	bcolor -- awas jangan typo
from 
	colors	
-- masih ada 3 red dan 2 blue
	
--------------------------------------------------------------------------------------------------
	
-- 2. select distinct pada beberapa kolom
select 
	distinct bcolor, fcolor 
from
	colors 
order by -- agar mempermudah melihat perbedaan
	bcolor, fcolor 
	
		
--------------------------------------------------------------------------------------------------

-- 3. select distinct pada table `film`
	
select 
	distinct rating 
from 
	film
order by 
	rating 
	
select 
	distinct rental_rate 
from 
	film
order by 
	rental_rate 
