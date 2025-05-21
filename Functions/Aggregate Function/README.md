- [PostgreSQL AVG Function](#postgresql-avg-function)
- [PostgreSQL COUNT Function](#postgresql-count-function)
- [PostgreSQL MAX Function](#postgresql-max-function)
- [PostgreSQL MIN Function](#postgresql-min-function)
- [PostgreSQL SUM Function](#postgresql-sum-function)

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


# PostgreSQL MAX Function

**Ringkasan**: Dalam tutorial ini, Anda akan belajar bagaimana menggunakan fungsi PostgreSQL `MAX()` untuk mendapatkan nilai maksimum dari sekumpulan nilai.

## Pengenalan Fungsi PostgreSQL MAX()
Fungsi PostgreSQL `MAX()` adalah fungsi agregat yang mengembalikan nilai maksimum dalam suatu kumpulan nilai.

Fungsi `MAX()` dapat berguna dalam banyak kasus. Misalnya, Anda dapat menggunakannya untuk menemukan karyawan dengan gaji tertinggi atau mengidentifikasi produk yang paling mahal.

Berikut sintaks dari fungsi `MAX()`:

```sql
MAX(expression);
```

Anda dapat menggunakan fungsi `MAX()` tidak hanya dalam klausa `SELECT`, tetapi juga dalam klausa `WHERE` dan `HAVING`.

## Contoh Penggunaan Fungsi PostgreSQL MAX()
Mari kita lihat beberapa contoh penggunaan fungsi `MAX()`. Kita akan menggunakan tabel `payment` dari database sampel.

![image](https://github.com/user-attachments/assets/b2974f2c-9ae3-4db2-b85a-a2adddc5b751)

---

### 1) Contoh dasar penggunaan fungsi PostgreSQL MAX()
Query berikut menggunakan fungsi `MAX()` untuk menemukan jumlah pembayaran tertinggi yang dilakukan oleh pelanggan dalam tabel `payment`:

```sql
SELECT
  MAX(amount)
FROM
  payment;
```

Output:

| max   |
|-------|
| 11.99 |

Total row: 1

---

### 2) Menggunakan fungsi PostgreSQL MAX() dalam subquery
Contoh berikut menggunakan fungsi `MAX()` dalam subquery untuk mendapatkan informasi pembayaran secara lebih rinci:

```sql
SELECT
  payment_id,
  customer_id,
  amount
FROM
  payment
WHERE
  amount = (
    SELECT
      MAX(amount)
    FROM
      payment
  );
```

Output:

| payment_id | customer_id | amount |
|------------|-------------|--------|
| 20403      | 362         | 11.99  |
| 22650      | 204         | 11.99  |
| 23757      | 116         | 11.99  |
| ...        | ...         | ...    |

Total row: (jumlah sesuai hasil sebenarnya)

Cara kerja:
- Pertama, subquery menggunakan fungsi `MAX()` untuk mengembalikan jumlah pembayaran tertinggi.
- Kedua, query utama mengambil semua pembayaran yang jumlahnya sama dengan nilai tertinggi yang dikembalikan oleh subquery.

---

### 3) Menggunakan fungsi PostgreSQL MAX() dengan klausa GROUP BY
Anda dapat menggabungkan fungsi `MAX()` dengan klausa `GROUP BY` untuk mendapatkan nilai maksimum dalam setiap kelompok.

Contoh berikut menggunakan fungsi `MAX()` dengan klausa `GROUP BY` untuk mengambil jumlah pembayaran tertinggi yang dilakukan oleh setiap pelanggan:

```sql
SELECT
  customer_id,
  MAX(amount)
FROM
  payment
GROUP BY
  customer_id;
```

Output:

| customer_id | max   |
|-------------|------|
| 184         | 9.99  |
| 87          | 10.99 |
| 477         | 10.99 |
| 273         | 8.99  |
| ...         | ...   |

Total row: (jumlah sesuai hasil sebenarnya)

---

### 4) Menggunakan fungsi PostgreSQL MAX() dengan klausa HAVING
Jika Anda menggunakan fungsi `MAX()` dalam klausa `HAVING`, Anda dapat menerapkan filter untuk suatu kelompok.

Contoh berikut menggunakan fungsi `MAX()` untuk memilih jumlah pembayaran tertinggi yang dilakukan oleh setiap pelanggan dan hanya menampilkan transaksi dengan jumlah lebih dari 8.99:

```sql
SELECT
  customer_id,
  MAX(amount)
FROM
  payment
GROUP BY
  customer_id
HAVING
  MAX(amount) > 8.99;
```

Output:

| customer_id | max   |
|-------------|------|
| 184         | 9.99  |
| 87          | 10.99 |
| 477         | 10.99 |
| 550         | 10.99 |
| 51          | 9.99  |
| ...         | ...   |

Total row: (jumlah sesuai hasil sebenarnya)

---

#### Ringkasan
- Gunakan fungsi PostgreSQL `MAX()` untuk menemukan nilai maksimum dalam suatu kumpulan data.

---
---
---

# PostgreSQL MIN Function

**Ringkasan**: Dalam tutorial ini, Anda akan belajar cara menggunakan fungsi PostgreSQL `MIN()` untuk mendapatkan nilai minimum dari sekumpulan data.

## Pengenalan Fungsi PostgreSQL MIN()
Fungsi PostgreSQL `MIN()` adalah fungsi agregat yang mengembalikan nilai minimum dalam suatu kumpulan data.

Untuk menemukan nilai minimum dalam sebuah kolom tabel, Anda memberikan nama kolom tersebut ke dalam fungsi `MIN()`. Tipe data kolom dapat berupa numerik, string, atau tipe data lain yang dapat dibandingkan.

Berikut sintaks dasar dari fungsi `MIN()`:

```sql
MIN(expression)
```

Tidak seperti fungsi `AVG()`, `COUNT()`, dan `SUM()`, opsi `DISTINCT` tidak memiliki efek pada fungsi `MIN()`.

## Contoh Penggunaan Fungsi PostgreSQL MIN()
Kita akan menggunakan tabel `film`, `film_category`, dan `category` dari database sampel *dvdrental* sebagai demonstrasi.

![image](https://github.com/user-attachments/assets/52d78823-b2b3-47b8-a213-9d31155404fc)

---

### 1) Contoh dasar penggunaan fungsi PostgreSQL MIN()
Contoh berikut menggunakan fungsi `MIN()` untuk mendapatkan tarif sewa terendah dari kolom `rental_rate` dalam tabel `film`:

```sql
SELECT
   MIN(rental_rate)
FROM
   film;
```

Output:

| min  |
|------|
| 0.99 |

Total row: 1

Query ini menghasilkan 0.99, yang merupakan tarif sewa terendah.

---

### 2) Menggunakan fungsi PostgreSQL MIN() dalam subquery
Contoh berikut menggunakan fungsi `MIN()` dalam subquery untuk mendapatkan informasi film dengan tarif sewa terendah:

```sql
SELECT
  film_id,
  title,
  rental_rate
FROM
  film
WHERE
  rental_rate = (
    SELECT
      MIN(rental_rate)
    FROM
      film
  );
```

Output:

| film_id | title               | rental_rate |
|---------|---------------------|-------------|
| 1       | Academy Dinosaur    | 0.99        |
| 11      | Alamo Videotape     | 0.99        |
| 12      | Alaska Phantom      | 0.99        |
| 213     | Date Speed          | 0.99        |
| ...     | ...                 | ...         |

Total row: (jumlah sesuai hasil sebenarnya)

Cara kerja:
- Pertama, subquery memilih tarif sewa terendah.
- Kemudian, query utama memilih film dengan tarif sewa yang sama dengan nilai terendah yang dikembalikan oleh subquery.

---

### 3) Menggunakan fungsi PostgreSQL MIN() dengan klausa GROUP BY
Dalam praktiknya, Anda sering menggunakan fungsi `MIN()` bersama dengan klausa `GROUP BY` untuk menemukan nilai terendah dalam setiap kelompok.

Contoh berikut menggunakan fungsi `MIN()` dengan klausa `GROUP BY` untuk menemukan biaya penggantian terendah dari film berdasarkan kategori:

```sql
SELECT
  name AS category,
  MIN(replacement_cost) AS replacement_cost
FROM
  category
  INNER JOIN film_category USING (category_id)
  INNER JOIN film USING (film_id)
GROUP BY
  name
ORDER BY
  name;
```

Output:

| category   | replacement_cost |
|-----------|------------------|
| Action    | 9.99             |
| Animation | 9.99             |
| Children  | 9.99             |
| Classics  | 10.99            |
| Comedy    | 9.99             |
| ...       | ...              |

Total row: (jumlah sesuai hasil sebenarnya)

---

### 4) Menggunakan fungsi PostgreSQL MIN() dengan klausa HAVING
Anda dapat menggunakan fungsi `MIN()` dalam klausa `HAVING` untuk memfilter kelompok dengan nilai minimum yang memenuhi kondisi tertentu.

Contoh berikut menggunakan fungsi `MIN()` untuk menemukan biaya penggantian terendah dari film yang dikelompokkan berdasarkan kategori, hanya menampilkan kelompok dengan biaya penggantian lebih dari 9.99:

```sql
SELECT
  name AS category,
  MIN(replacement_cost) AS replacement_cost
FROM
  category
  INNER JOIN film_category USING (category_id)
  INNER JOIN film USING (film_id)
GROUP BY
  name
HAVING
  MIN(replacement_cost) > 9.99
ORDER BY
  name;
```

Output:

| category  | replacement_cost |
|----------|------------------|
| Classics | 10.99            |
| Horror   | 10.99            |
| Music    | 10.99            |

Total row: 3

---

### 5) Menggunakan fungsi PostgreSQL MIN() dengan fungsi agregat lainnya
Anda dapat menggunakan fungsi `MIN()` bersama dengan fungsi agregat lainnya seperti `MAX()` dalam query yang sama.

Contoh berikut menggunakan fungsi `MIN()` dan `MAX()` untuk menemukan durasi film terpendek dan terpanjang berdasarkan kategori:

```sql
SELECT
  name AS category,
  MIN(length) AS min_length,
  MAX(length) AS max_length
FROM
  category
  INNER JOIN film_category USING (category_id)
  INNER JOIN film USING (film_id)
GROUP BY
  name
ORDER BY
  name;
```

Output:

| category   | min_length | max_length |
|-----------|-----------|-----------|
| Action    | 47        | 185       |
| Animation | 49        | 185       |
| Children  | 46        | 178       |
| Classics  | 46        | 184       |
| Comedy    | 47        | 185       |
| ...       | ...       | ...       |

Total row: 16

---

#### Ringkasan
- Gunakan fungsi `MIN()` untuk menemukan nilai terendah dalam suatu kumpulan data.
- Gunakan fungsi `MIN()` dengan klausa `GROUP BY` untuk menemukan nilai terendah dalam setiap kelompok data.

---
---
---


# PostgreSQL SUM Function

**Ringkasan**: Dalam tutorial ini, Anda akan belajar cara menggunakan fungsi PostgreSQL `SUM()` untuk menghitung jumlah dari sekumpulan nilai.

## Pengenalan Fungsi PostgreSQL SUM()
Fungsi PostgreSQL `SUM()` adalah fungsi agregat yang mengembalikan jumlah dari sekumpulan nilai.

Berikut sintaks dasar dari fungsi `SUM()`:

```sql
SUM(DISTINCT expression)
```

Fungsi `SUM()` mengabaikan nilai `NULL`, yang berarti nilai `NULL` tidak diperhitungkan dalam proses perhitungan.

Jika Anda menggunakan opsi `DISTINCT`, fungsi `SUM()` hanya akan menghitung jumlah dari nilai unik.

Sebagai contoh, tanpa opsi `DISTINCT`, `SUM()` dari nilai 1, 1, dan 2 akan menghasilkan 4. Namun, jumlah dari nilai unik 1, 1, dan 2 akan menghasilkan 3 (1 + 2) karena fungsi `SUM()` mengabaikan satu nilai duplikat (1).

Fungsi `SUM()` dari sekumpulan data kosong akan menghasilkan `NULL`, bukan nol.

## Contoh Penggunaan Fungsi PostgreSQL SUM()
Mari kita lihat beberapa contoh penggunaan fungsi `SUM()`. Kita akan menggunakan tabel `payment` dari database sampel.

![image](https://github.com/user-attachments/assets/f89e4520-ade1-4c1a-b913-47f87c85b847)

---

### 1) Menggunakan fungsi PostgreSQL SUM() dalam pernyataan SELECT
Contoh berikut menggunakan fungsi `SUM()` untuk menghitung total semua pembayaran dalam tabel `payment`:

```sql
SELECT
  SUM(amount)
FROM
  payment;
```

Output:

| sum      |
|---------|
| 61312.04 |

Total row: 1

---

### 2) Menggunakan fungsi PostgreSQL SUM() dengan kumpulan hasil kosong
Pernyataan berikut menggunakan fungsi `SUM()` untuk menghitung total pembayaran dari pelanggan dengan `customer_id` 2000:

```sql
SELECT
  SUM(amount)
FROM
  payment
WHERE
  customer_id = 2000;
```

Output:

| sum   |
|-------|
| null  |

Total row: 1

Dalam contoh ini, fungsi `SUM()` mengembalikan `NULL` karena tabel `payment` tidak memiliki baris dengan `customer_id` 2000.

---

### 3) Menggunakan fungsi SUM() dengan fungsi COALESCE()
Jika Anda ingin fungsi `SUM()` mengembalikan nol alih-alih `NULL` ketika tidak ada baris yang sesuai, gunakan fungsi `COALESCE()`.

Fungsi `COALESCE()` mengembalikan argumen pertama yang tidak `NULL`. Dengan kata lain, jika argumen pertama adalah `NULL`, maka ia mengembalikan argumen kedua.

Berikut contoh penggunaan `SUM()` dengan `COALESCE()`:

```sql
SELECT
  COALESCE(SUM(amount), 0) AS total
FROM
  payment
WHERE
  customer_id = 2000;
```

Output:

| total |
|-------|
| 0     |

Total row: 1

Jika ingin dalam bentuk text, Anda dapat melakukan casting terlebih dahulu

```sql
SELECT
  COALESCE(CAST(SUM(amount) AS TEXT), 'no row') AS total
FROM
  payment
WHERE
  customer_id = 2000;
```

Output :

| total      |
|------------|
| no row     |

---

### 4) Menggunakan fungsi PostgreSQL SUM() dengan klausa GROUP BY
Untuk menghitung total dalam setiap kelompok, gunakan klausa `GROUP BY` untuk mengelompokkan baris dalam tabel, kemudian terapkan fungsi `SUM()` pada masing-masing kelompok.

Contoh berikut menggunakan fungsi `SUM()` dengan `GROUP BY` untuk menghitung total jumlah pembayaran yang dilakukan oleh setiap pelanggan:

```sql
SELECT
  customer_id,
  SUM(amount) AS total
FROM
  payment
GROUP BY
  customer_id
ORDER BY
  total;
```

Output:

| customer_id | total  |
|-------------|--------|
| 318         | 27.93  |
| 281         | 32.90  |
| 248         | 37.87  |
| 320         | 47.85  |
| ...         | ...    |

Total row: (jumlah sesuai hasil sebenarnya)

Berikut query untuk mengambil lima pelanggan yang melakukan pembayaran tertinggi:

```sql
SELECT
  customer_id,
  SUM(amount) AS total
FROM
  payment
GROUP BY
  customer_id
ORDER BY
  total DESC
LIMIT
  5;
```

Output:

| customer_id | total  |
|-------------|--------|
| 148         | 211.55 |
| 526         | 208.58 |
| 178         | 194.61 |
| 137         | 191.62 |
| 144         | 189.60 |

Total row: 5

---

### 5) Menggunakan fungsi PostgreSQL SUM() dengan klausa HAVING
Untuk memfilter kelompok berdasarkan kondisi tertentu, gunakan fungsi `SUM()` dalam klausa `HAVING`.

Contoh berikut mengambil daftar pelanggan yang telah melakukan pembayaran lebih dari 200:

```sql
SELECT
  customer_id,
  SUM(amount) AS total
FROM
  payment
GROUP BY
  customer_id
HAVING
  SUM(amount) > 200
ORDER BY
  total DESC;
```

Output:

| customer_id | total  |
|-------------|--------|
| 148         | 211.55 |
| 526         | 208.58 |

Total row: 2

---

### 6) Menggunakan fungsi PostgreSQL SUM() dengan ekspresi
Berikut tabel `rental` dari database sampel:

![image](https://github.com/user-attachments/assets/4a1d97b9-9b0d-425e-88a2-c1c0bdcdfa5e)



### 6) Menggunakan fungsi PostgreSQL SUM() dengan ekspresi
Pernyataan berikut menggunakan fungsi `SUM()` untuk menghitung total hari sewa:

```sql
SELECT
  SUM(return_date - rental_date)
FROM
  rental;
```

Output:

| sum                     |
|-------------------------|
| 71786 days 190098:21:00 |

Total row: 1

Cara kerja:
- Pertama, menghitung durasi penyewaan dengan mengurangi tanggal penyewaan dari tanggal pengembalian.
- Kedua, menerapkan fungsi `SUM()` pada ekspresi tersebut.

Contoh berikut menggunakan fungsi `SUM()` untuk menghitung total durasi penyewaan berdasarkan pelanggan:

```sql
SELECT
  first_name || ' ' || last_name AS full_name,
  SUM(return_date - rental_date) AS rental_duration
FROM
  rental
  INNER JOIN customer USING(customer_id)
GROUP BY
  customer_id
ORDER BY
  full_name;
```

Output:

| full_name      | rental_duration        |
|----------------|------------------------|
| Aaron Selby    | 109 days 273:34:00     |
| Adam Gooch     | 106 days 245:18:00     |
| Adrian Clary   | 90 days 286:00:00      |
| Agnes Bishop   | 97 days 339:40:00      |
| ...            | ...                    |

Total row: (jumlah sesuai hasil sebenarnya)

---

#### Ringkasan
- Gunakan fungsi `SUM()` untuk menghitung jumlah nilai dalam suatu kumpulan data.
- Gunakan opsi `DISTINCT` dalam fungsi `SUM()` untuk menghitung jumlah nilai yang unik.
- Gunakan fungsi `SUM()` dengan klausa `GROUP BY` untuk menghitung jumlah nilai dalam setiap kelompok.

---
