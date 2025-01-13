/*kali ini kita bakal belajar mengenai : 
 * GROUPING SETS
 * gampangnya ya.. dari latihan group by kemarin, kan yang ditampilin cuman satu grouping doang nih
 * kalo grouping sets bisa nampilin lebih dari satu grouping
 * 
 * kita buat table sales dulu deh untuk demonstrasi
 */

drop table if exists sales

create table sales (
	brand varchar not null,
	segment varchar not null,
	quantity int not null,
	primary key (brand, segment)
);

insert into sales (brand, segment, quantity)
values 
	('ABC', 'Premium', 100),
	('ABC', 'Basic', 200),
	('XYZ', 'Premium', 100),
	('XYZ', 'Basic', 300)
returning *;
-- table sales ini nampilin data penjualan berdasarkan brand dan segment

-- INTRODUCTION GROUPING SETS
/* grouping atau pengelompokan kolom menggunakan query 'group by'
 * dilambangkan dengan daftar 1 kolom, atau lebih yang ditandai dengan koma
 * (kolom1, kolom2, ...)
 * 
 * untuk contoh kita pengen ngeliat data penjualan berdasarkan brand dan segment
 */ 

select brand, segment, sum(quantity) from sales s group by brand, segment 
-- kita dah make group by brand dan segment masih bingung bacanya kan
-- karena gabung semua
-- jadi mau gamau kudu cek satu satu 

select brand, sum(quantity) from sales s group by brand
-- kalo kita pengen ngeliat total penjualan keseluruhan secara brand

select segment, sum(quantity) from sales s group by segment 
-- kalo ini kita pengen liat total penjualan berdasarkan segment 

select sum(quantity) from sales s 
-- ini kalo mau liat secara keseluruhan dari penjualan produk

/* kan ribet ya kalo atu atu, ga ribet sih, lebih ke lebih banyak ngetik aja
 * kalo liat penjualan brand kita ketik query berdasarkan brand,
 * kalo pengen liat penjualan berdasarkan segment, ketik satu lagi
 * 
 * nah sebenernya bisa kita liatin semua tadi dalam satu query dengan 'union all'
 * tapi dengan catatan kasih null biar ga bingung
 */

select brand, segment, sum(quantity) from sales group by brand, segment 
union all
select brand, null, sum(quantity) from sales s group by brand
union all
select null, segment, sum(quantity) from sales group by segment 
union all 
select null, null, sum(quantity) from sales 

/* jadi cara baca hasil table nya tuh
 * kalo kolom brand dan segment tampil, berati data nampilin hasil penjualan berdasarkan brand dan segment
 * kalo kolom brand nyala tapi segment null, itu nampilin hasil penjualan berdasarkan brand
 * kalo kolom brand mati tapi segment nyala, itu nampilin hasil penjualan berdasarkan segment
 * kalo kolom brand dan segment mati, itu nampilin hasil penjualan secara keseluruhan
 * 
 * tapi walaupun bisa digabung, masih terlihat ribet secara syntax query
 * masih banyak yg harus di ketik
 * nah dari sini lah kita belajar mengenai grouping sets
 * secara basic query nya kaya gini :
 * 
 * SELECT
 * 		kolom1,
 * 		kolom2,
 * 		... ,
 * 		function,
 * FROM
 * 		table
 * GROUP BY
 * 		GROUPING SETS (
 * 		(kolom1, kolom2),
 * 		(kolom1),
 * 		(kolom2),
 * 		()
 * );
 * 
 * dari contoh query diatas, kita mau bagi jadi 4 group berbeda, 
 * tujuannya mau mirip hasil dari union all diatas
 * 
 * kita praktekin aja langsung
 */

select 
	brand, segment, sum(quantity)
from
	sales s 
group by
	grouping sets (
	(brand, segment),
	(brand),
	(segment),
	()
);

-- query di atas lebih pendek dan hasilnya juga terbilang bagus 
-- tanpa harus di scan berulang kali table salesnya pas make query union all

-- GROUPING FUNCTION
/*kalo tadi diatas kan grouping sets, 
 * kalo ini buat bedain mana brand mana segment, di tandai dengan ekspresi 0 kalo bener
 * kalo 1 bukan bagian dari suatu kolom
 * langsung contoh aja deh
 */ 

select 
	grouping (brand) kelompok_brand, -- ini as nama lain ya, kalo 0 berarti bener masuk kolom brand
	grouping (segment) kelompok_segment,
	brand,
	segment,
	sum(quantity)
from 
	sales s 
group by
	grouping sets (
	(brand),
	(segment),
	()
	)
order by 
	brand,
	segment 
	
/*kalo diatas ga di kasih keterangan kan 
 * yg mana brand yang mana segment
 * nah penambahan query function 'grouping' ini buat bantu detek mana yg brand mana yg segment
 * jadi berbeda dengan python, kalo 0 itu salah dan 1 itu bener
 * di postgreSQL berbeda, justru kalo 0 bener kalo 1 salah
 * 
 * misal di baris pertama, 
 * brand ABC di kolom 'kelompok_brand' nilainya 0, brarti itu bener brand
 * 
 * di baris ketiga dan keempat, 
 * yg 0 di kolom 'kelompok_segment' itu menandakan Basic dan Premium masuk kelompok segment
 * 
 * sedangkan baris ke 5 itu kan 1 1 semua, berarti salah 22nya, bukan brand bukan segment
 * menandakan itu total penjualan secara keseluruhan 
 * 
 * biar ga bingung tambahin query having kaya gini :
 */ 


select 
	grouping (brand) kelompok_brand,
	grouping (segment) kelompok_segment,
	brand,
	segment,
	sum(quantity)
from 
	sales s 
group by
	grouping sets (
	(brand),
	(segment),
	()
	)
having grouping (brand) = 0 -- disini bedanya, tinggal ganti 1 kalo mau liat yg segment
order by 
	brand,
	segment 
	
	
-- coba2 test
select c.country_id, c.country, count(c2.city_id) as total_kota
from country c inner join city c2 using (country_id)
group by c.country_id 
order by total_kota desc