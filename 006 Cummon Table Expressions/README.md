# Panduan PostgreSQL Common Table Expression

## Daftar Isi

- [PostgreSQL CTE](#postgresql-cte)

# PostgreSQL CTE

**Ringkasan**: Dalam tutorial ini, Anda akan belajar cara menggunakan *Common Table Expression* (CTE) PostgreSQL untuk menyederhanakan query yang kompleks.

## Pengenalan Common Table Expression (CTE) di PostgreSQL

*Common Table Expression* (CTE) memungkinkan Anda membuat hasil sementara dalam sebuah query.

CTE membantu meningkatkan keterbacaan query kompleks dengan membaginya menjadi bagian yang lebih kecil dan lebih dapat digunakan kembali.

### Sintaks Dasar CTE

```sql
WITH cte_name (column1, column2, ...) AS (
    -- Query CTE
    SELECT ...
)
-- Query utama yang menggunakan CTE
SELECT ...
FROM cte_name;
```

Penjelasan sintaks:
- **WITH clause**: Memperkenalkan *Common Table Expression* (CTE). Setelahnya terdapat nama CTE dan daftar kolom dalam tanda kurung (opsional).
- **CTE name**: Menentukan nama CTE yang bersifat unik dalam query.
- **Column List (opsional)**: Jika tidak ditentukan, kolom akan mengikuti nama dari hasil `SELECT` dalam CTE.
- **AS keyword**: Menandakan awal definisi CTE.
- **CTE query**: Query yang mendefinisikan CTE dan dapat mencakup `JOIN`, `WHERE`, `GROUP BY`, dan lainnya.
- **Main query**: Setelah CTE didefinisikan, Anda dapat merujuknya dalam query utama seperti tabel biasa, sehingga menyederhanakan struktur query yang kompleks.

---

## Contoh Penggunaan CTE di PostgreSQL

### 1) Contoh Dasar Common Table Expression

Berikut contoh penggunaan CTE untuk memilih `title` dan `length` film dalam kategori `'Action'` dan mengembalikan semua kolom dari CTE:

```sql
WITH action_films AS (
  SELECT
    f.title,
    f.length
  FROM film f
  INNER JOIN film_category fc USING (film_id)
  INNER JOIN category c USING (category_id)
  WHERE c.name = 'Action'
)
SELECT * FROM action_films;
```

**Output:**

|          title          | length |
|-------------------------|--------|
| Amadeus Holy            |    113 |
| American Circus         |    129 |
| Antitrust Tomatoes      |    168 |
| Ark Ridgemont           |     68 |
| ...                     | ...    |

Penjelasan:
- CTE `action_films` menggabungkan data dari tiga tabel (`film`, `film_category`, `category`).
- Query utama mengambil data dari CTE dengan `SELECT * FROM action_films`.

---

### 2) Menggunakan CTE dengan JOIN

Kita akan menggunakan tabel `rental` dan `staff` dalam contoh berikut.

Berikut contoh penggunaan CTE untuk mencari jumlah transaksi rental oleh setiap staf:

```sql
WITH cte_rental AS (
  SELECT
    staff_id,
    COUNT(rental_id) AS rental_count
  FROM rental
  GROUP BY staff_id
)
SELECT
  s.staff_id,
  first_name,
  last_name,
  rental_count
FROM staff s
INNER JOIN cte_rental USING (staff_id);
```

Penjelasan:
- CTE `cte_rental` mengambil `staff_id` dan jumlah transaksi rental.
- Query utama menggabungkan tabel `staff` dengan CTE berdasarkan `staff_id`.

**Output:**

| staff_id | first_name | last_name | rental_count |
|----------|------------|-----------|--------------|
|        1 | Mike       | Hillyer   |         8040 |
|        2 | Jon        | Stephens  |         8004 |
| ...      | ...        | ...       | ...          |

(2 rows)


---

### 3) Contoh Menggunakan Multiple CTEs

Berikut contoh penggunaan beberapa CTE untuk menghitung statistik film dan pelanggan:

```sql
WITH film_stats AS (
    SELECT
        AVG(rental_rate) AS avg_rental_rate,
        MAX(length) AS max_length,
        MIN(length) AS min_length
    FROM film
),
customer_stats AS (
    SELECT
        COUNT(DISTINCT customer_id) AS total_customers,
        SUM(amount) AS total_payments
    FROM payment
)
SELECT
    ROUND((SELECT avg_rental_rate FROM film_stats), 2) AS avg_film_rental_rate,
    (SELECT max_length FROM film_stats) AS max_film_length,
    (SELECT min_length FROM film_stats) AS min_film_length,
    (SELECT total_customers FROM customer_stats) AS total_customers,
    (SELECT total_payments FROM customer_stats) AS total_payments;
```

**Output:**

| avg_film_rental_rate | max_film_length | min_film_length | total_customers | total_payments |
|----------------------|-----------------|-----------------|-----------------|----------------|
|                 2.98 |             185 |              46 |             599 |       61312.04 |

(1 row)

Penjelasan:
- **CTE `film_stats`** menghitung rata-rata harga rental, panjang maksimum, dan panjang minimum film.
- **CTE `customer_stats`** menghitung total pelanggan dan jumlah pembayaran yang dilakukan.
- Query utama mengambil nilai dari masing-masing CTE untuk menghasilkan laporan ringkasan.

---

## Keunggulan Penggunaan CTE di PostgreSQL

Berikut beberapa keuntungan menggunakan *Common Table Expression* (CTE):

- **Meningkatkan keterbacaan query kompleks** – Mengorganisir query dalam bagian yang lebih terstruktur dan mudah dipahami.
- **Mendukung query rekursif** – Berguna untuk menangani data hierarkis seperti struktur organisasi.
- **Dapat digunakan dengan fungsi *window*** – CTE bisa digabungkan dengan fungsi *window* untuk mengolah dataset secara bertahap.

---

## Ringkasan

- Gunakan *Common Table Expression* (CTE) untuk membuat hasil sementara dalam query.
- Manfaatkan CTE untuk menyederhanakan dan meningkatkan keterbacaan query yang kompleks.

Semoga membantu! Jika ada hal lain yang perlu diperbaiki, beri tahu saya! 🚀
