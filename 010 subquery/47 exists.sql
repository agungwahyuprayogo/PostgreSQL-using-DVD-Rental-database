/* jadi kali ini kita belajar mengenai EXIST

simplenya sih ya buat ngetes, kalo berdasarkan kondisi tertentu apakah ada apa ga?
apakah exist atau not exist

dengan catatan kalo null berarti masih exist
kecuali kalo bener bener kosong baris yang ditampilin baru bisa di kategorikan not exists

langsung aja ke praktek */

-- pengen cek, adakah customer yang pembayarannya tuh 0, bisa di kategorikan belum pernah belanja
select exists (select 1 from payment where amount = 0)
-- hasilnya kan 'True' atau di dbeaver [v]

-- sekarang kita liat siapa aja yang paymentnya 0
SELECT first_name, last_name 
FROM customer c 
WHERE EXISTS (
    SELECT 'hallo' -- 'hallo' jangan diambil pusing, karena ga bakal ngaruh efek apa2. mau diganti 1 juga gpp
    FROM payment p 
    WHERE 
      p.customer_id = c.customer_id 
      AND amount = 0
  ) 
ORDER BY 
  first_name, last_name;

-- sekarang kita liat make inner buat buktiin dah bener apa belum
select c.customer_id, c.first_name, c.last_name, p.amount 
from customer c inner join payment p using (customer_id) 
where p.amount < 0
order by first_name, last_name 
-- jawaban udah sama, cuman disini gatau napa si 'Tammy Sanders' muncul 2x

-------------------------------------------------------------------------------------------

-- CHECK NOT EXIST
-- tadi kan udah keliatan hasil exist, sekarang tinggal ganti = 0 jadi > 0,
-- harusnya yang muncul selain yg tadi
select not exists (select 1 from payment where amount < 1) -- kaga bisa njir 
-- ohh ya simplenya, make exist aja, kalo False atau [ ] berarti ga ada alias not existed

-- misal cek ada yg amount nya < 0 ga? 
select exists (select 1 from payment where amount < 0)
-- hasilnya sih [ ] berarti false, dah bener sih harusnya

-- contoh kasus, kita pengen cek ada ga customer yg pengeluaranya ga lebih dari 11
SELECT first_name, last_name 
FROM customer c 
where NOT EXISTS (
    SELECT 'hallo' -- 'hallo' jangan diambil pusing, karena ga bakal ngaruh efek apa2. mau diganti 1 juga gpp
    FROM payment p 
    WHERE 
      p.customer_id = c.customer_id 
      AND amount > 11
  ) 
ORDER BY 
  first_name, last_name;
  
 -- kita cek ya
 select distinct c.customer_id, c.first_name, c.last_name --, p.amount (dikomen karena kalo diliatin amount nya, jadi diliatin juga amount yg berbeda beda, jadi tetep banyak barisnya)
 from customer c inner join payment p using (customer_id)
 where p.amount < 11
 order by c.first_name
 -- udah distinct tapi masih banyak (karena kolom amount ternyata)
 -- hasilnya sama ya, kalo not exist di cek siapa aja yang pengeluaranya lebih dari 11
 -- kalo make inner otomatis cara ngeceknya kebalikanya, siapa yang pengeluarannya kurang dari 11
 
 ----------------------------------------------------------------------------------------------
 
 -- cara cek apakah ada null 
 SELECT *
FROM 
  customer 
WHERE 
  EXISTS(
    SELECT NULL
  ) 
ORDER BY 
  first_name, 
  last_name;
 -- cuman pas di cek, mana yg null anjay?
 -- pas dari where ke bawah di komen, totalnya tetep 599