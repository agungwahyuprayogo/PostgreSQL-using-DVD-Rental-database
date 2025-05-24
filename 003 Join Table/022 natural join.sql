/* jadi natural join ini biasa di pake buat gabungin table yang nama table nya sama
 * sebenernya sih mirip2 make left / inner / right join
 * bedanya cuman kalo make natural join ga perlu nulis banyak banyak gitu
 * 
 * secara basic query nya kaya gini :
 * 
 * SELECT 
 * 		select list
 * FROM
 * 		table1
 * NATURAL [INNER, LEFT, RIGHT] JOIN table2
 * 
 * di query atas, 
 * pertama spesifikasikan dulu kolom mana aja yang perlu di liatin
 * tentukan table utama sebagai acuan
 * lalu table yang mau di gabungin ke table 2
 * 
 * natural join bisa ada inner, left join, dan right join. 
 * tapi kalo ga ditentuin, masuknya ke 'inner join' secara default
 * 
 * intinya Natural join ini bikin query jadi lebih singkat
 * 
 * misal buat inner join kan gini biasanya :
 * SELECT nama2kolom
 * FROM table1
 * INNER JOIN table2 on table2.nama_kolom on table1.nama_kolom
 * 
 * INNER JOIN table2 using(nama_kolom)
 * 
 * kalo di natural jadinya kaya gini :
 * SELECT nama2kolom
 * FROM table1
 * natural inner join table2
 * 
 * langsung coba aja lah ya gausah kebanyakan teori
 */

-- kita buat table categories
-- dimana category id nya otomatis ngisi angka
create table categories (
	category_id serial primary key,
	category_name varchar(255) not null
);

-- terus buat table product
-- dimana product id nya juga otomatis
-- tapi mau sambungin 
create table products (
	product_id serial primary key,
	product_name varchar(255) not null,
	category_id int not null,
	foreign key (category_id) references categories (category_id)
);

-- drop table products 

insert into categories (category_name)
values
	('Smartphone'),
	('Laptop'),
	('Tablet'),
	('VR')
returning *;

insert into products (product_name, category_id)
values 
	('iPhone', 1),
	('Samsung S24', 1),
	('Lenovo Legion', 2),
	('Dell Alien Ware', 2),
	('iPad', 3),
	('Kindle Fire', '3')
returning *;

-- drop table products

-- drop table categories

-- BELAJAR BASIC NATURAL JOIN
select 
	* 
from 
	products p 
natural join categories c -- (default inner join) make using
-- iya kan, ga perlu nulis panjang panjang

-- kalo yang lama kan gini nih
select 
	* 
from 
	products p 
inner join 
	categories c on c.category_id = p.category_id 
-- bedanya kalo yang natural, category_id nya ga muncul 2x, yg ini 2x

-- NATURAL JOIN to perform LEFT JOIN
select 
	* 
from 
	categories c 
natural left join 
	products p 

-- coba make sample datavase DVDRental
-- CONTOH NATURAL JOIN HASILNYA KOSONG
select 
	* 
from 
	city c 
natural join 
	country c2
-- kenapa hasilnya kosong? karena ada kolom last_update, last_update ga cocok buat kolom yang lain
