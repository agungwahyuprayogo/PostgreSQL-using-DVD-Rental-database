/* Di tutorial kali ini, kita bakal belajar bagaimana cara membuat table menggunakan
'crate table'

biasanya, relasi database terdiri atas beberapa table yang saling berkait. table yang memungkinkan
anda untuk menyimpan data terstruktur seperti pelanggan, produk, dan karyawan.

untuk membuat table baru, anda dapat menggunakan syntax dasar berikut :

create table [IF NOT EXISTS] nama_table (
	kolom1 tipe_data(length) batasan_kolom,
	kolom2 tipe_data(length) batasan_kolom,
	...
	kolom5 tipe_data(length) batasan_kolom
)

Dalam sintaksis ini:

Pertama, tentukan nama tabel yang ingin Anda buat setelah CREATE TABLEkata kunci. 
Nama tabel harus unik dalam skema . Jika Anda membuat tabel dengan nama yang sudah ada, 
Anda akan mendapatkan kesalahan.

Kedua, gunakan opsi IF NOT EXISTS untuk membuat tabel baru hanya jika tabel tersebut belum ada. 
Jika Anda menggunakan opsi IF NOT EXISTS tersebut dan tabel tersebut sudah ada, 
PostgreSQL akan mengeluarkan pemberitahuan, bukan kesalahan.

Batasan kolom menentukan aturan yang diterapkan pada data dalam kolom untuk memastikan 
integritas data. Batasan kolom meliputi kunci utama primary key, foreign key, not null, 
unique, check, and default.

PostgreSQL menyediakan batasan atau constraighn seperti berikut 
NOT NULL  – memastikan bahwa nilai dalam kolom tidak dapat NULL.
UNIQUE – memastikan nilai dalam kolom bersifat unik di seluruh baris dalam tabel yang sama.
PRIMARY KEY – kolom kunci utama mengidentifikasi baris-baris dalam tabel secara unik. 
			Sebuah tabel dapat memiliki satu dan hanya satu kunci utama. 
			Batasan kunci utama memungkinkan Anda untuk menentukan kunci utama suatu tabel.
CHECK – memastikan data harus memenuhi ekspresi boolean. Misalnya, nilai pada kolom harga 
			harus nol atau positif.
FOREIGN KEY – memastikan bahwa nilai dalam kolom atau sekelompok kolom dari suatu tabel ada 
			dalam kolom atau sekelompok kolom di tabel lain. Tidak seperti kunci utama, suatu 
			tabel dapat memiliki banyak kunci asing.

batas tiap kolom bisa berbeda beda dalam satu table, misal :
* user_id – primary key
* username – unique and not null
* password – not null
* email – unique and not null
* created_at – not null
* last_login – null

sebagai contoh bisa buat table kaya gini : */

CREATE TABLE accounts (
  user_id SERIAL PRIMARY KEY, 
  username VARCHAR (50) UNIQUE NOT NULL, 
  password VARCHAR (50) NOT NULL, 
  email VARCHAR (255) UNIQUE NOT NULL, 
  created_at TIMESTAMP NOT NULL, 
  last_login TIMESTAMP
);
-- ga dijalanin ^
--------------------------------------------------------------------------------------------

/* dibawah ini cuman jelasin, bagaimana cara jalanin create table di psql dan pgadmin


ntah lah skip dulu cuy sementara

beda soalnya yang ditampilin tutorial sama psql jalanin langsung