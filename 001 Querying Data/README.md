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

Pas kita narik data dari tabel pake perintah `SELECT`, hasil baris datanya sering kali keluar acak-acakan alias gak berurutan. Nah, biar datanya rapi dan enak dibaca, kita bisa pake klausa `ORDER BY`.

Klausa `ORDER BY` ini fungsinya buat ngurutin baris data hasil query, bisa dari yang terkecil ke terbesar (_ascending_) atau sebaliknya dari yang terbesar ke terkecil (_descending_).

Begini cara nulis klausa `ORDER BY` yang bener:

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

Penjelasan Gampangnya : 

- `sort_expression` : Kolom atau rumus yang mau kita jadikan acuan buat ngurutin data. Kalau mau ngurutin pake beberapa kolom sekaligus, tinggal pisahin pake tanda koma (`,`).
- `ASC` (_Ascending_) : Ngurutin dari yang paling kecil ke besar (contoh: A ke Z, atau 1 ke 10). Ini adalah setelan bawaan (default). Jadi kalau gak ditulis apa-apa, PostgreSQL bakal otomatis pake `ASC`.
- `DESC` (_Descending_) : Ngurutin dari yang paling besar ke kecil (contoh: Z ke A, atau 10 ke 1).

Di balik layar, PostgreSQL ngerjain perintah kita dengan urutan kayak gini :

$$\text{FROM} \rightarrow \text{SELECT} \rightarrow \text{ORDER BY}$$

**Info Penting** : Karena proses `SELECT` jalan duluan sebelum `ORDER BY`, kalau kita bikin nama alias (nama samaran) kolom di bagian `SELECT`, nama alias itu udah bisa langsung kita panggil dan pake di bagian `ORDER BY`.

Mari kita ambil beberapa contoh penggunaan klausa `ORDER BY` di PostgreSQL.

## Contoh ORDER BY PostgreSQL

Kita akan menggunakan tabel `customer` dalam database sampel untuk demonstrasi.

### 1) Ngurutin Pake Satu Kolom (Ascending / Dari Kecil ke Besar)

Query ini dipakai buat ngurutin data pelanggan berdasarkan nama depan (`first_name`) dari abjad A ke Z:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name ASC;
```

<img width="327" height="360" alt="image" src="https://github.com/user-attachments/assets/d141dd06-55ac-4731-bf5d-63b61f0bdc5d" />

Karena `ASC` itu setelan default bawaan pabrik, kita juga bisa hapus tulisan `ASC`-nya. Hasilnya bakal tetep sama persis :

```sql
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name;
```

### 2) Ngurutin Pake Satu Kolom (Descending / Dari Besar ke Kecil)

Kalau mau balik urutannya dari abjad Z ke A berdasarkan nama belakang (`last_name`), kita tinggal tambah kata `DESC` di belakangnya :

```sql
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  last_name DESC;
```

Output setelah kolom `last_name` diurutkan secara _descending_ :

<img width="328" height="408" alt="image" src="https://github.com/user-attachments/assets/3611468e-f6bd-4342-8af3-28ee58bcbb9b" />

### 3) Ngurutin Pake Banyak Kolom Sekaligus

Query di bawah ini bakal ngurutin data berdasarkan nama depan (`first_name`) dari A-Z dulu. Nah, kalau ada nama depan yang sama (misalnya ada dua orang namanya "`Kelly`"), barulah mereka diurutin berdasarkan nama belakangnya (`last_name`) dari Z-A :

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

<img width="347" height="515" alt="image" src="https://github.com/user-attachments/assets/23877d36-b676-42d3-b93e-516db1171fff" />

Dalam contoh ini, klausa `ORDER BY` mengurutkan baris berdasarkan nilai di kolom nama depan terlebih dahulu. Kemudian mengurutkan baris yang sudah diurutkan berdasarkan nilai di kolom nama belakang.

### 4) Ngurutin Pake Rumus (Ekspresi) & Alias

Fungsi `LENGTH()` dipakai buat ngitung jumlah huruf di dalam teks.

Kueri di bawah ini bakal ngitung panjang karakter dari nama depan, kita kasih nama alias `len`, terus kita urutin dari nama yang paling panjang ke yang paling pendek :

```sql
SELECT
  first_name,
  LENGTH(first_name) len
FROM
  customer
ORDER BY
  len DESC;
```

<img width="260" height="338" alt="image" src="https://github.com/user-attachments/assets/aea05101-d177-4ac9-88fb-bbae991345b7" />

Karena proses `ORDER BY` jalan paling akhir, alias `len` yang kita bikin di `SELECT` tadi udah aman dan sah buat langsung dipake.

## PostgreSQL ORDER BY dan NULL
Di dunia database, `NULL` itu artinya data kosong alias belum diisi (bukan angka 0, dan bukan juga spasi kosong).

Pas kita ngurutin data yang ada nilai `NULL`-nya, kita bisa atur posisinya mau ditaruh di mana pake perintah `NULLS FIRST` atau `NULLS LAST` :

```sql
ORDER BY sort_expresssion [ASC | DESC] [NULLS FIRST | NULLS LAST]
```

- `NULLS FIRST` : Taruh baris kosong (`NULL`) di paling atas.
- `NULLS LAST` : Taruh baris kosong (`NULL`) di paling bawah.

Biar gampang dibayangin, yuk buat tabel kecil bernama sort_demo dulu buat latihan :

```sql
-- bikin tabel baru
CREATE TABLE sort_demo(num INT);

-- Masukin data contoh (angka 1, 2, 3, dan satu data kosong)
INSERT INTO sort_demo(num)
VALUES
  (1),
  (2),
  (3),
  (null);
```

#### A. Aturan Bawaan pas Urutan Naik (ASC)

Secara default, kalau kita ngurutin data secara naik (`ASC`), PostgreSQL bakal naruh nilai `NULL` di **paling akhir** (`NULLS LAST`) :

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

Hasil di atas sama aja kayak kita nulis perintahnya lengkap pake `NULLS LAST` kayak gini :

```sql
SELECT
  num
FROM
  sort_demo
ORDER BY
  num NULLS LAST;
```

Nah, kalau mau maksa data `NULL`-nya pindah ke paling atas, kita pake `NULLS FIRST` :

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

#### B. Aturan Bawaan pas Urutan Turun (DESC)

Sebaliknya, kalau kita ngurutin data secara turun (`DESC`), PostgreSQL secara default bakal naruh nilai `NULL` di paling atas (`NULLS FIRST`) :

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


Kalau mau maksa data `NULL`-nya ngalah dan turun ke paling bawah, kita tinggal tambah `NULLS LAST` di ujungnya :

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
- Pake `ORDER BY` di bagian paling bawah query buat ngurutin data.
- `ASC` = Urutin dari kecil ke besar (Default bawaan).
- `DESC` = Urutin dari besar ke kecil.
- Kita bisa ngurutin pake nama alias kolom karena proses `SELECT` jalan duluan sebelum `ORDER BY`.
- Atur posisi data kosong pake `NULLS FIRST` atau `NULLS LAST` biar posisi `NULL` gak ngacak sesuai kemauan kita.


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
