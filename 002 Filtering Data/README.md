# Panduan PostgreSQL Filtering Data

## Daftar Isi
- [PostgreSQL WHERE](#postgresql-where)
- [PostgreSQL AND Operator](#postgresql-and-operator)
- [PostgreSQL OR Operator](#postgresql-or-operator)
- [PostgreSQL LIMIT](#postgresql-limit)
- [PostgreSQL FETCH](#postgresql-fetch)
- [PostgreSQL IN](#postgresql-in)
- [PostgreSQL BETWEEN](#postgresql-between)
- [PostgreSQL LIKE](#postgresql-like)
- [PostgreSQL IS NULL](#postgresql-is-null)

# PostgreSQL WHERE

## Pengenalan Klausa PostgreSQL WHERE

Perintah `SELECT` biasa bakal menampilkan semua baris data dari kolom yang kita pilih di dalam tabel. Nah, kalau kita cuma mau mengambil baris data yang memenuhi kriteria atau kondisi tertentu saja, kita harus pakai klausa `WHERE`.

Sintaks klausa PostgreSQL `WHERE` adalah sebagai berikut:

```sql
SELECT
  select_list
FROM
  table_name
WHERE
  condition
ORDER BY
  sort_expression;
```

Dalam sintaks ini : 
- Klausa `WHERE` ditulis tepat setelah klausa `FROM` pada pernyataan `SELECT`.
- Klausa `WHERE` menggunakan `condition` (kondisi) untuk memfilter baris data yang ditarik dari klausa `SELECT`.
- `condition` ini berupa ekspresi boolean yang hasilnya cuma ada tiga kemungkinan: `True` (benar), `False` (salah), atau `Unknown` (tidak diketahui).
- Query cuma bakal menampilkan baris data yang memenuhi `condition` pada klausa `WHERE`. Dengan kata lain, cuma baris yang bikin condition bernilai `True` aja yang bakal muncul di hasil akhir.

### Urutan Eksekusi Query di PostgreSQL :

Di balik layar, PostgreSQL mengevaluasi klausa `WHERE` setelah klausa `FROM`, tapi sebelum klausa `SELECT` dan `ORDER BY`.

<img width="640" height="74" alt="image" src="https://github.com/user-attachments/assets/0b56bb9f-4200-4c70-ad3e-e5fa325a48ea" />

Jika kamu menggunakan alias kolom dalam klausa `SELECT`, kamu tidak dapat menggunakannya dalam klausa `WHERE`.

Selain pada perintah `SELECT`, kamu juga bisa pakai klausa `WHERE` di perintah `UPDATE` dan `DELETE` buat menentukan baris data mana aja yang mau diubah atau dihapus.

Untuk menyusun kondisi di dalam klausa `WHERE`, kita bisa pakai operator perbandingan dan logika berikut :

| Operator   | Deskripsi                                                                 |
|------------|---------------------------------------------------------------------------|
| =          | Sama dengan                                                               |
| >          | Lebih besar dari                                                          |
| <          | Lebih kecil dari                                                          |
| >=         | Lebih besar atau sama dengan                                              |
| <=         | Lebih kecil atau sama dengan                                              |
| <> atau != | Tidak sama dengan                                                         |
| AND        | Operator Logika AND (kedua kondisi harus bernilai true)                   |
| OR         | Operator Logika OR (salah satu kondisi bernilai true)                     |
| IN         | Bernilai true kalau datanya cocok dengan salah satu nilai di dalam daftar |
| BEETWEEN   | Bernilai true kalau datanya ada di antara rentang nilai tertentu          |
| LIKE       | Bernilai true kalau datanya cocok dengan pola teks tertentu               |
| IS NULL    | Bernilai true kalau nilainya adalah NULL (kosong)                         |
| NOT        | Membalikkan hasil dari operator lain                                      |

## Contoh Klausa PostgreSQL WHERE 
Yuk, langsung kita coba praktekkan penggunaan klausa `WHERE` lewat beberapa contoh!

Kita bakal pakai tabel `customer` dari sampel database buat demonstrasi.

<img width="206" height="256" alt="image" src="https://github.com/user-attachments/assets/6d9815a3-3fce-46e7-bf88-28441aea8f42" />

### 1)  Pakai Operator Sama Dengan (=)
Query berikut menggunakan klausa `WHERE` buat mencari data pelanggan yang nama depannya adalah "`Jamie`" :

```sql
SELECT
  last_name,
  first_name
FROM
  customer
WHERE
  first_name = 'Jamie';
```

Output:

| last_name | first_name |
|-----------|------------|
| Rice      | Jamie      |
| Waugh     | Jamie      |

(2 rows)

### 2) Pakai Operator AND
Contoh berikut menggunakan klausa `WHERE` ditambah operator logika `AND` buat mencari pelanggan yang nama depan DAN nama belakangnya persis "`Jamie`" dan "`Rice`" :

```sql
SELECT
  last_name,
  first_name
FROM
  customer
WHERE
  first_name = 'Jamie'
  AND last_name = 'Rice';
```

Output:

| last_name | first_name |
|-----------|------------|
| Rice      | Jamie      |

(1 row)

### 3) Pakai Operator OR
Contoh berikut menggunakan klausa `WHERE` dengan operator `OR` buat mencari pelanggan yang nama belakangnya `Rodriguez` ATAU nama depannya `Adam` :

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  last_name = 'Rodriguez'
  OR first_name = 'Adam';
```

Output:

| first_name | last_name |
|------------|-----------|
| Laura      | Rodriguez |
| Adam       | Gooch     |

(2 rows)

### 4) Pakai Operator IN
Kalau kamu mau mencocokkan data dari sekumpulan daftar nilai, kamu bisa pakai operator `IN`.

Contoh berikut menggunakan klausa `WHERE` dengan operator `IN` buat mencari pelanggan yang nama depannya ada di dalam daftar `Ann`, `Anne`, atau `Annie` :

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name IN ('Ann', 'Anne', 'Annie');
```

Output:

| first_name | last_name |
|------------|-----------|
| Ann        | Evans     |
| Anne       | Powell    |
| Annie      | Russell   |

### 5) Pakai Operator LIKE
Buat mencari teks yang cocok dengan pola tertentu, kita bisa pakai operator `LIKE`.

Contoh berikut menggunakan operator `LIKE` di dalam klausa `WHERE` buat mencari pelanggan yang nama depannya diawali dengan kata `Ann..` :

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'Ann%';
```

Output:

| first_name | last_name |
|------------|-----------|
| Anna       | Hill      |
| Ann        | Evans     |
| Anne       | Powell    |
| Annie      | Russell   |
| Annette    | Olson     |
| ...        | ...       |

(5 rows)


Tanda `%` di sini disebut _wildcard_, yang artinya bisa mencocokkan karakter teks apa saja setelahnya. Jadi pola `'Ann%'` bakal cocok dengan teks apa pun yang diawali oleh kata `'Ann'`.

### 6) Pakai Operator BETWEEN
Contoh berikut dipakai buat mencari pelanggan yang nama depannya diawali huruf `A` dan panjang karakternya berjumlah antara 3 sampai 5 huruf menggunakan operator `BETWEEN`.

Operator `BETWEEN` ini bakal bernilai true kalau nilainya ada di dalam rentang yang ditentukan.

```sql
SELECT
  first_name,
  LENGTH(first_name) as name_length
FROM
  customer
WHERE
    first_name LIKE 'A%'
  AND
    LENGTH(first_name) BETWEEN 3 AND 5
ORDER BY
  name_length;
```

Output:


| first_name | name_length |
|------------|-------------|
| Amy        |           3 |
| Ann        |           3 |
| Ana        |           3 |
| Andy       |           4 |
| Anna       |           4 |
| Anne       |           4 |
| Alma       |           4 |
| Adam       |           4 |
| Alan       |           4 |
| Alex       |           4 |
| Angel      |           5 |
| ...        | ...         |


Di contoh ini, kita menggunakan fungsi `LENGTH()` untuk menghitung total jumlah karakter dari teks nama depan.

### 7) Pakai Operator Tidak Sama Dengan (<>)
Contoh ini dipakai buat mencari pelanggan yang nama depannya diawali dengan kata `Bra..`, tapi nama belakangnya **BUKAN** `Motley` :

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'Bra%'
    AND
  last_name <> 'Motley';
```

Output:

| first_name | last_name |
|------------|-----------|
| Brandy     | Graves    |
| Brandon    | Huey      |
| Brad       | Mccurdy   |
| ...        | ...       |


**FYI** : Kamu bisa pakai operator `!=` atau `<>` secara bergantian karena fungsi keduanya persis sama (tidak sama dengan).

#### Summary
- Pakai klausa `WHERE` di dalam perintah `SELECT` untuk menyaring dan mengambil baris data berdasarkan satu atau beberapa kondisi tertentu.

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# PostgreSQL AND Operator

Di tutorial ini, kamu bakal belajar tentang operator logika `AND` di PostgreSQL dan gimana cara menggunakannya buat menggabungkan beberapa ekspresi boolean sekaligus.

## Pengenalan Operator PostgreSQL AND
Di PostgreSQL, nilai boolean punya salah satu dari tiga kemungkinan nilai: `true` (benar), `false` (salah), dan `null` (kosong/tidak diketahui).

- PostgreSQL memakai `true`, `'t'`, `'true'`, `'y'`, `'yes'`, dan `'1'` untuk mewakili nilai `true`,
- serta `false`, `'f'`, `'false'`, `'n'`, `'no'`, dan `'0'` untuk mewakili nilai `false`.
- Ekspresi boolean sendiri adalah ekspresi yang kalau dihitung bakal menghasilkan nilai boolean. Contohnya, ekspresi `1=1` itu adalah ekspresi boolean yang hasilnya `true` :

```sql
SELECT 1 = 1 AS result;
```

Output :

| result |
|--------|
| t      |

Huruf `t` pada output di atas menandakan nilainya adalah `true`.

Operator `AND` adalah operator logika yang dipakai buat menggabungkan dua ekspresi boolean.

Sintaks dasar penggunaan operator `AND` adalah seperti ini:

```sql
expression1 AND expression2
```

- Pada sintaks di atas, `expression1` dan `expression2` adalah ekspresi boolean yang nilainya bisa berupa `true`, `false`, atau `null`.
- Operator `AND` cuma bakal mengembalikan nilai `true` kalau kedua ekspresi bernilai `true`.
- Kalau salah satu ekspresi saja bernilai `false`, hasilnya bakal `false`.
- Di luar itu, hasilnya adalah `null`.

Tabel di bawah ini menunjukkan hasil keluaran operator `AND` saat menggabungkan nilai `true`, `false` dan `null` :

| **AND**   | **TRUE** | **FALSE** | **NULL** |
|-----------|----------|-----------|----------|
| **TRUE**  | True     | False     | Null     |
| **FALSE** | False    | False     | False    |
| **NULL**  | Null     | False     | Null     |

Dalam praktiknya, kamu bakal sering banget memakai operator `AND` di dalam klausa `WHERE`. Tujuannya buat memastikan semua kondisi yang kamu tentukan harus bernilai `true` agar baris data tersebut bisa masuk ke dalam hasil query.

## PostgreSQL AND operator
Yuk, kita coba lihat beberapa contoh penggunaan operator `AND` ini!

### 1) Contoh dasar penggunaan operator PostgreSQL AND
Contoh berikut menggunakan operator `AND` buat **menggabungkan dua nilai `true`**, yang **bakal menghasilkan `true`** :

```sql
SELECT true AND true AS result;
```

Output:

| result |
|--------|
| t      |

Query berikut memakai operator `AND` buat **menggabungkan `true` dengan `false`**, yang bakal **menghasilkan `false`** :

```sql
SELECT true AND false AS result;
```

Output:

| result |
|--------|
| f      |

Contoh berikut memakai operator `AND` buat **menggabungkan `true` dengan `null`**, yang bakal **menghasilkan `null`** :

```sql
SELECT true AND null AS result;
```

Output:

| result |
|--------|
| null   |

Contoh berikut memakai operator `AND` buat **menggabungkan `false` dengan `false`**, yang bakal **menghasilkan `false`** :

```sql
SELECT false AND false AS result;
```

Output:

| result |
|--------|
| f      |

Contoh berikut memakai operator `AND` buat **menggabungkan `false` dengan `null`**, yang bakal **menghasilkan `false`** :

```sql
SELECT false AND null AS result;
```

Output:

| result |
|--------|
| f      |

Contoh berikut memakai operator `AND` buat **menggabungkan `null` dengan `null`**, yang bakal **menghasilkan `null`** :

```sql
SELECT null AND null AS result;
```

Output:

| result |
|--------|
| null   |

### 2) Menggunakan operator AND dalam klausa WHERE
Kita bakal memakai tabel `film` dari contoh database buat kebutuhan demonstrasi :

![image](https://github.com/user-attachments/assets/cfef6559-d850-48d8-879c-f7e65198d5a2)

Contoh berikut memakai operator `AND` di dalam klausa `WHERE` buat mencari `film` yang _durasinya lebih dari 180 menit_ DAN _tarif sewanya kurang dari 1_ :

```sql
SELECT
  title,
  length,
  rental_rate
FROM
  film
WHERE
    length > 180
  AND
    rental_rate < 1;
```

Output:


| title              | length | rental_rate |
|--------------------|--------|-------------|
| Catch Amistad      |    183 |        0.99 |
| Haunting Pianist   |    181 |        0.99 |
| Intrigue Worst     |    181 |        0.99 |
| Love Suicides      |    181 |        0.99 |
| Runaway Tenenbaums |    181 |        0.99 |
| Smoochy Control    |    184 |        0.99 |
| Sorority Queen     |    184 |        0.99 |
| Theory Mermaid     |    184 |        0.99 |
| Wild Apollo        |    181 |        0.99 |
| Young Language     |    183 |        0.99 |
| ...                | ...    | ...         |


### Ringkasan
- Gunakan operator `AND` untuk menggabungkan beberapa ekspresi boolean.


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# PostgreSQL OR Operator

## Kenalan sama Operator OR di PostgreSQL

Gampangnya, operator `OR` itu dipake pas kamu mau ngebanggungin dua kondisi atau lebih. Cara nulis dasarnya simpel banget :

SQL :

```sql
ekspresi1 OR ekspresi2
```

Di sini, `ekspresi1` sama `ekspresi2` itu cuma patokan kondisi yang hasilnya cuma ada 3 kemungkinan: `true` (benar), `false` (salah), atau `null` (kosong/nggak ada nilai).

Cara kerja `OR` itu  simple banget :
- `true` : Asal salah satu aja kondisi bernilai `true`, hasil akhirnya bakal langsung jadi `true`.
- `false` : Hasilnya baru bakal `false` kalau semua kondisinya emang sama-sama `false`.
- `null` : Kalau nggak masuk ke dua aturan di atas (misal gabungan `false` sama `null`), hasilnya jadi `null`.

Biar makin kebayang, ini tabel patokan (_truth table_) pas kamu ngegabungin `true`, `false`, dan `null` pake `OR` :

| **OR** | **True** | **False** | **Null** |
|------|------|-------|------|
| **True** | True | True  | True |
| **False** | True | False | Null |
| **Null** | True | Null  | Null |

Pas ngetik kueri SQL sehari-hari, kamu bakal sering banget naro `OR` di bagian `WHERE`. Gunanya simpel : biar PostgreSQL nampilin data yang penting salah satu syaratnya keturut.

## Contoh Langsung Penggunaan Operator OR
Yuk, langsung kita bedah contohnya dari yang paling dasar sampai ke tabel database beneran!

### 1) Uji Coba Logika Dasar OR
Nih contoh cara kerja `OR` kalau kita tes langsung pake perintah `SELECT` :

- Gabungin `true` sama `true` (Hasilnya tetep `true`) :

```sql
SELECT true OR true AS result;
```

Output:

| result |
|--------|
| t      |

(1 row)

- Gabungin `true` sama `false` (Hasilnya tetep `true`, karena udah ada satu yang benar) :

```sql
SELECT true OR false AS result;
```

Output:

| result |
|--------|
| t      |

(1 row)

- Gabungin `true` sama `null` (Hasilnya tetep `true`, karena yang penting udah ada `true`-nya) :

```sql
SELECT true OR null AS result;
```

Output:

| result |
|--------|
| t      |

(1 row)


- Gabungin `false` sama `false` (Hasilnya jadi `false`, karena dua-duanya nggak ada yang benar) :

```sql
SELECT false OR false AS result;
```

Output:

| result |
|--------|
| f      |

(1 row)

- Gabungin `false` sama `null` (Hasilnya jadi `null`, soalnya PostgreSQL bingung nggak bisa mastiin) :

```sql
SELECT false OR null AS result;
```

Output:

| result |
|--------|
| null    |

(1 row)


Gabungin `null` sama `null` (Hasilnya tetep `null`) :

```
SELECT null OR null AS result;
```

Output:

| result |
|--------|
| null   |

(1 row)


### 2) Pake Operator `OR` di Dalam Klausa `WHERE`

Sekarang kita coba di data beneran. Kita pake tabel `film` yang strukturnya kaya gambar ini:

![image](https://github.com/user-attachments/assets/e8f25316-623d-4f23-aba7-ef0229accaba)

Misalkan kamu lagi nyari daftar `film` yang harga sewanya (`rental_rate`) `0.99` ATAU `2.99`. Kamu tinggal tulis SQL-nya kaya gini :

```sql
SELECT
  title,
  rental_rate
FROM
  film
WHERE
  rental_rate = 0.99 OR
  rental_rate = 2.99;
```

Output:

| title            | rental_rate |
|------------------|-------------|
| Academy Dinosaur |        0.99 |
| Adaptation Holes |        2.99 |
| Affair Prejudice |        2.99 |
| African Egg      |        2.99 |

**Penjelasan** : Kueri di atas bakal ngecek setiap baris di tabel `film`. Pas ketemu `film` yang harganya `0.99` atau `2.99`, baris itu bakal langsung ditarik dan ditampilin di layar.


#### Ringkasan
- Pake operator `OR` kalau kamu mau nyaring data yang pilihan syaratnya fleksibel, cukup salah satu syarat aja yang cocok, datanya langsung keluar.

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# PostgreSQL LIMIT

## Kenalan sama Klausa 'LIMIT' di PostgreSQL

Gampangnya, klausa `LIMIT` di PostgreSQL itu perintah tambahan opsional (boleh dipakai, boleh enggak) di dalam perintah `SELECT`. Gunanya buat membatasi berapa banyak baris data yang mau kamu tampilin dari hasil kueri.

Bentuk dasar nulis klausa `LIMIT` itu kaya gini :

```sql
SELECT
  select_list
FROM
  table_name
ORDER BY
  sort_expression
LIMIT
  row_count;
```

Perintah ini bakal nampilin data sebanyak angka yang kamu tulis di `row_count`.
- Kalau `row_count` kamu isi angka nol (`0`), kueri bakal nampilin hasil yang kosong melompong (nggak ada data sama sekali).
- Tapi kalau `row_count` bernilai `NULL`, kuerinya bakal jalan normal seolah-olah kamu nggak pakai klausa `LIMIT` sama sekali (semua data ditarik).

### Kombinasi dengan Klausa 'OFFSET'
Nah, kalau kamu mau ngelewatin/melompati beberapa baris data dulu sebelum nampilin `row_count` baris yang kamu mau, kamu bisa gabungin sama klausa `OFFSET`. Posisinya ditaro persis setelah `LIMIT` :

```sql
SELECT
  select_list
FROM
  table_name
ORDER BY
  sort_expression
LIMIT
  row_count
OFFSET
  row_to_skip;
```

Perintah di atas bakal **ngelewatin sebanyak `row_to_skip` baris dulu**, baru deh **mengambil data sebanyak `row_count` baris**.
- Kalau `row_to_skip` bernilai nol (`0`), hasilnya bakal sama aja kaya kamu nggak pakai klausa `OFFSET`.
- Penting buat diingat : Secara sistem, PostgreSQL bakal memproses klausa `OFFSET` dulu baru kemudian nge-proses klausa `LIMIT`.

**Catatan Penting Soal Urutan Data!**
PostgreSQL itu pada dasarnya nyimpen data di dalam tabel tanpa urutan yang pasti. Makanya, tiap kali kamu mau pakai `LIMIT`, sangat disarankan buat selalu pakai `ORDER BY`. Kalau kamu nggak pakai `ORDER BY`, hasil baris data yang dibatasi sama `LIMIT` bakal keluar secara acak/tidak terduga.

### Contoh Penggunaan Klausa 'LIMIT' di PostgreSQL

Biar langsung paham, yuk kita bedah beberapa contohnya! Kita bakal pakai tabel `film` dari database latihan buat contoh ini :

![image](https://github.com/user-attachments/assets/b698e255-a938-4132-bc01-ce067166af74)

### 1) Membatasi Jumlah Baris Data yang Diambil

Contoh pertama ini kita pakai klausa `LIMIT` buat ngambil 5 `film` pertama yang diurutkan berdasarkan `film_id` :

```sql
SELECT
  film_id,
  title,
  release_year
FROM
  film
ORDER BY
  film_id
LIMIT
  5;
```

**Hasil Output** :

Perintah di atas bakal nampilin 5 film paling atas berdasarkan `film_id` (diurutkan dari ID terkecil ke terbesar).

| film_id | title            | release_year |
|---------|------------------|--------------|
| 1       | Academy Dinosaur | 2006         |
| 2       | Ace Goldfinger   | 2006         |
| 3       | Adaptation Holes | 2006         | 
| 4       | Affair Prejudice | 2006         |
| 5       | African Egg      | 2006         |

### Cara Kerjanya di Belakang Layar :

- Pertama, PostgreSQL mengurutkan semua film berdasarkan `film_id` dari kecil ke besar (ascending) pakai `ORDER` BY `film_id`. 
- Kedua, sistem langsung memotong dan mengambil 5 baris teratas saja pakai `LIMIT` 5.

---

### 2) Menggabungkan Klausa 'LIMIT' dengan 'OFFSET'

Misalkan kamu mau ngambil 4 film, tapi mau dimulai dari film keempat (melewati 3 film pertama). Kalau diurutkan berdasarkan `film_id`, kamu bisa tulis gabungan `LIMIT` dan `OFFSET` kaya gini :

```sql
SELECT
  film_id,
  title,
  release_year
FROM
  film
ORDER BY
  film_id
LIMIT 4 OFFSET 3;
```

**Hasil Output :**  

| film_id | title            | release_year |
|---------|------------------|--------------|
| 4       | Affair Prejudice |         2006 |
| 5       | African Egg      |         2006 |
| 6       | Agent Truman     |         2006 |
| 7       | Airplane Sierra  |         2006 |

### Cara Kerjanya di Belakang Layar :

- Pertama, PostgreSQL mengurutkan data berdasarkan `film_id` dari kecil ke besar.
- Kedua, sistem melewati/melompati 3 baris pertama (`film_id` `1`, `2`, dan `3`) gara-gara ada `OFFSET 3`.
- Ketiga, sistem mengambil 4 baris berikutnya (`film_id` `4`, `5`, `6`, dan `7`) gara-gara ada `LIMIT 4`.

**Penjelasan Tambahan (Fitur Pagination)** :
Teknik kombinasi `LIMIT` dan `OFFSET` ini biasanya dipakai pas kamu mau bikin sistem halaman (pagination) di aplikasi atau website! 

Misal : 
- Halaman 1 isi 10 data (`LIMIT 10 OFFSET 0`)
- Halaman 2 isi 10 data berikutnya (`LIMIT 10 OFFSET 10`), dan seterusnya.

### 3) Mencari Data N Teratas (Top N) atau N Terbawah (Bottom N) 

Biasanya, kita sering banget pakai `LIMIT` buat nyari data dengan nilai paling tinggi atau paling rendah.

Contohnya, query di bawah ini memakai `LIMIT` buat ngambil 10 film dengan biaya sewa (`rental_rate`) paling mahal :

```sql
SELECT
  film_id,
  title,
  rental_rate
FROM
  film
ORDER BY
  rental_rate DESC
LIMIT
  10;
```

Lewat perintah ini, kita menarik 10 film termahal berdasarkan `rental_rate` yang diurutkan secara menurun / dari besar ke kecil (`DESC`).

_(Tips: Kalau kamu mau ngambil 10 film paling murah, kamu tinggal ganti kodenya dari `DESC` jadi `ASC` di bagian `ORDER BY`)._

Hasil Output :

| film_id | title               | rental_rate |
|---------|---------------------|-------------|
| 13      | Ali Forever         |        4.99 |
| 20      | Amelie Hellfighters |        4.99 |
| 7       | Airplane Sierra     |        4.99 |
| 10      | Aladdin Calendar    |        4.99 |
| 2       | Ace Goldfinger      |        4.99 |
| 8       | Airport Pollock     |        4.99 |
| 98      | Bright Encounters   |        4.99 |
| 133     | Chamber Italian     |        4.99 |
| 384     | Grosse Wonderful    |        4.99 |
| 21      | American Circus     |        4.99 |

(10 rows)


### Cara Kerjanya di Belakang Layar :

- Pertama, PostgreSQL mengurutkan dulu seluruh data film berdasarkan harga sewanya (`rental_rate`) dari yang paling mahal ke paling murah pakai `ORDER BY rental_rate DESC`.
- Kedua, sistem tinggal mengambil 10 baris teratas dari hasil urutan tersebut pakai `LIMIT 10`.

#### **Ringkasan Singkat**  
Gunakan kombinasi klausa `LIMIT` dan `OFFSET` di PostgreSQL saat kamu mau mengambil sebagian/potongan baris data tertentu saja dari hasil kueri kamu.


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# PostgreSQL FETCH 

**Ringkasan** : Di tutorial ini, kamu bakal belajar cara pakai klausa `FETCH` di PostgreSQL buat ngambil sebagian baris data yang dihasilkan oleh kueri.

## **Kenalan sama Klausa `FETCH` di PostgreSQL**  

Biar bisa ngelewatin beberapa baris dan ngambil data dalam jumlah tertentu, kamu pasti udah familiar sama klausa `LIMIT` di dalam perintah `SELECT`.

Klausa `LIMIT` ini emang populer banget dan dipakai di banyak database (RDBMS) kaya MySQL, H2, sama HSQLDB. Tapi perlu kamu tahu, `LIMIT` itu sebenarnya bukan bagian dari standar SQL resmi!

Nah, biar sesuai sama standar SQL internasional, PostgreSQL juga mendukun klausa `FETCH`. Fungsinya persis sama: buat ngelewatin beberapa baris data dulu, terus ngambil sejumlah baris yang kamu butuhin.

Sebagai informasi tambahan, klausa `FETCH` ini pertama kali dikenalkan di standar SQL:2008.

Nih, bentuk penulisan (sintaks) klausa `FETCH` di PostgreSQL:


```sql
OFFSET row_to_skip { ROW | ROWS }
FETCH { FIRST | NEXT } [ row_count ] { ROW | ROWS } ONLY
```

Penjelasan simpel dari sintaks di atas:

- Pertama, tentuin berapa banyak baris yang mau dilewati (`row_to_skip`) di belakang kata kunci `OFFSET`. Angkanya harus nol atau bilangan positif, dan default-nya adalah `0` (artinya nggak ada baris yang dilewati). 
- Kalau misal `row_to_skip` angkanya lebih besar dari total baris yang ada di tabel, ya kuerinya bakal ngasilin data kosong melompong.
- Kedua, tentuin berapa baris yang mau ditarik/diambil (`row_count`) di dalam klausa `FETCH`. Angkanya harus `1` atau lebih besar, dan secara bawaan (default) nilainya adalah 1.
- Kata `ROW` dan `ROWS` itu sama aja (sinonim), begitu juga `FIRST` dan `NEXT`. Kamu bebas mau pakai yang mana aja, hasilnya bakal tetep sama.

**Tips Penting** : Karena PostgreSQL nyimpen baris data tanpa urutan yang pasti, selalu gunakan klausa `ORDER BY` tiap kali kamu pakai `FETCH` biar urutan datanya konsisten dan gak acak-acakan.

**Catatan unik** : Di standar SQL:2008, klausa `OFFSET` harus ditulis sebelum `FETCH`. Tapi di PostgreSQL, urutannya bebas banget—kamu mau tulis `FETCH` duluan baru `OFFSET` juga tetep jalan!

---

## **FETCH vs. LIMIT**  

Secara fungsi, `FETCH` dan `LIMIT` itu 100% kembar identik. Bedanya cuma di "penyesuaian standar". Kalau kamu lagi bikin aplikasi yang pengen mudah dipindahin (kompatibel) ke berbagai jenis database lain, sangat disaranin pakai `FETCH` karena dia ngikutin standar SQL resmi.

## **Contoh Penggunaan `FETCH` di PostgreSQL**  

Biar langsung kebayang, kita bakal coba praktek pakai tabel `film` dari database latihan berikut:

![image](https://github.com/user-attachments/assets/a358c66a-5373-4ead-8b59-58756768f75c)

### 1. Ngambil 1 Data Teratas

Perintah berikut pakai klausa `FETCH` buat ngambil 1 `film` pertama setelah diurutkan berdasarkan judul dari A ke Z (ascending) :

```sql
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
FETCH FIRST ROW ONLY;
```

**Output:**

| film_id |      title       |
|---------|------------------|
| 1       | Academy Dinosaur |

_FYI_, perintah di atas itu sama persis artinya kalau kamu tulis secara lengkap kayak gini :

```sql
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
FETCH FIRST 1 ROW ONLY;
```

### 2. Ngambil Beberapa Data Teratas

Kalau kamu mau ngambil 5 film pertama yang diurutkan berdasarkan judul, kuerinya tinggal diubah dikit jadi gini :

```sql
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
FETCH FIRST 5 ROW ONLY;
```

**Output:**

| film_id |      title        |
|---------|------------------|
| 1       | Academy Dinosaur |
| 2       | Ace Goldfinger   |
| 3       | Adaptation Holes |
| 4       | Affair Prejudice |
| 5       | African Egg      |

### 3. Kombinasi dengan OFFSET (Melompati Data)

Nah, kalau kamu mau ngambil 5 film berikutnya (yaitu urutan ke-6 sampai ke-10) setelah ngelewatin 5 film pertama, kamu tinggal tambahin `OFFSET 5 ROWS` :

```sql
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
OFFSET 5 ROWS
FETCH FIRST 5 ROW ONLY;
```

**Output:**

| film_id |      title        |
|---------|------------------|
| 6       | Agent Truman     |
| 7       | Airplane Sierra  |
| 8       | Airport Pollock  |
| 9       | Alabama Devil    |
| 10      | Aladdin Calendar |

### **Ringkasan**  
Gunakan klausa `FETCH` di PostgreSQL kalau kamu mau melompati sejumlah baris data tertentu lalu menarik sebagian baris saja dari hasil kueri sesuai standar SQL resmi.

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# PostgreSQL IN

## Kenalan sama Operator 'IN' di PostgreSQL 

Bayangin kamu lagi nyari barang di dalam daftar belanjaan. Daripada mengecek barang satu per satu secara terpisah, operator `IN` di PostgreSQL mempermudah kamu untuk mengecek apakah sebuah data cocok dengan salah satu pilihan dari daftar yang kamu buat.

Penulisan dasarnya simpel banget :

```sql
value IN (value1, value2, ...)
```

- Operator `IN` bakal menghasilkan jawaban `TRUE` (benar) kalau data yang dicari (value) cocok sama salah satu isi pilihan di dalam tanda kurung, misalnya `value1` atau `value2`.
- Pilihan di dalam daftar itu bisa berupa **nilai langsung** (_literal value_), seperti angka, kata (string), atau tanggal.
- Nanti saat belajar _Subquery_, kamu juga bakal tahu kalau isi di dalam daftar kurung itu bisa berasal dari hasil kueri pencarian lain.

Secara cara kerja, operator `IN` ini sebenarnya sama persis seperti kamu menulis banyak kondisi `OR` (atau) yang digabung jadi satu:

```sql
value = value1 OR value = value2 OR ...
```


## Contoh Cara Pakai Operator 'IN'

Biar lebih makin kebayang, yuk lihat contoh-contoh praktisnya pakai tabel data latihan di bawah ini!

### 1. Menggunakan 'IN' dengan Daftar Angka

Kita bakal pakai tabel `film` :

![image](https://github.com/user-attachments/assets/882709fd-617d-4b33-8742-cb16cf421d46)

Contoh berikut menggunakan operator `'IN'` untuk mengambil informasi tentang film dengan `'film_id'` 1, 2, dan 3:

```sql
SELECT
  film_id, title
FROM
  film
WHERE
  film_id IN (1, 2, 3);
```

**Output:**

| film_id |      title       |
|---------|------------------|
| 1       | Academy Dinosaur |
| 2       | Ace Goldfinger   |
| 3       | Adaptation Holes |

---

Kalau kamu gak pakai `IN`, kamu harus mengetik kueri panjang yang menggabungkan operator `=` dan `OR` seperti ini :

```sql
SELECT
  film_id, title
FROM
  film
WHERE
  film_id = 1
  OR film_id = 2
  OR film_id = 3;
```

---

#### Keuntungan Pakai Operator `IN` :
- Kode tulisan kamu jadi jauh lebih pendek dan enak dibaca.
- Dari sisi performa, **PostgreSQL memproses kueri dengan `IN` jauh lebih cepat** dibanding harus membaca banyak operator `OR` satu per satu.

### 2. Menggunakan 'IN' dengan Daftar Teks / Kata (String)

Kali ini kita bakal coba pakai tabel `actor` : 

![image](https://github.com/user-attachments/assets/d04c04d6-e365-467b-99e7-88006c0a44a5)
  
Misalkan kamu mau mencari aktor yang nama belakangnya (`last_name`) adalah 'Allen', 'Chase', atau 'Davis':

```sql
SELECT
  first_name, last_name
FROM
  actor
WHERE
  last_name IN ('Allen', 'Chase', 'Davis')
ORDER BY
  last_name;
```

**Output:**  

| first_name | last_name |
|------------|-----------|
| Meryl      | Allen    |
| Cuba       | Allen    |
| Kim        | Allen    |
| Jon        | Chase    |
| Ed         | Chase    |
| Susan      | Davis    |
| Jennifer   | Davis    |
| Susan      | Davis    |

### 3. Menggunakan 'IN' dengan Daftar Tanggal

Di contoh ketiga ini, kita mau mencari data pembayaran dari tabel `payment` yang transaksi pembayarannya terjadi pada tanggal `'2007-02-15'` atau `'2007-02-16'` :

```sql
SELECT
  payment_id, amount, payment_date
FROM
  payment
WHERE
  payment_date::date IN ('2007-02-15', '2007-02-16');
```

**Output:**

| payment_id | amount |        payment_date        |
|------------|--------|---------------------------|
| 17503      |  7.99  | 2007-02-15 22:25:46.996577 |
| 17504      |  1.99  | 2007-02-16 17:23:14.996577 |
| 17505      |  7.99  | 2007-02-16 22:41:45.996577 |
| 17512      |  4.99  | 2007-02-16 00:10:50.996577 |
| ...        |  ...   | ...                        |

Penjelasan Tambahan Soal Tipe Data Waktu (timestamp) :
- Kolom `payment_date` di database itu biasanya bertipe timestamp (artinya berisi paket lengkap: **Tanggal + Jam/Menit/Detik**).
- Supaya jamnya diabaikan dan PostgreSQL cuma mencocokkan tanggalnya aja, kita perlu **mengubah (konversi) format datanya jadi tipe Tanggal (_date_) saja**.
- Caranya yaitu dengan menambahkan operator ubah tipe _data/cast_ berupa tanda `::date` di belakang nama kolom :

```sql
payment_date::date
```

Misal datanya semula berisi `'2007-02-15 22:25:46.996577'`, setelah diberi `::date`, PostgreSQL bakal memotongnya sehingga cuma membaca bagian `'2007-02-15'` saja.

---

## Operator 'NOT IN' (Kebalikan dari 'IN')

Kalau operator `IN` buat nyari yang cocok, operator `NOT IN` dipakai untuk pengecualian (mencari data yang **TIDAK** ada di dalam daftar).

Penulisan dasarnya :

```sql
value NOT IN (value1, value2, ...)
```

- Operator `NOT IN` akan menghasilkan `TRUE` (benar) kalau data (`value`) TIDAK sama dengan semua daftar pilihan di dalam kurung. Tapi kalau datanya ada yang cocok satu aja, dia bakal bernilai FALSE (salah).
- Sama kaya sebelumnya, secara cara kerja operator `NOT IN` ini merupakan gabungan dari kondisi tidak sama dengan (`<>`) yang dihubungkan dengan operator `AND` :

```sql
value <> value1 AND value <> value2 AND ...
```

---

## Contoh Penggunaan Operator 'NOT IN'

Misalkan kamu mau menampilkan semua data film yang ID-nya **BUKAN** `1`, `2`, atau `3`:

```sql
SELECT
  film_id, title
FROM
  film
WHERE
  film_id NOT IN (1, 2, 3)
ORDER BY
  film_id;
```

**Output:**


| film_id |            title           |
|---------|----------------------------|
| 4       | Affair Prejudice           |
| 5       | African Egg                |
| 6       | Agent Truman               |
| 7       | Airplane Sierra            |
| 8       | Airport Pollock            |
| ...     | ...                        |

---

Kueri di atas kalau ditulis pakai operator tidak sama dengan (`<>`) dan gabungan `AND` hasilnya bakal sama persis seperti ini :

```sql
SELECT
  film_id, title
FROM
  film
WHERE
  film_id <> 1
  AND film_id <> 2
  AND film_id <> 3
ORDER BY
  film_id;
```

---

### **Ringkasan**  
- Pakai operator `IN` kalau kamu mau menyaring data yang cocok dengan salah satu isi pilihan di dalam daftar.
- Pakai operator `NOT IN` kalau kamu mau menyaring data yang **TIDAK** boleh sama dengan semua pilihan yang ada di dalam daftar (pengecualian).

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# **PostgreSQL BETWEEN**  

## **Kenalan sama Operator '`BETWEEN`' di PostgreSQL**  

Bayangin kamu lagi menyaring data berdasarkan batas bawah dan batas atas. Nah, operator `BETWEEN` di PostgreSQL dipakai buat **memeriksa apakah suatu nilai berada di dalam rentang tertentu** (di antara nilai A dan nilai B).

Bentuk penulisan dasarnya simpel banget :

```sql
value BETWEEN low AND high;
```

- Operator `BETWEEN` bakal menghasilkan nilai **`TRUE` (benar)** kalau data (`value`) **lebih besar atau sama dengan** `low` DAN **lebih kecil atau sama dengan** `high`. Kalau di luar rentang itu, dia bakal mengembalikan nilai **`FALSE` (salah)**.
- **Penting** : Operator `BETWEEN` itu sifatnya _inclusive_ (termasuk). Artinya, nilai batas `low` dan `high`-nya sendiri **ikut dihitung** dalam pencarian.

Secara cara kerja, kamu juga bisa menulis kueri ini pakai kombinasi operator `>=` (lebih besar atau sama dengan), `<=` (lebih kecil atau sama dengan), dan operator `AND` :

```sql
value >= low AND value <= high;
```

### Operator '`NOT BETWEEN`' (Mencari di Luar Rentang)

Kalau kamu mau mencari data yang **berada di luar rentang** (di bawah nilai `low` atau di atas nilai `high`), kamu tinggal tambahin kata `NOT` :

```sql
value NOT BETWEEN low AND high;
```

Penulisan di atas sama persis fungsinya dengan gabungan operator kurang dari (`<`) dan lebih dari (`>`) yang dihubungkan dengan operator `OR` :

```sql
value < low OR value > high;
```

Dalam praktik sehari-hari, operator `BETWEEN` ini sering banget dipakai di dalam klausa `WHERE` pada perintah `SELECT`, `INSERT`, `UPDATE`, maupun `DELETE`).

## Contoh Penggunaan Operator '`BETWEEN`' 

Yuk, langsung kita bedah contoh-contoh praktisnya menggunakan tabel `payment` dari database contoh!

<img width="195" height="165" alt="image" src="https://github.com/user-attachments/assets/b64fdde5-f0f3-46d8-a69e-8a09fa7941ef" />

### 1. Menggunakan 'BETWEEN' dengan Angka

Misalkan kamu mau mengambil data pembayaran yang `ID` pembayarannya (`payment_id`) berada di antara angka **`17503` sampai `17505`** :

```sql
SELECT
  payment_id, amount
FROM
  payment
WHERE
  payment_id
      BETWEEN 17503 AND 17505
ORDER BY
  payment_id;
```

**Output:**

| payment_id | amount |
|------------|--------|
| 17503      |  7.99  |
| 17504      |  1.99  |
| 17505      |  7.99  |

Perhatikan bahwa angka batas 17503 dan 17505-nya tetap ikut tampil di dalam hasil.

## 2. Contoh Penggunaan PostgreSQL 'NOT BETWEEN'

Sebaliknya, kalau kamu mau mencari data pembayaran yang ID-nya **TIDAK berada** di antara angka `17503` dan `17505` :

```sql
SELECT
  payment_id, amount
FROM
  payment
WHERE
  payment_id
      NOT BETWEEN 17503 AND 17505
ORDER BY
  payment_id;
```

**Output:**


| payment_id | amount |
|------------|--------|
| 17506      |  2.99  |
| 17507      |  7.99  |
| 17508      |  5.99  |
| 17509      |  5.99  |
| 17510      |  5.99  |
| ...        |  ...   |

## 3. Menggunakan '`BETWEEN`' dengan Rentang Tanggal

Gimana kalau mau menyaring berdasarkan rentang tanggal? Gunakan penulisan tanggal berformat standar internasional **ISO 8601**, yaitu '`YYYY-MM-DD`' (Tahun-Bulan-Tanggal).

Contohnya, kueri di bawah ini dipakai buat mencari transaksi pembayaran dari tanggal '`2007-02-15`' **sampai** '`2007-02-20`' yang nominal pembayarannya (`amount`) **lebih dari 10** :

```sql
SELECT
  customer_id, payment_id, amount, payment_date
FROM
  payment
WHERE
  payment_date
      BETWEEN '2007-02-15' AND '2007-02-20'
  AND
      amount > 10
ORDER BY
  payment_date;
```

**Output:**  

| customer_id | payment_id | amount |        payment_date        |
|-------------|------------|--------|----------------------------|
| 33         | 18640      | 10.99  | 2007-02-15 08:14:59.996577 |
| 544        | 18272      | 10.99  | 2007-02-15 16:59:12.996577 |
| 516        | 18175      | 10.99  | 2007-02-16 13:20:28.996577 |
| 572        | 18367      | 10.99  | 2007-02-17 02:33:38.996577 |
| 260        | 19481      | 10.99  | 2007-02-17 16:37:30.996577 |
| 477        | 18035      | 10.99  | 2007-02-18 07:01:49.996577 |
| 221        | 19336      | 10.99  | 2007-02-19 09:18:28.996577 |

Tips Penjelas Soal Tipe Data Tanggal & Jam (timestamp) :
- Saat menuliskan `'2007-02-20'`, PostgreSQL secara otomatis menganggapnya sebagai jam 00:00:00 di awal hari tersebut (`'2007-02-20 00:00:00'`).
- Jadi kalau kolom `payment_date` berisi jam/menit (seperti contoh di atas), data di tanggal 20 Februari setelah jam 00:00:00 tidak akan ikut masuk kecuali di-cast atau disesuaikan rentang jamnya.

### Ringkasan
- Gunakan operator `BETWEEN` untuk mengecek apakah suatu data ada di dalam rentang batas minimal dan batas maksimal.
- Gunakan operator `NOT BETWEEN` kalau kamu mau mengambil data yang berada di luar rentang tersebut.

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


# PostgreSQL LIKE

## Kenalan sama Operator 'LIKE' di PostgreSQL

Bayangin kamu lagi nyari nama pelanggan, tapi **lupa nama lengkap pastinya.** Kamu cuma ingat kalau **nama depannya diawali dengan kata `'Jen'`**.

Gimana cara nyarinya di dalam _database?_

Kalau kamu mengecek kolom `first_name` di tabel `customer` satu per satu manual, jelas **bakal memakan waktu lama banget**, apalagi kalau data pelanggannya ada ribuan baris. 

Untungnya, PostgreSQL punya operator `LIKE` yang fleksibel banget buat mencari data berdasarkan **pola tertentu** (_pattern matching_). Contohnya seperti kueri berikut :

```sql
SELECT
  first_name, last_name
FROM
  customer
WHERE
  first_name LIKE 'Jen%';
```

Output :

| first_name | last_name |
|------------|-----------|
| Jennifer   | Davis     |
| Jennie     | Terry     |
| Jenny      | Castro    |

Coba perhatikan bagian perintah `WHERE` di atas :

```sql
first_name LIKE 'Jen%'
```
Bagian ini terdiri dari :
- Kolom `first_name` (data yang mau dicari),
- Operator `LIKE` dan
- Teks pola `'Jen%'` (disebut _pattern_).
Maksud dari pola `'Jen%'` adalah : _"Cari nama yang **diawali dengan `'Jen'`**, dan setelahnya **bebas mau diikuti oleh huruf/karakter apa saja.**_"

Kueri ini akan **mengembalikan baris** di mana nilai dalam kolom `'first_name'` **dimulai dengan `'Jen'`**, diikuti oleh **karakter apa pun**. Teknik ini dikenal sebagai **pattern matching**.

## Simbol Sakti (Wildcard) dalam PostgreSQL 'LIKE'

Untuk membuat pola pencarian, kamu bisa menggabungkan teks biasa dengan **karakter khusus yang dinamakan _Wildcard._**

PostgreSQL menyediakan **dua karakter wildcard utama** :  

- **Tanda Persen (`%`)** > Mewakili **banyak karakter sekaligus** (bisa berupa sekumpulan huruf, satu huruf, atau bahkan tidak ada huruf sama sekali).
- **Tanda Garis Bawah / Underscore (`_`)** > Mewakili **tepat satu karakter tunggal saja.**

Bentuk penulisan dasarnya :

```sql
value LIKE pattern
```

- Operator `LIKE` bakal menghasilkan **`TRUE` (benar)** kalau nilai data cocok sama pola yang kamu buat.
- Sebaliknya, kalau kamu mau mencari data yang **TIDAK cocok** sama pola tersebut, tinggal tambahkan kata `NOT` :

```sql
value NOT LIKE pattern
```

>> **Catatan Penting** : _Kalau pola yang kamu tulis sama sekali **tidak pakai karakter wildcard (`%` atau `_`)**, maka operator `LIKE` bakal bekerja **sama persis seperti operator sama dengan** (`=`)_.


## Contoh-Contoh Penggunaan Operator 'LIKE'

### 1. Contoh Dasar Operator 'LIKE'

Perhatikan contoh sederhana tanpa tabel ini :

```sql
SELECT 'Apple' LIKE 'Apple' AS result;
```

**Output:**

| result |
|--------|
| t      |

_(Keterangan : `t` artinya **True / Benar**. Kueri di atas bernilai benar karena string `'Apple'` sama persis dengan `'Apple'`, persis seperti penggunaan operator `=`)._

Sekarang kita coba tambahkan wildcard `%` :

```sql
SELECT 'Apple' LIKE 'A%' AS result;
```

Output :

| result |
|--------|
| t      |

Hasilnya tetap **True** (`t`) karena kata 'Apple' **diawali dengan huruf 'A'.**


### 2. Menggunakan Operator 'LIKE' pada Data Tabel

Kita bakal pakai tabel `customer` sebagai contoh :

![image](https://github.com/user-attachments/assets/4d0b5c18-20d4-4e63-9f22-4a0e600ee733)

### Mencari Nama Depan yang Mengandung Teks `'er'` 

Misalkan kamu mau mencari semua pelanggan yang nama depannya **memiliki selipan huruf `'er'`** (mau di depan, di tengah, atau di belakang) :

```sql
SELECT
  first_name, last_name
FROM
  customer
WHERE
  first_name LIKE '%er%'
ORDER BY
  first_name;
```

Output :

| first_name  | last_name |
|-------------|-----------|
| Albert      | Crouse    |
| Alberto     | Henning   |
| Alexander   | Fennell   |
| Amber       | Dixon     |
| Bernard     | Colby     |
| ...         | ...       | 

_(Tanda `%er%` artinya: sebelum teks `'er'` bebas ada karakter apa saja, dan setelah teks `'er'` juga bebas ada karakter apa saja)._

### 3. Menggabungkan Wildcard `%` dan `_`

Kamu juga bisa menggabungkan wildcard `%` (banyak karakter) dan `_` (satu karakter) sekaligus dalam satu pola :

```sql
SELECT
  first_name, last_name
FROM
  customer
WHERE
  first_name LIKE '_her%'
ORDER BY
  first_name;
```

**Output:**  

| first_name | last_name |
|------------|-----------|
| Cheryl     | Murphy    |
| Sherri     | Rhodes    |
| Sherry     | Marshall  |
| Theresa    | Watson    |

Pola `'_her%'` ini cara bacanya gini :

- **`_` (Underscore pertama)** : Huruf ke-1 bebas huruf apa saja (misal: `'C'`, `'S'`, `'T'`).  
- `her` : Huruf ke-2, 3, dan 4 **WAJIB** bertuliskan `'her'`. 
- `%` : Huruf ke-5 dan seterusnya bebas berapa karakter saja.


### 4. Contoh Penggunaan 'NOT LIKE' (Pengecualian)

Kueri di bawah ini dipakai buat mencari data pelanggan yang nama depannya **TIDAK diawali dengan kata `'Jen'`** :

```sql
SELECT
  first_name, last_name
FROM
  customer
WHERE
  first_name NOT LIKE 'Jen%'
ORDER BY
  first_name;
```

Output :

| first_name  | last_name |
|-------------|-----------|
| Aaron       | Selby     |
| Adam        | Gooch     |
| Adrian      | Clary     | 
| Agnes       | Bishop    |
| ...         | ...       |

---

## Fitur Spesial PostgreSQL: Operator 'ILIKE' (Case-Insensitive)

Secara _default_, operator `LIKE` itu **sensitif terhadap huruf besar/kecil** (_Case-Sensitive_). Artinya `'BAR%'` tidak akan cocok dengan `'Barbara'`. 

Nah, PostgreSQL punya fitur keren bernama `ILIKE` (_i = Insensitive_). Operator ini bakal **mengabaikan beda huruf besar dan kecil!**

Contohnya, kamu mau nyari nama yang diawali huruf `'BAR'` (pake huruf kapital semua) : 

```sql
SELECT
  first_name, last_name
FROM
  customer
WHERE
  first_name ILIKE 'BAR%';
```

Output:

| first_name | last_name |
|------------|----------|
| Barbara    | Jones    |
| Barry      | Lovelace |

Meskipun di database tulisan namanya `'Barbara'` (kapital cuma di depan), operator `ILIKE` tetap bisa menemukannya!

Bandingkan kalau kamu cuma memakai `LIKE` biasa: :

```sql
SELECT
  first_name, last_name
FROM
  customer
WHERE
  first_name LIKE 'BAR%';
```

Output :

| first_name | last_name |
|------------|-----------|
| (0 rows)   |           |

(Hasilnya kosong/0 rows karena `LIKE` menganggap `'BAR'` beda dengan `'Bar'`).

## Simbol Singkat Alternatif untuk 'LIKE'

PostgreSQL menyediakan simbol singkat (_shorthand_) buat menggantikan tulisan operator `LIKE` dan kawan-kawannya :

| **Simbol Singkat** | **Sama Dengan Operator** | **Fungsi**                                      |
|--------------------|--------------------------|-------------------------------------------------|
| `~~`               | LIKE                     | Mencari pola (Sensitif huruf besar/kecil)       |
| `~~*`              | ILIKE                    | Mencari pola (TIDAK sensitif huruf besar/kecil) | 
| `!~~`              | NOT LIKE                 | Mencari yang TIDAK cocok dengan pola            |
| `!~~*`             | NOT ILIKE                | Mencari yang TIDAK cocok (TIDAK sensitif huruf) |

Contoh penggunaan simbol `~~` (menggantikan `LIKE`) :

```sql
SELECT
  first_name, last_name
FROM
  customer
WHERE
  first_name ~~ 'Dar%'
ORDER BY
  first_name;
```

Output:

| first_name | last_name |
|------------|-----------|
| Darlene    | Rose      |
| Darrell    | Power     |
| Darren     | Windham   | 
| Darryl     | Ashcraft  |
| Daryl      | Larue     |

## PostgreSQL 'LIKE' dengan Opsi 'ESCAPE'

Terkadang, data yang mau kamu cari di dalam database memang benar-benar mengandung simbol `%` atau `_` asli. 

Contoh kalimat di _database_ :

1. `"The rents are now 10% higher than last month"` _(Ada simbol `%` asli)_
2. `"The new film will have _ in the title"` _(Ada simbol _ asli)_

Gimana caranya nyari angka `'10%'` tanpa bikin PostgreSQL bingung dan menganggap `%` sebagai wildcard?

Jawabannya : Gunakan opsi `ESCAPE`!

```sql
string LIKE pattern ESCAPE escape_character;
```

### Mari Buat Tabel Latihan Dulu:

```sql
CREATE TABLE t(
   message text
);

INSERT INTO t(message)
VALUES('The rents are now 10% higher than last month'),
      ('The new film will have _ in the title');

SELECT message FROM t;
```

---

Output Tabel `t` :

| message                                      |
|----------------------------------------------|
| The rents are now 10% higher than last month |
| The new film will have _ in the title        |


### Cara Pakai 'ESCAPE' buat Nyari Simbol `%` Asli:

Kita tentukan satu karakter bebas (misalnya tanda dollar `$`) sebagai karakter penyelamat (_escape character_). Karakter wildcard yang berada tepat di belakang tanda `$` bakal dianggap sebagai **teks biasa**, bukan simbol wildcard lagi.

```sql
SELECT * FROM t
WHERE message LIKE '%10$%%' ESCAPE '$';
```

---

Output :

| message                                      |
|----------------------------------------------|
| The rents are now 10% higher than last month |

Bedah Pola `'%10$%%'` :
- `%` pertama = Wildcard (sebelum angka 10 bebas teks apa aja).
- `10` = Teks angka 10.
- `$%` = Karena ada tanda `$`, maka simbol `%` ini **dianggap karakter persen biasa**, bukan wildcard!
- `%` terakhir = Wildcard (setelah tanda persen bebas teks apa aja).


#### Ringkasan
- Gunakan operator `'LIKE'` untuk mencari data sesuai pola tertentu.
- Gunakan operator `'NOT LIKE'` untuk mencari data yang **TIDAK** cocok dengan pola. 
- Wildcard `'%`' dipakai buat mencocokkan **banyak karakter** (0 atau lebih). 
- Wildcard `'_'` dipakai buat mencocokkan **tepat 1 karakter**. 
- Gunakan `'ESCAPE'` kalau mau pencocokan pola yang **tidak peduli huruf besar/kecil**.
- Gunakan operator `'ILIKE'` untuk **pencocokan tanpa peka huruf besar/kecil**.


---
---
---

# PostgreSQL IS NULL

## Pengantar tentang NULL

Di dalam database, NULL itu artinya data yang hilang, belum diisi, atau emang gak berlaku. Yang paling penting dan sering bikin keliru: NULL itu bukan sebuah nilai atau angka nol. Jadi, kamu gak bisa membandingkan NULL pakai tanda sama dengan (`=`) atau tidak sama dengan (`<>`).

Kalau kamu nekat ngebandingin NULL sama nilai lain (atau bahkan NULL sama NULL), hasilnya bakalan tetep NULL alias gak jelas. 

Coba aja kamu jalani query ini:

```sql
SELECT null = null AS result;
```

Output-nya bakalan kayak gini :

| result |
|--------|
| null   |

Total row: 1

## Operator IS NULL dan IS NOT NULL

Nah, karena tanda `=` sama `<>` gak bakal mempan buat ngecek NULL, PostgreSQL nyediain operator khusus, yaitu IS NULL dan IS NOT NULL.

### Operator IS NULL

Sintaks dasarnya simpel banget :

```sql
value IS NULL
```

Perintah IS NULL ini bakal ngehasilin true kalau datanya emang NULL, dan false kalau datanya ada isinya.


### Operator IS NOT NULL

Kalau mau balikannya, tinggal tambahin NOT :

```sql
value IS NOT NULL
```

Perintah IS NOT NULL bakal ngehasilin true kalau datanya terisi (gak NULL), dan false kalau datanya ternyata NULL.

Catatan Penting Lain Soal NULL :
- Kalau mau ngatur urutan data NULL pas dipanggil, kamu bisa cek materi ORDER BY. Di situ ada opsi NULLS FIRST atau NULLS LAST.
- PostgreSQL juga punya fungsi-fungsi keren buat ngakalin NULL, contohnya kaya COALESCE, NULLIF, sama ISNULL.
- Biar sebuah kolom gak bisa diinput data kosong sama sekali, kamu bisa pasang aturan NOT NULL pas bikin struktur tabelnya.

## Contoh penggunaan operator PostgreSQL IS NULL

Buat latihan, kita pakai contoh dari skema tabel `address` ini :

![image](https://github.com/user-attachments/assets/8d21a191-174a-43fc-b391-f4a2e3ad138f)

Fyi, tampilan bawaan psql di terminal itu biasanya nampilin NULL sebagai teks kosong biasa. Biar kamu gak bingung bedain mana NULL mana teks kosong, mending ketik perintah ini dulu di terminal :

```bash
\pset null null
```

Perintah ini ngebantu banget karena bakal nampilin tulisan null secara jelas pas nemu data yang NULL. 

---

### 1) Contoh Dasar Penggunaan Operator IS NULL

Query di bawah ini dipakai buat nyari data alamat di tabel address yang kolom address2-nya bernilai NULL :

```sql
SELECT
  address,
  address2
FROM
  address
WHERE
  address2 IS NULL;
```

Output:

| address              | address2 |
|----------------------|----------|
| 47 MySakila Drive    | null     |
| 28 MySQL Boulevard   | null     |
| 23 Workhaven Lane    | null     |
| 1411 Lillydale Drive | null     |

Total row: 4

### 2) Contoh Penggunaan Operator IS NOT NULL

Nah kalau query ini dipakai buat ngambil data alamat yang kolom address2-nya ada isinya (alias bukan NULL) :

```sql
SELECT
  address,
  address2
FROM
  address
WHERE
  address2 IS NOT NULL;
```

Output:

| address               | address2 |
|-----------------------|----------|
| 1913 Hanoi Way        |          |
| 1121 Loja Avenue      |          |
| 692 Joliet Street     |          |
| 1566 Inegl Manor      |          |

Total row: 4

Coba perhatiin deh, kolom address2 di atas kelihatan blong atau kosong, bukan tulisan null. Ini artinya data itu disimpannya sebagai string kosong (`""`), bukan NULL. Nyampur string kosong sama NULL di kolom yang sama kayak gini tergolong bad practice, karena ntar bisa bikin pusing pas lagi olah data.

#### Ringkasan
- Di database, NULL itu nandain data yang hilang atau belum ada isinya.
- Pakai IS NULL kalau mau ngecek data yang bernilai NULL.
- Pakai IS NOT NULL kalau mau nyari data yang gak NULL alias ada isinya.

---
