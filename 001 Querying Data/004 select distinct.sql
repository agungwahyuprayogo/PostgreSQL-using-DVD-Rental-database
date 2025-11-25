/* jadi select distinct ini fungsi nya buat ngilangin duplikat dalam table
 * misal di table ada 'Agung Wahyu' dan 'Agung Prayogo'
 * dan kita cuman pengen nampilin first_name doang
 * nanti yang muncul cuman 1 Agung
 * karena memang distinct ini buat ngilagin yg sama
 * 
 * kecuali nampilin first_name dan last_name
 * nanti tetep nampil 22nya
 * 
 */

CREATE TABLE colors(
  id SERIAL PRIMARY KEY,
  bcolor VARCHAR,
  fcolor VARCHAR
);

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

-- kita tampilin semua dulu
select c.bcolor, c.fcolor from colors c 

-- distinct bcolor
select distinct c.bcolor from colors c 

select distinct c.fcolor from colors c 


-- distinct dua kolom
select distinct c.bcolor, c.bcolor from colors c 
-- nah beda kan sama ga distinct

-- select distinct dalam sample database
select f.rental_rate from film f 

select distinct f.rental_rate from film f order by f.rental_rate 

