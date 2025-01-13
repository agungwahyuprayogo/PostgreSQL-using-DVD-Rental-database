# 'between' digunakan untuk menampilkan data 
/* 
 * basicnya pada dasarnya adalah sebagai berikut :
 * value between low and high (batas bawah dan batas atas )
 */

-- between biasa
select payment_id, amount from payment p where payment_id between 17503 and 17505 order by payment_id 

-- pake operator >= <= (between)
select payment_id, amount from payment p where payment_id >= 17503 and payment_id <= 17505 order by payment_id 

-- sekarang not between, jadi diluar range
select payment_id, amount from payment p where payment_id not between 17503 and 17505 order by payment_id 

-- make operator > < (not between)
select payment_id, amount from payment p where payment_id < 17503 or payment_id > 17505 order by payment_id 