-- introduction operator AND

/* di postgreSQL, ada 3 value bolean, yaitu 'True', 'False', dan 'Null'
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
 
 select 1 = 1 as result
 -- disini yang keliatan hasilnya [v] yang berarti true
 
 select 1 = 0 as result
 -- disini hasilnya [0] yang berarti false
 
 /* secara table seperti ini
  * AND_________TRUE____________FALSE___________NULL
  * TRUE	|	true			false			null
  * FALSE	|	false			false			false
  * NULL	|	null			false			null
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
 select true and true as result
 
 select true and false as result
 
 select true and null as result
 
 
 -- false
 
 select false and true as result
 
 select false and false as result
 
 select false and null as result
 
 -- null 
 
 select null and true as result
 
 select null and false as result
 
 select null and null as result
 
 
 
 /* Penggunaan query 'and' dan 'where' 
  * harusnya udah di pelajari ya seperti yang sebelum sebelumnya
  * cuman berhubung bahas 'and' kalo hasil run ga make database kaya gmn gitu
  * 
  */
  
 select title, length, rental_rate from film f where length > 180 and rental_rate < 1
 
 