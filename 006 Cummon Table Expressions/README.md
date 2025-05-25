# Panduan PostgreSQL Common Table Expression

## Daftar Isi

- [PostgreSQL CTE](#postgresql-cte)
- [PostgreSQL RECURSIVE CTE](#postgresql-recursive-cte)

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

---
---
---
---
---
---
---
---
---
---

# PostgreSQL RECURSIVE CTE

**Summary**: in this tutorial, you will learn about the PostgreSQL recursive query using recursive common table expressions or CTEs.

## Introduction to the PostgreSQL recursive query

In PostgreSQL, a `common table expression` (CTE) is a named temporary result set within a query.

A recursive CTE allows you to perform recursion within a query using the `WITH RECURSIVE` syntax.

A recursive CTE is often referred to as a recursive query.

Here’s the basic syntax of a recursive CTE:

```sql
WITH RECURSIVE cte_name (column1, column2, ...)
AS(
    -- anchor member
    SELECT select_list FROM table1 WHERE condition

    UNION [ALL]

    -- recursive term
    SELECT select_list FROM cte_name WHERE recursive_condition
)
SELECT * FROM cte_name;
```

In this syntax:

- `cte_name`: Specify the name of the CTE. You can reference this CTE name in the subsequent parts of the query.
- `column1`, `column2`, … Specify the columns selected in both the anchor and recursive members. These columns define the CTE’s structure.
- Anchor member: Responsible for forming the base result set of the CTE structure.
- Recursive member: Refer to the CTE name itself. It combines with the anchor member using the `UNION` or `UNION ALL` operator.
- `recursive_condition`: Is a condition used in the recursive member that determines how the recursion stops.

PostgreSQL executes a recursive CTE in the following sequence:

- First, execute the anchor member to create the base result set (R0\).
- Second, execute the recursive member with Ri as an input to return the result set Ri\+1 as the output.
- Third, repeat step 2 until an empty set is returned. (termination check)
- Finally, return the final result set that is a `UNION` or `UNION ALL` of the result sets R0, R1, … Rn.

A recursive CTE can be useful when dealing with hierarchical or nested data structures, such as trees or graphs.

## PostgreSQL recursive query example

Let’s take an example of using a recursive query.

### 1) Setting up a sample table

First, create a new table called employees:

```sql
CREATE TABLE employees (
  employee_id SERIAL PRIMARY KEY,
  full_name VARCHAR NOT NULL,
  manager_id INT
);
```

The `employees` table has three columns: `employee_id`, `full_name`, and `manager_id`. The `manager_id` column specifies the manager id of an employee.

Second, insert some rows into the `employees` table:

```sql
INSERT INTO employees (employee_id, full_name, manager_id)
VALUES
  (1, 'Michael North', NULL),
  (2, 'Megan Berry', 1),
  (3, 'Sarah Berry', 1),
  (4, 'Zoe Black', 1),
  (5, 'Tim James', 1),
  (6, 'Bella Tucker', 2),
  (7, 'Ryan Metcalfe', 2),
  (8, 'Max Mills', 2),
  (9, 'Benjamin Glover', 2),
  (10, 'Carolyn Henderson', 3),
  (11, 'Nicola Kelly', 3),
  (12, 'Alexandra Climo', 3),
  (13, 'Dominic King', 3),
  (14, 'Leonard Gray', 4),
  (15, 'Eric Rampling', 4),
  (16, 'Piers Paige', 7),
  (17, 'Ryan Henderson', 7),
  (18, 'Frank Tucker', 8),
  (19, 'Nathan Ferguson', 8),
  (20, 'Kevin Rampling', 8);
```

### 2) Basic PostgreSQL recursive query example

The following statement uses a recursive CTE to find all subordinates of the manager with the id 2\.

```sql
WITH RECURSIVE subordinates AS (
  SELECT
    employee_id,
    manager_id,
    full_name
  FROM
    employees
  WHERE
    employee_id = 2
  UNION
  SELECT
    e.employee_id,
    e.manager_id,
    e.full_name
  FROM
    employees e
    INNER JOIN subordinates s ON s.employee_id = e.manager_id
)
SELECT * FROM subordinates;
```

Output:

| employee_id | manager_id | full_name        |
|------------|------------|-----------------|
| 2          | 1          | Megan Berry     |
| 6          | 2          | Bella Tucker    |
| 7          | 2          | Ryan Metcalfe   |
| 8          | 2          | Max Mills       |
| 9          | 2          | Benjamin Glover |
| 16         | 7          | Piers Paige     |
| 17         | 7          | Ryan Henderson  |
| 18         | 8          | Frank Tucker    |
| 19         | 8          | Nathan Ferguson |
| 20         | 8          | Kevin Rampling  |

(10 rows)


How it works:

- The recursive CTE `subordinates` defines an anchor member and a recursive member.
- The anchor member returns the base result set R0 which is the employee with the id 2\.

| employee_id | manager_id | full_name    |
|------------|------------|-------------|
| 2          | 1          | Megan Berry |

(1 row)


The recursive member returns the direct subordinate(s) of the employee id 2. This is the result of joining between the `employees` table and the `subordinates` CTE. The first iteration of the recursive term returns the following result set:

| employee_id | manager_id | full_name       |
|------------|------------|-----------------|
| 6          | 2          | Bella Tucker    |
| 7          | 2          | Ryan Metcalfe   |
| 8          | 2          | Max Mills       |
| 9          | 2          | Benjamin Glover |

(4 rows)


PostgreSQL executes the recursive member repeatedly. The second iteration of the recursive member uses the result set above step as the input value, and returns this result set:

| employee_id | manager_id | full_name       |
|------------|------------|-----------------|
| 16         | 7          | Piers Paige     |
| 17         | 7          | Ryan Henderson  |
| 18         | 8          | Frank Tucker    |
| 19         | 8          | Nathan Ferguson |
| 20         | 8          | Kevin Rampling  |

(5 rows)


The third iteration returns an empty result set because no employee is reporting to the employee with the id 16, 17, 18, 19, and 20.

PostgreSQL returns the final result set which is the union of all result sets in the first and second iterations generated by the non-recursive and recursive members.

| employee_id | manager_id | full_name       |
|------------|------------|-----------------|
| 2          | 1          | Megan Berry     |
| 6          | 2          | Bella Tucker    |
| 7          | 2          | Ryan Metcalfe   |
| 8          | 2          | Max Mills       |
| 9          | 2          | Benjamin Glover |
| 16         | 7          | Piers Paige     |
| 17         | 7          | Ryan Henderson  |
| 18         | 8          | Frank Tucker    |
| 19         | 8          | Nathan Ferguson |
| 20         | 8          | Kevin Rampling  |

(10 rows)


## Summary

- Use the `WITH RECURSIVE` syntax to define a recursive query.
- Use a recursive query to deal with hierarchical or nested data structures such as trees or graphs.
