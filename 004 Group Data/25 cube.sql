/* INTRODUCTION CUBE
 * 'cube' merupakan sub query dari 'group by'. 
 * 'cube' memperbolehkan anda untuk menghasilkan group yang berbeda 
 * 
 * berikut adalah ilustrasi dari cube
 * 
 * SELECT
 * 		kolom1,
 * 		kolom2,
 * 		... ,
 * 		function(kolom4)
 * FROM
 * 		table
 * GROUP BY
 * 		CUBE (kolom1, kolom2, kolom3)
 * 
 * pertama, tentukan kolom mana yg akan di kelompokan dalam cube
 * kedua, tentukan kolom (dimensi atau kolom dimensi) yang ingin anda analisa 
 * ketiga, gunakan tanda kurung pada bagian kolom yang ingin di kelompokan dalam cube
 * 
 * cube berkerja berdasarkan dimensi yang kita masukan, secara singkat kaya gini :
 * misal ada 3 kolom: c1, c2, c3
 * 
 * cube(c1,c2,c3)
 * 
 * grouping sets (
 * 		(c1, c2, c3),
 * 		(c1, c2),
 * 		(c1, c3),
 * 		(c2, c3),
 * 		(c1),
 * 		(c2),
 * 		(c3),
 * 		()
 * )
 * 
 * nangkep ya maksudnya
 * kita yg atur bagian mana aja yang mau di pecah atau di jabarin dalam cube
 * 
 * langsung contohnya aja deh
 */

select 
	brand, 
	segment, 
	sum(quantity) 
from 
	sales 
group by 
	cube(brand, segment)
order by
	brand,
	segment -- perlu di order brand dan segment, kalo brand doang ga rapi
-- kalo ini jalanin semua, maksudnya ngitung semua total penjualan baik dari brand dan segment
-- brand diitung, segment diitung, total keselu
-- abis abc di itung, lanjut xyz
-- abis xyz ke segment, abis segment di itung keseluruhan

-- kalo cuman mau liat total penjualan berdasarkan segment kaya gini aja
select 
	brand, 
	segment, 
	sum(quantity) 
from 
	sales 
group by 
	brand,
	cube(segment)
order by
	brand,
	segment
-- kalo disini abis segment udah
	
-- coba coba buat tau bedanya sama rolls ip
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
-- sama njir, ga beda
-- kalo cube sampe 9 baris
	-- kalo roll up 7 baris doang