-- 'between' digunakan untuk menampilkan data 
/* 
 * basicnya pada dasarnya adalah sebagai berikut :
 * value between low and high (batas bawah dan batas atas )
 */

-- between biasa, low value between high value
select payment_id, amount from payment p where payment_id between 17503 and 17505 order by payment_id 

-- pake operator pengganti between >= value <= value 
select payment_id, amount from payment p where payment_id >= 17503 and payment_id <= 17505 order by payment_id 

-- sekarang not between, jadi diluar range
select payment_id, amount from payment p where payment_id not between 17503 and 17505 order by payment_id 

-- make operator penggantin not between > < 
select payment_id, amount from payment p where payment_id < 17503 or payment_id > 17505 order by payment_id 

-- between menggunakan tanggal
select 
  customer_id,
  payment_id,
  amount,
  payment_date
from 
  payment
where 
  payment_date between '2007-02-15' and '2007-02-20'
  and  amount > 10
order by
  payment_date;
