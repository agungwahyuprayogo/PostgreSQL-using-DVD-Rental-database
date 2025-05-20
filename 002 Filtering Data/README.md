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

| result |
|--------|
| t      |

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

| result |
|--------|
| t      |

Pernyataan berikut menggunakan operator `AND` untuk menggabungkan `true` dengan `false`, yang mengembalikan `false`:

```sql
SELECT true AND false AS result;
```

Output:

| result |
|--------|
| f      |

Contoh berikut menggunakan operator `AND` untuk menggabungkan true dengan `null`, yang mengembalikan `null`:

```sql
SELECT true AND null AS result;
```

Output:

| result |
|--------|
| null      |

Contoh berikut menggunakan operator `AND` untuk menggabungkan `false` dengan `false`, yang mengembalikan `false`:

```sql
SELECT false AND false AS result;
```

Output:

| result |
|--------|
| f      |

Contoh berikut menggunakan operator `AND` untuk menggabungkan `false` dengan `null`, yang mengembalikan `false`:

```sql
SELECT false AND null AS result;
```

Output:

| result |
|--------|
| f      |

Contoh berikut menggunakan operator `AND` untuk menggabungkan `null` dengan `null`, yang mengembalikan `null`:

```sql
SELECT null AND null AS result;
```

Output:

| result |
|--------|
| null   |

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

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# PostgreSQL IN

## **Pengenalan Operator PostgreSQL 'IN'**  

Operator `'IN'` memungkinkan kamu untuk memeriksa apakah suatu **nilai cocok** dengan **salah satu nilai** dalam daftar.

Berikut adalah sintaks dasar dari operator `'IN'`:

```sql
value IN (value1, value2, ...)
```

Operator `'IN'` akan mengembalikan **true** jika `'value'` sama dengan salah satu nilai dalam daftar, seperti `'value1'` dan `'value2'`.

Daftar nilai dapat berupa **nilai literal**, termasuk angka dan string.

Selain nilai literal, operator `'IN'` juga dapat menerima daftar nilai yang dihasilkan dari suatu kueri. Kamu akan belajar lebih lanjut tentang penggunaan operator `'IN'` dengan kueri dalam tutorial subquery.

Secara fungsional, operator `'IN'` setara dengan **kombinasi beberapa ekspresi boolean** yang digabungkan dengan operator `'OR'`:

```sql
value = value1 OR value = value2 OR ...
```

---

## **Contoh Penggunaan Operator PostgreSQL 'IN'**  

Kita akan menggunakan tabel `'film'` dari database contoh.

![image](https://github.com/user-attachments/assets/882709fd-617d-4b33-8742-cb16cf421d46)

### **1) Menggunakan Operator PostgreSQL 'IN' dengan Daftar Angka**

Contoh berikut menggunakan operator `'IN'` untuk mengambil informasi tentang film dengan `'film_id'` 1, 2, dan 3:

```sql
SELECT
  film_id,
  title
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

Pernyataan berikut menggunakan operator `'='` dan `'OR'` sebagai pengganti operator `'IN'`, yang setara dengan kueri di atas:

```sql
SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id = 1
  OR film_id = 2
  OR film_id = 3;
```

---

Kueri yang menggunakan operator `'IN'` lebih **pendek** dan **mudah dibaca** dibandingkan kueri yang menggunakan operator `'='` dan `'OR'`.

Selain itu, PostgreSQL **mengeksekusi kueri dengan operator `'IN'` lebih cepat** daripada kueri yang menggunakan banyak operator `'OR'`.

### **2) Menggunakan Operator PostgreSQL 'IN' dengan Daftar String**  

Kita akan menggunakan tabel `'actor'` dari database contoh:  

![image](https://github.com/user-attachments/assets/d04c04d6-e365-467b-99e7-88006c0a44a5)
  

Contoh berikut menggunakan operator `'IN'` untuk menemukan aktor yang memiliki nama belakang dalam daftar `'Allen'`, `'Chase'`, dan `'Davis'`:

```sql
SELECT
  first_name,
  last_name
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

### 3) Menggunakan Operator PostgreSQL 'IN' dengan Daftar Tanggal

Pernyataan berikut menggunakan operator `'IN'` untuk menemukan pembayaran dengan tanggal pembayaran dalam daftar tanggal: `'2007-02-15'` dan `'2007-02-16'`:

```sql
SELECT
  payment_id,
  amount,
  payment_date
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


Dalam contoh ini, kolom `'payment_date'` memiliki tipe `'timestamp'`, yang terdiri dari bagian **tanggal** dan **waktu**.

Agar nilai dalam kolom `'payment_date'` cocok dengan daftar tanggal, kamu perlu **mengonversinya ke tipe tanggal saja**.  

Untuk melakukannya, gunakan operator **cast (`::`)**:

```sql
payment_date::date
```

Sebagai contoh, jika nilai timestamp adalah `'2007-02-15 22:25:46.996577'`, operator cast akan mengonversinya menjadi **`2007-02-15`**.

---

## **PostgreSQL 'NOT IN' Operator**  

Untuk meniadakan operator `'IN'`, gunakan **operator `'NOT IN'`**.  

Berikut adalah sintaks dasar dari operator `'NOT IN'`:

```sql
value NOT IN (value1, value2, ...)
```

Operator `'NOT IN'` akan **mengembalikan true** jika `'value'` **tidak sama** dengan salah satu nilai dalam daftar, seperti `'value1'` dan `'value2'`. Jika ada kecocokan, operator ini akan mengembalikan **false**.

Secara fungsional, operator `'NOT IN'` setara dengan **kombinasi beberapa ekspresi boolean** yang digabungkan dengan operator `'AND'`:

```sql
value <> value1 AND value <> value2 AND ...
```

---

## **Contoh Penggunaan PostgreSQL 'NOT IN'**  

Pernyataan berikut menggunakan operator `'NOT IN'` untuk mengambil film yang **id-nya bukan 1, 2, atau 3**:

```sql
SELECT
  film_id,
  title
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

Kueri berikut mengambil hasil yang **sama**, tetapi menggunakan **operator tidak sama (`<>`)** dan operator **AND**:

```sql
SELECT
  film_id,
  title
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
✅ Gunakan operator `'IN'` untuk memeriksa apakah suatu nilai cocok dengan salah satu nilai dalam daftar.  
✅ Gunakan operator `'NOT IN'` untuk **meniadakan** operator `'IN'`.  

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

# **PostgreSQL BETWEEN**  

## **Pengenalan Operator PostgreSQL 'BETWEEN'**  

Operator `'BETWEEN'` memungkinkan kamu untuk **memeriksa apakah suatu nilai berada dalam rentang tertentu**.

Berikut adalah sintaks dasar dari operator `'BETWEEN'`:

```sql
value BETWEEN low AND high;
```

Jika `'value'` lebih besar atau sama dengan **`low`** dan lebih kecil atau sama dengan **`high`**, operator `'BETWEEN'` akan **mengembalikan true**; jika tidak, akan mengembalikan **false**.

Operator `'BETWEEN'` dapat ditulis ulang menggunakan operator **`>=`** (lebih besar atau sama dengan) dan **`<=`** (lebih kecil atau sama dengan), serta operator logika **`AND`**:

```sql
value >= low AND value <= high;
```

Jika kamu ingin memeriksa apakah suatu **nilai berada di luar** rentang tertentu, gunakan **operator `'NOT BETWEEN'`**:

```sql
value NOT BETWEEN low AND high;
```

Pernyataan ini setara dengan kombinasi operator **lebih kecil dari (`<`)** dan **lebih besar dari (`>`)**:

```sql
value < low OR value > high;
```

Dalam praktiknya, operator `'BETWEEN'` sering digunakan dalam klausa `'WHERE'` dari pernyataan `'SELECT'`, `'INSERT'`, `'UPDATE'`, dan `'DELETE'`.

---

## **Contoh Penggunaan Operator PostgreSQL 'BETWEEN'**  

Mari kita lihat tabel `'payment'` dalam database contoh.

**(gambar tabel payment)**  

---

### **1) Menggunakan Operator PostgreSQL 'BETWEEN' dengan Angka**  

Kueri berikut menggunakan operator `'BETWEEN'` untuk mengambil pembayaran dengan `'payment_id'` antara **`17503` dan `17505`**:

```sql
SELECT
  payment_id,
  amount
FROM
  payment
WHERE
  payment_id BETWEEN 17503 AND 17505
ORDER BY
  payment_id;
```

**Output:**

| payment_id | amount |
|------------|--------|
| 17503      |  7.99  |
| 17504      |  1.99  |
| 17505      |  7.99  |

## **2) Contoh Penggunaan PostgreSQL 'NOT BETWEEN'**  

Contoh berikut menggunakan operator `'NOT BETWEEN'` untuk menemukan pembayaran dengan `'payment_id'` **tidak berada** di antara `17503` dan `17505`:

```sql
SELECT
  payment_id,
  amount
FROM
  payment
WHERE
  payment_id NOT BETWEEN 17503 AND 17505
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

## **3) Menggunakan PostgreSQL 'BETWEEN' dengan Rentang Tanggal**  

Jika ingin memeriksa suatu nilai dalam rentang tanggal, gunakan format tanggal **ISO 8601**, yaitu `'YYYY-MM-DD'`.

Contoh berikut menggunakan operator `'BETWEEN'` untuk menemukan pembayaran dengan **tanggal pembayaran antara `'2007-02-15'` dan `'2007-02-20'`**, serta jumlah **lebih dari 10**:

```sql
SELECT
  customer_id,
  payment_id,
  amount,
  payment_date
FROM
  payment
WHERE
  payment_date BETWEEN '2007-02-15' AND '2007-02-20'
  AND amount > 10
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

---


### **Ringkasan**  
✅ Gunakan operator `'BETWEEN'` untuk memeriksa apakah suatu nilai berada dalam rentang tertentu.  
✅ Gunakan operator `'NOT BETWEEN'` untuk **meniadakan** operator `'BETWEEN'`.  



--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------




# **PostgreSQL LIKE**  

## **Pengenalan Operator PostgreSQL 'LIKE'**  

Misalkan kamu ingin mencari pelanggan, tetapi **tidak mengingat namanya secara pasti**. Namun, kamu tahu bahwa nama mereka **dimulai dengan** `'Jen'`.  

Bagaimana cara menemukan pelanggan yang sesuai di database?  

Kamu bisa **memeriksa satu per satu** kolom `'first_name'` dalam tabel `'customer'`, tetapi **hal ini memakan waktu** terutama jika tabel memiliki banyak baris.  

Untungnya, kamu bisa **menggunakan operator PostgreSQL 'LIKE'** untuk mencocokkan nama depan pelanggan dengan pola tertentu, seperti dalam kueri berikut:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'Jen%';
```

**Output:**

| first_name | last_name |
|------------|-----------|
| Jennifer   | Davis    |
| Jennie     | Terry    |
| Jenny      | Castro   |

Klausa `'WHERE'` dalam kueri di atas berisi ekspresi:

```sql
first_name LIKE 'Jen%'
```

Ekspresi ini terdiri dari **kolom `'first_name'`**, **operator `'LIKE'`**, dan **string literal** yang mengandung tanda persen (`%`).  
String `'Jen%'` disebut sebagai **pola (pattern)**.

Kueri ini akan **mengembalikan baris** di mana nilai dalam kolom `'first_name'` **dimulai dengan `'Jen'`**, diikuti oleh **karakter apa pun**. Teknik ini dikenal sebagai **pattern matching**.

---

## **Wildcard dalam PostgreSQL 'LIKE'**  

Kamu dapat membentuk pola dengan **menggabungkan nilai literal dengan karakter wildcard** serta menggunakan operator **'LIKE'** atau **'NOT LIKE'** untuk menemukan kecocokan.  

PostgreSQL menyediakan **dua wildcard utama**:  

✅ **Tanda persen (`%`)** → Cocok dengan **urutan karakter apa pun**, termasuk tidak ada karakter.  
✅ **Tanda garis bawah (`_`)** → Cocok dengan **satu karakter tunggal**.

Sintaks dasar dari operator `'LIKE'`:

```sql
value LIKE pattern
```

Operator `'LIKE'` mengembalikan **true** jika `'value'` cocok dengan `'pattern'`.  
Jika ingin **meniadakan** operator `'LIKE'`, gunakan **operator 'NOT LIKE'**:

```sql
value NOT LIKE pattern
```

Operator `'NOT LIKE'` akan **mengembalikan true** jika `'value'` **tidak cocok** dengan `'pattern'`.

Jika pola **tidak berisi wildcard**, operator `'LIKE'` **berperilaku seperti operator '='**.

---

## **Contoh Penggunaan PostgreSQL 'LIKE'**  

### **1) Contoh Dasar Operator 'LIKE'**  

Kueri berikut menggunakan **operator 'LIKE'** dengan pola **tanpa karakter wildcard**:

```sql
SELECT 'Apple' LIKE 'Apple' AS result;
```

**Output:**

| result |
|--------|
| t      |


Dalam contoh ini, operator `'LIKE'` **berperilaku seperti operator '='**, karena `'Apple' = 'Apple'` adalah **true**.

Kueri berikut menggunakan **operator 'LIKE'** untuk mencocokkan **string yang dimulai dengan huruf 'A'**:

```sql
SELECT 'Apple' LIKE 'A%' AS result;
```

**Output:**

| result |
|--------|
| t      |

Kueri mengembalikan **true** karena string `'Apple'` **dimulai dengan huruf 'A'**.

---

### **2) Menggunakan Operator 'LIKE' dengan Data Tabel**  

Kita akan menggunakan tabel `'customer'` dari database contoh.

![image](https://github.com/user-attachments/assets/4d0b5c18-20d4-4e63-9f22-4a0e600ee733)

# **Contoh Penggunaan PostgreSQL 'LIKE'**  

### **Menggunakan Operator 'LIKE' untuk Mencari Nama Depan yang Mengandung String 'er'**  

Kueri berikut menggunakan operator `'LIKE'` untuk menemukan pelanggan dengan **nama depan yang mengandung string `'er'`**:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE '%er%'
ORDER BY
  first_name;
```

**Output:**  

| first_name  | last_name |
|-------------|----------|
| Albert      | Crouse   |
| Alberto     | Henning  |
| Alexander   | Fennell  |
| Amber       | Dixon    |
| Bernard     | Colby    |
| ...         | ...      |

---

### **3) Menggunakan Operator 'LIKE' dengan Pola yang Mengandung Wildcard `%` dan `_`**  

Kueri berikut menggunakan operator `'LIKE'` dengan pola yang mengandung **wildcard persen (`%`) dan garis bawah (`_`)**:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE '_her%'
ORDER BY
  first_name;
```

**Output:**  

| first_name | last_name |
|------------|----------|
| Cheryl     | Murphy   |
| Sherri     | Rhodes   |
| Sherry     | Marshall |
| Theresa    | Watson   |

Pola `'_her%'` cocok dengan string yang memenuhi kondisi berikut:  

✅ **Karakter pertama bisa apa saja**.  
✅ **Karakter berikutnya harus `'her'`**.  
✅ **Karakter setelah `'her'` bisa berjumlah berapa saja (termasuk nol karakter)**.

---

### **4) Contoh Penggunaan PostgreSQL 'NOT LIKE'**  

Kueri berikut menggunakan operator `'NOT LIKE'` untuk menemukan pelanggan **yang nama depannya tidak dimulai dengan `'Jen'`**:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name NOT LIKE 'Jen%'
ORDER BY
  first_name;
```

**Output:**  

| first_name  | last_name |
|-------------|----------|
| Aaron       | Selby    |
| Adam        | Gooch    |
| Adrian      | Clary    |
| Agnes       | Bishop   |
| ...         | ...      |

---

## **Ekstensi PostgreSQL untuk Operator 'LIKE'**  

PostgreSQL menyediakan **operator 'ILIKE'**, yang **mirip dengan 'LIKE'** tetapi **mendukung pencocokan tanpa peka huruf besar-kecil**.  

Contoh berikut menggunakan operator `'ILIKE'` untuk menemukan pelanggan dengan nama depan yang **dimulai dengan `'BAR'`, tanpa memperhatikan huruf besar atau kecil**:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name ILIKE 'BAR%';
```

**Output:**  

| first_name | last_name |
|------------|----------|
| Barbara    | Jones    |
| Barry      | Lovelace |

Dalam contoh ini, pola `'BAR%'` cocok dengan **string apa pun yang dimulai dengan `'BAR'`, `'Bar'`, `'BaR'`, dan sebagainya**.  
Jika menggunakan **operator 'LIKE' biasa**, kueri tidak akan mengembalikan hasil:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'BAR%';
```

**Output:**  


| first_name | last_name |
|------------|-----------|
| (0 rows)   |           |


---

## **Operator Alternatif PostgreSQL untuk 'LIKE'**  

PostgreSQL juga menyediakan **operator alternatif** untuk `'LIKE'`, `'NOT LIKE'`, `'ILIKE'`, dan `'NOT ILIKE'`, seperti yang ditunjukkan dalam tabel berikut:

| **Operator** | **Setara Dengan** |
|--------------|-------------------|
| `~~`         | LIKE              |
| `~~*`        | ILIKE             |
| `!~~`        | NOT LIKE          |
| `!~~*`       | NOT ILIKE         |

---

Contoh berikut menggunakan operator **`~~`** untuk menemukan pelanggan dengan **nama depan yang dimulai dengan `'Dar'`**:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name ~~ 'Dar%'
ORDER BY
  first_name;
```

**Output:**  


| first_name | last_name |
|------------|----------|
| Darlene    | Rose     |
| Darrell    | Power    |
| Darren     | Windham  |
| Darryl     | Ashcraft |
| Daryl      | Larue    |

## **PostgreSQL 'LIKE' dengan Opsi 'ESCAPE'**  

Terkadang, data yang ingin kamu cocokkan mengandung **karakter wildcard** seperti `'%'` dan `'_'`. Contoh:  

```
The rents are now 10% higher than last month  
The new film will have _ in the title  
```

Untuk **menginstruksikan operator `'LIKE'` agar memperlakukan karakter wildcard** `'%'` dan `'_'` sebagai **karakter biasa**, gunakan **opsi 'ESCAPE'** dalam operator `'LIKE'`:

```sql
string LIKE pattern ESCAPE escape_character;
```

---

### **Membuat Tabel untuk Demonstrasi**  

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

**Output:**  

| message                                      |
|----------------------------------------------|
| The rents are now 10% higher than last month |
| The new film will have _ in the title        |

---

### **Menggunakan Operator 'LIKE' dengan 'ESCAPE'**  

Pernyataan berikut menggunakan **operator 'LIKE' dengan opsi 'ESCAPE'** untuk memperlakukan `'%'` yang muncul setelah angka `'10'` sebagai **karakter biasa**:

```sql
SELECT * FROM t
WHERE message LIKE '%10$%%' ESCAPE '$';
```

---

**Output:**  

| message                                      |
|----------------------------------------------|
| The rents are now 10% higher than last month |

Dalam pola `' %10$%% '`, karakter `'%'` pertama dan terakhir **berfungsi sebagai wildcard**, sedangkan `'%'` setelah karakter **escape `$`** dianggap sebagai **karakter biasa**.

---

#### **Ringkasan**  
- Gunakan operator `'LIKE'` untuk mencocokkan data berdasarkan pola.  
- Gunakan operator `'NOT LIKE'` untuk **meniadakan** operator `'LIKE'`.  
- Gunakan wildcard `'%`' untuk mencocokkan **nol atau lebih karakter**.  
- Gunakan wildcard `'_'` untuk mencocokkan **satu karakter tunggal**.  
- Gunakan opsi `'ESCAPE'` untuk menentukan karakter pelolosan (escape).  
- Gunakan operator `'ILIKE'` untuk **pencocokan tanpa peka huruf besar/kecil**.

---
---
---

# PostgreSQL IS NULL

## Pengantar tentang NULL
Dalam dunia basis data, `NULL` berarti informasi yang hilang atau tidak berlaku. `NULL` bukanlah sebuah nilai, sehingga Anda tidak dapat membandingkannya dengan nilai lain seperti angka atau string.

Perbandingan antara `NULL` dengan sebuah nilai akan selalu menghasilkan `NULL`. Selain itu, `NULL` tidak sama dengan `NULL`, sehingga ekspresi berikut akan menghasilkan `NULL`:

```sql
SELECT null = null AS result;
```

Output:

| result |
|--------|
| null   |

Total row: 1

## Operator IS NULL
Untuk memeriksa apakah sebuah nilai adalah NULL atau bukan, Anda tidak dapat menggunakan operator sama dengan (`=`) atau tidak sama dengan (`<>`). Sebagai gantinya, gunakan operator `IS NULL`.

Berikut sintaks dasar dari operator `IS NULL`:

```sql
value IS NULL
```

Operator `IS NULL` akan mengembalikan true jika `value` adalah NULL dan false jika tidak.

Untuk meniadakan operator `IS NULL`, gunakan operator `IS NOT NULL`:

```sql
value IS NOT NULL
```

Operator `IS NOT NULL` akan mengembalikan true jika nilai tidak NULL dan false jika sebaliknya.

Untuk mempelajari cara menangani NULL dalam proses pengurutan, lihat tutorial *ORDER BY*.

PostgreSQL menawarkan beberapa fungsi berguna untuk menangani NULL secara efektif, seperti NULLIF, ISNULL, dan COALESCE.

Untuk memastikan bahwa sebuah kolom tidak mengandung NULL, gunakan constraint NOT NULL.

## Contoh penggunaan operator PostgreSQL IS NULL
Kita akan menggunakan tabel `address` dari database sampel:

![image](https://github.com/user-attachments/assets/8d21a191-174a-43fc-b391-f4a2e3ad138f)

---

Harap diperhatikan bahwa program `psql` menampilkan `NULL` sebagai string kosong secara default. Untuk mengubah cara `psql` menampilkan `NULL` di terminal, gunakan perintah: `\pset null null`. Perintah ini akan menampilkan `NULL` sebagai null.

### 1) Contoh dasar penggunaan operator IS NULL
Contoh berikut menggunakan operator `IS NULL` untuk mencari alamat dari tabel `address` yang memiliki kolom `address2` bernilai `NULL`:

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
|----------------------|---------|
| 47 MySakila Drive   | null    |
| 28 MySQL Boulevard  | null    |
| 23 Workhaven Lane   | null    |
| 1411 Lillydale Drive | null    |

Total row: 4

### 2) Contoh penggunaan operator IS NOT NULL
Contoh berikut menggunakan operator `IS NOT NULL` untuk mengambil alamat yang memiliki nilai `address2` yang bukan NULL:

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
|-----------------------|---------|
| 1913 Hanoi Way       |         |
| 1121 Loja Avenue     |         |
| 692 Joliet Street    |         |
| 1566 Inegl Manor     |         |

Total row: 4

Perhatikan bahwa `address2` kosong, bukan NULL. Ini adalah contoh *bad practice* dalam penyimpanan string kosong dan NULL dalam kolom yang sama.

#### Ringkasan
- Dalam basis data, NULL berarti informasi yang hilang atau tidak berlaku.
- Operator `IS NULL` mengembalikan true jika sebuah nilai adalah NULL dan false jika tidak.
- Operator `IS NOT NULL` mengembalikan true jika sebuah nilai bukan NULL dan false jika sebaliknya.

---
