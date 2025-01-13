/* kali ini kita bakal belajar Roll Up
 * hampir mirip sama cube kemarin 
 * cuman kalo roll up itu ga semuanya dihitung
 * 
 * kalo cube kemarin kan sampe banyak null nya tuh di baris bawah2, ada null 3x
 * kalo di roll up ga, yang diitung cuman yg kita masukin aja
 * total penjualan juga di itung tapi ga semua dari segment dan brand diitung semua
 * 
 * cube gini nih itungannya
 * (c1, c2, c3)
 * (c1, c2)
 * (c2, c3)
 * (c1,c3)
 * (c1)
 * (c2)
 * (c3)
 * ()
 * 
 * kalo di roll up yang dikeluarin gini doang
 * (c1, c2, c3) 
 * (c1, c2)
 * (c1)
 * ()
 * dengan asumsi kalo c1 > c2 > c3
 * 
 * langsung contoh aja deh
 */

SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    ROLLUP (brand, segment)
ORDER BY
    brand,
    segment;

--coba kita bandingin sama cube
 select  
	segment,
	brand,
	sum(quantity) 
from 
	sales 
group by 
	cube(segment, brand)
order by
	segment,
	brand

-- berarti kembali lagi ke kebutuhan, kalo pengen liat semua hasilnya, make cube
-- kalo cuman pengen liat sebagian make roll up

-- sekarang kita balik, segment dulu baru brand
SELECT
    segment,
    brand,
    SUM (quantity)
FROM
    sales
GROUP BY
    ROLLUP (segment, brand)
ORDER BY
    segment,
    brand;

  -- sekarang kita coba roll up sebagian doang
 SELECT
    segment,
    brand,
    SUM (quantity)
FROM
    sales
GROUP BY
    segment,
    ROLLUP (brand)
ORDER BY
    segment,
    brand;
-- yang di hitung sampe brand doang, abis tuh berenti
   
-- skarang kita coba make data dvdrental
SELECT
    EXTRACT (YEAR FROM rental_date) y,
    EXTRACT (MONTH FROM rental_date) m,
    EXTRACT (DAY FROM rental_date) d,
    COUNT (rental_id)
FROM
    rental
GROUP BY
    ROLLUP (
        EXTRACT (YEAR FROM rental_date),
        EXTRACT (MONTH FROM rental_date),
        EXTRACT (DAY FROM rental_date)
    );
