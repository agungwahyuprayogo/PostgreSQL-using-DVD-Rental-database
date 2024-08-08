/* dalam tutorial kali ini kita akan belajar menggunakan serial tipe pseudo, dan cara menggunakan untuk 
menentukan data kolom bertambah otomatis

didalam PostgreSQL, sequence merupakan jenis objek khusus yang menghasilkan serangkaian bilangan bulat. 
squence sering digunakan dalam primary key dalam table

ketika membuat table baru, squence dapat dibuat dengan SERIAL pseudo-type seperti berikut :

CREATE TABLE table_name(
	id SERIAL
)

dengan menetapkan SERIAL ke kolom 'id', PostgreSQL melakukan hal berikut :
- Pertama, buat objek urutan dan tetapkan nilai berikutnya yang dihasilkan oleh urutan sebagai nilai 
	default untuk kolom.
- Kedua, tambahkan batasan NOT NULL pada kolom id karena urutan selalu menghasilkan bilangan bulat, 
	yang merupakan nilai non-null.
- Ketiga, tetapkan pemilik urutan pada kolom id; sebagai hasilnya, objek urutan akan dihapus ketika kolom 
	id atau tabel dihapus.

query create table diatas sama dengan query berikut :
----------------------------------------------------------------------
CREATE SEQUENCE table_name_id_seq;

CREATE TABLE table_name (
    id integer NOT NULL DEFAULT nextval('table_name_id_seq')
);

ALTER SEQUENCE table_name_id_seq
OWNED BY table_name.id;
----------------------------------------------------------------------

PostgreSQL menyediakan 3 jenis tipe serial :
_________________________________________________________________
Nama		|	Storage File	|	range
_________________________________________________________________
SMALLSERIAL	| 	  2 bytes		|1 - 32.767
SERIAL		| 	  4 bytes		|1 - 2,147,483,647
BIGSERIAL	| 	  8 types		|1 - 9,223,372,036,854,775,807
_________________________________________________________________

___________________________________________________________________________________________________________

1.) Basic serial 

penting untuk dicatat bahwa serial tidak secara otomatis membuat kolom menjadi primary key. 
tapi harus menambahkan query 'primary key' di dalam kolom tersebut */

CREATE TABLE fruits(
   id SERIAL PRIMARY KEY,
   name VARCHAR NOT NULL
);

/* buat masukin data ke kolom yang ada tipe data serial, bisa di skip aja nama kolom tersebut dan langsung
masukin nama kolom berikutnya */

insert into fruits (name)
values ('mango')

-- atau cara lain bisa menggunakan default 

insert into fruits (id, name)
values (default, 'apple') -- kalo ada tipe kolom serial, bisa isi default aja supaya otomatis

select * from fruits f 
-- terbukti kita ga masukin angka sama sekali tapi di kolom id, ada 1 dan 2

-------------------------------------------------------------------------------------------------------
/*
2.) Melihat Urutan Terakhir Serial

kamu bisa liat urutan terakhir dalam table yang kolomnya tipe data serial, basic query-nya seperti ini :
pg_get_serial_sequence('table_name','column_name') 

Tentu, berikut terjemahannya:

"Anda dapat memberikan angka urutan ke fungsi currval() untuk mendapatkan nilai terbaru yang dihasilkan 
oleh urutan tersebut. Sebagai contoh, pernyataan berikut mengembalikan nilai terbaru yang dihasilkan oleh 
objek fruits_id_seq:"
**/

SELECT currval(pg_get_serial_sequence('fruits', 'id'));

/* ----------------------------------------------------------------------------------------------------
3.) Melihat Hasil Urutan Ketika Memasukan data

kalo di serial tetiba aja kan tau2 udah nomer berapa, nah kalo pengen liat yang kita masukin urutan ke 
berapa, kita bisa make returning (nama kolom) */

insert into fruits (name)
values ('Banana')
returning id
-- belum sempet kedip dah langsung nampilin, kalo Banana masuk ke urutan ke 3

/* -------------------------------------------------------------------------------------------------------

4.) Menambahkan Kolom Tipe Data Serial 
kalo ada table yang belum ada serial dan pengen di jadiin primary key, bisa
kita buat table demoaddserial */

CREATE TABLE demoaddserial(
    name VARCHAR(255) NOT NULL
);

-- lalu kita bisa menambahkan kolom baru dengan tipe data serial, dan sekaligus menjadikannya primary key
alter table demoaddserial 
add column id serial primary key

-- bisa refresh dan klik 2x tablenya, ke tampilan ERD
-- nambah kolom id dan tipe data serial, serta primary key
