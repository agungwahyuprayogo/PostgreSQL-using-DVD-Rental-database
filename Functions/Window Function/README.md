- [PostgreSQL Window Function](#postgresql-window-function)
- [PostgreSQL ROW_NUMBER Function](#postgresql-row_number-function)
- [PostgreSQL RANK](#postgresql-rank)

---

# PostgreSQL Window Function

**Ringkasan**: Dalam tutorial ini, Anda akan belajar cara menggunakan fungsi *window* PostgreSQL untuk melakukan perhitungan pada sekumpulan baris yang terkait dengan baris saat ini.

## Menyiapkan tabel sampel
Pertama, buat dua tabel bernama `products` dan `product_groups` untuk demonstrasi:

![image](https://github.com/user-attachments/assets/59010ade-afeb-45a6-8fb0-f83abddb8892)

```sql
CREATE TABLE product_groups (
	group_id serial PRIMARY KEY,
	group_name VARCHAR (255) NOT NULL
);

CREATE TABLE products (
	product_id serial PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	price DECIMAL (11, 2),
	group_id INT NOT NULL,
	FOREIGN KEY (group_id) REFERENCES product_groups (group_id)
);
```

Kedua, masukkan beberapa baris data ke dalam tabel:

```sql
INSERT INTO product_groups (group_name)
VALUES
	('Smartphone'),
	('Laptop'),
	('Tablet');

INSERT INTO products (product_name, group_id, price)
VALUES
	('Microsoft Lumia', 1, 200),
	('HTC One', 1, 400),
	('Nexus', 1, 500),
	('iPhone', 1, 900),
	('HP Elite', 2, 1200),
	('Lenovo Thinkpad', 2, 700),
	('Sony VAIO', 2, 700),
	('Dell Vostro', 2, 800),
	('iPad', 3, 700),
	('Kindle Fire', 3, 150),
	('Samsung Galaxy Tab', 3, 200);
```

![image](https://github.com/user-attachments/assets/4653553b-d346-4f9a-b742-114932d4205d)

![image](https://github.com/user-attachments/assets/5f1c843e-7fb3-45e4-a620-6202fa76013f)

---

## Pengenalan Fungsi Window di PostgreSQL
Cara termudah untuk memahami fungsi *window* adalah dengan terlebih dahulu meninjau fungsi agregat. Fungsi agregat menggabungkan data dari sekumpulan baris menjadi satu baris.

Contoh berikut menggunakan fungsi agregat `AVG()` untuk menghitung harga rata-rata dari semua produk dalam tabel `products`:

```sql
SELECT
	AVG(price)
FROM
	products;
```

![image](https://github.com/user-attachments/assets/eb6f47cd-919e-49c0-928f-c2da8c415e16)

Untuk menerapkan fungsi agregat pada subset baris, gunakan klausa `GROUP BY`. Contoh berikut mengembalikan harga rata-rata untuk setiap kelompok produk:

```sql
SELECT
	group_name,
	AVG(price)
FROM
	products
INNER JOIN
	product_groups USING (group_id)
GROUP BY
	group_name;
```

![image](https://github.com/user-attachments/assets/3a7eaf14-bef0-49f8-ab44-826270360d5a)

Seperti yang terlihat jelas dari outputnya, fungsi `AVG()` mengurangi jumlah baris yang dikembalikan oleh query dalam kedua contoh.

Mirip dengan fungsi agregat, fungsi *window* bekerja pada sekumpulan baris. Namun, ia tidak mengurangi jumlah baris yang dikembalikan oleh query.

Istilah *window* menggambarkan sekumpulan baris tempat fungsi *window* beroperasi. Fungsi *window* mengembalikan nilai dari baris dalam *window*.

Sebagai contoh, query berikut mengembalikan nama produk, harga, nama kelompok produk, serta harga rata-rata dari setiap kelompok produk:

```sql
SELECT
	product_name,
	price,
	group_name,
	AVG(price) OVER (
	   PARTITION BY group_name
	)
FROM
	products
INNER JOIN
	product_groups USING (group_id);
```

![image](https://github.com/user-attachments/assets/3ff9b525-cadb-4b4c-ba40-438e6eeaee90)

Dalam query ini, fungsi `AVG()` berfungsi sebagai fungsi *window* yang bekerja pada sekumpulan baris yang ditentukan oleh klausa `OVER`. Setiap sekumpulan baris disebut *window*.

Sintaks baru dalam query ini adalah klausa `OVER`:

```sql
AVG(price) OVER (PARTITION BY group_name)
```

Dalam sintaks ini, `PARTITION BY` membagi baris dari hasil query ke dalam kelompok, dan fungsi `AVG()` diterapkan pada setiap kelompok untuk mengembalikan harga rata-rata per kelompok.

Perlu dicatat bahwa fungsi *window* selalu melakukan perhitungan pada hasil query setelah klausa `JOIN`, `WHERE`, `GROUP BY`, dan `HAVING`, serta sebelum klausa `ORDER BY` dieksekusi.

---

## Sintaks Fungsi Window di PostgreSQL
PostgreSQL memiliki sintaks yang cukup kompleks untuk pemanggilan fungsi *window*. Berikut adalah versi yang disederhanakan:

```sql
window_function(arg1, arg2,..) OVER (
   [PARTITION BY partition_expression]
   [ORDER BY sort_expression [ASC | DESC] [NULLS {FIRST | LAST }])
```

### window_function(arg1,arg2,...)
`window_function` adalah nama fungsi *window*. Beberapa fungsi *window* tidak menerima argumen.

### Klausa PARTITION BY
Klausa `PARTITION BY` membagi baris menjadi beberapa kelompok atau *partisi* di mana fungsi *window* diterapkan. Seperti pada contoh sebelumnya, kita menggunakan kelompok produk untuk membagi produk ke dalam kelompok (*partisi*).

Klausa `PARTITION BY` bersifat opsional. Jika Anda mengabaikannya, fungsi *window* akan memperlakukan seluruh hasil query sebagai satu *partisi*.

### Klausa ORDER BY
Klausa `ORDER BY` menentukan urutan baris dalam setiap *partisi* tempat fungsi *window* diterapkan.

Klausa `ORDER BY` dapat menggunakan opsi `NULLS FIRST` atau `NULLS LAST` untuk menentukan apakah nilai *nullable* harus berada di awal atau akhir hasil query. Default-nya adalah `NULLS LAST`.

### frame_clause
`frame_clause` mendefinisikan subset dari baris dalam *partisi* saat ini tempat fungsi *window* diterapkan. Subset baris ini disebut *frame*.

Jika Anda menggunakan beberapa fungsi *window* dalam satu query:

```sql
SELECT
    wf1() OVER(PARTITION BY c1 ORDER BY c2),
    wf2() OVER(PARTITION BY c1 ORDER BY c2)
FROM table_name;
```

Anda dapat menggunakan klausa `WINDOW` untuk memperpendek query seperti berikut:

```sql
SELECT
   wf1() OVER w,
   wf2() OVER w,
FROM table_name
WINDOW w AS (PARTITION BY c1 ORDER BY c2);
```

Anda juga dapat menggunakan klausa `WINDOW` meskipun hanya memanggil satu fungsi *window* dalam query:

```sql
SELECT wf1() OVER w
FROM table_name
WINDOW w AS (PARTITION BY c1 ORDER BY c2);
```

---

### Daftar Fungsi Window di PostgreSQL
Berikut tabel yang mencantumkan semua fungsi *window* yang tersedia di PostgreSQL. Perhatikan bahwa beberapa fungsi agregat seperti `AVG()`, `MIN()`, `MAX()`, `SUM()`, dan `COUNT()` juga dapat digunakan sebagai fungsi *window*.

| Nama | Deskripsi |
|------|------------|
| CUME_DIST | Mengembalikan peringkat relatif dari baris saat ini. |
| DENSE_RANK | Memberikan peringkat pada baris saat ini dalam *partisi* tanpa celah. |
| FIRST_VALUE | Mengembalikan nilai yang dievaluasi terhadap baris pertama dalam *partisi*. |
| LAG | Mengembalikan nilai yang dievaluasi terhadap baris yang berada pada offset tertentu sebelum baris saat ini dalam *partisi*. |
| LAST_VALUE | Mengembalikan nilai yang dievaluasi terhadap baris terakhir dalam *partisi*. |
| LEAD | Mengembalikan nilai yang dievaluasi terhadap baris yang berada pada offset tertentu setelah baris saat ini dalam *partisi*. |
| NTILE | Membagi baris dalam *partisi* secara merata dan menetapkan setiap baris angka mulai dari 1 hingga nilai argumen. |
| NTH_VALUE | Mengembalikan nilai yang dievaluasi terhadap baris ke-n dalam *partisi* yang telah diurutkan. |
| PERCENT_RANK | Mengembalikan peringkat relatif dari baris saat ini `(rank-1) / (total rows – 1)`. |
| RANK | Memberikan peringkat pada baris saat ini dalam *partisi* dengan celah. |
| ROW_NUMBER | Menomori baris saat ini dalam *partisi* mulai dari 1. |

---

## Fungsi ROW_NUMBER(), RANK(), dan DENSE_RANK()
Fungsi `ROW_NUMBER()`, `RANK()`, dan `DENSE_RANK()` menetapkan bilangan bulat ke setiap baris berdasarkan urutannya dalam hasil query.

Fungsi `ROW_NUMBER()` memberikan nomor urut secara berurutan kepada setiap baris dalam setiap *partisi*. Lihat query berikut:

```sql
SELECT
 	product_name,
	group_name,
	price,
	ROW_NUMBER() OVER (
		PARTITION BY group_name
		ORDER BY price
		)
FROM
	products
INNER JOIN
	product_groups USING (group_id);
```

![image](https://github.com/user-attachments/assets/ab447fe3-7db7-4780-ba4e-e7c545d5a0a2)

---

Fungsi `RANK()` memberikan peringkat dalam *partisi* yang diurutkan. Jika beberapa baris memiliki nilai yang sama, fungsi `RANK()` akan memberikan peringkat yang sama, sementara peringkat berikutnya akan dilewati.

Lihat query berikut:

```sql
SELECT
	product_name,
	group_name,
    	price,
	RANK() OVER (
		PARTITION BY group_name
		ORDER BY
			price
		)
FROM
	products
INNER JOIN 
	product_groups USING (group_id);
```

![image](https://github.com/user-attachments/assets/1169b989-a0d7-4355-adb2-4a3c00276b07)

Dalam kelompok produk laptop, baik `Sony VAIO` maupun `Lenovo Thinkpad` memiliki harga yang sama, sehingga keduanya mendapatkan peringkat 1. Baris berikutnya dalam kelompok tersebut adalah `Dell Vostro`, yang mendapatkan peringkat 3 karena peringkat 2 dilewati.

---

Mirip dengan fungsi `RANK()`, fungsi `DENSE_RANK()` memberikan peringkat pada setiap baris dalam *partisi* yang diurutkan, tetapi tanpa celah. Dengan kata lain, beberapa baris bisa mendapatkan peringkat yang sama, tetapi tidak ada peringkat yang dilewati.

```sql
SELECT
	product_name,
	group_name,
	price,
	DENSE_RANK() OVER (
		PARTITION BY group_name
		ORDER BY
			price
		)
FROM
	products
INNER JOIN
	product_groups USING (group_id);
```

![image](https://github.com/user-attachments/assets/54bfebaa-a503-4612-a613-69be8a193b67)


Dalam kelompok produk laptop, peringkat 1 diberikan kepada `Sony VAIO` dan `Lenovo Thinkpad`. Peringkat berikutnya adalah 2, yang diberikan kepada `Dell Vostro`.

---

## Fungsi FIRST_VALUE dan LAST_VALUE

Fungsi `FIRST_VALUE()` mengembalikan nilai yang dievaluasi terhadap baris pertama dalam *partisi*, sedangkan fungsi `LAST_VALUE()` mengembalikan nilai yang dievaluasi terhadap baris terakhir dalam *partisi*.

Pernyataan berikut menggunakan `FIRST_VALUE()` untuk mendapatkan harga terendah di setiap kelompok produk:

```sql
SELECT
	product_name,
	group_name,
	price,
	FIRST_VALUE(price) OVER (
		PARTITION BY group_name
		ORDER BY
			price
		) AS lowest_price_per_group
FROM
	products
INNER JOIN
	product_groups USING (group_id);
```

![image](https://github.com/user-attachments/assets/bb90005c-a616-4d66-9e9e-f1c159994d71)

Pernyataan berikut menggunakan fungsi `LAST_VALUE()` untuk mendapatkan harga tertinggi di setiap kelompok produk:

```sql
SELECT
	product_name,
	group_name,
	price,
	LAST_VALUE(price) OVER (
		PARTITION BY group_name
		ORDER BY
			price RANGE BETWEEN UNBOUNDED PRECEDING
			AND UNBOUNDED FOLLOWING
	) AS highest_price_per_group
FROM
	products
INNER JOIN
	product_groups USING (group_id);
```

![image](https://github.com/user-attachments/assets/5d233f5e-0e33-4ba1-b77a-c7f7378f2452)


Perhatikan bahwa kita menambahkan klausa *frame* `RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING`, karena secara default klausa *frame* adalah `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`.

![image](https://github.com/user-attachments/assets/f22feb89-39bc-4d8b-ac76-4f1cc65a0cfd)



---

## Fungsi LAG dan LEAD

Fungsi `LAG()` memungkinkan akses ke data dari baris sebelumnya, sedangkan fungsi `LEAD()` memungkinkan akses ke data dari baris berikutnya.

Baik fungsi `LAG()` maupun `LEAD()` memiliki sintaks yang sama seperti berikut:

```sql
LAG  (expression [,offset] [,default]) over_clause;
LEAD (expression [,offset] [,default]) over_clause;
```

Dalam sintaks ini:

- `expression` – kolom atau ekspresi untuk menghitung nilai yang dikembalikan.
- `offset` – jumlah baris sebelum (`LAG`) atau sesudah (`LEAD`) baris saat ini. Secara default, bernilai 1.
- `default` – nilai yang dikembalikan jika `offset` melebihi cakupan *window*. Jika diabaikan, nilai default adalah `NULL`.

Pernyataan berikut menggunakan fungsi `LAG()` untuk mendapatkan harga dari baris sebelumnya dan menghitung selisih antara harga baris saat ini dan harga baris sebelumnya:

```sql
SELECT
	product_name,
	group_name,
	price,
	LAG(price, 1) OVER (
		PARTITION BY group_name
		ORDER BY price
	) AS prev_price,
	price - LAG(price, 1) OVER (
		PARTITION BY group_name
		ORDER BY
			price
	) AS cur_prev_diff
FROM
	products
INNER JOIN
	product_groups USING (group_id);
```

![image](https://github.com/user-attachments/assets/cd337034-21d6-40b8-8c65-c6510e0beb73)

Pernyataan berikut menggunakan fungsi `LEAD()` untuk mendapatkan harga dari baris berikutnya dan menghitung selisih antara harga baris saat ini dan harga baris berikutnya:

```sql
SELECT
	product_name,
	group_name,
	price,
	LEAD(price, 1) OVER (
		PARTITION BY group_name
		ORDER BY price
	) AS next_price,
	price - LEAD(price, 1) OVER (
		PARTITION BY group_name
		ORDER BY price
	) AS cur_next_diff
FROM
	products
INNER JOIN
	product_groups USING (group_id);
```

![image](https://github.com/user-attachments/assets/a561b1d4-7a50-495c-89c3-ea42e9f2d84a)

## 📊 Urutan Belajar SQL Window Function

| Urutan | Fungsi          | Kategori       | Penjelasan Singkat                                                                |
|--------|-----------------|----------------|-----------------------------------------------------------------------------------|
| 1      | `ROW_NUMBER()`  | Ranking        | Memberi nomor urut unik dalam partisi; tidak ada nilai yang sama.                 |
| 2      | `RANK()`        | Ranking        | Memberi peringkat; nilai sama mendapat peringkat yang sama, tapi ada "gap".       |
| 3      | `DENSE_RANK()`  | Ranking        | Seperti `RANK()`, tapi **tanpa gap** antara peringkat.                            |
| 4      | `NTILE(n)`      | Distribusi     | Membagi data ke dalam *n* grup yang kurang lebih sama besar.                      |
| 5      | `LAG()`         | Navigasi       | Mengambil nilai dari baris sebelumnya dalam window.                               |
| 6      | `LEAD()`        | Navigasi       | Mengambil nilai dari baris berikutnya dalam window.                               |
| 7      | `FIRST_VALUE()` | Navigasi       | Mengambil nilai pertama dalam window.                                             |
| 8      | `LAST_VALUE()`  | Navigasi       | Mengambil nilai terakhir dalam window.                                            |
| 9      | `NTH_VALUE()`   | Navigasi       | Mengambil nilai ke-*n* dalam window.                                              |
| 10     | `PERCENT_RANK()`| Statistik      | Menentukan posisi relatif baris sebagai persentase, dengan gap.                   |
| 11     | `CUME_DIST()`   | Statistik      | Menentukan distribusi kumulatif baris dalam window.                               |


---
---
---

# PostgreSQL ROW_NUMBER Function

**Ringkasan**: Dalam tutorial ini, Anda akan belajar cara menggunakan fungsi PostgreSQL `ROW_NUMBER()` untuk menetapkan nilai integer unik ke setiap baris dalam hasil query.

## Pengenalan Fungsi PostgreSQL ROW_NUMBER()
Fungsi `ROW_NUMBER()` adalah fungsi *window* yang memberikan nomor urut secara berurutan kepada setiap baris dalam hasil query.

Berikut sintaks dari fungsi `ROW_NUMBER()`:

```sql
ROW_NUMBER() OVER(
    [PARTITION BY column_1, column_2,…]
    [ORDER BY column_3, column_4,…]
)
```

Sekumpulan baris tempat fungsi `ROW_NUMBER()` beroperasi disebut *window*.

Klausa `PARTITION BY` membagi *window* menjadi kelompok atau *partisi* yang lebih kecil. Jika Anda menyertakan klausa `PARTITION BY`, maka penomoran setiap *partisi* akan dimulai dari satu dan bertambah satu setiap barisnya.

Karena klausa `PARTITION BY` bersifat opsional, Anda dapat mengabaikannya, dan fungsi `ROW_NUMBER()` akan memperlakukan seluruh *window* sebagai satu *partisi*.

Klausa `ORDER BY` dalam `OVER` menentukan urutan penomoran baris.

---

## Contoh Penggunaan Fungsi PostgreSQL ROW_NUMBER()
Kita akan menggunakan tabel `products` yang dibuat dalam tutorial fungsi *window* PostgreSQL untuk mendemonstrasikan fungsionalitas `ROW_NUMBER()`.

![image](https://github.com/user-attachments/assets/74b8085e-f966-4aa4-a428-34181cf8570e)

Berikut ini menunjukkan data dalam tabel `products`:

![image](https://github.com/user-attachments/assets/59956b8d-3bb2-4d23-8116-3b1897931f66)

Lihat query berikut.

```sql
SELECT
  product_id,
  product_name,
  group_id,
  ROW_NUMBER () OVER (
    	ORDER BY
		product_id
	)
FROM
  products;
```

![image](https://github.com/user-attachments/assets/d9254a3e-5373-4e15-8f28-4bfc010f74ec)

Karena kita tidak menggunakan klausa `PARTITION BY`, fungsi `ROW_NUMBER()` menganggap seluruh hasil query sebagai satu *partisi*.

Klausa `ORDER BY` mengurutkan hasil query berdasarkan `product_id`, sehingga fungsi `ROW_NUMBER()` menetapkan nilai integer ke setiap baris berdasarkan urutan `product_id`.

Dalam query berikut, kita mengubah kolom dalam klausa `ORDER BY` menjadi `product_name`, sehingga fungsi `ROW_NUMBER()` menetapkan nilai integer ke setiap baris berdasarkan urutan nama produk.

```sql
SELECT
  product_id,
  product_name,
  group_id,
  ROW_NUMBER () OVER (
	ORDER BY
      		product_name
  )
FROM
	products;
```

![image](https://github.com/user-attachments/assets/769264e2-6855-49d5-9b8a-018602cc9501)

Dalam query berikut, kita menggunakan klausa `PARTITION BY` untuk membagi *window* menjadi subset berdasarkan nilai dalam kolom `group_id`. Dalam hal ini, fungsi `ROW_NUMBER()` menetapkan angka satu ke baris awal setiap *partisi* dan meningkat satu untuk setiap baris berikutnya dalam *partisi* yang sama.

Klausa `ORDER BY` mengurutkan baris dalam setiap *partisi* berdasarkan nilai dalam kolom `product_name`.

```sql
SELECT
	product_id,
  	product_name,
  	group_id,
  	ROW_NUMBER() OVER (
    		PARTITION BY
			group_id
    		ORDER BY
      			product_name
  		)
FROM
  	products;
```

![image](https://github.com/user-attachments/assets/65055f35-dba0-4148-8abd-b982ee87b71c)

---

## Fungsi PostgreSQL ROW_NUMBER() dan Operator DISTINCT
Query berikut menggunakan fungsi `ROW_NUMBER()` untuk menetapkan angka berurutan pada harga yang unik dari tabel `products`:

```sql
SELECT
	DISTINCT price,
	ROW_NUMBER() OVER (
		ORDER BY
			price
		)
FROM
  	products
ORDER BY
  	price;
```

![image](https://github.com/user-attachments/assets/1cd3c5b2-e927-41ac-ad48-b229cdc08bb5)

Namun, hasilnya tidak sesuai dengan yang diharapkan karena masih terdapat harga yang duplikat. Alasannya adalah fungsi `ROW_NUMBER()` beroperasi pada hasil query sebelum `DISTINCT` diterapkan.

Untuk mengatasi masalah ini, kita dapat memperoleh daftar harga yang unik dalam sebuah CTE, lalu menerapkan fungsi `ROW_NUMBER()` dalam query luar seperti berikut:

```sql
WITH prices AS (
  SELECT DISTINCT price
  FROM products
)
SELECT
  price,
  ROW_NUMBER() OVER (ORDER BY price) AS row_num
FROM
  prices;
```

![image](https://github.com/user-attachments/assets/65b27027-dddb-4b1f-9b90-d03a6f11bdf7)

Atau kita bisa menggunakan subquery dalam klausa `FROM` untuk mendapatkan daftar harga unik, lalu menerapkan fungsi `ROW_NUMBER()` dalam query luar.

```sql
SELECT
  price,
  ROW_NUMBER() OVER (ORDER BY price) AS row_num
FROM (
  SELECT DISTINCT price
  FROM products
) AS prices;
```

![image](https://github.com/user-attachments/assets/96394c7b-93c8-406b-ae34-400e750ae84c)

---

## Menggunakan Fungsi ROW_NUMBER() untuk Paginasi

Dalam pengembangan aplikasi, teknik paginasi digunakan untuk menampilkan sebagian baris daripada menampilkan semua baris dalam tabel.

Selain menggunakan klausa `LIMIT`, Anda dapat menggunakan fungsi `ROW_NUMBER()` untuk paginasi.

Sebagai contoh, query berikut memilih lima baris yang dimulai dari nomor baris ke-6:

```sql
SELECT *
FROM (
  SELECT
    product_id,
    product_name,
    price,
    ROW_NUMBER() OVER (ORDER BY product_name) AS rn
  FROM products
) AS ranked
WHERE rn BETWEEN 6 AND 10;

```

![image](https://github.com/user-attachments/assets/b4968d73-054e-4ed6-b4c4-8aeaee74d794)

---

## Menggunakan Fungsi ROW_NUMBER() untuk Mendapatkan Baris ke-n Tertinggi/Terendah

Sebagai contoh, untuk mendapatkan produk dengan harga tertinggi ketiga, pertama, kita mengambil harga yang unik dari tabel `products` dan memilih harga dengan nomor baris ke-3. Kemudian, dalam query luar, kita mengambil produk dengan harga yang sama dengan harga tertinggi ketiga.

```sql
SELECT *
FROM products
WHERE price = (
  SELECT price
  FROM (
    SELECT price,
           ROW_NUMBER() OVER (ORDER BY price DESC) AS nth
    FROM (SELECT DISTINCT price FROM products)
  )
  WHERE nth = 3
);
```

![image](https://github.com/user-attachments/assets/65c3073f-58a9-4ae9-bec8-0f5e3246f548)

#### Ringkasan
- Gunakan fungsi PostgreSQL `ROW_NUMBER()` untuk menetapkan nilai integer ke setiap baris dalam hasil query.

---
---
---

# PostgreSQL RANK

**Ringkasan**: Dalam tutorial ini, Anda akan belajar cara menggunakan fungsi PostgreSQL `RANK()` untuk menetapkan peringkat pada setiap baris dalam hasil query.

## Pengenalan Fungsi PostgreSQL RANK()

Fungsi `RANK()` memberikan peringkat pada setiap baris dalam *partisi* dari hasil query.

Untuk setiap *partisi*, peringkat baris pertama adalah 1. Fungsi `RANK()` menambahkan jumlah baris yang memiliki nilai sama ke peringkat tersebut untuk menghitung peringkat baris berikutnya, sehingga peringkatnya mungkin tidak berurutan. Selain itu, baris dengan nilai yang sama akan mendapatkan peringkat yang sama.

Berikut sintaks fungsi `RANK()`:

```sql
RANK() OVER (
    [PARTITION BY partition_expression, ... ]
    ORDER BY sort_expression [ASC | DESC], ...
)
```

Dalam sintaks ini:

- Pertama, klausa `PARTITION BY` membagi hasil query menjadi *partisi* tempat fungsi `RANK()` diterapkan.
- Kemudian, klausa `ORDER BY` menentukan urutan baris dalam setiap *partisi* yang digunakan oleh fungsi.

Fungsi `RANK()` dapat digunakan untuk membuat laporan *top-N* dan *bottom-N*.

## Contoh Penggunaan Fungsi PostgreSQL RANK()

Pertama, buat tabel baru bernama `ranks` yang memiliki satu kolom:

```sql
CREATE TABLE ranks (
    c VARCHAR(10)
);
```

Kedua, masukkan beberapa baris ke dalam tabel `ranks`:

```sql
INSERT INTO ranks(c)
VALUES('A'),('A'),('B'),('B'),('B'),('C'),('E');
```

Ketiga, query data dari tabel `ranks`:

```sql
SELECT
    c
FROM
    ranks;
```

![image](https://github.com/user-attachments/assets/6800f799-143f-40f6-9ebc-5f2c676ffad9)

Keempat, gunakan fungsi `RANK()` untuk menetapkan peringkat pada baris dalam hasil query tabel `ranks`:

```sql
SELECT
    c,
    RANK () OVER (
        ORDER BY c
    ) rank_number
FROM
    ranks;
```

Gambar berikut menunjukkan outputnya:

![image](https://github.com/user-attachments/assets/3414810e-2b7a-4ab1-b087-85eebd32e297)

Seperti yang dapat Anda lihat dengan jelas dari outputnya:

- Baris pertama dan kedua mendapatkan peringkat yang sama karena memiliki nilai `A`.
- Baris ketiga, keempat, dan kelima mendapatkan peringkat 3 karena fungsi `RANK()` melewati peringkat 2, dan semuanya memiliki nilai `B`.

---

## Contoh Penggunaan Fungsi PostgreSQL RANK()

Kita akan menggunakan tabel `products` untuk mendemonstrasikan fungsi `RANK()`.

![image](https://github.com/user-attachments/assets/8179f890-fcc4-4cbf-a473-b60acb39234b)

Gambar ini menunjukkan data tabel `products` :

![image](https://github.com/user-attachments/assets/38811125-3b84-43b7-bf4b-4019683af49c)

### 1) Menggunakan Fungsi PostgreSQL RANK() untuk Seluruh Hasil Query

Contoh berikut menggunakan fungsi `RANK()` untuk menetapkan peringkat pada setiap produk berdasarkan harga:

```sql
SELECT
    product_id,
    product_name,
    price,
    RANK () OVER (
        ORDER BY price DESC
    ) price_rank
FROM
    products;
```

![image](https://github.com/user-attachments/assets/5b57917e-b913-46ca-9510-637d63d3e0e6)

Dalam contoh ini, kita tidak menyertakan klausa `PARTITION BY`, sehingga fungsi `RANK()` memperlakukan seluruh hasil query sebagai satu *partisi*.

Fungsi `RANK()` menghitung peringkat setiap baris dalam hasil query yang telah diurutkan berdasarkan harga dari tinggi ke rendah.

---

### 2) Menggunakan Fungsi PostgreSQL RANK() dengan Klausa PARTITION BY

Contoh berikut menggunakan fungsi `RANK()` untuk menetapkan peringkat pada setiap produk dalam kelompok produk masing-masing:

```sql
SELECT
    product_id,
    product_name,
    group_name,
    price,
    RANK () OVER (
        PARTITION BY p.group_id
        ORDER BY price DESC
    ) price_rank
FROM
    products p
INNER JOIN
    product_groups g USING (group_id);
```

![image](https://github.com/user-attachments/assets/7db4a296-c054-43f9-ad61-614e2f18a46c)

Dalam contoh ini:

- Pertama, klausa `PARTITION BY` membagi produk berdasarkan kelompok produk (`group_id`).
- Kedua, klausa `ORDER BY` mengurutkan produk dalam setiap *partisi* berdasarkan harga dari tinggi ke rendah.

Fungsi `RANK()` diterapkan pada setiap produk dalam setiap kelompok dan direset saat kelompok produk berubah.

Dalam tutorial ini, Anda telah belajar cara menggunakan fungsi PostgreSQL `RANK()` untuk menghitung peringkat setiap baris dalam *partisi* dari hasil query.
