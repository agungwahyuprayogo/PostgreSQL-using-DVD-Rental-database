# Panduan PostgreSQL Filtering Data

## Daftar Isi
- [PostgreSQL WHERE](#postgresql-where)
- [PostgreSQL AND Operator](#postgresql-and-operator)
- [PostgreSQL OR Operator](#postgresql-or-operator)
- [PostgreSQL LIMIT](#postgresql-limit)
- [PostgreSQL FETCH](#postgresql-fetch)

# PostgreSQL WHERE

## Introduction to PostgreSQL WHERE clause
Pernyataan `SELECT` mengembalikan semua baris dari satu atau lebih kolom dalam sebuah tabel. Untuk mengambil baris yang memenuhi kondisi tertentu, kamu menggunakan klausa `WHERE`.

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

Dalam sintaks ini, klausa `WHERE` ditempatkan tepat setelah klausa `FROM` dari pernyataan `SELECT`.

Klausa `WHERE` menggunakan `kondisi` untuk memfilter baris yang dikembalikan dari klausa `SELECT`.

`kondisi` adalah ekspresi boolean yang mengevaluasi ke true, false, atau unknown.

Query hanya mengembalikan baris yang memenuhi `kondisi` dalam klausa `WHERE`. Dengan kata lain, query hanya akan menyertakan baris yang menyebabkan `kondisi` dievaluasi menjadi true dalam hasil.

PostgreSQL mengevaluasi klausa `WHERE` setelah klausa `FROM` tetapi sebelum klausa `SELECT` dan `ORDER BY`.

Jika kamu menggunakan alias kolom dalam klausa `SELECT`, kamu tidak dapat menggunakannya dalam klausa `WHERE`.

Selain pernyataan `SELECT`, kamu juga bisa menggunakan klausa `WHERE` dalam pernyataan `UPDATE` dan `DELETE` untuk menentukan baris yang akan diupdate dan dihapus.

Untuk membentuk kondisi dalam klausa `WHERE`, kamu menggunakan operator perbandingan dan logis:

| Operator | Deskripsi |
|----------|----------|
| = | Sama dengan |
| > | Lebih besar dari |
| < | Lebih kecil dari |
| >= | Lebih besar atau sama dengan |
| <= | Lebih kecil atau sama dengan |
| <> atau != | Tidak sama dengan |
| AND | Operator Logika AND |
| OR | Operator Logika OR |
| IN | Mengembalikan true jika nilai cocok dengan salah satu nilai dalam daftar |
| BEETWEEN | Mengembalikan true jika nilai berada di antara rentang nilai |
| LIKE | Mengembalikan true jika nilai cocok dengan pola |
| IS NULL | Mengembalikan true jika nilai adalah NULL |
| NOT | Menegasikan hasil dari operator lain |

## Contoh Klausa PostgreSQL WHERE 
Mari kita berlatih dengan beberapa contoh penggunaan klausa `WHERE`.

Kita akan menggunakan tabel customer dari database contoh untuk demonstrasi.

### 1)  Menggunakan klausa WHERE dengan contoh operator sama dengan (=)
Pernyataan berikut menggunakan klausa `WHERE` untuk mencari pelanggan yang nama depannya adalah `Jamie`:

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

### 2) Menggunakan klausa WHERE dengan contoh operator AND
Contoh berikut menggunakan klausa `WHERE` dengan operator logika `AND` untuk mencari pelanggan yang nama depan dan nama belakangnya adalah `Jamie` dan `Rice`:

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

### 3) Menggunakan klausa WHERE dengan contoh operator OR
Contoh berikut menggunakan klausa `WHERE` dengan operator `OR` untuk mencari pelanggan yang nama belakangnya adalah `Rodriguez` atau nama depannya adalah `Adam`:

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

### 4) Menggunakan klausa WHERE dengan contoh operator IN
Jika kamu ingin menemukan nilai dalam daftar nilai, kamu bisa menggunakan operator `IN`.

Contoh berikut menggunakan klausa `WHERE` dengan operator `IN` untuk mencari pelanggan dengan nama depan dalam daftar `Ann`, `Anne`, dan `Annie`:

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

### 5) Menggunakan klausa WHERE dengan contoh operator LIKE
Untuk menemukan string yang cocok dengan pola tertentu, kamu menggunakan operator `LIKE`.

Contoh berikut menggunakan operator `LIKE` dalam klausa `WHERE` untuk menemukan pelanggan yang nama depannya dimulai dengan kata `Ann..`:

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

(5 rows)


`%` disebut wildcard yang cocok dengan string apa pun. Pola `'Ann%'` cocok dengan string apa pun yang dimulai dengan `'Ann'`.

### 6) Menggunakan klausa WHERE dengan contoh operator BETWEEN
Contoh berikut menemukan pelanggan yang nama depannya dimulai dengan huruf `A` dan terdiri dari 3 hingga 5 karakter dengan menggunakan operator `BETWEEN`.

Operator `BETWEEN` mengembalikan true jika nilai berada dalam rentang nilai.

```sql
SELECT
  first_name,
  LENGTH(first_name) name_length
FROM
  customer
WHERE
  first_name LIKE 'A%'
  AND LENGTH(first_name) BETWEEN 3
  AND 5
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

Dalam contoh ini, kita menggunakan fungsi `LENGTH()` untuk mendapatkan jumlah karakter dari string input.

### 7) Menggunakan klausa WHERE dengan contoh operator tidak sama dengan (<>)
Contoh ini menemukan pelanggan yang nama depannya dimulai dengan `Bra` dan nama belakangnya bukan `Motley`:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'Bra%'
  AND last_name <> 'Motley';
```

Output:

| first_name | last_name |
|------------|-----------|
| Brandy     | Graves    |
| Brandon    | Huey      |
| Brad       | Mccurdy   |


Perlu dicatat bahwa kamu bisa menggunakan operator `!=` dan operator `<>` secara bergantian karena mereka setara.

#### Summary
- Gunakan klausa `WHERE` dalam pernyataan `SELECT` untuk memfilter baris dari query berdasarkan satu atau lebih kondisi.

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# PostgreSQL AND Operator

**Ringkasan**: Dalam tutorial ini, kamu akan belajar tentang operator logika `AND` di PostgreSQL dan cara menggunakannya untuk menggabungkan beberapa ekspresi boolean.

## Introduction to the PostgreSQL AND operator
Dalam PostgreSQL, nilai boolean bisa memiliki salah satu dari tiga nilai: `true`, `false`, dan `null`.

PostgreSQL menggunakan `true`, `'t'`, `'true'`, `'y'`, `'yes'`, `'1'` untuk merepresentasikan nilai true 

dan `false`, `'f'`, `'false'`, `'n'`, `'no'`, dan `'0'` untuk merepresentasikan nilai false.

Ekspresi boolean adalah ekspresi yang dievaluasi menjadi nilai boolean. Misalnya, ekspresi `1=1` adalah ekspresi boolean yang dievaluasi menjadi `true`:

```sql
SELECT 1 = 1 AS result;
```

Output :

```
result
--------
 t
(1 row)
```

Huruf `t` dalam output menunjukkan nilai `true`.

Operator `AND` adalah operator logika yang menggabungkan dua ekspresi boolean.

Berikut sintaks dasar dari operator `AND`:

```sql
expression1 AND expression2
```

Dalam sintaks ini, `expression1` dan `expression2` adalah ekspresi boolean yang dievaluasi menjadi `true`, `false`, atau `null`.

Operator `AND` mengembalikan `true` hanya jika kedua ekspresi bernilai `true`. Mengembalikan `false` jika salah satu ekspresi bernilai `false`. Selain itu, mengembalikan `null`.

Tabel berikut menunjukkan hasil dari operator `AND` saat menggabungkan `true`, `false`, dan `null`.

| **AND**   | **TRUE** | **FALSE** | **NULL** |
|-----------|----------|-----------|----------|
| **TRUE**  | True | False | Null  |
| **FALSE** | False | False | False |
| **NULL**  | Null | False | Null  |

Dalam praktiknya, kamu sering menggunakan operator `AND` dalam klausa `WHERE` untuk memastikan bahwa semua ekspresi yang ditentukan harus bernilai true agar sebuah baris dimasukkan dalam set hasil.

## PostgreSQL AND operator
Mari kita jelajahi beberapa contoh penggunaan operator `AND`.

### 1) Contoh dasar penggunaan operator PostgreSQL AND
Contoh berikut menggunakan operator `AND` untuk menggabungkan dua nilai true, yang mengembalikan `true`:

```sql
SELECT true AND true AS result;
```

Output:

```
result
--------
 t
(1 row)
```

Pernyataan berikut menggunakan operator `AND` untuk menggabungkan `true` dengan `false`, yang mengembalikan `false`:

```sql
SELECT true AND false AS result;
```

Output:

```
result
--------
 f
(1 row)
```

Contoh berikut menggunakan operator `AND` untuk menggabungkan true dengan `null`, yang mengembalikan `null`:

```sql
SELECT true AND null AS result;
```

Output:

```
result
--------
 null
(1 row)
```

Contoh berikut menggunakan operator `AND` untuk menggabungkan `false` dengan `false`, yang mengembalikan `false`:

```sql
SELECT false AND false AS result;
```

Output:

```
result
--------
 f
(1 row)
```

Contoh berikut menggunakan operator `AND` untuk menggabungkan `false` dengan `null`, yang mengembalikan `false`:

```sql
SELECT false AND null AS result;
```

Output:

```
result
--------
 f
(1 row)
```

Contoh berikut menggunakan operator `AND` untuk menggabungkan `null` dengan `null`, yang mengembalikan `null`:

```sql
SELECT null AND null AS result;
```

Output:

```
result
--------
 null
(1 row)
```

### 2) Menggunakan operator AND dalam klausa WHERE
Kita akan menggunakan tabel `film` dari database contoh untuk demonstrasi:

![image](https://github.com/user-attachments/assets/cfef6559-d850-48d8-879c-f7e65198d5a2)

Contoh berikut menggunakan operator `AND` dalam klausa `WHERE` untuk mencari film yang durasinya lebih dari 180 menit dan tarif sewanya kurang dari 1:

```sql
SELECT
  title,
  length,
  rental_rate
FROM
  film
WHERE
  length > 180
  AND rental_rate < 1;
```

Output:


| title              | length | rental_rate |
|--------------------|--------|-------------|
| Catch Amistad      |    183 |        0.   |
| Haunting Pianist   |    181 |        0.   |
| Intrigue Worst     |    181 |        0.99 |
| Love Suicides      |    181 |        0.99 |
| Runaway Tenenbaums |    181 |        0.99 |
| Smoochy Control    |    184 |        0.99 |
| Sorority Queen     |    184 |        0.99 |
| Theory Mermaid     |    184 |        0.99 |
| Wild Apollo        |    181 |        0.99 |
| Young Language     |    183 |        0.99 |


### Summary
- Gunakan operator `AND` untuk menggabungkan beberapa ekspresi boolean.


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# PostgreSQL OR Operator

## Introduction to the PostgreSQL OR operator

Operator `OR` adalah operator logika yang menggabungkan beberapa ekspresi boolean. Berikut adalah sintaks dasar operator `OR`:

```sql
expression1 OR expression2
```

Dalam sintaks ini, `expression1` dan `expression2` adalah ekspresi boolean yang mengevaluasi `true`, `false`, atau `null`.

Operator `OR` mengembalikan `true` hanya jika salah satu ekspresi adalah `true`. Ini mengembalikan `false` jika kedua ekspresi adalah `false`. Jika tidak, ini mengembalikan `null`.

Tabel berikut menunjukkan hasil operator `OR` saat menggabungkan `true`, `false`, dan `null`.

| **OR** | **True** | **False** | **Null** |
|------|------|-------|------|
| **True** | True | True  | True |
| **False** | True | False | Null |
| **Null** | True | Null  | Null |

Dalam praktiknya, Anda biasanya menggunakan operator `OR` di klausa `WHERE` untuk memastikan bahwa salah satu dari ekspresi yang ditentukan harus `true` agar baris dimasukkan dalam hasil.

## PostgreSQL OR operator
Mari kita lihat beberapa contoh penggunaan operator `OR`.

### 1) Contoh dasar operator PostgreSQL OR
Contoh berikut menggunakan operator `OR` untuk menggabungkan `true dengan true`, yang mengembalikan `true`:

```sql
SELECT true OR true AS result;
```

Keluaran:

```
result
--------
 t
(1 row)
```

Pernyataan berikut menggunakan operator `OR` untuk menggabungkan `true dengan false`, yang mengembalikan `true`:

```sql
SELECT true OR false AS result;
```

Keluaran:

```
result
--------
 t
(1 row)
```

Contoh berikut menggunakan operator `OR` untuk menggabungkan `true dengan null`, yang mengembalikan `true`:

```sql
SELECT true OR null AS result;
```

Keluaran:

```
result
--------
 t
(1 row)
```

Contoh berikut menggunakan operator `OR` untuk menggabungkan `false dengan false`, yang mengembalikan `false`:

```sql
SELECT false OR false AS result;
```

Keluaran:

```
result
--------
 f
(1 row)
```

Contoh berikut menggunakan operator `OR` untuk `menggabungkan false dengan null`, yang mengembalikan `null`:

```sql
SELECT false OR null AS result;
```

Keluaran:

```
result
--------
 null
(1 row)
```

Contoh berikut menggunakan operator `OR` untuk `menggabungkan null dengan null`, yang mengembalikan `null`:

```
SELECT null OR null AS result;
```

Keluaran:

```
result
--------
 null
(1 row)
```

### 2) Menggunakan operator OR dalam klausa WHERE
Kita akan menggunakan tabel `film` dari basis data contoh untuk demonstrasi:

![image](https://github.com/user-attachments/assets/e8f25316-623d-4f23-aba7-ef0229accaba)

Contoh berikut menggunakan operator `OR` dalam klausa `WHERE` untuk menemukan film-film yang memiliki tarif sewa `0.99` atau `2.99`:

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

Keluaran:


| title            | rental_rate |
|------------------|-------------|
| Academy Dinosaur |        0.99 |
| Adaptation Holes |        2.99 |
| Affair Prejudice |        2.99 |
| African Egg      |        2.99 |


#### Summary
- Gunakan operator `OR` untuk menggabungkan beberapa ekspresi boolean.

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# PostgreSQL LIMIT

## Pengenalan Klausa PostgreSQL 'LIMIT'  
PostgreSQL `'LIMIT'` adalah klausa opsional dalam pernyataan `'SELECT'` yang membatasi jumlah baris yang dikembalikan oleh kueri.

Berikut adalah sintaks dasar dari klausa `'LIMIT'`:

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

Pernyataan ini mengembalikan `row_count` baris yang dihasilkan oleh kueri. Jika `row_count` adalah nol, kueri akan mengembalikan kumpulan data kosong. Jika `row_count` bernilai `NULL`, hasil kueri akan sama seperti saat tidak menggunakan klausa `'LIMIT'`.

Jika kamu ingin melewati sejumlah baris sebelum mengembalikan `row_count` baris, kamu dapat menggunakan klausa `'OFFSET'` yang ditempatkan setelah klausa `'LIMIT'`:

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

Pernyataan ini pertama-tama melewati `row_to_skip` baris sebelum mengembalikan `row_count` baris yang dihasilkan oleh kueri.

Jika `row_to_skip` bernilai nol, maka pernyataan tersebut akan berfungsi seolah-olah tidak memiliki klausa `'OFFSET'`.

Penting untuk dicatat bahwa PostgreSQL mengevaluasi klausa `'OFFSET'` sebelum klausa `'LIMIT'`.

PostgreSQL menyimpan baris dalam tabel tanpa urutan yang ditentukan. Oleh karena itu, saat menggunakan klausa `'LIMIT'`, kamu harus selalu menggunakan klausa `'ORDER BY'` untuk mengontrol urutan baris yang dihasilkan.

Jika kamu tidak menggunakan klausa `'ORDER BY'`, maka hasil kueri mungkin berisi baris dalam urutan yang tidak ditentukan.

### Contoh Klausa PostgreSQL 'LIMIT'

Mari kita lihat beberapa contoh penggunaan klausa PostgreSQL `'LIMIT'`. Kita akan menggunakan tabel `'film'` dalam database contoh untuk demonstrasi.

![image](https://github.com/user-attachments/assets/b698e255-a938-4132-bc01-ce067166af74)

### 1) Menggunakan PostgreSQL 'LIMIT' untuk Membatasi Jumlah Baris yang Dikembalikan

Pernyataan berikut menggunakan klausa `'LIMIT'` untuk mengambil lima film pertama yang diurutkan berdasarkan `'film_id'`:

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

**Output:**  
Pernyataan ini akan mengembalikan **lima film pertama** berdasarkan `'film_id'`, dengan urutan dari nilai terkecil ke terbesar.

| film_id | title            | release_year |
|---------|------------------|--------------|
| 1       | Academy Dinosaur | 2006         |
| 2       | Ace Goldfinger   | 2006         |
| 3       | Adaptation Holes | 2006         | 
| 4       | Affair Prejudice | 2006         |
| 5       | African Egg      | 2006         |

### Cara Kerjanya

- Pertama, urutkan film berdasarkan `'film_id'` dalam **urutan menaik** menggunakan klausa `'ORDER BY film_id'`.  
- Kedua, ambil **5 film pertama** dari atas menggunakan klausa `'LIMIT 5'`.

---

### 2) Menggunakan Klausa 'LIMIT' dengan Klausa 'OFFSET'

Untuk mengambil **4 film** mulai dari **film keempat**, yang diurutkan berdasarkan `'film_id'`, kamu bisa menggunakan klausa `'LIMIT'` dan `'OFFSET'` seperti berikut:

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

**Output:**  

| film_id | title            | release_year |
|---------|------------------|--------------|
| 4       | Affair Prejudice |         2006 |
| 5       | African Egg      |         2006 |
| 6       | Agent Truman     |         2006 |
| 7       | Airplane Sierra  |         2006 |

### Cara Kerjanya  

- Pertama, **urutkan film berdasarkan `'film_id'`** dalam **urutan menaik**.  
- Kedua, **lewati 3 baris pertama** menggunakan klausa `'OFFSET 3'`.  
- Ketiga, **ambil 4 baris berikutnya** menggunakan klausa `'LIMIT 4'`.

### 3) Menggunakan 'LIMIT OFFSET' untuk Mendapatkan N Baris Teratas/Bawah  

Biasanya, kamu sering menggunakan klausa `'LIMIT'` untuk memilih baris dengan nilai **tertinggi atau terendah** dari sebuah tabel.  

Contoh berikut menggunakan klausa `'LIMIT'` untuk mengambil **10 film dengan biaya sewa tertinggi**:

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

Dengan perintah ini, kita mengambil **10 film paling mahal** berdasarkan `'rental_rate'`, diurutkan dalam **urutan menurun** (dari harga tertinggi ke terendah). Jika ingin mendapatkan **10 film termurah**, cukup ubah `'DESC'` menjadi `'ASC'` dalam klausa `'ORDER BY'`.

Output:

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


### Cara Kerjanya  

- Pertama, **urutkan semua film berdasarkan biaya sewa** dari **yang tertinggi ke terendah** menggunakan klausa `'ORDER BY rental_rate DESC'`.  
- Kedua, **ambil hanya 10 baris teratas** menggunakan klausa `'LIMIT 10'`.  

#### **Ringkasan**  
Gunakan klausa PostgreSQL `'LIMIT OFFSET'` untuk mengambil sebagian dari kumpulan baris yang dikembalikan oleh kueri.


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# PostgreSQL FETCH 

**Ringkasan:** Dalam tutorial ini, kamu akan belajar cara menggunakan klausa PostgreSQL `'FETCH'` untuk mengambil sebagian baris yang dikembalikan oleh kueri.

## **Pengenalan Klausa PostgreSQL 'FETCH'**  

Untuk melewati sejumlah baris dan mengambil jumlah baris tertentu, kamu sering menggunakan klausa `'LIMIT'` dalam pernyataan `'SELECT'`.  

Klausa `'LIMIT'` banyak digunakan oleh berbagai Sistem Manajemen Basis Data Relasional (RDBMS) seperti MySQL, H2, dan HSQLDB. Namun, `'LIMIT'` bukanlah bagian dari standar SQL.

Agar sesuai dengan standar SQL, PostgreSQL mendukung klausa `'FETCH'`, yang memungkinkan melewati sejumlah baris tertentu lalu mengambil sejumlah baris spesifik.

Perlu diketahui bahwa klausa `'FETCH'` diperkenalkan sebagai bagian dari **standar SQL:2008**.

Berikut adalah sintaks dari klausa `'FETCH'` dalam PostgreSQL:


```sql
OFFSET row_to_skip { ROW | ROWS }
FETCH { FIRST | NEXT } [ row_count ] { ROW | ROWS } ONLY
```


Dalam sintaks ini:

- **Pertama**, tentukan jumlah baris yang akan dilewati (`row_to_skip`) setelah kata kunci `'OFFSET'`. Nilai ini harus berupa bilangan bulat **nol atau positif**, dengan nilai default 0 (artinya tidak melewati baris).  
- Jika `row_to_skip` lebih besar dari jumlah total baris dalam tabel, kueri tidak akan mengembalikan hasil apa pun.  
- **Kedua**, tentukan jumlah baris yang ingin diambil (`row_count`) dalam klausa `'FETCH'`. Nilai ini harus berupa **bilangan bulat 1 atau lebih besar**, dengan nilai default **1**.  
- `'ROW'` adalah sinonim dari `'ROWS'`, sedangkan `'FIRST'` adalah sinonim dari `'NEXT'`, sehingga bisa digunakan secara bergantian.

Karena PostgreSQL menyimpan baris dalam urutan yang tidak ditentukan, **selalu gunakan klausa `'ORDER BY'`** saat menggunakan `'FETCH'`, agar urutan hasil konsisten.

Catatan: Dalam SQL:2008, klausa `'OFFSET'` harus muncul sebelum `'FETCH'`. Namun, dalam PostgreSQL, kedua klausa ini bisa muncul dalam urutan **apa pun**.

---

## **FETCH vs. LIMIT**  

Klausa `'FETCH'` memiliki fungsi yang sama dengan klausa `'LIMIT'`. Jika kamu ingin membuat aplikasi yang **kompatibel dengan berbagai sistem basis data**, sebaiknya gunakan `'FETCH'`, karena klausa ini mengikuti standar SQL.

---

## **Contoh Penggunaan PostgreSQL 'FETCH'**  

Kita akan menggunakan tabel `'film'` dalam database contoh untuk demonstrasi.

![image](https://github.com/user-attachments/assets/a358c66a-5373-4ead-8b59-58756768f75c)

### Klausa PostgreSQL 'FETCH'

Pernyataan berikut menggunakan klausa `'FETCH'` untuk memilih **film pertama** yang diurutkan berdasarkan judul dalam **urutan menaik**:

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


Pernyataan ini setara dengan kueri berikut:

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

---

Pernyataan berikut menggunakan klausa `'FETCH'` untuk memilih **lima film pertama** yang diurutkan berdasarkan judul:

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


---

Pernyataan berikut mengambil **lima film berikutnya** setelah lima film pertama yang diurutkan berdasarkan judul:

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
Gunakan klausa PostgreSQL `'FETCH'` untuk melewati sejumlah baris dan mengambil sejumlah baris tertentu dari hasil kueri.
