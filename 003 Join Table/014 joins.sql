/* di tutorial ini kita bakal belajar mengenai join menggunakan 
 * inner join, left join, right join, dan full outer join
 */

create table basket_a (
	a int primary key, 
	fruit_a varchar (100) not null
);

create table basket_b (
	b int primary key, 
	fruit_b varchar (100) not null
);

insert into basket_a (a, fruit_a) 
values 
	(1, 'Apple'),
	(2, 'Orange'),
	(3, 'Banana'),
	(4, 'Cucumber');
	
insert into basket_b (b, fruit_b) 
values 
	(1, 'Orange'),
	(2, 'Apple'),
	(3, 'Watermelon'),
	(4, 'Pear');
	
select * from basket_a ba 

select * from basket_b bb 
-----------------------------------------------------------------------------------------
-- INNER JOIN
/* gampangnya , dari 2 table cuman bakal nampilin data yg sama
 */

select a, fruit_a, b, fruit_b from basket_a inner join basket_b on fruit_a = fruit_b
-- inner join nampilin data yang sama doang
-- dan fruit b ngikut fruit a dari urutan buahnya
-----------------------------------------------------------------------------------------

-- LEFT JOIN
-- gampangnya, SEMUA tabel pertama (fruit a) ditampilin
-- tabel kedua (fruit b) cuman nampilin data yg sama, kalo ga sama jadi null

select a, fruit_a, b, fruit_b from basket_a left join basket_b on fruit_a = fruit_b
-----------------------------------------------------------------------------------------


-- LEFT OUTER JOIN
-- gampangnya kalo data pertama (fruit a) sama kedua (fruit b) ada yg sama, ga di tapilin
-- nampilin data fruit a yg ga ada di fruit b, sisanya null

select a, fruit_a, b, fruit_b from basket_a left join basket_b on fruit_a = fruit_b where b is null
-- make where is null karena emang pengen nampilin frut b yang ga ada di fruit a
----------------------------------------------------------------------------------------


-- RIGHT JOIN
-- gampangnya, semua table di kedua (fruit b) ditampilin
-- table pertama (fruit a) cuman nampilin data yang sama, kalo ga sama jadi null
select a, fruit_a, b, fruit_b from basket_a right join basket_b on fruit_a = fruit_b

---------------------------------------------------------------------------------------

-- RIGHT OUTER JOIN
-- kalo ada data di fruit_a dan fruit_b yang sama, ga ditampilin
-- nampilin data fruit b yg ga ada di juga di fruit a, sisanya null
select a, fruit_a, b, fruit_b from basket_a right join basket_b on fruit_a = fruit_b where a is null
-- dengan catatan kalo kanan, berarti yang fruit a yg di filter


--------------------------------------------------------------------------------------
-- FULL OUTER JOIN
-- kalo ada yang sama, di taro paling atas
-- kalo kiri ada, tapi kanan ga ada, jadi null
-- kalo kanan ada, tapi kiri ga ada, jadi null
select a, fruit_a, b, fruit_b from basket_a full outer join basket_b on fruit_a = fruit_b
-- biasanya make full outer join ini kalo pengen liat semua value datanya
