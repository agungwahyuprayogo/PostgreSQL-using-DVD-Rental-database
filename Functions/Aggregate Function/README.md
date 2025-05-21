- [PostgreSQL AVG Function](#postgresql-avg-function)
- [PostgreSQL COUNT Function](#postgresql-count-function)

---
---
---

# PostgreSQL AVG Function

## Pengenalan Fungsi PostgreSQL AVG()
Fungsi `AVG()` adalah salah satu fungsi agregat yang paling sering digunakan di PostgreSQL. Fungsi `AVG()` memungkinkan Anda menghitung nilai rata-rata dari suatu kumpulan data.

Berikut sintaks dari fungsi `AVG()`:

```sql
AVG(column)
```

Anda dapat menggunakan fungsi `AVG()` dalam klausa `SELECT` dan `HAVING`.

Untuk menghitung nilai rata-rata dari nilai yang unik dalam suatu kumpulan data, gunakan opsi `DISTINCT` seperti berikut:

```sql
AVG(DISTINCT column)
```

Perhatikan bahwa fungsi `AVG()` mengabaikan `NULL`. Jika kolom tidak memiliki nilai, fungsi `AVG()` akan mengembalikan `NULL`.

## Contoh Penggunaan Fungsi PostgreSQL AVG()
Mari kita lihat beberapa contoh penggunaan fungsi `AVG()`.

Kita akan menggunakan tabel `payment` dari database sampel *dvdrental* sebagai demonstrasi.

![image](https://github.com/user-attachments/assets/81dfa84e-4b12-4d65-94d0-df37165be001)

---

### 1) Contoh dasar penggunaan fungsi PostgreSQL AVG()
Contoh berikut menggunakan fungsi `AVG()` untuk menghitung rata-rata jumlah pembayaran yang dilakukan oleh pelanggan:

```sql
SELECT AVG(amount)
FROM payment;
```

Output:

| avg               |
|------------------|
| 4.2006056453822965 |

Total row: 1

Untuk membuat output lebih mudah dibaca, Anda dapat menggunakan operator `CAST` seperti berikut:

```sql
SELECT AVG(amount)::numeric(10,2)
FROM payment;
```

Output:

| avg  |
|------|
| 4.20 |

Total row: 1

#### Apa arti NUMERIC(10,2)?

```sql
NUMERIC(10, 2)
```

Berarti:

10 = precision (jumlah total digit, termasuk sebelum dan sesudah koma).

2 = scale (jumlah digit di belakang koma).

Contoh:

| Angka	Valid? | (NUMERIC(10,2))  |	Penjelasan |
|--------------|------------------|------------|
| 12345678.90	 | ✅               |	8 digit sebelum koma + 2 digit setelah koma = 10 total |
| 123456789.90	| ❌               |	9 digit sebelum koma + 2 digit setelah koma = 11 total (kelebihan) |

---

### 2) Contoh penggunaan fungsi AVG() dengan operator DISTINCT
Query berikut mengembalikan rata-rata pembayaran yang dilakukan oleh pelanggan. Karena kita menggunakan `DISTINCT`, PostgreSQL hanya mengambil jumlah pembayaran yang unik dan menghitung rata-rata.

```sql
SELECT AVG(DISTINCT amount)::numeric(10,2)
FROM payment;
```

Output:

| avg  |
|------|
| 6.14 |

Total row: 1

Perhatikan bahwa hasilnya berbeda dari contoh pertama yang tidak menggunakan opsi `DISTINCT`.

---

### 3) Contoh penggunaan fungsi AVG() dengan fungsi SUM()
Query berikut menggunakan fungsi `AVG()` bersama dengan fungsi `SUM()` untuk menghitung total pembayaran yang dilakukan oleh pelanggan dan rata-rata dari semua transaksi.

```sql
SELECT
	AVG(amount)::numeric(10,2),
	SUM(amount)::numeric(10,2)
FROM
	payment;
```

Output:

| avg  |   sum     |
|------|----------|
| 4.20 | 61312.04 |

Total row: 1

---

### 4) Menggunakan fungsi PostgreSQL AVG() dengan klausa GROUP BY
Biasanya, Anda menggunakan fungsi `AVG()` dengan klausa `GROUP BY` untuk menghitung nilai rata-rata per kelompok.

- Pertama, klausa `GROUP BY` membagi baris dalam tabel ke dalam kelompok.
- Kemudian, fungsi `AVG()` menghitung nilai rata-rata untuk setiap kelompok.

Contoh berikut menggunakan fungsi `AVG()` dengan klausa `GROUP BY` untuk menghitung rata-rata jumlah pembayaran yang dilakukan oleh setiap pelanggan:

```sql
SELECT
  customer_id,
  first_name,
  last_name,
  AVG(amount)::NUMERIC(10,2)
FROM
  payment
  INNER JOIN customer USING(customer_id)
GROUP BY
  customer_id
ORDER BY
  customer_id;
```

Output:

| customer_id | first_name | last_name | avg  |
|------------|-----------|-----------|------|
| 1          | Mary      | Smith     | 3.82 |
| 2          | Patricia  | Johnson   | 4.76 |
| 3          | Linda     | Williams  | 5.45 |
| 4          | Barbara   | Jones     | 3.72 |
| ...        | ...       | ...       | ...  |


Dalam query ini, kita menggabungkan tabel `payment` dengan tabel `customer` menggunakan *inner join*. Klausa `GROUP BY` digunakan untuk mengelompokkan pelanggan ke dalam kelompok, lalu fungsi `AVG()` digunakan untuk menghitung rata-rata per kelompok.

---

### 5) Contoh penggunaan fungsi PostgreSQL AVG() dengan klausa HAVING
Anda dapat menggunakan fungsi `AVG()` dalam klausa `HAVING` untuk memfilter kelompok berdasarkan kondisi tertentu.

Contoh berikut menggunakan fungsi `AVG()` untuk menghitung rata-rata pembayaran setiap pelanggan dan hanya menampilkan pelanggan yang melakukan pembayaran lebih dari 5 USD:

```sql
SELECT
  customer_id,
  first_name,
  last_name,
  AVG(amount)::NUMERIC(10,2)
FROM
  payment
  INNER JOIN customer USING(customer_id)
GROUP BY
  customer_id
HAVING
  AVG(amount) > 5
ORDER BY
  customer_id;
```

Output:

| customer_id | first_name | last_name | avg  |
|------------|-----------|-----------|------|
| 3          | Linda     | Williams  | 5.45 |
| 19         | Ruth      | Martinez  | 5.49 |
| 137        | Rhonda    | Kennedy   | 5.04 |
| 181        | Ana       | Bradley   | 5.08 |
| 187        | Brittany  | Riley     | 5.62 |
| 209        | Tonya     | Chapman   | 5.09 |
| 259        | Lena      | Jensen    | 5.16 |
| 272        | Kay       | Caldwell  | 5.07 |
| 285        | Miriam    | Mckinney  | 5.12 |
| 293        | Mae       | Fletcher  | 5.13 |
| 310        | Daniel    | Cabral    | 5.30 |
| 311        | Paul      | Trout     | 5.39 |
| 321        | Kevin     | Schuler   | 5.52 |
| 470        | Gordon    | Allard    | 5.09 |
| 472        | Greg      | Robins    | 5.07 |
| 477        | Dan       | Paine     | 5.09 |
| 508        | Milton    | Howland   | 5.29 |
| 522        | Arnold    | Havens    | 5.05 |
| 542        | Lonnie    | Tirado    | 5.30 |
| 583        | Marshall  | Thorn     | 5.12 |

Total row: 20

Query ini mirip dengan contoh sebelumnya namun ditambahkan klausa `HAVING`. Kita menggunakan fungsi `AVG()` dalam klausa `HAVING` untuk memfilter kelompok dengan nilai rata-rata lebih besar dari 5.

---

### 6) Menggunakan fungsi PostgreSQL AVG() dengan NULL
Mari kita lihat bagaimana fungsi `AVG()` berperilaku ketika menerima input yang mengandung `NULL`.

Pertama, buat tabel bernama `t1`:

```sql
CREATE TABLE t1 (
  id serial PRIMARY KEY,
  amount INTEGER
);
```

Kedua, masukkan beberapa data sampel:

```sql
INSERT INTO t1 (amount)
VALUES
  (10),
  (NULL),
  (30);
```

Data dalam tabel `t1` adalah sebagai berikut:

```sql
SELECT
  *
FROM
  t1;
```

Ketiga, gunakan fungsi `AVG()` untuk menghitung rata-rata nilai dalam kolom `amount`:

```sql
SELECT AVG(amount)::numeric(10,2)
FROM t1;
```

Output:

| avg   |
|-------|
| 20.00 |

Total row: 1

Hasilnya adalah 20, yang menunjukkan bahwa fungsi `AVG()` mengabaikan nilai `NULL`.

---

#### Ringkasan
- Gunakan fungsi PostgreSQL `AVG()` untuk menghitung nilai rata-rata dari suatu kumpulan data.
- Fungsi `AVG()` mengabaikan `NULL` dalam perhitungan.
- Fungsi `AVG()` mengembalikan `NULL` jika kumpulan data kosong.


---
---
---



# PostgreSQL COUNT Function

## Pengenalan Fungsi PostgreSQL COUNT()
Fungsi `COUNT()` adalah fungsi agregat yang memungkinkan Anda mendapatkan jumlah baris yang sesuai dengan kondisi tertentu.

Pernyataan berikut menunjukkan berbagai cara penggunaan fungsi `COUNT()`.

## COUNT(*)
Fungsi `COUNT(*)` mengembalikan jumlah baris yang dikembalikan oleh pernyataan `SELECT`, termasuk nilai `NULL` dan duplikat.

```sql
SELECT
   COUNT(*)
FROM
   table_name
WHERE
   condition;
```

Ketika Anda menerapkan fungsi `COUNT(*)` ke seluruh tabel, PostgreSQL harus membaca seluruh tabel secara berurutan. Jika Anda menggunakan fungsi `COUNT(*)` pada tabel yang besar, query akan berjalan lambat. Hal ini terkait dengan implementasi MVCC di PostgreSQL.

Karena adanya banyak transaksi yang melihat berbagai keadaan data secara bersamaan, tidak ada cara langsung bagi fungsi `COUNT(*)` untuk menghitung jumlah baris dalam seluruh tabel. Oleh karena itu, PostgreSQL harus membaca semua baris.

## COUNT(column)
Mirip dengan fungsi `COUNT(*)`, fungsi `COUNT(column_name)` mengembalikan jumlah baris yang dikembalikan oleh klausa `SELECT`. Namun, fungsi ini tidak menghitung nilai `NULL` dalam kolom yang ditentukan.

```sql
SELECT
   COUNT(column_name)
FROM
   table_name
WHERE
   condition;
```

## COUNT(DISTINCT column)
Dalam sintaks ini, `COUNT(DISTINCT column_name)` mengembalikan jumlah nilai unik yang bukan `NULL` dalam kolom yang ditentukan.

```sql
SELECT
   COUNT(DISTINCT column_name)
FROM
   table_name
WHERE
   condition;
```

Dalam praktiknya, Anda sering menggunakan fungsi `COUNT()` bersama dengan klausa `GROUP BY` untuk mendapatkan jumlah item dalam setiap kelompok.

Sebagai contoh, Anda dapat menggunakan fungsi `COUNT()` dengan klausa `GROUP BY` untuk menghitung jumlah film dalam setiap kategori film.

## Contoh penggunaan fungsi PostgreSQL COUNT()
Kita akan menggunakan tabel `payment` dalam database sampel sebagai demonstrasi.

![image](https://github.com/user-attachments/assets/38f217c3-329f-488d-9bc8-554836fb726f)

---

### 1) Contoh dasar penggunaan PostgreSQL COUNT(*)
Pernyataan berikut menggunakan fungsi `COUNT(*)` untuk menghitung jumlah transaksi dalam tabel `payment`:

```sql
SELECT
   COUNT(*)
FROM
   payment;
```

Output:

| count  |
|--------|
| 14596  |

Total row: 1

---

### 2) Contoh PostgreSQL COUNT(DISTINCT column)
Untuk mendapatkan jumlah pembayaran unik yang dilakukan oleh pelanggan, gunakan fungsi `COUNT(DISTINCT amount)` seperti contoh berikut:

```sql
SELECT
  COUNT(DISTINCT amount)
FROM
  payment;
```

Output:

| count |
|-------|
| 19    |

Total row: 1

---

### 3) Penggunaan fungsi PostgreSQL COUNT() dengan klausa GROUP BY
Contoh berikut menggunakan fungsi `COUNT()` bersama `GROUP BY` untuk menghitung jumlah pembayaran setiap pelanggan:

```sql
SELECT
  customer_id,
  COUNT(customer_id)
FROM
  payment
GROUP BY
  customer_id;
```

Output:

| customer_id | count |
|-------------|------|
| 184         | 20   |
| 87          | 28   |
| 477         | 21   |
| 273         | 28   |
| ...         | ...  |

Total row: (jumlah sesuai hasil sebenarnya)

Jika Anda ingin menampilkan nama pelanggan alih-alih ID, Anda bisa menggabungkan tabel `payment` dengan tabel `customer`:

```sql
SELECT
  first_name || ' ' || last_name AS full_name,
  COUNT(customer_id)
FROM
  payment
INNER JOIN customer USING(customer_id)
GROUP BY
  customer_id;
```

Output:

| full_name         | count |
|------------------|------|
| Vivian Ruiz      | 20   |
| Wanda Patterson  | 28   |
| Dan Paine        | 21   |
| Priscilla Lowe   | 28   |
| ...              | ...  |

Total row: (jumlah sesuai hasil sebenarnya)

---

### 4) Penggunaan fungsi PostgreSQL COUNT() dengan klausa HAVING
Anda dapat menggunakan fungsi `COUNT()` dalam klausa `HAVING` untuk menerapkan kondisi tertentu pada kelompok. Contoh berikut mencari pelanggan yang telah melakukan lebih dari 40 pembayaran:

```sql
SELECT
  first_name || ' ' || last_name AS full_name,
  COUNT(customer_id)
FROM
  payment
INNER JOIN customer USING(customer_id)
GROUP BY
  customer_id
HAVING
  COUNT(customer_id) > 40;
```

Output:

| full_name   | count |
|------------|------|
| Karl Seal  | 42   |
| Eleanor Hunt | 45 |

Total row: 2

---

#### Ringkasan
- Gunakan fungsi PostgreSQL `COUNT()` untuk mendapatkan jumlah baris dalam tabel.

---

---

---
