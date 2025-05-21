-- using payment table
select * from payment p 

-- 1. Basic avg() function
select avg(amount) from payment p
-- hasilnya 4.2006056453822965

-- agar lebih mudah dibaca
select avg(amount)::numeric(10,2) from payment p 
-- hasilnya 4.2


-- 2. using avg() with distinct operator
select 
	avg(distinct amount)::numeric(10,2)
from 
	payment p
-- hasilnya beda karena soal pertama tidak menggunakan distinct
	
-- 3. using avg() with sum() function
select 
	avg(amount)::numeric(10,2) as rata_rata,
	sum(amount)::numeric(10,2) as total_pendapatan
from 
	payment p 
	
-- 4. using avg() with group by clause
select 
	c.customer_id,
	c.first_name || ' ' || c.last_name as nama_lengkap,
	avg(p.amount) as rata_rata,
	sum(p.amount) as total_pengeluaran
from 
	payment p 
inner join 
	customer c using(customer_id)
group by 
	c.customer_id
order by total_pengeluaran desc

-- 5. using avg() with having clause
select 
	c.customer_id,
	c.first_name || ' ' || c.last_name as nama_lengkap,
	avg(p.amount) as rata_rata,
	sum(p.amount) as total_pengeluaran
from 
	payment p 
inner join 
	customer c using(customer_id)
group by 
	c.customer_id
having 
	avg(amount) > 4 -- gabisa make as rata_rata diatas
order by total_pengeluaran desc

-- 6 Using PostgreSQL AVG() function and NULL
CREATE TABLE t1 (
  id serial PRIMARY KEY,
  amount INTEGER
);

INSERT INTO t1 (amount)
VALUES
  (10),
  (NULL),
  (30);

SELECT
  *
FROM
  t1;

SELECT AVG(amount)::numeric(10,2)
FROM t1;
-- hasilnya 20, membuktikan jika avg() tidak menghitung value null
