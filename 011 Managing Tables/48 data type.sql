/* ditutorial kali ini kita akan belajar mengenai Tipe data dalam PostgreSQL yang meliputi 
boolean, character, numeric, temporal, array, json, UUID, dan tipe spesial

Ringkasan dari Tipe Data di PostgreSQL 
- Boolean
- Character yang meliputi 'char', 'varchar', dan 'text'
- Numeric yang meliputi 'interger' dan bilangan koma (float)
- Tipe data temporal seperti 'date', 'time', 'timestamp' dan 'interval'
- UUID untuk Universally Unique Identifiers
- array untuk mengurutkan array kalimat, angka, dsb
- JSON
- hstore
- Spesial Tipe data seperti alamat jaringan dan data geometri

--------------------------------------------------------------------------------------------
BOOLEAN

Tipe data boolan dapat menggunakan 3 kemungkinan value seperti 'true', 'false' dan 'null'. kamu
bisa menggunakan 'boolean' atau 'bool' untuk mendeklarasikan kolom dengan tipe data boolean

ketika kamu mengimput data ke dalam kolom boolean, postgreSQL akan meng-convert itu menjadi 
value boolean seperti :
- 1, yes, y, t, true ter-convert menjadi true dalam boolean di PostgreSQL
- 0, no, false, f ter-convert menjadi false dalam boolean di PostgreSQL

ketika kamu 'select' data dari kolom boolean, PostgreSQL akan mengeluarkan value kembali seperti :
- t untuk true, f untuk false (di pgAdmin)
- [v] untuk true, [ ] untuk false (di dbeaver)

--------------------------------------------------------------------------------------------
CHARACTER 

PostgreSQL menyediakan 3 tipe data charakter kaya : CHAR(n), VARCHAR(n), dan TEXT

- CHAR(n) adalah karakter dengan panjang pasti. Jika anda memasukan karakter kurang dari lebih 
				pendek dari panjang kolom, maka karakternya akan berubah menjadi spasi. Namun, 
				jika kita memasukan karakter lebih panjang dari pada panjang kolom, akan error.
- VARCHAR(n) adalah string karakter dengan panjang maksimal sebanyak n. jika kita memasukan 
				karakter kurang dari n, maka tidak akan menambah spasi.
- text, secara teori, text memiliki panjang tak terbatas, hanya saja tak bisa di run.
				hanya dapat dilihat

--------------------------------------------------------------------------------------------

NUMERIC

PostgreSQL menyediakan 2 jenis tipe data yang berbeda dari angka :
- Interger
- Floating-point Numbers

Interger
terdapat 3 jenis interger dalam PostgreSQL
- Small Interger (smallint), adalah 2 byte interger yang memiliki range dari -32.768 hingga 32.767
- Interger (int), adalah 4 byte interger yang memiliki jangkauan dari -2,147,483,648 hingga 2,147,483,647.
- Serial, mirip interger tapi dia otomatis menghasilkan dan mengisi value berdasarkan kolom serial. 
	mirip auto_increment di mySQL atau autoincrement di SQLite

Floating-Point
terdapat 3 jenis floating point dalam postgreSQL
- float(n)  adalah bilangan floating-point yang presisinya paling sedikit, n, 
	hingga maksimum 8 byte.
- realatau float8merupakan angka floating-point 4-byte.
- numeric atau numeric(p,s) merupakan bilangan riil dengan p digit dan s angka setelah titik 
desimal. Ini numeric(p,s)adalah bilangan eksak.

----------------------------------------------------------------------------------------------

Tipe data Temporal

Tipe data temporal memungkinkan Anda menyimpan data tanggal dan/atau waktu. 
PostgreSQL memiliki lima tipe data temporal utama:

- DATE hanya menyimpan tanggal saja.
- TIME menyimpan nilai waktu dalam sehari.
- TIMESTAMP menyimpan nilai tanggal dan waktu.
- TIMESTAMPTZ adalah tipe data cap waktu yang berdasarkan zona waktu. 
	Ini adalah singkatan dari timestamp with the time zone.
- INTERVAL menyimpan periode.

---------------------------------------------------------------------------------------------

Arrays

di PostgreSQL, kamu bisa menyimpan serangkaian array seperti : array kalimat, array interger, dan
masih banyak lagi di kolom array. Array berguna dalam beberapa situasi seperti menyimpan hari hari
dalam seminggu dan bulan - bulan dalam setahun

---------------------------------------------------------------------------------------------
dah sisanya ga penting njer 

dah lah lanjut 

JSON
PostgreSQL menyediakan dua tipe data JSON: JSONdan JSONBuntuk menyimpan data JSON.

Tipe data ini JSON menyimpan data JSON biasa yang memerlukan penguraian ulang untuk setiap 
pemrosesan, sedangkan JSONBtipe data menyimpan JSONdata dalam format biner yang lebih cepat 
diproses tetapi lebih lambat untuk disisipkan. Selain itu, JSONB mendukung pengindeksan, 
yang dapat menjadi keuntungan.

UUID
Tipe data ini UUIDmemungkinkan Anda menyimpan Universal Unique Identifier yang ditetapkan oleh 
RFC 4122. Nilai-nilai  tersebut UUID menjamin keunikan yang lebih baik daripada SERIAL dan dapat 
digunakan untuk menyembunyikan data sensitif yang terekspos ke publik seperti nilai-nilai id di URL.

Tipe data khusus
Selain tipe data primitif, PostgreSQL juga menyediakan beberapa tipe data khusus yang terkait 
dengan geometri dan jaringan.

box– kotak persegi panjang.
line – satu set poin.
point– sepasang angka geometris.
lseg– ruas garis.
polygon– geometri tertutup.
inet– alamat IP4.
macaddr– alamat MAC. 