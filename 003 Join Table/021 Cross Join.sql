/* CROSS JOIN 
 * 
 * mungkin biar bisa nangkep maksudnya bisa cari tau dulu di google image
 * lalu cari dengan keyword "cross join sql"
 * 
 * jadi intinya cross join itu menggabungkan tiap baris dari tiap kolom
 * 
 * beda sama left join dan right join, cross join ga punya hasil prediksi join
 * lebih ke silang silang gitu
 * 
 * langsung contohnya aje la ya
 */

drop table if exists t1;

create table 
	t1 (lable char(1) primary key);
	
drop table if exists t2;

create table
	t2 (score int primary key);
	
insert into 
	t1 (lable)
values 
	('A'),
	('B');
	
insert into 
	t2 (score)
values 
	(1),
	(2),
	(3);
	
select * from t1 cross join t2

/* di table 1 kan kita masukin A,B
 * di table 2 kita masukin 1,2, dan 3
 * 
 * hasil dari query diatas kan A1, B1, A2, B2, A3, B3
 * gampangnya, yang di table 2 baris paling atas dulu yang disilang (A1, B1)
 * kalo semua baris di table 2 udah semua disilang baru balik lagi ke table satu baris selanjutnya
 */ 
