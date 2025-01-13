# Panduan PostgreSQL Filtering Data

## Daftar Isi
- [PostgreSQL WHERE](#postgresql-where)
- [PostgreSQL AND Operator](#postgresql-and-operator)
- [PostgreSQL ORDER BY](#postgresql-order-by)
- [PostgreSQL SELECT DISTINCT](#postgresql-select-distinct)

# PostgreSQL WHERE

## Introduction to PostgreSQL WHERE clause
Pernyataan `SELECT` mengembalikan semua baris dari satu atau lebih kolom dalam sebuah tabel. Untuk mengambil baris yang memenuhi kondisi tertentu, kamu menggunakan klausa `WHERE`.

Sintaks klausa PostgreSQL `WHERE` adalah sebagai berikut:

```
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

```
SELECT
  last_name,
  first_name
FROM
  customer
WHERE
  first_name = 'Jamie';
```

Output:

```
last_name | first_name
-----------+------------
 Rice      | Jamie
 Waugh     | Jamie
(2 rows)
```

### 2) Menggunakan klausa WHERE dengan contoh operator AND
Contoh berikut menggunakan klausa `WHERE` dengan operator logika `AND` untuk mencari pelanggan yang nama depan dan nama belakangnya adalah `Jamie` dan `Rice`:

```
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

```
last_name | first_name
-----------+------------
 Rice      | Jamie
(1 row)
```

### 3) Menggunakan klausa WHERE dengan contoh operator OR
Contoh berikut menggunakan klausa `WHERE` dengan operator `OR` untuk mencari pelanggan yang nama belakangnya adalah `Rodriguez` atau nama depannya adalah `Adam`:

```
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

```
first_name | last_name
------------+-----------
 Laura      | Rodriguez
 Adam       | Gooch
(2 rows)
```

### 4) Menggunakan klausa WHERE dengan contoh operator IN
Jika kamu ingin menemukan nilai dalam daftar nilai, kamu bisa menggunakan operator `IN`.

Contoh berikut menggunakan klausa `WHERE` dengan operator `IN` untuk mencari pelanggan dengan nama depan dalam daftar `Ann`, `Anne`, dan `Annie`:

```
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name IN ('Ann', 'Anne', 'Annie');
```

Output:

```
first_name | last_name
------------+-----------
 Ann        | Evans
 Anne       | Powell
 Annie      | Russell
(3 rows)
```

### 5) Menggunakan klausa WHERE dengan contoh operator LIKE
Untuk menemukan string yang cocok dengan pola tertentu, kamu menggunakan operator `LIKE`.

Contoh berikut menggunakan operator `LIKE` dalam klausa `WHERE` untuk menemukan pelanggan yang nama depannya dimulai dengan kata `Ann..`:

```
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'Ann%';
```

Output:

```
first_name | last_name
------------+-----------
 Anna       | Hill
 Ann        | Evans
 Anne       | Powell
 Annie      | Russell
 Annette    | Olson
(5 rows)
```

`%` disebut wildcard yang cocok dengan string apa pun. Pola `'Ann%'` cocok dengan string apa pun yang dimulai dengan `'Ann'`.

### 6) Menggunakan klausa WHERE dengan contoh operator BETWEEN
Contoh berikut menemukan pelanggan yang nama depannya dimulai dengan huruf `A` dan terdiri dari 3 hingga 5 karakter dengan menggunakan operator `BETWEEN`.

Operator `BETWEEN` mengembalikan true jika nilai berada dalam rentang nilai.

```
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

```
first_name | name_length
------------+-------------
 Amy        |           3
 Ann        |           3
 Ana        |           3
 Andy       |           4
 Anna       |           4
 Anne       |           4
 Alma       |           4
 Adam       |           4
 Alan       |           4
 Alex       |           4
 Angel      |           5
...
```

Dalam contoh ini, kita menggunakan fungsi `LENGTH()` untuk mendapatkan jumlah karakter dari string input.

### 7) Menggunakan klausa WHERE dengan contoh operator tidak sama dengan (<>)
Contoh ini menemukan pelanggan yang nama depannya dimulai dengan `Bra` dan nama belakangnya bukan `Motley`:

```
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

```
first_name | last_name
------------+-----------
 Brandy     | Graves
 Brandon    | Huey
 Brad       | Mccurdy
(3 rows)
```

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

```
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

```
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

```
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

```
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

```
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

```
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

```
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

```
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

```
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

```
title               | length | rental_rate
--------------------+--------+-------------
 Catch Amistad      |    183 |        0.99
 Haunting Pianist   |    181 |        0.99
 Intrigue Worst     |    181 |        0.99
 Love Suicides      |    181 |        0.99
 Runaway Tenenbaums |    181 |        0.99
 Smoochy Control    |    184 |        0.99
 Sorority Queen     |    184 |        0.99
 Theory Mermaid     |    184 |        0.99
 Wild Apollo        |    181 |        0.99
 Young Language     |    183 |        0.99
(10 rows)
```

### Summary
- Gunakan operator `AND` untuk menggabungkan beberapa ekspresi boolean.
