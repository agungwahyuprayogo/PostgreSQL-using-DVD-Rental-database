-- 1. Ngurutin data make satu kolom aja
-- ngurutin nama dari abjad A - Z firts_name
select
	first_name,
	last_name 
from 
	customer
order by
	first_name asc  -- ga wajib karena defaultnya asc (urutan dari A - Z)
	

select
	first_name,
	last_name 
from 
	customer
order by
	first_name -- hasilnya akan sama dengan yang sebelumnya.
	
------------------------------------------------------------------------------------------------------
	
-- 2. Ngurutin data make satu kolom (descending / dari besar ke kecil)
-- kalo mau dibalik urutannya dari abjad Z - A, atau angka dari yang terbesar ke terkecil,, gunakan desc

-- ngurutin nama dari abjad Z - A di last_name
	
select 
	first_name,
	last_name
from 
	customer
order by 
	last_name desc -- liat last_name, urutannya dari abjad belakang dulu (Z Y X)

------------------------------------------------------------------------------------------------------

-- 3. Ngurutin nama make banyak kolom (campuran ascending dan descending)
select 
	first_name,
	last_name 
from 
	customer
order by
	first_name asc,
	last_name desc
-- Ada 2 orang yang namanya "Kelly", last_name nya dari "T" dulu baru "K"
	
------------------------------------------------------------------------------------------------------
	
-- 4. ngurutin data berdasarkan rumus (ekspresi) & alias
-- semisal kita pengen nampilin data yang huruf first_name - nya paling banyak
	
select
	first_name,
	length(first_name) as len -- length menghitung jumlah karakter huruf, "len" adalah nama alias
from 
	customer
order by
	len desc	-- kita urutkan dari yang paling banyak
	
------------------------------------------------------------------------------------------------------
	
-- ORDER BY AND NULLS
-- Di dunia database, NULL itu artinya data kosong alias belum diisi (bukan angka 0, dan bukan juga spasi kosong).
	
-- buat table demo dulu
-- bikin tabel baru
CREATE TABLE sort_demo(num INT);

-- Masukin data contoh (angka 1, 2, 3, dan satu data kosong)
INSERT INTO sort_demo(num)
VALUES
  (1),
  (2),
  (3),
  (null);

------------------------------------------------------------------------------------------------------

-- A. Aturan default / bawaan (asc)
select 
	num 
from 
	sort_demo
order by
	num -- NULLS ada di posisi terakhir
	
-----
	
select 
	num 
from 
	sort_demo
order by
	num nulls last -- hasilnya sama kaya sebelumnya
	
-----
	
-- kalo mau mindah NULLS diatas :
select 
	num 
from 
	sort_demo
order by
	num nulls first -- NULLS jadi diatas
	
----------------------------------------------------------------------------------------------------------------------

-- B. Aturan bawaan pas urutan turun (desc)
-- sebaliknya, kalo kita ngurutin data secara turun (desc) NULLS akan jadi di paling atas

select
	num
from 
	sort_demo
order by
	num desc -- NULL akan di posisi paling atas
	
-- kalo mau maksa NULLS ada di bawah dan urutan dari yang terbesar, bisa set NULLS LAST
	
select
	num
from 
	sort_demo
order by
	num desc nulls last
