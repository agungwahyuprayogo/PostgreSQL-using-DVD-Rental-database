# Panduan PostgreSQL Querying Data

## Daftar Isi
- [PostgreSQL SELECT](#postgresql-select)
- [PostgreSQL Column Aliases](#postgresql-column-aliases)
- [PostgreSQL ORDER BY](#postgresql-order-by)


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


---------------------------------------------------------------------------------------------------------------------

# PostgreSQL Column Aliases

## Pengenalan kolom alias di PostgreSQL
Kolom alias memungkinkan Anda untuk memberikan nama sementara pada kolom atau ekspresi dalam daftar pilih pernyataan `SELECT`. Alias kolom ini ada sementara selama eksekusi kueri.

Berikut ini adalah sintaks penggunaan alias kolom:

```
SELECT column_name AS alias_name
FROM table_name;
```

Dalam sintaks ini, `column_name` diberikan alias `alias_name`. Kata kunci `AS` bersifat opsional, sehingga Anda dapat menghilangkannya seperti ini:

```
SELECT column_name alias_name
FROM table_name;
```

Sintaks berikut menunjukkan cara menetapkan alias untuk ekspresi dalam klausa `SELECT`:

```
SELECT expression AS alias_name
FROM table_name;
```

Tujuan utama dari alias kolom adalah untuk membuat heading output dari kueri menjadi lebih bermakna.

## Contoh alias kolom PostgreSQL

Kita akan menggunakan tabel `customer` dari database sampel untuk menunjukkan cara bekerja dengan alias kolom.

![image](https://github.com/user-attachments/assets/9fbc1adb-05f7-49f9-9dda-e1a1f8451e9d)

### 1) Menetapkan alias kolom ke contoh kolom
Kueri berikut mengembalikan nama depan dan nama belakang semua `customers` dari tabel customer:

```
SELECT
   first_name,
   last_name
FROM customer;
```

![image](https://github.com/user-attachments/assets/76fabe41-25c0-40f8-b25d-78676e226c70)

Jika Anda ingin mengganti nama heading `last_name`, Anda dapat memberikan nama baru menggunakan alias kolom seperti ini:

```
SELECT
   first_name,
   last_name AS surname
FROM customer;
```

Kueri ini menetapkan `surname` sebagai alias dari kolom `last_name`:

![image](https://github.com/user-attachments/assets/8dc0a58f-8746-46e5-a5b5-2d2e60f471d3)

Atau Anda bisa membuatnya lebih pendek dengan menghapus kata kunci AS seperti berikut:

```
SELECT
   first_name,
   last_name surname
FROM customer;
```

### 2) Memberikan alias kolom untuk ekspresi
Kueri berikut akan mengembalikan nama lengkap semua pelanggan di table `customer` dengan menggabungkan nama depan, spasi, dan nama belakang:

```
SELECT
   first_name || ' ' || last_name
FROM
   customer;
```

Perlu dicatat bahwa di PostgreSQL, Anda menggunakan `||` sebagai operator penggabungan yang menggabungkan satu atau lebih string menjadi satu string.

![image](https://github.com/user-attachments/assets/d676edb7-3fbf-42ab-92f9-fb4539c54b6c)

Seperti yang bisa Anda lihat dari output, heading dari kolom tersebut tidak bermakna `?column?`.

Untuk mengatasi ini, Anda dapat memberikan ekspresi `first_name || ' ' || last_name` sebuah alias kolom, misalnya `full_name`:

```
SELECT
    first_name || ' ' || last_name AS full_name
FROM
    customer;
```

![image](https://github.com/user-attachments/assets/ad649137-0e9e-4416-917e-6f9aef6c1710)

### 3) Alias kolom yang mengandung spasi

Jika ingin nama alias kolom mengandung satu atau lebih spasi, Anda perlu mengapitnya dengan tanda kutip ganda seperti ini:

```
column_name AS "column alias"
```

Contohnya:

```
SELECT
    first_name || ' ' || last_name "full name"
FROM
    customer;
```

![image](https://github.com/user-attachments/assets/ea0736ef-c998-434f-bc60-58b1f3899a9e)

### Ringkasan
- Tetapkan sebuah kolom atau ekspresi dengan alias kolom menggunakan sintaks `column_name AS alias_name` atau `expression AS alias_name`. Kata kunci `AS` bersifat opsional.
- Gunakan tanda kutip ganda (`"`) untuk mengapit alias kolom yang mengandung spasi.
  
---------------------------------------------------------------------------------------------------------------

# PostgreSQL ORDER BY

Ketika Anda mengambil data dari sebuah tabel, pernyataan `SELECT` mengembalikan baris dalam urutan yang tidak ditentukan. Untuk mengurutkan baris hasil kueri, Anda menggunakan klausa `ORDER BY` dalam pernyataan `SELECT`.

Klausa `ORDER BY` memungkinkan Anda mengurutkan baris yang dikembalikan oleh klausa `SELECT` dalam urutan naik atau turun berdasarkan ekspresi urutan.

Berikut adalah sintaks klausa `ORDER BY`:

```
SELECT
  select_list
FROM
  table_name
ORDER BY
  sort_expression1 [ASC | DESC],
  sort_expression2 [ASC | DESC],
  ...;
```

Dalam sintaks ini:

- Pertama, tentukan ekspresi urutan, yang bisa berupa kolom atau ekspresi, yang ingin Anda urutkan setelah kata kunci `ORDER BY`. Jika Anda ingin mengurutkan hasil kueri berdasarkan beberapa kolom atau ekspresi, Anda perlu menempatkan koma (`,`) antara dua kolom atau ekspresi untuk memisahkannya.
- Kedua, Anda menggunakan opsi `ASC` untuk mengurutkan baris dalam urutan naik dan opsi `DESC` untuk mengurutkan baris dalam urutan turun. Jika Anda menghilangkan opsi `ASC` atau `DESC`, `ORDER BY` menggunakan `ASC` secara default.

PostgreSQL mengevaluasi klausa dalam pernyataan `SELECT` dalam urutan berikut: `FROM`, `SELECT`, dan `ORDER BY`.

Karena urutan evaluasi, jika Anda memiliki alias kolom dalam klausa `SELECT`, Anda bisa menggunakannya dalam klausa `ORDER BY`.

Mari kita ambil beberapa contoh penggunaan klausa `ORDER BY` di PostgreSQL.

## Contoh ORDER BY PostgreSQL

Kita akan menggunakan tabel `customer` dalam database sampel untuk demonstrasi.

### 1) Menggunakan klausa ORDER BY untuk mengurutkan baris berdasarkan satu kolom

Kueri berikut menggunakan klausa `ORDER BY` untuk mengurutkan pelanggan berdasarkan nama depan mereka dalam urutan naik:

```
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name ASC;
```

Karena opsi `ASC` adalah default, Anda bisa menghilangkannya dalam klausa `ORDER BY` seperti ini:

```
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name;
```

### 2) Menggunakan klausa ORDER BY untuk mengurutkan baris berdasarkan satu kolom dalam urutan turun

Pernyataan berikut memilih nama depan dan nama belakang dari tabel `customer` dan mengurutkan baris berdasarkan nilai di kolom nama belakang dalam urutan turun:

```
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  last_name DESC;
```

### 3) Menggunakan klausa ORDER BY untuk mengurutkan baris berdasarkan beberapa kolom

Pernyataan berikut memilih nama depan dan nama belakang dari tabel `customer` dan mengurutkan baris berdasarkan nama depan dalam urutan naik dan nama belakang dalam urutan turun:

```
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name ASC,
  last_name DESC;
```

Dalam contoh ini, klausa `ORDER BY` mengurutkan baris berdasarkan nilai di kolom nama depan terlebih dahulu. Kemudian mengurutkan baris yang sudah diurutkan berdasarkan nilai di kolom nama belakang.

### 4) Menggunakan klausa ORDER BY untuk mengurutkan baris berdasarkan ekspresi

Fungsi `LENGTH()` menerima string dan mengembalikan panjang string tersebut.

Pernyataan berikut memilih nama depan dan panjangnya. Mengurutkan baris berdasarkan panjang nama depan:

```
SELECT
  first_name,
  LENGTH(first_name) len
FROM
  customer
ORDER BY
  len DESC;
```

Karena klausa `ORDER BY` dievaluasi setelah klausa `SELECT`, alias kolom `len` tersedia dan bisa digunakan dalam klausa `ORDER BY`.

## PostgreSQL ORDER BY dan NULL
Dalam dunia database, `NULL` adalah penanda yang menunjukkan data yang hilang atau data yang tidak diketahui pada saat pencatatan.

Ketika Anda mengurutkan baris yang mengandung `NULL`, Anda bisa menentukan urutan `NULL` dengan nilai lain yang tidak null menggunakan opsi `NULLS FIRST` atau `NULLS LAST` dalam klausa `ORDER BY`:

```
ORDER BY sort_expresssion [ASC | DESC] [NULLS FIRST | NULLS LAST]
```

Opsi `NULLS FIRST` menempatkan `NULL` sebelum nilai lain yang tidak null dan opsi `NULLS LAST` menempatkan `NULL` setelah nilai lain yang tidak null.

Mari kita buat tabel untuk demonstrasi.

```
-- membuat tabel baru
CREATE TABLE sort_demo(num INT);

-- memasukkan beberapa data
INSERT INTO sort_demo(num)
VALUES
  (1),
  (2),
  (3),
  (null);
```

Jika Anda belum familiar dengan pernyataan `CREATE TABLE` dan `INSERT`, Anda bisa mengeksekusinya dari `pgAdmin` atau `psql` untuk membuat tabel `sort_demo` dan memasukkan data ke dalamnya.

Kueri berikut mengembalikan data dari tabel `sort_demo`:

```
SELECT
  num
FROM
  sort_demo
ORDER BY
  num;
```

```
num
------
    1
    2
    3
 null
(4 rows)
```

Dalam contoh ini, klausa `ORDER BY` mengurutkan nilai di kolom `num` dari tabel `sort_demo` dalam urutan naik. Ini menempatkan `NULL` setelah nilai lainnya.

Perlu dicatat bahwa psql menampilkan null sebagai string kosong secara default. Untuk membuat null lebih jelas, Anda bisa mengeksekusi perintah berikut untuk mengubah string kosong menjadi null:

```
\pset null null
```

Output:

```
Null display is "null".
```

Jika Anda menggunakan opsi `ASC`, klausa `ORDER BY` menggunakan opsi `NULLS LAST` secara default. Oleh karena itu, kueri berikut mengembalikan hasil yang sama:

```
SELECT
  num
FROM
  sort_demo
ORDER BY
  num NULLS LAST;
```

Output:

```
num
------
    1
    2
    3
 null
(4 rows)
```

Untuk menempatkan `NULL` sebelum nilai lain yang tidak null, gunakan opsi `NULLS FIRST`:

```
SELECT
  num
FROM
  sort_demo
ORDER BY
  num NULLS FIRST;
```

Output:

```
num
------
 null
    1
    2
    3
(4 rows)
```

Pernyataan berikut mengurutkan nilai di kolom `num` dari tabel `sort_demo` dalam urutan turun:

```
SELECT
  num
FROM
  sort_demo
ORDER BY
  num DESC;
```

Output:

```
num
------
 null
    3
    2
    1
(4 rows)
```

Output menunjukkan bahwa klausa `ORDER BY` dengan opsi `DESC` menggunakan `NULLS FIRST` secara default.

Untuk membalikkan urutan, gunakan opsi `NULLS LAST`:

```
SELECT
  num
FROM
  sort_demo
ORDER BY
  num DESC NULLS LAST;
```

Output:

```
num
------
    3
    2
    1
 null
(4 rows)
```

### Ringkasan
- Gunakan klausa `ORDER BY` dalam pernyataan `SELECT` untuk mengurutkan baris dalam kumpulan kueri.
- Gunakan opsi `ASC` untuk mengurutkan baris dalam urutan naik dan opsi `DESC` untuk mengurutkan baris dalam urutan turun.
- Klausa `ORDER BY` menggunakan opsi `ASC` secara default.
- Gunakan opsi `NULLS FIRST` dan `NULLS LAST` untuk secara eksplisit menentukan urutan `NULL` dengan nilai lain yang tidak null.
