-----------------------------------------------------------------------------------------

-- 1. Memberi nama alias pada salah satu kolom

-- normalnya kan gini
select 
	first_name,
	last_name 
from 
	customer
	
-- contoh alias pada kolom
-- usahakan menggunakan tanda underscore -> _
select 
	first_name as nama_depan, -- dari first name menjadi nama depan
	last_name
from 
	customer

select 
	first_name,
	last_name as nama_belakang -- 
from 
	customer

select 
	first_name as nama_depan,
	last_name as nama_belakang 
from 
	customer
	
select 
	first_name nama_depan,
	last_name nama_belakang 
from 
	customer

-----------------------------------------------------------------------------------------

-- 2. nama alias untuk ekspresi
	
SELECT
    first_name || ' ' || last_name as full_name
FROM
    customer;

-- bisa juga tanpa harus menulis 'as'
SELECT
    first_name || ' ' || last_name nama_lengkap
FROM
    customer;


-----------------------------------------------------------------------------------------

-- 3. Nama alias kolom yang mengandung spasi
-- kita beri 2 tanda petik -> " ... "

-- contoh sebelum tanda petik (salah)
select 
	first_name as nama depan, -- error
	last_name as nama belakang, -- error
	first_name || ' ' || last_name as nama lengkap -- error
from 
	customer 

-- contoh menggunakan tanda 2 petik (benar) -> " "
select 
	first_name "nama depan", -- bisa menggunakan spasi
	last_name "nama belakang",
from 
	customer 

-- contoh ekspersi
select 
	first_name || ' ' || last_name "nama lengkap"
from 
	customer 
