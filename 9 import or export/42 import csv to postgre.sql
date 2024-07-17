/* kali ini kita bakal belajar mengenai import data melalui csv

pertama kita buat table nya terlebih dahulu */

CREATE TABLE persons (
  id SERIAL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  dob DATE,
  email VARCHAR(255),
  PRIMARY KEY (id)
);

/* udah dibuatin juga di path : C:\Users\admin\Documents\Latihan PostgreSQL\9 import or export
dengan isi seperti ini :

First Name,Last Name,Date Of Birth,Email
John,Doe,1995-01-05,john.doe@postgresqltutorial.com
Jane,Doe,1995-02-05,jane.doe@postgresqltutorial.com

sekarang kita jalanin syntax nya buat ngambil data */


-- kalo error, tonton ini dulu https://www.youtube.com/watch?v=YBzIpirIOY4&ab_channel=HarshMehta
-- buat ngasih akses folder to everyone
COPY persons(first_name, last_name, dob, email)
FROM 'C:\Users\admin\Documents\Latihan PostgreSQL\9 import or export\persons.csv'
DELIMITER ','
CSV HEADER;

-- berhasil, maka dari itu kita cek
select * from persons p 

-- nah buat ngetes lagi make cara lain, kita format dulu
TRUNCATE TABLE persons 
RESTART IDENTITY;

-- bisa juga make ini, tapi skip dulu aja
--COPY persons, -- kalo disini error karena kolom id di skip
--FROM 'C:\Users\admin\Documents\Latihan PostgreSQL\9 import or export\persons.csv' 
--DELIMITER ',' 
--CSV HEADER;

TRUNCATE TABLE persons 
RESTART IDENTITY;

-- bisa juga lewat pgadmin nya langsung, liat di tutorial ini :
-- https://www.postgresqltutorial.com/postgresql-tutorial/import-csv-file-into-posgresql-table/

-- karena di pgAdmin berhasil, ini mau ngetes dah masuk pa belum
select * from persons p 
-- anjay bisa