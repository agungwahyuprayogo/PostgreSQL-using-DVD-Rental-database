# PostgreSQL SELECT

Salah satu tugas paling umum ketika kita bekerja dengan database adalah mengambil data dari tabel menggunakan pernyataan `SELECT`.

Pernyataan `SELECT` adalah salah satu pernyataan paling kompleks di PostgreSQL. Pernyataan ini memiliki banyak klausa yang dapat digunakan 
untuk membentuk query yang fleksibel.

query (sekumpulan instruksi yang bisa digunakan untuk bekerja dengan data) 

Karena kompleksitasnya, kita akan membaginya menjadi banyak tutorial yang lebih pendek dan mudah dipahami sehingga dapat mempelajari 
setiap klausa lebih cepat.

Pernyataan `SELECT` memiliki klausa-klausa berikut:

- Memilih baris yang unik menggunakan operator `DISTINCT`.
- Mengurutkan baris menggunakan klausa `ORDER BY`.
- Menyaring baris menggunakan klausa `WHERE`.
- Memilih sebagian baris dari tabel menggunakan klausa `LIMIT` atau `FETCH`.
- Mengelompokkan baris menjadi kelompok-kelompok menggunakan klausa `GROUP BY`.
- Menyaring kelompok menggunakan klausa `HAVING`.
- Menggabungkan dengan tabel lain menggunakan join seperti klausa `INNER JOIN`, `LEFT JOIN`, `FULL OUTER JOIN`, `CROSS JOIN`.
- Melakukan operasi set menggunakan `UNION`, `INTERSECT`, dan `EXCEPT`.

## PostgreSQL SELECT statement syntax
Mari kita mulai dengan bentuk dasar pernyataan `SELECT` yang mengambil data dari satu tabel.

Berikut ini adalah sintaks dari pernyataan `SELECT`:

```
SELECT
   select_list
FROM
   table_name;
```

- Pertama, tentukan daftar kolom yang dapat berupa satu kolom atau daftar kolom dalam tabel dari mana Anda ingin mengambil data. Jika Anda menentukan daftar kolom, Anda perlu menempatkan tanda koma (`,`) di antara dua kolom untuk memisahkannya. Jika Anda ingin memilih data dari semua kolom dalam tabel, Anda dapat menggunakan tanda bintang (`*`) sebagai pengganti semua nama kolom. Daftar kolom juga dapat berisi ekspresi atau nilai literal.
- Kedua, berikan nama tabel dari mana Anda ingin mengambil data setelah kata kunci `FROM`.

Klausa `FROM` bersifat opsional. Jika Anda tidak mengambil data dari tabel apa pun, Anda dapat mengabaikan klausa `FROM` dalam pernyataan `SELECT`.

PostgreSQL mengevaluasi klausa `FROM` sebelum klausa `SELECT` dalam pernyataan `SELECT`:

![image](https://github.com/user-attachments/assets/35bb63a4-df25-43d1-9a22-cee24e98ed34)

Perlu diperhatikan bahwa kata kunci SQL tidak peka huruf besar/kecil. Artinya `SELECT` setara dengan `select` atau `Select`. 
Untuk kemudahan membaca, kita akan menggunakan semua kata kunci SQL dengan huruf besar.

## Contoh PostgreSQL SELECT

Mari kita eksplorasi beberapa contoh penggunaan pernyataan `SELECT`.

Kita akan menggunakan tabel `customer` dalam database sampel `dvdrental` untuk demonstrasi.

![image](https://github.com/user-attachments/assets/6b8a1c85-235d-4cf3-add5-23d766490c43)

### 1) Menggunakan pernyataan PostgreSQL SELECT untuk mengambil data dari satu kolom

Contoh ini menggunakan pernyataan `SELECT` untuk menemukan nama depan semua pelanggan dari tabel customer:

```
SELECT first_name FROM customer;
```

Berikut adalah sebagian output:

```
first_name
-------------
 Jared
 Mary
 Patricia
 Linda
 Barbara
...
```

Perhatikan bahwa kita menambahkan tanda titik koma (`;`) di akhir pernyataan SELECT. Tanda titik koma bukanlah bagian dari pernyataan SQL; melainkan, ini berfungsi sebagai sinyal bagi PostgreSQL bahwa pernyataan SQL telah selesai. Selain itu, tanda titik koma digunakan untuk memisahkan dua atau lebih pernyataan SQL.

### 2) Menggunakan pernyataan PostgreSQL SELECT untuk mengambil data dari beberapa kolom
Kueri berikut menggunakan pernyataan `SELECT` untuk mengambil nama depan, nama belakang, dan email pelanggan dari tabel `customer`:

```
SELECT
   first_name,
   last_name,
   email
FROM
   customer;
```

Sebagian output:

```
first_name  |  last_name   |                  email
-------------+--------------+------------------------------------------
 Jared       | Ely          | jared.ely@sakilacustomer.org
 Mary        | Smith        | mary.smith@sakilacustomer.org
 Patricia    | Johnson      | patricia.johnson@sakilacustomer.org
...
```
Output menunjukkan tiga kolom yang sesuai yaitu first_name, last_name, dan email.

### 3) Menggunakan pernyataan PostgreSQL SELECT untuk mengambil data dari semua kolom dalam tabel

Kueri berikut menggunakan pernyataan `SELECT *` untuk mengambil data dari semua kolom tabel `customer`:

```
SELECT * FROM customer;
```

Sebagian output:

```
customer_id | store_id | first_name  |  last_name    |                  email                                    | address_id | activebool | create_date |       last_update       | active
-------------+----------+-------------+--------------+------------------------------------------+------------+------------+-------------+-------------------------+--------
         524 |        1 | Jared       | Ely          | [[email protected]](../cdn-cgi/l/email-protection.html)   |        530 | t          | 2006-02-14  | 2013-05-26 14:49:45.738 |      1
           1 |        1 | Mary        | Smith        | [[email protected]](../cdn-cgi/l/email-protection.html)   |          5 | t          | 2006-02-14  | 2013-05-26 14:49:45.738 |      1
           2 |        1 | Patricia    | Johnson      | [[email protected]](../cdn-cgi/l/email-protection.html)   |          6 | t          | 2006-02-14  | 2013-05-26 14:49:45.738 |      1
...
```

Dalam contoh ini, kita menggunakan tanda bintang (`*`) dalam klausa `SELECT`, yang berfungsi sebagai pengganti semua kolom.

Alih-alih mencantumkan semua kolom dalam klausa `SELECT` satu per satu, kita dapat menggunakan tanda bintang (`*`) untuk memperpendek kueri.

Namun, menggunakan tanda bintang (`*`) dalam pernyataan `SELECT` dianggap sebagai praktik yang buruk ketika Anda menyematkan pernyataan SQL dalam kode aplikasi, seperti Python, Java, atau PHP karena alasan berikut:

- Kinerja database. Misalkan Anda memiliki tabel dengan banyak kolom dan data yang substansial, pernyataan `SELECT` dengan tanda bintang (`*`) akan mengambil data dari semua kolom tabel, yang berpotensi mengambil lebih banyak data dari yang dibutuhkan untuk aplikasi.
- Kinerja aplikasi. Mengambil data yang tidak perlu dari database meningkatkan lalu lintas antara server PostgreSQL dan server aplikasi. Akibatnya, ini dapat menyebabkan waktu respons yang lebih lambat dan skalabilitas yang lebih rendah untuk aplikasi Anda.

Oleh karena itu, disarankan untuk secara eksplisit menentukan nama kolom dalam klausa `SELECT` kapan pun memungkinkan. Ini memastikan bahwa hanya data yang diperlukan yang diambil dari database, sehingga berkontribusi pada kueri yang lebih efisien dan dioptimalkan.

Tanda bintang (`*`) sebaiknya hanya digunakan untuk kueri ad-hoc yang meninjau data dari database.

### 4) Menggunakan pernyataan PostgreSQL SELECT dengan ekspresi
Contoh berikut menggunakan pernyataan `SELECT` untuk mengembalikan nama lengkap dan email semua pelanggan dari tabel `customer`:

```
SELECT
   first_name || ' ' || last_name,
   email
FROM
   customer;
```

Output:

```
 ?column?              |                  email
 -----------------------+------------------------------------------
 Jared Ely             | [[email protected]](../cdn-cgi/l/email-protection.html)
 Mary Smith            | [[email protected]](../cdn-cgi/l/email-protection.html)
 Patricia Johnson      | [[email protected]](../cdn-cgi/l/email-protection.html)
...
```
Dalam contoh ini, kita menggunakan operator konkatenasi `||` untuk menggabungkan nama depan, spasi, dan nama belakang setiap pelanggan.

Perhatikan bahwa kolom pertama dari output tidak memiliki nama tetapi `?column?`. Untuk memberi nama sementara pada kolom dalam kueri, 
Anda dapat menggunakan alias kolom:

```
expression AS column_lias
```

Kata kunci AS adalah opsional. Oleh karena itu, Anda dapat menggunakan sintaks yang lebih pendek:

```
expression column_lias
```

Misalnya, Anda dapat memberikan alias kolom full_name pada kolom pertama dari kueri sebagai berikut:

```
SELECT
   first_name || ' ' || last_name full_name,
   email
FROM
   customer;
```

Output:

```
 full_name             |                  email
-----------------------+------------------------------------------
 Jared Ely             | [[email protected]](../cdn-cgi/l/email-protection.html)
 Mary Smith            | [[email protected]](../cdn-cgi/l/email-protection.html)
 Patricia Johnson      | [[email protected]](../cdn-cgi/l/email-protection.html)
...
```

### 5) Menggunakan pernyataan PostgreSQL SELECT tanpa klausa FROM
Klausa `FROM` dalam pernyataan `SELECT` bersifat opsional. Oleh karena itu, Anda dapat mengabaikannya dalam pernyataan `SELECT`.

Biasanya, Anda menggunakan klausa `SELECT` dengan fungsi untuk mengambil hasil fungsi tersebut. Misalnya:

```
SELECT NOW();
```

Dalam contoh ini, kita menggunakan fungsi `NOW()` dalam pernyataan `SELECT`. Ini akan mengembalikan tanggal dan waktu saat ini dari server PostgreSQL.

#### Ringkasan
- Gunakan pernyataan `SELECT ... FROM` untuk mengambil data dari sebuah tabel.
- PostgreSQL mengevaluasi klausa `FROM` sebelum klausa `SELECT`.
- Gunakan alias kolom untuk memberikan nama sementara pada kolom atau ekspresi dalam sebuah kueri.
- Dalam PostgreSQL, klausa `FROM` bersifat opsional.
