/* sekarang kita bakal latihan 'where' 
 * query ini digunain buat nampilin select yang lebih spesifik
 * 
 * penggambarannya seperti ini :
 * 
 * SELECT 
 * 		nama_kolom
 * FROM
 * 		nama_table
 * WHERE
 * 		kondisi
 * 
 * 
 * 
 * sekarang kita latihan menggunakan operator '='
 */*/
 
 select first_name, last_name from customer c where first_name = 'Jamie'
 
-- dari query diatas, terlihat yang tampil cuman 2, 
 -- karena yang spesifik nama depanya Jamie cuman ada 2 nama
 
 
 -- sekarang kita latihan menggunakan operator 'AND'
 
 select first_name, last_name from customer c where first_name = 'Jamie' and last_name = 'Rice'
 

/* selain '=' dan 'and' ada banyak sebenernya
 * =
 * >
 * <
 * >=
 * <=
 * <> atau !=
 * and
 * or
 * in
 * between
 * like
 * is null
 * not
 * 
 * sekarang kita latihan make or
 * 
 */*/
 
 select first_name, last_name from customer c where last_name = 'Rodriguez' or first_name = 'Adam'
 
 /* maksud dari query diatas adalah, 
  * tampilin orang yang nama belakangnya 'Rodriguez' atau 
  * orang yang nama depanya 'Adam'
  * karena 22nya ada, jadi lah ke tampil 22nya
  * 
  * sekarang kita ganti 'Rodriguez' jadi 'Rodigues' (make s)
  * tetep muncul hasil yaitu adam,
  * karena kalo make 'or' asal salah satu ada, ya tetep di tampilin
  * 
  * kalo mau nampilin lebih dari satu nama,
  * bisa make 'in'
  * 
  * */
 
 select first_name, last_name from customer c where first_name in ('Ann', 'Anne', 'Annie');
 
/* karena ketiga nama tersebut mirip2, bisa make 'like'
 * 
 */*/
 
 select first_name, last_name from customer c where first_name like 'Ann%'
 -- di query ini, kita ingin menampilkan dimana first name yang ada 'Ann' di depan
 -- maka hasilnya ada anna, ann, anne, annie dst
 
 select first_name, length(first_name) name_length from customer c where first_name like 'A%' and length(first_name) between 3 and 5 order by name_length
 -- menampilkan nama dengan awalan 'A' dan mengurutkannya dari yang terkecil ke terbesar
 
 select first_name, last_name from customer c where first_name like 'Bra%' and last_name <> 'Motley';
 -- menampilkan orang dengan huruf awal 'Bra', tapi tidak menampilkan yg nama akhirnya 'Motley'
