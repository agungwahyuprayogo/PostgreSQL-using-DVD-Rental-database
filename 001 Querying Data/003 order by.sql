-- biasanya, ketika kita menampilkan data dengan 'select', urutan data yang dikeluarkan tampil secara acak, 
-- nah kita bisa mengurutkan datanya menggunakan klausa 'order by'

---------------------------------------------------------------------------------------

-- 1. Menggunakan 'order by' pada 1 kolom
-- menggunakan klausa 'asc' untuk kolom first name urutan naik (A-Z)
select 
	first_name "nama depan",
	last_name "nama belakang"
from 
	customer
order by 
	first_name asc -- dengan asc
-- nama depan / first name menggunakan urutan A -> Z
-- namun tanpa kita tulis 'asc', secara default SQL sudah mengurutkan dengan asc
	
select 
	first_name "nama depan",
	last_name "nama belakang"
from 
	customer
order by 
	first_name -- tanpa asc
	
	
---------------------------------------------------------------------------------------
	
-- 2. menggunakan 'order by' dari huruf belakang (Z -> A) menggunakan 'desc'
	
select 
	first_name, 
	last_name 
from 
	customer
order by
	first_name desc -- first name dari urutan Z - A
	
select 
	first_name, 
	last_name 
from 
	customer
order by
	last_name desc -- last name dari urutan Z - A
	

---------------------------------------------------------------------------------------
	
-- 3. menggunakan klausah 'order by' pada beberapa kolom (lebih dari satu kolom)
	
select 
	first_name "nama depan",
	last_name "nama belakang"
from 
	customer
order by 
	first_name asc, -- jangan lupa gunakan tanda koma ( , )
	last_name desc
-- untuk melihat perbedaan first_name asc dengan last_name desc, coba lihat urutan 259
-- Jamie di dahului oleh Jamie Waugh, baru setelah itu Jamie Rice
-- W abjad urutan ke 23 , sedangkan R abjad urutan 18
	
---------------------------------------------------------------------------------------
	
-- 4. Menggunakan 'order by' untuk mengurutkan baris berdasarkan ekspresi
select 
	first_name, 
	length(first_name) jumlah_huruf
from 
	customer

SELECT 
    first_name
FROM 
    customer
ORDER BY 
    RIGHT(first_name, 1) ASC; -- Mengambil 1 huruf dari kanan
    	
---------------------------------------------------------------------------------------

-- 5. Order by dan Null
    
/* Dalam dunia database, NULL adalah penanda yang menunjukkan data yang hilang atau data yang tidak diketahui pada saat pencatatan.

Ketika Anda mengurutkan baris yang mengandung NULL, Anda bisa menentukan urutan NULL dengan nilai lain yang tidak null 
menggunakan opsi NULLS FIRST atau NULLS LAST dalam klausa ORDER BY: */
    
-- kita buat table baru untuk demonstrasi
-- membuat tabel baru
CREATE TABLE sort_demo(num INT);

-- memasukkan beberapa data
INSERT INTO sort_demo(num)
VALUES
  (1),
  (2),
  (3),
  (null);

-- uji mengembalikan data dari table `sort_demo`
select 
	num 
from 
	sort_demo 
	
-- menggunakan `nulls last` sebagai ganti `asc` untuk menempatkan null di akhir 
select 
	num 
from 
	sort_demo 
order by 
	num nulls last -- `nulls` menggunakan `s`
	
-- menempatkan null diatas, maka gunakan `nulls first
select 
	num 
from 
	sort_demo 
order by 
	num nulls first

-- jika kita menggunakan `desc`, maka urutan data dari yang terbesar - terkecil, 
-- lalu baru null di akhir data / baris yang di tampilkan
select 
	num 
from 
	sort_demo sd 
order by 
	num desc
	
-- namun.. kalo ingin mengurutkan null diakhir setelah mengurutkan data angka dari terbesar - terkecil
-- kita bisa menambahkan `nulls last`
select 
	num 
from 
	sort_demo sd 
order by 
	num desc nulls last
	
	
-- Ringkasan -- 
-- Gunakan klausa ORDER BY dalam pernyataan SELECT untuk mengurutkan baris dalam kumpulan kueri.
-- Gunakan opsi ASC untuk mengurutkan baris dalam urutan naik dan opsi DESC untuk mengurutkan baris dalam urutan turun.
-- Klausa ORDER BY menggunakan opsi ASC secara default.
-- Gunakan opsi NULLS FIRST dan NULLS LAST untuk secara eksplisit menentukan urutan NULL dengan nilai lain yang tidak null.
	
