# Panduan PostgreSQL Querying Data

## Daftar Isi
- [PostgreSQL SELECT](#postgresql-select)
- [PostgreSQL Column Aliases](#postgresql-column-aliases)
- [PostgreSQL ORDER BY](#postgresql-order-by)
- [PostgreSQL SELECT DISTINCT](#postgresql-select-distinct)

---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------

# PostgreSQL SELECT

Kerjaan yang paling sering kita lakuin pas mainan database itu pasti ngambil data dari tabel. Nah, di PostgreSQL, senjatanya adalah pakai perintah `SELECT`.

Bisa dibilang, perintah `SELECT` ini salah satu yang paling sakti sekaligus kompleks di PostgreSQL. Kenapa? Soalnya dia punya banyak banget klausa tambahan yang bikin kita bisa nge-query data secara fleksibel banget.

**FYI (Query itu apa sih?)** : Query itu gampangnya sekumpulan instruksi atau perintah tertulis yang kita kasih ke database buat ngasih tahu dia harus ngapain sama data kita.

Karena fiturnya banyak banget, kita bakal bagi materi `SELECT` ini jadi beberapa bagian kecil biar belajarnya gak pusing dan lebih cepat nempel.

Nantinya, perintah `SELECT` ini bakal sering ditemenin sama klausa-klausa kayak gini:

- Nyari data yang unik (gak duplikat) pakai `DISTINCT`.
- Ngurutin data pakai `ORDER BY`.
- Nyaring data pakai `WHERE`.
- Ngambil sebagian baris data aja pakai `LIMIT` atau `FETCH`.
- Ngelompokkin data pakai `GROUP BY`.
- Nyaring data yang udah dikelompokkin pakai `HAVING`.
- Menggabungkan tabel satu dengan tabel lainnya pakai keluarga Join (`INNER JOIN`, `LEFT JOIN`, `FULL OUTER JOIN`, `CROSS JOIN`).
- Operasi himpunan data pakai `UNION`, `INTERSECT`, dan `EXCEPT`.

## Aturan Main & Syntax PostgreSQL SELECT

Yuk kita mulai dari yang paling basic dulu: ngambil data dari satu tabel.

Bentuk dasar dari perintah `SELECT` itu kayak gini:

```sql
SELECT
   select_list
FROM
   table_name;
```

- **Bagian Pertama** (`SELECT`) : Tulis nama kolom yang mau kamu ambil datanya. Kalau kolomnya lebih dari satu, pisahin pakai tanda koma (`,`). Tapi, kalau kamu lagi malas ngetik dan pengen ambil semua kolom yang ada di tabel itu, tinggal ganti aja nama kolomnya pakai tanda bintang (`*`). Di bagian ini, kamu juga bisa masukin rumus matematika atau nilai instan (literal).
- **Bagian Kedua** (`FROM`): Tinggal tulis nama tabel tempat data itu disimpan setelah kata kunci `FROM`.

Oiya, klausa `FROM` ini sebenarnya gak wajib-wajib banget kok. Kalau kamu gak lagi ngambil data dari tabel mana pun (misal cuma mau hitung-hitungan atau manggila fungsi waktu), kamu bisa skip klausa `FROM` ini.

**Penting buat diingat** : Di balik layar, PostgreSQL itu bakal ngeproses klausa `FROM` duluan baru habis itu klausa `SELECT`-nya dijalankan. Proses jalannya kayak gini :

![image](https://github.com/user-attachments/assets/35bb63a4-df25-43d1-9a22-cee24e98ed34)

**Catatan tambahan** : SQL itu sifatnya case-insensitive alias gak pilih kasih sama huruf besar/kecil. Jadi tulisan `SELECT`, `select`, atau `Select` itu sama aja di mata Postgres. Tapi, biar kode kita rapi dan gampang dibaca orang lain, ke depannya kita sepakat pakai huruf **BESAR** semua ya buat kata kunci SQL-nya.

## Contoh Praktek PostgreSQL SELECT

Biar gak ngawang-ngawang, yuk kita langsung coba praktek.

Kita bakal pakai tabel `customer` yang ada di dalam database latihan `dvdrental`. Penampakan tabelnya kayak gini nih:

![image](https://github.com/user-attachments/assets/6b8a1c85-235d-4cf3-add5-23d766490c43)

### 1) Ngambil Data dari Satu Kolom Saja

Misalkan kita cuma pengen tahu siapa aja sih nama depan (`first name`) semua pelanggan kita. Query-nya sesimpel ini :

```sql
SELECT first_name FROM customer;
```

Nanti output-nya bakal keluar kayak gini (ini cuma sebagian ya) :


| first_name |
|------------|
| Jared      |
| Mary       |
| Patricia   |
| Linda      |
| Barbara    |

Sadar gak kalau di ujung query tadi ada tanda titik koma (`;`)? Nah, titik koma ini sebenarnya bukan bagian dari aturan sintaks SQL-nya, melainkan tanda buat Postgres kalau perintah kita udah selesai ditulis. Tanda ini juga berguna banget kalau kamu mau ngejalankan beberapa perintah SQL sekaligus dalam satu waktu biar gak dempetan.

### 2) Ngambil Data dari Beberapa Kolom Sekaligus
Kalau mau ngambil nama depan, nama belakang, plus email pelanggan secara bersamaan, tinggal pisahin aja nama kolomnya pakai koma :

```sql
SELECT
   first_name,
   last_name,
   email
FROM
   customer;
```

Sebagian output:

| first_name | last_name  | email                               |
|------------|------------|-------------------------------------|
| Jared      | Ely        | jared.ely@sakilacustomer.org        |
| Mary       | Smith      | mary.smith@sakilacustomer.org       |
| Patricia   | Johnson    | patricia.johnson@sakilacustomer.org |

Sekarang muncul tiga kolom sekaligus sesuai yang kita minta :)

### 3) Ngambil Semua Kolom yang Ada di Tabel

Kalau pengen lihat **semua isi kolom** dari tabel `customer` tanpa terkecuali, langsung hajar pakai tanda bintang (`*`) :

```sql
SELECT * FROM customer;
```

Sebagian output:


| customer_id | store_id | first_name | last_name | email                       | address_id | activebool | create_date | last_update             | active |
|-------------|----------|------------|-----------|-----------------------------|------------|------------|-------------|-------------------------|--------|
| 524         | 1        | Jared      | Ely       | [email protected]           | 530        | t          | 2006-02-14  | 2013-05-26 14:49:45.738 | 1      |
| 1           | 1        | Mary       | Smith     | [email protected]           | 5          | t          | 2006-02-14  | 2013-05-26 14:49:45.738 | 1      |
| 2           | 1        | Patricia   | Johnson   | [email protected]           | 6          | t          | 2006-02-14  | 2013-05-26 14:49:45.738 | 1      |


Pakai `SELECT *` ini emang jalan pintas paling enak karena kodenya jadi super pendek.

TAPI INGAT! Menggunakan tanda bintang (`*`) itu dianggap _bad practice_ kalau kamu udah mulai nulis kode SQL di dalam aplikasi beneran (misal digabung ke program Python, Java, atau PHP). Alasan utamanya karena :

- **Bikin berat database** : Kebayang gak kalau tabelmu punya 100 kolom dan datanya ada jutaan baris? Perintah `SELECT *` bakal narik semuanya, padahal aplikasi kamu mungkin cuma butuh kolom `email`-nya doang. Mubazir banget kan?
- **Aplikasi jadi lemot** : Data melimpah yang gak terlalu penting tadi bakal bikin lalu lintas jaringan antara server database dan server aplikasimu jadi padat. Efeknya? Aplikasi kamu bakal lemot dan gampang _crash_ pas usernya lagi rame.

Jadi, biasakan buat nulis nama kolomnya secara spesifik ya. Selain bikin query efisien, performa aplikasimu juga bakal aman. Tanda bintang (`*`) ini baiknya dipakai pas kita lagi nge-cek atau iseng nyari tahu isi data aja secara langsung (ad-hoc query).

### 4) Menggunakan Perintah SELECT dengan Ekspresi/Manipulasi
Kita juga bisa gabungin data antar kolom langsung lewat query loh. Contohnya, kita pengen ngegabungin nama depan dan nama belakang jadi satu kolom "Full Name" atau "Nama Lengkap" :

```sql
SELECT
   first_name || ' ' || last_name,
   email
FROM
   customer;
```

Output:

| ?column?            | email                     |
|---------------------|---------------------------|
| Jared Ely           | [email protected]         |
| Mary Smith          | [email protected]         |
| Patricia Johnson    | [email protected]         |


Di sini kita pakai operator `||` buat nge-gabungin (_concatenate_) string nama depan, spasi, dan nama belakang.

Tapi perhatiin deh output kolom pertamanya, kok namanya malah `?column?` sih? Jelek banget kan. Nah, biar nama kolom hasil manipulasi ini punya nama sementara yang rapi, kita bisa pakai fitur alias kolom dengan kata kunci `AS`:

```sql
expression AS column_alias
```

Kata kunci `AS` ini opsional kok, jadi kalau mau disingkat langsung spasi nama aliasnya juga bisa:

```sql
expression column_alias
```

Yuk kita rapiin query gabung nama tadi pakai alias `full_name` :

```sql
SELECT
   first_name || ' ' || last_name full_name,
   email
FROM
   customer;
```

Output:

| full_name           | email                     |
|---------------------|---------------------------|
| Jared Ely           | [email protected]         |
| Mary Smith          | [email protected]         |
| Patricia Johnson    | [email protected]         |

Nah, kalau gini kan output-nya jadi cakep.

### 5) Menggunakan Perintah SELECT tanpa Klausa FROM
Kayak yang sempat disenggol di atas, klausa FROM itu gak wajib. Kamu bisa pakai SELECT doang buat manggil fungsi bawaan Postgres.

Contoh paling gampang, kita pengen tahu waktu dan tanggal saat ini di server database :

sql
```
SELECT NOW();
```

Query di atas bakal langsung ngebalikin info tanggal dan jam detik ini juga dari server PostgreSQL kamu tanpa perlu narik dari tabel apa pun.

#### Rangkuman Singkat Belajar Kita
- Pakai rumus `SELECT ... FROM` buat ngambil data dari tabel.
- Ingat, PostgreSQL bakal ngeliat klausa `FROM` duluan baru ngeproses perintah `SELECT`-nya.
- Pakai alias kolom kalau kamu pengen ngasih nama sementara buat kolom baru atau hasil rumus matematika/string.
- Klausa `FROM` di PostgreSQL itu sifatnya opsional (gak wajib ada).

---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------


# PostgreSQL Column Aliases

## Konsep Dasarnya Apa Sih?
**Alias** itu sederhananya adalah **"nama panggung" atau nama samaran sementara** yang kita berikan pada kolom atau hasil rumus (ekspresi) pas kita lagi nge-`SELECT` data.
- Alias ini cuma hidup selama query berjalan.
- Nama kolom asli di dalam database kamu **tidak akan berubah sama sekali**.
- Tujuan utamanya cuma satu : **Biar judul kolom tabel (heading) pas keluar jadi lebih rapi dan gampang dimengerti.**

Sintaks dasarnya ada dua cara :

```sql
-- Cara 1: Pakai kata kunci AS (Direkomendasikan biar rapi)
SELECT
   column_name AS alias_name
FROM
   table_name;

-- Cara 2: Tanpa AS (Langsung dipisah spasi)
SELECT
   column_name alias_name
FROM
   table_name;
```

## Contoh Praktek Menggunakan Tabel customer

Di database sampel kita, ada tabel bernama `customer` yang strukturnya seperti gambar di bawah ini:

![image](https://github.com/user-attachments/assets/9fbc1adb-05f7-49f9-9dda-e1a1f8451e9d)

### 1) Menetapkan Alias pada Kolom Asli
Kalau kita ngambil data nama depan dan nama belakang pake query standar :

```sql
SELECT
   first_name,
   last_name
FROM customer;
```

![image](https://github.com/user-attachments/assets/76fabe41-25c0-40f8-b25d-78676e226c70)

Hasil judul kolomnya bakal bawaan dari database, yaitu `first_name` dan `last_name` :

Nah, misal kita pengen ngubah judul `last_name` pas tampil biar jadi `surname` (nama keluarga), kodenya begini :

```sql
SELECT
   first_name,
   last_name AS surname
FROM customer;
```

Hasilnya, judul kolom kedua otomatis berubah jadi `surname` :

![image](https://github.com/user-attachments/assets/8dc0a58f-8746-46e5-a5b5-2d2e60f471d3)

**Tips** : Kamu juga bisa hapus kata `AS`-nya langsung kayak gini, hasilnya bakalan tetep sama persis:

```sql
SELECT
   first_name,
   last_name surname
FROM customer;
```

### 2) Memberikan Alias untuk Ekspresi (Hasil Gabungan)

Di PostgreSQL, kita bisa gabungin teks/string menggunakan operator `||`. Misal kita mau gabungin `first_name`, spasi (`' '`), dan `last_name` biar langsung jadi nama lengkap :

```sql
SELECT
   first_name || ' ' || last_name
FROM
   customer;
```

Kalau gak dikasih nama alias, Postgres bakal bingung mau ngasih judul apa. 
Akhirnya dia ngasih judul default yang jelek banget, yaitu `?column?` :

![image](https://github.com/user-attachments/assets/d676edb7-3fbf-42ab-92f9-fb4539c54b6c)

Biar kelihatan profesional, kita wajib kasih nama samaran (alias) menggunakan `AS full_name` :

```sql
SELECT
    first_name || ' ' || last_name AS full_name
FROM
    customer;
```

![image](https://github.com/user-attachments/assets/ad649137-0e9e-4416-917e-6f9aef6c1710)

Sekarang, judul kolomnya berubah jadi indah dan jelas : `full_name`.

### 3) Aturan Main Kalau Alias Menggunakan Spasi

Secara default, Postgres bakal eror kalau kamu bikin nama alias yang dipisah pakai spasi biasa (misal: `full name` ).

Solusinya, nama alias tersebut wajib diapit menggunakan Tanda Kutip Ganda (`"`).

```sql
column_name AS "column alias"
```

Contohnya:

```sql
SELECT
    first_name || ' ' || last_name "full name"
FROM
    customer;
```

![image](https://github.com/user-attachments/assets/ea0736ef-c998-434f-bc60-58b1f3899a9e)

Hasil di tabel output-nya nanti judul kolomnya bakal ada spasinya : `full name`.

### Ringkasan
- Alias = Nama panggung sementara buat judul kolom pas di-tampilkan.
- Kata kunci `AS` itu opsional (boleh ditulis, boleh langsung spasi).
- Gunakan tanda kutip dua (`"`) kalau nama alias yang kamu pengen itu mengandung spasi. Jangan tertukar dengan kutip satu (`'`) yang dipakai khusus untuk ngisi teks data (kayak spasi pemisah nama di atas).
  
---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------


# PostgreSQL ORDER BY

Ketika Anda mengambil data dari sebuah tabel, pernyataan `SELECT` mengembalikan baris dalam urutan yang tidak ditentukan. Untuk mengurutkan baris hasil kueri, Anda menggunakan klausa `ORDER BY` dalam pernyataan `SELECT`.

Klausa `ORDER BY` memungkinkan Anda mengurutkan baris yang dikembalikan oleh klausa `SELECT` dalam urutan naik atau turun berdasarkan ekspresi urutan.

Berikut adalah sintaks klausa `ORDER BY`:

```sql
SELECT
  select_list
FROM
  table_name
ORDER BY
  sort_expression1 [ASC | DESC],
  sort_expression2 [ASC | DESC],
  ...;
```

Dalam sintaks ini:

- Pertama, tentukan ekspresi urutan, yang bisa berupa kolom atau ekspresi, yang ingin Anda urutkan setelah kata kunci `ORDER BY`. Jika Anda ingin mengurutkan hasil kueri berdasarkan beberapa kolom atau ekspresi, Anda perlu menempatkan koma (`,`) antara dua kolom atau ekspresi untuk memisahkannya.
- Kedua, Anda menggunakan opsi `ASC` untuk mengurutkan baris dalam urutan naik dan opsi `DESC` untuk mengurutkan baris dalam urutan turun. Jika Anda menghilangkan opsi `ASC` atau `DESC`, `ORDER BY` menggunakan `ASC` secara default.

PostgreSQL mengevaluasi klausa dalam pernyataan `SELECT` dalam urutan berikut: `FROM`, `SELECT`, dan `ORDER BY`.

Karena urutan evaluasi, jika Anda memiliki alias kolom dalam klausa `SELECT`, Anda bisa menggunakannya dalam klausa `ORDER BY`.

Mari kita ambil beberapa contoh penggunaan klausa `ORDER BY` di PostgreSQL.

## Contoh ORDER BY PostgreSQL

Kita akan menggunakan tabel `customer` dalam database sampel untuk demonstrasi.

### 1) Menggunakan klausa ORDER BY untuk mengurutkan baris berdasarkan satu kolom

Kueri berikut menggunakan klausa `ORDER BY` untuk mengurutkan pelanggan berdasarkan nama depan mereka dalam urutan naik:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name ASC;
```

Karena opsi `ASC` adalah default, Anda bisa menghilangkannya dalam klausa `ORDER BY` seperti ini:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name;
```

### 2) Menggunakan klausa ORDER BY untuk mengurutkan baris berdasarkan satu kolom dalam urutan turun

Pernyataan berikut memilih nama depan dan nama belakang dari tabel `customer` dan mengurutkan baris berdasarkan nilai di kolom nama belakang dalam urutan turun:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  last_name DESC;
```

### 3) Menggunakan klausa ORDER BY untuk mengurutkan baris berdasarkan beberapa kolom

Pernyataan berikut memilih nama depan dan nama belakang dari tabel `customer` dan mengurutkan baris berdasarkan nama depan dalam urutan naik dan nama belakang dalam urutan turun:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name ASC,
  last_name DESC;
```

Dalam contoh ini, klausa `ORDER BY` mengurutkan baris berdasarkan nilai di kolom nama depan terlebih dahulu. Kemudian mengurutkan baris yang sudah diurutkan berdasarkan nilai di kolom nama belakang.

### 4) Menggunakan klausa ORDER BY untuk mengurutkan baris berdasarkan ekspresi

Fungsi `LENGTH()` menerima string dan mengembalikan panjang string tersebut.

Pernyataan berikut memilih nama depan dan panjangnya. Mengurutkan baris berdasarkan panjang nama depan:

```sql
SELECT
  first_name,
  LENGTH(first_name) len
FROM
  customer
ORDER BY
  len DESC;
```

Karena klausa `ORDER BY` dievaluasi setelah klausa `SELECT`, alias kolom `len` tersedia dan bisa digunakan dalam klausa `ORDER BY`.

## PostgreSQL ORDER BY dan NULL
Dalam dunia database, `NULL` adalah penanda yang menunjukkan data yang hilang atau data yang tidak diketahui pada saat pencatatan.

Ketika Anda mengurutkan baris yang mengandung `NULL`, Anda bisa menentukan urutan `NULL` dengan nilai lain yang tidak null menggunakan opsi `NULLS FIRST` atau `NULLS LAST` dalam klausa `ORDER BY`:

```sql
ORDER BY sort_expresssion [ASC | DESC] [NULLS FIRST | NULLS LAST]
```

Opsi `NULLS FIRST` menempatkan `NULL` sebelum nilai lain yang tidak null dan opsi `NULLS LAST` menempatkan `NULL` setelah nilai lain yang tidak null.

Mari kita buat tabel untuk demonstrasi.

```sql
-- membuat tabel baru
CREATE TABLE sort_demo(num INT);

-- memasukkan beberapa data
INSERT INTO sort_demo(num)
VALUES
  (1),
  (2),
  (3),
  (null);
```

Jika Anda belum familiar dengan pernyataan `CREATE TABLE` dan `INSERT`, Anda bisa mengeksekusinya dari `pgAdmin` atau `psql` untuk membuat tabel `sort_demo` dan memasukkan data ke dalamnya.

Kueri berikut mengembalikan data dari tabel `sort_demo`:

```sql
SELECT
  num
FROM
  sort_demo
ORDER BY
  num;
```


| num | 
|-----|
|   1 |
|   2 |
|   3 |
| null|

(4 rows)


Dalam contoh ini, klausa `ORDER BY` mengurutkan nilai di kolom `num` dari tabel `sort_demo` dalam urutan naik. Ini menempatkan `NULL` setelah nilai lainnya.

Perlu dicatat bahwa psql menampilkan null sebagai string kosong secara default. Untuk membuat null lebih jelas, Anda bisa mengeksekusi perintah berikut untuk mengubah string kosong menjadi null:

```sql
\pset null null
```

Output:


| |
| :--- |
|  Null display is "null". |

Jika Anda menggunakan opsi `ASC`, klausa `ORDER BY` menggunakan opsi `NULLS LAST` secara default. Oleh karena itu, kueri berikut mengembalikan hasil yang sama:

```sql
SELECT
  num
FROM
  sort_demo
ORDER BY
  num NULLS LAST;
```

Output:


| **num**  |
|------|
|   1  |
|   2  |
|   3  |
| null |

(4 rows)

Untuk menempatkan `NULL` sebelum nilai lain yang tidak null, gunakan opsi `NULLS FIRST`:

```sql
SELECT
  num
FROM
  sort_demo
ORDER BY
  num NULLS FIRST;
```

Output:

| **num**  |
|------|
| null |
|    1 | 
|    2 |
|    3 |

(4 rows)


Pernyataan berikut mengurutkan nilai di kolom `num` dari tabel `sort_demo` dalam urutan turun:

```sql
SELECT
  num
FROM
  sort_demo
ORDER BY
  num DESC;
```

Output:


| **num**  |
|------|
| null |
|    3 |
|    2 |
|    1 |

(4 rows)


Output menunjukkan bahwa klausa `ORDER BY` dengan opsi `DESC` menggunakan `NULLS FIRST` secara default.

Untuk membalikkan urutan, gunakan opsi `NULLS LAST`:

```sql
SELECT
  num
FROM
  sort_demo
ORDER BY
  num DESC NULLS LAST;
```

Output:


| **num**  |
|------|
|   3  |
|   2  |
|   1  |
| null |

(4 rows)

### Ringkasan
- Gunakan klausa `ORDER BY` dalam pernyataan `SELECT` untuk mengurutkan baris dalam kumpulan kueri.
- Gunakan opsi `ASC` untuk mengurutkan baris dalam urutan naik dan opsi `DESC` untuk mengurutkan baris dalam urutan turun.
- Klausa `ORDER BY` menggunakan opsi `ASC` secara default.
- Gunakan opsi `NULLS FIRST` dan `NULLS LAST` untuk secara eksplisit menentukan urutan `NULL` dengan nilai lain yang tidak null.


---------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------------------


# PostgreSQL SELECT DISTINCT

## Pengenalan klausa PostgreSQL SELECT DISTINCT
`SELECT DISTINCT` menghilangkan baris duplikat dari hasil kueri. Klausa `SELECT DISTINCT` mempertahankan satu baris untuk setiap grup duplikat.

Klausa `SELECT DISTINCT` dapat diterapkan pada satu atau lebih kolom dalam daftar pilih pernyataan `SELECT`.

Berikut adalah sintaks penggunaan klausa `DISTINCT`:

```sql
SELECT
  DISTINCT column1
FROM
  table_name;
```

Dalam sintaks ini, `SELECT DISTINCT` menggunakan nilai dalam kolom `column1` untuk mengevaluasi duplikat.

Jika Anda menentukan beberapa kolom, klausa `SELECT DISTINCT` akan mengevaluasi duplikat berdasarkan kombinasi nilai-nilai dalam kolom-kolom tersebut. Contohnya:

```sql
SELECT
   DISTINCT column1, column2
FROM
   table_name;
```

Dalam sintaks ini, `SELECT DISTINCT` menggunakan kombinasi nilai dalam kolom `column1` dan `column2` untuk mengevaluasi duplikat.

Perhatikan bahwa PostgreSQL juga menawarkan klausa `DISTINCT ON` yang mempertahankan entri unik pertama dari sebuah kolom atau kombinasi kolom dalam hasil kueri.

Jika Anda ingin menemukan nilai unik dari semua kolom dalam tabel, Anda dapat menggunakan `SELECT DISTINCT *`:

```sql
SELECT DISTINCT *
FROM table_name;
```

Tanda bintang (`*`) berarti semua kolom dari `table_name`.

# Contoh PostgreSQL SELECT DISTINCT

Mari kita buat tabel baru untuk latihan menggunakan klausa `SELECT DISTINCT`.

Perhatikan bahwa Anda akan belajar cara membuat tabel dan memasukkan data ke dalamnya dalam tutorial selanjutnya. Dalam tutorial ini, Anda perlu menjalankan pernyataan di psql atau pgAdmin untuk menjalankan pernyataan.

Pertama, buat tabel `colors` yang memiliki tiga kolom: `id`, `bcolor` dan `fcolor` menggunakan pernyataan `CREATE TABLE` berikut:

```sql
CREATE TABLE colors(
  id SERIAL PRIMARY KEY,
  bcolor VARCHAR,
  fcolor VARCHAR
);
```

Kedua, masukkan beberapa baris ke dalam tabel `colors`:

```sql
INSERT INTO
  colors (bcolor, fcolor)
VALUES
  ('red', 'red'),
  ('red', 'red'),
  ('red', NULL),
  (NULL, 'red'),
  (NULL, NULL),
  ('green', 'green'),
  ('blue', 'blue'),
  ('blue', 'blue');
```

Ketiga, ambil data dari tabel `colors` menggunakan pernyataan `SELECT`:

```sql
SELECT
  id,
  bcolor,
  fcolor
FROM
  colors;
```

Output:

| id | bcolor | fcolor |
|----|--------|--------|
|  1 | red    | red    |
|  2 | red    | red    |
|  3 | red    | null   |
|  4 | null   | red    |
|  5 | null   | null   |
|  6 | green  | green  |
|  7 | blue   | blue   |
|  8 | blue   | blue   |

### 1) Contoh PostgreSQL SELECT DISTINCT satu kolom
Pernyataan berikut memilih nilai unik dari kolom `bcolor` dari tabel `t1` dan mengurutkan hasil kueri dalam urutan alfabetis menggunakan klausa `ORDER BY`.

```sql
SELECT
  DISTINCT bcolor
FROM
  colors
ORDER BY
  bcolor;
```

Output:

| bcolor |
|--------|
| blue |
| green |
| red |
| null |

(4 rows)


Kolom `bcolor` memiliki 3 nilai red, dua NULL, 1 nilai green, dan dua nilai blue. DISTINCT menghilangkan dua nilai red, 1 NULL, dan satu blue.

Perhatikan bahwa PostgreSQL menganggap `NULL` sebagai duplikat sehingga mempertahankan satu `NULL` untuk semua `NULL` ketika Anda menerapkan klausa `SELECT DISTINCT`.

### 2) SELECT DISTINCT pada beberapa kolom

Pernyataan berikut menerapkan klausa `SELECT DISTINCT` pada kolom `bcolor` dan `fcolor`:

```sql
SELECT
  DISTINCT bcolor, fcolor
FROM
  colors
ORDER BY
  bcolor,
  fcolor;
```

Output:

| bcolor | fcolor |
|--------|--------|
| blue   | blue |
| green  | green |
| red    | red |
| red    | null |
| null   | red |
| null   | null |

(6 rows)

Dalam contoh ini, kueri menggunakan nilai dari kolom `bcolor` dan `fcolor` untuk mengevaluasi keunikan baris.

### 3) Menggunakan klausa SELECT DISTINCT dalam praktik

Dalam praktiknya, Anda sering menggunakan klausa `SELECT DISTINCT` untuk menganalisis keunikan nilai dalam sebuah kolom.

Misalnya, Anda mungkin ingin mengetahui berapa banyak tarif sewa untuk film dari tabel `film`:

![image](https://github.com/user-attachments/assets/3f578cbf-d4f5-4771-9039-72a68e504134)

Untuk mencapainya, Anda bisa menentukan kolom `rental_rate` dalam klausa `SELECT DISTINCT` sebagai berikut:

```sql
SELECT DISTINCT
  rental_rate
FROM
  film
ORDER BY
  rental_rate;
```

Output:

| rental_rate |
|-------------|
| 0.99        |
| 2.99        |
| 4.99        |

Output menunjukkan bahwa hanya ada tiga tarif sewa yang unik yaitu 0.99, 2.99, dan 4.99.

### Ringkasan
- Gunakan `SELECT DISTINCT` untuk menghilangkan baris duplikat dari hasil kueri.
