-- FUNCTION
-- Menggunakan table payment

select * from payment p

-- 1. Contoh dasar menggunakan count()
select count(*) from payment *
-- dari sini disimpulkan, data di table payment ada 14.596 baris, dimana null juga dihitung

--- 

-- 2) Contoh PostgreSQL COUNT(DISTINCT column)
SELECT
	COUNT(DISTINCT customer_id)
FROM
	payment;
-- ada sebanyak 599 customer unik (berbeda) di data ini

---

-- 3. Penggunaan fungsi PostgreSQL COUNT() dengan klausa GROUP BY
SELECT
  	customer_id,
  	COUNT(customer_id)
FROM
	payment
GROUP BY
	customer_id
order by 2 desc
-- di tampilkan id_customer beserta berapa kali di belanja

-- jika ingin mengetahui namanya juga
select
	c.customer_id,
  	c.first_name || ' ' || c.last_name AS full_name,
  	COUNT(customer_id) as total_belanja
FROM
  	payment p
INNER JOIN 
	customer c USING(customer_id)
group by
  customer_id
order by 
	total_belanja desc
	
-- 4. Penggunaan fungsi PostgreSQL COUNT() dengan klausa HAVING
SELECT
  first_name || ' ' || last_name AS full_name,
  COUNT(customer_id)
FROM
  payment
INNER JOIN customer USING(customer_id)
GROUP BY
  customer_id
HAVING
  COUNT(customer_id) > 40;
