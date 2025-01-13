/* kali ini kita bakal belajar mengenai union untuk mengkombinasikan 2 table dalam satu set query
 * 
 * basiq syntax union seperti ini :
 * 
 * SELECT 
 * 		select_list
 * FROM 
 * 		A
 * UNION
 * SELECT 
 * 		select_list
 * FROM 
 * 		B;
 * 
 * jumlah dan urutan kolom dalam daftar select harus sama 
 * tipe data harus yang kompatibel (bisa di otak atik komputer)
 * 
 * operator onion hapus duplikat data dari dua table gabungan.
 * kalo mau ga ilangin duplikat, bisa make union all
 * mirip mirip sama union, cuman tambahin all di syntax nya
 * 
 * SELECT 
 * 		select_list
 * FROM 
 * 		A
 * UNION ALL
 * SELECT 
 * 		select_list
 * FROM 
 * 		B; 
 */

create table top_rated_films(
	title varchar not null,
	release_year smallint
);

create table most_popular_films(
	title varchar not null,
	release_year smallint
);

insert into top_rated_films(title, release_year)
values 
	('The Shawshank Redemption', 1994),
	('The Godfather', 1972),
	('The Dark Knight', 2008),
	('12 Angry Men', 1957);
	
insert into most_popular_films (title, release_year)
values 
	('An America Pickle', 2020),
	('The Godfather', 1972),
	('The Dark Knight', 2008),
	('Greyhound', 2020);

select * from most_popular_films mpf 

select * from top_rated_films trf 

-- contoh dasar union 
select * from most_popular_films mpf 
union 
select * from top_rated_films trf 
-- harusnya kan ada 8, kenapa cuman ada 6? 
-- karena kalo ada yg sama dari judul dan tahunya, maka duplicate
-- nah kalo make union yg duplicate tuh di ilangin

-- kalo pengen keluar semuanya
select * from most_popular_films mpf 
union all
select * from top_rated_films trf 
-- tampil semua kan
-- tapi ada kekurangan, yaitu ga urut
-- makanya kita bisa make order by

-- order by taro di paling bawah
select * from most_popular_films mpf 
union all
select * from top_rated_films trf 
order by title 
-- kali ini kita bisa bandingin duat table buat liat datanya sama pa ga