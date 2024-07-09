/* UPSERT, merupakan singkatan dari UPdate dan inSERT
 * operasi yang memungkinkan kita menyisipkan baris data baru pada table
 * kalo belum data barisnya nambah, 
 * kalo udah ada, prosesnya di lewatin alias di diemin aja
 * 
 * sebenernya di PostgreSQL ga ada query UPSERT, 
 * tapi dalam kasus ini kita bisa make ON CONFLICT
 * jadi idenya kalo ada pop-up error, kita bisa gunakan sebagai alternatif
 * 
 * secara basic syntax seperti ini : 

INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...)
ON CONFLICT (conflict_column)
DO NOTHING | DO UPDATE SET column1 = value1, column2 = value2, ...;

penjelasannya :
* 	DO NOTHING: 
	Ini menginstruksikan PostgreSQL untuk tidak melakukan apa pun saat konflik terjadi.
*	DO UPDATE: 
	Ini melakukan pembaruan jika terjadi konflik.
* 	SET column = value1, column = value2, ...: 
 	Daftar kolom yang akan diperbarui dan nilainya yang sesuai jika terjadi konflik.
 	
langsung praktek aja dari pada kebanyakan teori
*/

CREATE TABLE karyawan_upsert(
    emp_id 	INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1),
    birthdate DATE,
    email VARCHAR(100) UNIQUE,
    salary INT
);

-- sekarang kita coba input satu dulu data baru
INSERT INTO karyawan_upsert -- ga harus nulis tiap kolom ternyata selama jumlah values nya sama kaya kolom
VALUES(1,'Annie','Smith','F', DATE '1988-01-09', 'ani@email.com', 5000);

-- trus coba lagi make syntax query yang sama
INSERT INTO karyawan_upsert 
VALUES(1,'Annie','Smith','F', DATE '1988-01-09', 'ani@email.com',5000);
/* muncul pop-up
ERROR: duplicate key value violates unique constraint "karyawan_upsert_pkey"
Key (emp_id)=(1) already exists.

intinya primary key udah ada, ga bisa ada data baru yang sama sama satu emp_id nya
 */

-- nah cara ngatasinya, kalo sama tambahin on conflict do nothing
INSERT INTO karyawan_upsert 
VALUES(1,'Annie','Smith','F', DATE '1988-01-09', 'ani@email.com',5000)
ON CONFLICT DO NOTHING;
-- ada tulisan updated rows 0, yang menandakan ga ada yg baru, tapi sukses

-- sama aja make ini sebenernya
INSERT INTO karyawan_upsert 
VALUES(1,'Annie','Smith','F', DATE '1988-01-09', 'ani@email.com',5000)
ON CONFLICT(emp_id) DO NOTHING; -- kalo ada conflict di kolom (emp_id)

-- atau yang ini 
INSERT INTO karyawan_upsert 
VALUES(1,'Annie','Smith','F', DATE '1988-01-09', 'ani@email.com',5000)
ON CONFLICT ON CONSTRAINT karyawan_upsert_pkey DO NOTHING; -- on constraint, pada kendala artinya, nama table primary key (pkey)

------------------------------------------------------------------------------------------
-- sebenernya bisa sih make update
-- tapi kan ga ada yang tau nih, misalkan kita ragu dah nambahin apa belum
-- make cara ini buat jaga2 kalo ragu udah apa belum, kalo belum nambah
-- kalo udah keubah
INSERT INTO karyawan_upsert 
VALUES(1,'Annie','Rizzolo','F', DATE '1988-01-09', 'ani@email.com',5000)
ON CONFLICT(emp_id) DO UPDATE SET last_name = 'Rizzolo';
-- update rows jadi 1, yang menandakan ada yg berubah

select * from karyawan_upsert ku 
-- last name jadi Rizzolo

-- mirip2 sebenernya hasil akhirnya kaya diatas, 
-- cuman bedanya yg ini ada exclude, tapi hasilnya sama kok
INSERT INTO karyawan_upsert 
VALUES(1,'Annie','Rizzolo','F', DATE '1988-01-09', 'ani@email.com',5000)
ON CONFLICT(emp_id) DO UPDATE SET last_name = EXCLUDED.last_name;

-- ON CONFLICT WHERE 
-- update tapi make query where
INSERT INTO karyawan_upsert 
VALUES(1,'Annie','Rizzolo','F', DATE '1988-01-09', 'ani@email.com',5000)
ON CONFLICT(emp_id) where salary > 0 -- harusnya kan conflict nih
DO UPDATE SET salary = 0; -- nah cara biar ga error conflict make do update ini 

select * from karyawan_upsert ku 

-- sekarang nyoba sekali dua kali
INSERT INTO karyawan_upsert 
VALUES(2,'Agung','Wahyu Prayogo','M', DATE '2000-05-12', 'agungwhypryg@email.com',5000)
ON CONFLICT ON CONSTRAINT karyawan_upsert_pkey DO NOTHING;
-- coba cek select * lagi lalu jalankan insert agung lagi, lalu cek * lagi
-- ternyata beneran berhasil, kalo dah ada diem aja ga nambah
-- kalo belum ada nambah