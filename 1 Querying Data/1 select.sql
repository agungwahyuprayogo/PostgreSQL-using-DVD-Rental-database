select * from actor a 

select * from customer c 

select * from country c 

-------------------------------------
select a.first_name, a.last_name from actor a 

select c.first_name, c.last_name, c.email from customer c 

select c.country, c.country_id  from country c 

-------------------------------------
SELECT
   first_name || ' ' || last_name, -- nama kolom masih `?`
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
SELECT NOW(); -- untuk liat jam dan hari ini
