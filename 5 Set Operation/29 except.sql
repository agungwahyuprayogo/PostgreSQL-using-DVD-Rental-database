    /* sekarang kita latihan except
 * secara kerja mirip mirip sama left join
 * cuman bedanya yaa, ga perlu ada foreign key
 * tapi ya gitu kudu sama total baris dan kolomnya
 * 
 * sekarang kita liat dulu deh kedua table yang mau kita buat latihan
 */ 

select * from most_popular_films mpf 
-- hasilnya 
--An America Pickle (harusnya muncul ini)
--The Godfather (sama)
--The Dark Knight (sama)
--Greyhound (harusnya muncul ini)

select * from top_rated_films trf 
-- hasilnya
--The Shawshank Redemption
--The Godfather (sama)
--The Dark Knight (sama)
--12 Angry Men

-- dari kedua table diatas, harusnya yang tampil american pickle dan greyhound
select * from most_popular_films mpf 
except 
select * from top_rated_films trf 
-- dan ternyata bener, yang keluar mirip perkiraan