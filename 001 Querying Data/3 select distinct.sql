/* kali ini kita belajar distinc
 * jadi distinc ini fungsinya buat nampilin data yang ga duplicate
 * 
 * jadi, misal di table yang sama ada data agung wahyu dan agung prasojo
 * lalu pengen nampilin first_name, harusnya kan tampil 2 kan
 * tapi karena distinct jadi cuman nampilin satu aja
 * karena agung mau ada 10 juga di table itu bakal di tampilin 1 kalo make distinc
 * 
 * kecuali kalo nampilin first_name dan last_name
 * baru bisa nampilin 22nya
 * 
 * select distinct 
 * 		column 1, column 2
 * from
 * 		table name
 * 
 * 
 * supaya perbedaan keliatan jelas, kita buat table baru 
 * sekalian latihan buat table
 */*/
 
create table distinct_demo (id serial not null primary key, bcolor varchar, fcolor varchar);
 
insert into distinct_demo (bcolor, fcolor)
values 
('red', 'red'),
('red', 'red'),
('red', NULL),
('red', 'green'),
('red', 'blue'),
('green', 'red'),
('green', 'blue'),
('green', 'green'),
('blue', 'red'),
('blue', 'green'),
('blue', 'blue');

/* sekarang kita tampilkan data di table distinct_demo TIDAK menggunakan distinct
 * harusnya tampil semua
 */*/
 
 select id, bcolor, fcolor from distinct_demo dd 
 
 -- disini keliatan kalo query diatas dijalanin, ada 11 baris ke bawah hasil datanya
 -- sekarang kita nyoba make distinct
 
 select distinct bcolor from distinct_demo dd 
 
 -- ketika distinct dijalankan, hanya ada 3, padahal sebelumnya ada 11 baris
 -- sekarang kita nyoba make 2 kolom berbeda
 
 select distinct bcolor, fcolor from distinct_demo dd 
 
 -- ketika di jalanin, cuman jadi ada 10 baris, padahal kalo ga dimasukin distinct ada 11