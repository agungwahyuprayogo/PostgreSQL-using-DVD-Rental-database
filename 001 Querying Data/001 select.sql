----------------------------------------------------------

-- 1. mengambil data dari satu kolom

select first_name from customer c 

select last_name from customer

----------------------------------------------------------

-- 2. mengambil data lebih dari satu kolom
-- menggunakan ' , ' sebagai pemisah tiap kolom

select first_name, last_name from actor

select first_name, last_name, email from customer

select country, country_id  from country 

----------------------------------------------------------

-- 3. mengambil data dari semua kolom

select * from actor a 

select * from customer c 

select * from country c 


----------------------------------------------------------

-- 4. ekspresi

SELECT
   first_name || ' ' || last_name, -- nama kolom masih `?column?`
   email
FROM
   customer;

SELECT
   first_name || ' ' || last_name as full_name, -- nama kolom yang sebelumnya ? jadi full name
   email
FROM
   customer;

SELECT
   first_name || ' ' || last_name nama_lengkap, -- ga make as 
   email
FROM
   customer;

------------------------------------

-- 5. Syntax select tanpa 'from'

SELECT NOW(); -- untuk liat jam dan hari ini
