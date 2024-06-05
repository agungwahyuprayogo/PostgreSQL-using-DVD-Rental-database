/* Pembahasannya mirip2 yang kemarin di pembahasan AND OPERATOR
 * cuman bedanya kali ini kita make operator or
 * 
 * di postgreSQL, ada 3 value bolean, yaitu 'True', 'False', dan 'Null'
 * jujur baru kali ini juga si dapet bolean null
 * ntah melambangkan arti apa null ini
 * 
 * cek di copilot microsoft, jawabanya begini :
 * 
 * NULL: Nilai NULL mewakili ketidakpastian atau ketidaktahuan. 
 * Ini digunakan ketika kita tidak memiliki informasi tentang suatu 
 * kondisi. Misalnya, jika kita tidak tahu apakah suatu produk tersedia 
 * atau tidak, kita dapat menggunakan NULL. NULL juga digunakan 
 * untuk menggambarkan situasi di mana data tidak ada atau belum 
 * diisi.
	
	Dalam praktiknya, NULL sering digunakan untuk mengatasi 
	situasi ketika kita tidak memiliki informasi lengkap 
	atau ketika data belum tersedia. Misalnya, jika kita ingin 
	menghitung jumlah produk yang tersedia, kita dapat 
	mengabaikan nilai NULL dalam perhitungan tersebut.
 * 
 * di postgreSQL menggunakan true, 't', 'true', 'y', 'yes', '1' untuk mempresentasikan boolean 'True'
 * 
 * untuk false dalam bentuk 'f', 'false', 'n', 'no', '0', untuk mempresentasikan boolean 'False'
 * 
 * di postgreSQL, kita bisa cek hasil boolean dengan cara
 */*/
 
 select 1 <> 1 as result
 -- disini yang keliatan hasilnya [ ] yang berarti false
 -- gw juga bingung cok kok hasilnya false
 -- padahal true sama true
 
 /* Perbandingan Ekspresi 1 OR 1:
* Sekarang, mari kita fokus pada ekspresi 1 OR 1.
* Di PostgreSQL, operator OR digunakan untuk menggabungkan 
  dua kondisi logika. Jika salah satu kondisi adalah true, 
  maka hasilnya adalah true.
* Namun, dalam kasus ini, kita membandingkan dua angka, 
  bukan kondisi logika.
* Ketika kita mengevaluasi 1 OR 1, PostgreSQL menganggapnya 
  sebagai perbandingan numerik, bukan sebagai kondisi logika.
* Karena kedua angka adalah sama (yaitu 1), hasilnya adalah 
  false.
  * */
 
 select 1 <> 0 as result
 -- disini hasilnya [v] yang berarti false
 
 /* secara table seperti ini
  * OR__________TRUE____________FALSE___________NULL
  * TRUE	|	true			true			true
  * FALSE	|	true			false			null
  * NULL	|	true			null			null
  * 
  * gampangnya gini, true bakal jadi true kalo ketemu true doang, selain itu hasilnya false
  * false mau ketemu apapun hasilnya tetep false
  * kalo null selama ga ketemu false hasilnya dah pasti null
  * 
  * kita bisa cek di bawah
  * kalo diatas buat angka pake '='
  * kalo huruf make 'and'
  */
 
 -- true
 select true or true as result
 
 select true or false as result
 
 select true or null as result
 
 
 -- false
 
 select false or true as result
 
 select false or false as result
 
 select false or null as result
 
 -- null 
 
 select null or true as result
 
 select null or false as result
 
 select null or null as result
 
  /* Penggunaan query 'or' dan 'where' 
  * harusnya udah di pelajari ya seperti yang sebelum sebelumnya
  * cuman berhubung bahas 'or' kalo hasil run ga make database kaya gmn gitu
  */
 
 select title, rental_rate from film f where rental_rate = 0.99 or rental_rate = 2.99