/* kali ini kita bakal belajar beberapa teknik untuk export data dari postgreSQL 
dalam bentuk csv

kita make data di table persons tadi
kita cek dulu data dalam table nya : */

select * from persons p 

-- EXPORT DATA FROM TABLE TO CSV USING COPY STATEMENT
/* sebagai contoh, kalo mau export data table 'persons'
ke csv file (nama_file.csv) ke folder misal C:\temp, bisa make statement kaya gini :
langsung praktek ae dah */

copy persons to 'C:\Users\admin\Documents\Latihan PostgreSQL\9 import or export\export\data_komplit_db.csv' delimiter ',' csv header 
-- person nama tablenya
-- to 'folder yang pengen dituju
-- delimeter itu pemisah tiap kolom atau data ','
-- csv header maksudnya header dimasukin ke csv juga

/* ada kalanya kita ga pengen save semua kolom, cuman beberapa aja
ini ada caranya gimana biar ga save semua kolom */
copy persons (first_name, last_name, email)
to 'C:\Users\admin\Documents\Latihan PostgreSQL\9 import or export\export\wo id.csv' delimiter ',' csv header 

-- permisalan lagi, kalo cuman mau ambil data emailnya doang,
-- ya cukup kaya diatas, tapi yg di dalem kurung email aja
copy persons (email)
to 'C:\Users\admin\Documents\Latihan PostgreSQL\9 import or export\export\just email.csv' delimiter ',' csv header 
-- berhasil wkwk

-- nah kalo mau export data tanpa header, tapi langsung ke data dengan pemisah koma
copy persons to 'C:\Users\admin\Documents\Latihan PostgreSQL\9 import or export\export\wo header.csv' delimiter ',' csv 
-- kalo yg lain kan csv header diakhir, ini ga make header ya cukup hapus aja header dari syntax



--------------------------------------------------------------------------------------------
-- kalo mau export tapi lewat psql
-- \copy (SELECT * FROM persons) to 'C:\Users\admin\Documents\Latihan PostgreSQL\9 import or export\export\wo header.csv' with csv
-- dikomen soalnya ga jalan kalo di sql, kecuali di psql
-- ga bisa njer
-- dah lah skip