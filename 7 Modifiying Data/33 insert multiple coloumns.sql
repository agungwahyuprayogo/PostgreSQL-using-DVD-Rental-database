/* statement Insert di PostgreSQL berguna untuk menambahkan baris baru dalam table
 
basic syntaxnya adalah sebagai berikut :
INSERT INTO table1(column1, column2, …)
VALUES (value1, value2, …);

pertama, spesifikan nama table (table1) yang ingin dimasukan data setelah 'INSERT INTO'
masukan kolom kolom mana saja dari table yang di tuju (table1) pisahkan dengan koma (column1, column2, …)
masukan value data, pisahkan dengan koma (value1, value2, …) setelah 'VALUES'

kalo pengen liat lansung hasilnya bisa langsung tambahin 'RETURNING' dibawah setelah value

INSERT INTO table1(column1, column2, …)
VALUES (value1, value2, …)
RETURNING *; (maksudnya * all)

bisa juga kalo nampilin sebagai nama lain dengan cara :
RETURNING * as nama_output

buat table baru dengan nama 'links'

 */

CREATE TABLE links (
  id SERIAL PRIMARY KEY, -- serial biar bisa isi otomatis
  url VARCHAR(255) NOT NULL, -- ga boleh kosong
  name VARCHAR(255) NOT NULL, -- ga boleh kosong (not null)
  description VARCHAR (255), -- boleh kosong KARENA GA ADA query not nul
  last_update DATE -- boleh kosong juga
);

-- basic insert 
INSERT INTO links (url, name) -- ngetes, yg di isi yg ga boleh kosong, id otomatis
VALUES('https://www.postgresqltutorial.com','PostgreSQL Tutorial');
-- 

select * from links l 
-- description dan last_update bisa kosong

-- nambahin karakter tanda petik ('), misal nama O'Reilly Media, ketik ''
INSERT INTO links (url, name)
VALUES('http://www.oreilly.com','O''Reilly Media');

-- sekarang masukin tanggal 
INSERT INTO links (url, name, last_update)
VALUES('https://www.google.com','Google','2013-06-01'); -- format tanggal tahun, bulan, tanggal

-- ngetes nampilin table setelah insert tanpa select *
INSERT INTO links (url, name)
VALUES('https://www.postgresql.org','PostgreSQL') 
RETURNING *;
-- nampilin data terakhir yg di input

select * from links l 