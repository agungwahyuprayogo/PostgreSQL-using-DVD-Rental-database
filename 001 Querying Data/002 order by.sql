/* biasanya setelah kita menggunakan query 'select',
 * hasil yang di tampilkan acak dan 
 * data tanpil apa adanya dari database ketika dibuat
 * 
 * tapi kita bisa membuatnya menjadi terurut, menggunakan 'order by'
 * 
 * SELECT nama_kolom FROM nama_table ORDER BY nama_kolom asc | desc
 * 
 * untuk tampil dari abjad, terkecil bisa make 
 * tapi kalo gamau susah ngurutinnya make berdasarkan nama kolom gpp
 * 
 * kalo mau dari abjad paling akhir atau dari angka terbesar bisa make desc
 */

select first_name from customer order by first_name 

/* dalam default, kalo ga dimasukin asc atau desc kaya diatas, default asc
 * jadi kalo misalkan query diatas di tambahin asc di belakang, sama aja hasilnya
 */*/
 
select first_name from customer order by first_name asc

/* maka hasil query diatas bakal sama aja
 * sekarang kita nyoba desc, urutin dari abjad terakhir atau dari angka terbesar
 * */

select first_name from customer order by first_name desc

/* bisa ga gunain asc dan desc berbarengan? 
 * bisa dong. 
 * */

select first_name , last_name from customer c order by first_name asc, last_name desc

/* mungkin hasilnya sekilas ga keliatan, 
 * tapi kalo dilihat dari data ke 327 sama 328 keliatan
 * disitu sama sama kelly, tapi last name desc keliatan bedanya yg tampil torres dulu
 * baru knott
 * */

select first_name ||' '|| last_name as nama_lengkap, length(first_name ||''|| last_name) as len from customer c order by len asc

/* dengan cara diatas, kita bisa menampilkan len 
 * atau menghitung berapa banyak karakter dalam suatu nama
 * 
 * karena data bawaan terlalu banyak , kali ini kita akan membuat data baru
 * agar bisa melihat perbedaan dalam query order by
 */*/
 
 -- create new table
 create table sort_demo(num int)
 
 -- insert some data
 insert into sort_demo(num)
 values
 (1),
 (2),
 (3),
 (null);
 
-- show sort by 
select num from sort_demo sd order by num asc

-- kalo make asc, terurut dari yang terkecil dahulu sampe ke terbesar
-- baru ke NULL

select num from sort_demo sd order by num desc

-- dari yang terbesar dulu baru ke terkecil
-- tapi disini NULL ntah kenapa masuk yang ke terbesar

select num from sort_demo sd order by num nulls first 

-- ketika jalanin ini, bakal naro NULL paling atas, 
-- tapi angka tetep ngurut dari kecil ke terbesar

select num from sort_demo sd order by num nulls last 

-- disini NULL ada di paling atas, tapi angka tetep urut dari kecil > besar
