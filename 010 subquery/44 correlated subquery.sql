/* CORRELATED SUB QUERY

di tutorial ini, kamu akan belajar mengenai PostgreSQL Correlated Subquery
untuk performa yang tergantung pada NILAI kolom yang sedang di proses

di postgreSQL, correlated subquery adalah query yang merefrensikan kolom dari query luar

berbeda dengan subquery biasanya, 
postgreSQL mengevaluasi correlated subquery sekali kepada setiap baris 

karena mengevaluasi tiap baris, ada kemungkinan terjadi kesalahan jika data besar

correlated subquery ini berguna pada saat kita pengen nampilin data yang mengandung ANGKA

-----------------------------------------------------------------------------------------
misal kita pengen nampilin film mana aja yang durasinya lebih panjang dari pada durasi film rata2 */

select 
	film_id, title, length, rating 
from 
	film f 
where 
	length > (
		select 
			avg(length)
		from 
			film 
		where 
			rating = f.rating 
)
order by 
	film_id 
	
/* bagaimana cara kerjanya?

kueri utama mengambil id, titile, length dan rating dari table 'film' alias 'f'
	
	SELECT film_id, title, length, rating
	FROM film f
	WHERE length > (...)
	
query 'WHERE length > (...)' memastikan agar daftar film yang di tampilin lebih besar dari rata2
	
correlated subquery menghitung, berapa lama rata2 durasi film yg ada dengan syntax ini :
	
	SELECT AVG(length)
	FROM film
	WHERE rating = f.rating
	
penggunaan kolom 'rating' bukan tanpa alasan, 
pembagian berdasarkan rating lebih mudah dalam pembagian kelompok
	
	misal :
Bayangkan Anda memiliki tiga film:
Film A: Judul = “Avengers,” Rating = “PG-13,” Durasi = 150 menit
Film B: Judul = “Finding Nemo,” Rating = “G,” Durasi = 100 menit
Film C: Judul = “Inception,” Rating = “PG-13,” Durasi = 180 menit

Jika Anda menghitung rata-rata durasi tanpa mempertimbangkan rating, 
Anda akan mendapatkan (150 + 100 + 180) / 3 = 143,33 menit.

Namun, rata-rata tersebut tidak bermakna karena mencampur kategori rating yang berbeda.

Dengan menggunakan kolom ‘rating’, Anda menghitung dua rata-rata terpisah:

Untuk film dengan rating “PG-13”: (150 + 180) / 2 = 165 menit

Untuk film dengan rating “G”: 100 menit

Sekarang Anda dapat membandingkan durasi setiap film dengan rata-rata yang relevan.