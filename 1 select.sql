/* ilustrasi : 
 * 
 * select nama_kolom
 * from nama_data
 * 
 * 
 * jadi 'select' query buat nampilin kolom yang ada di data
 * 'nama_kolom' , kalo semua cukup make *. kalo lebih dari satu make tanda pisah koma
 * query 'from' nyambung sama nama database yang pengen kita lihat data2nya 
 * 
 * contoh ngeliat semua kolom make *
 * */

select * from customer

select * from address

select * from actor

/* di atas keliatan, kalo make *, semua nama kolom disuatu data bisa keliatan semua
 * sebagai contoh dari table customer, semua kolom mulai dari customer_id, store_id, first_name dll ada
 * 
 * sekarang kita pen nyoba kalo cuman kolom tertentu aja,
 * satu kolom dulu deh :
 */*/
 
select first_name from customer c 

select last_name from customer

select address from address a 

select last_name from actor 

/* diatas adalah contoh nampilin hanya satu kolom dari table
 * jadi beda sama sebelumnya yang make *, ini langsung nama kolomnya
 * 
 * kalo pengen lebih dari 1 kolom, bisa 2 atau lebih, tanda pemisahnya koma
 */

select first_name , last_name , email from customer

select last_name , first_name from customer c

/* kalo soal urutan, ga ada aturan baku ya
 * misal kalo mau last name dulu baru first name juga gapapa
 * 
 * kalo nama depan dan nama belakang dipisah kek rada anu nih
 * 2 kolom bisa di gabung jadi satu, dengan cara :
 */
 
 select first_name ||' '|| last_name as nama_lengkap from customer c 
 
 /* sebelumnya kan kalo nampilin 2 kolom make koma
  * ini beda, make ||' '||
  * fungsinya ya buat gabungin 2 kolom berbeda dan 
  * di dalam tanda petik itu ada karakter spasi
  * as itu buat nama gabungan 2 kolom sebelumnya jadi nama_lengkap
  *  */
 