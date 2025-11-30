/* 
 
where digunakan untuk memfilter baris berdasarkan kondisi tertentu
 
Operator	Deskripsi
=			Sama dengan
>			Lebih besar dari
<			Lebih kecil dari
>=			Lebih besar atau sama dengan
<=			Lebih kecil atau sama dengan
<> 			atau !=	Tidak sama dengan
AND			Operator Logika AND
OR			Operator Logika OR
IN			Mengembalikan true jika nilai cocok dengan salah satu nilai dalam daftar
BEETWEEN	Mengembalikan true jika nilai berada di antara rentang nilai
LIKE		Mengembalikan true jika nilai cocok dengan pola
IS NULL		Mengembalikan true jika nilai adalah NULL
NOT			Menegasikan hasil dari operator lain
 
 */

-------------------------------------------------------------------------------------------------------------------

-- 1. Menggunakan where dengan contoh operator `=`

select 
	first_name, 
	last_name  
from 
	customer
where 
	first_name = 'Jamie' 
	-- GUNAKAN 1 kutip -> ' ' , 
	-- BUKAN 2 kutip -> " "
	
-------------------------------------------------------------------------------------------------------------------
	
-- 2. Menggunakan where dengan contoh operator `and`
-- AND, terdapat dua kondisi atau lebih, dimana semua harus terpenuhi

select 
	first_name, 
	last_name  
from 
	customer
where 
	first_name = 'Jamie' 
		and -- menggunakan indentasi agar mudah dibaca / readable
	last_name = 'Rice'	
	
-------------------------------------------------------------------------------------------------------------------
	
-- 3. Menggunakan WHERE dengan contoh operator OR
-- ada 2 kondisi atau lebih, dimana hanya salah satu saja yang terpenuhi
	

select 
	first_name ,
	last_name 
from 
	customer
where 
	first_name = 'Adam'
		or -- readable
	last_name = 'Rodriguez'
		
-------------------------------------------------------------------------------------------------------------------
	
-- 4. Where dengan operator IN
-- IN adalah jalan pintas selain OR, dibandingkan dengan cara ini :
select 
	first_name ,
	last_name 
from 
	customer
where 
	first_name = 'Ann'
		or 					-- terlalu banyak or
	first_name  = 'Anne'
		or 					-- terlalu banyak or
	first_name  = 'Annie'
	
-- lebih baik kita menggunakan cara ini : 
select 
	first_name ,
	last_name 
from 
	customer
where 
	first_name in ('Ann', 'Anne', 'Annie') -- cukup satu baris
-- cara ini ^ jauh lebih singkat dan efektif dibandingkan menggunakan or 

	
-------------------------------------------------------------------------------------------------------------------
	
-- 5. WHERE dengan operator LIKE
-- LIKE digunakan untuk mencari data yang cocok dengan pola tertentu (pattern matching)
	
select 
	first_name ,
	last_name
from 
	customer
where 
	first_name like 'Ann%' -- % disebut wildcard, cocok untuk mencari string apa pun yang dimulai dengan 'Ann'


	
-------------------------------------------------------------------------------------------------------------------
	

-- 6. WHERE dengan operator BETWEEN
-- BETWEEN , digunakan untuk menguji apakah suatu nilai berada di dalam rentang nilai tertentu 
	
select 
	first_name || ' ' || last_name, 
	length(first_name || ' ' || last_name) panjang_karakter
from 
	customer
where 
	first_name like 'A%' 
		and 
	length(first_name || ' ' || last_name ) between 3 and 10 -- tidak bisa menggunakan 'panjang karakter', harus tulis ulang length(..)
order by 
	panjang_karakter 
	
		
-------------------------------------------------------------------------------------------------------------------
	
-- 7. WHERE dengan operator tidak sama dengan <> 
-- <>, kita tidak ingin mengeluarkan data itu
	
select
	first_name,
	last_name 
from 
	customer
where 
	first_name like 'Bra%'
		and
	last_name <> 'Motley' -- tidak ingin menegluarkan data Bra Motley
	
