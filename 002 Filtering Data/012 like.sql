/* 

Anggeplah lu inget sama satu nama customer, tapi lupa nama keseluruhan dia,, 
dan lu cuman inget nama depan dia 'Jen'.

Nah kalo dicari satu - satu kan lama ya pasti, apalagi kalo datanya bisa ribuan (bisa lebih). 
Untungnya PostgreSQL punya operator 'LIKE' yang digunakan
 */

select
	first_name, last_name 
from 
	customer 
where 
	first_name like 'Jen%'
	
-----------------------------------------------------------------------------------------------------------
	
/*
Trus untuk membuat pola pencarian, kita bisa make karakter khusus (wildcard) :
- Tanda Persen (%) > bisa buat nyari banyak karakter
- Tanda Underscore (_) > cuman buat satu karakter aja
 
~ value LIKE pattern ~ , contoh 'Jen%' diatas termasuk
 
Nanti deh di bawah di kasih contoh
 
Ada lagi, kalo kita mau GA NAMPILIN data tertentu,, kita tinggal nambahin NOT


~ value NOT LIKE patern ~

>> Catatan : kalo ga make tanda '%' dan '_', maka LIKE bakal kerja seakan make tanda '='

**/

-----------------------------------------------------------------------------------------------------------
	
-- 1. Contoh Dasar Operator LIKE

select 'Apple' like 'Apple' as result -- versi normal, kita bisa coba versi wildcard

select 'Apple' like 'App%' as result -- hasilnya tetep true karena kata 'Apple' diawali dengan 'App'

-----------------------------------------------------------------------------------------------------------

-- 2. Make Operator LIKE di table, customer
-- kita pengen cari nama yang mengandung 'er' , bebas mau diawal, tengah atau belakang gpp

select
	first_name, last_name 
from 
	customer
where 
	first_name like '%er%'
order by
	first_name 
	
-- hasilnya di kolom 'first_name' cuman nampilin nama yang ada 'er' -nya
	
-----------------------------------------------------------------------------------------------------------
	
	
-- 3. Mencoba Wildcard kaya % dan _
-- Semisal kita pengen cari nama yang huruf ke 2 sampai 4 mengandung 'her' (huruf depannya bebas)

select
	first_name, last_name
from 
	customer
where 
	first_name like '_her%'
order by
	first_name 
	
/*
cara baca '_her%' tuh gini 
- _ (underscore pertama) : huruf ke - 1 bebas apa aja (boleh C, F, G atau apapun)
- 'her' : huruf ke 2, 3 dan 4 WAJIB her
- '%' (persen) : huruf ke 5 dan seterusnya bebas berapa karakter jumlahnya
 */
	
	
-----------------------------------------------------------------------------------------------------------
	
-- 4. Contoh penggunaan NOT LIKE
-- Kita pengen ngilangin nama yang awalannya 'Jen...'
	
select
	first_name, last_name
from 
	customer
where
	first_name not like 'Jen%'
order by
	first_name 
	
-- silahkan scroll sampai sekitaran first_name huruf 'J' , nama 'Jen..' dihilangkan
	
-----------------------------------------------------------------------------------------------------------
	
/*

Secara default operator LIKE tuh case sensitive, 
jadi kalo kita salah gede kecil hurufnya, bakal ga keluar hasilnya

Contohnya gini 'BAR%' tidak akan cocok sama 'Barbara', 
Nah postgreSQL ada fitur keren namanya ILIKE (i = insensitive).
Operator ini bakal cuek sama perbedaan besar kecil pada huruf

Langsung di coba aja
*/
	
select 
	first_name, last_name 
from 
	customer
where 
	first_name ilike 'BAR%'
order by 
	first_name 
	
-- coba kita bandingin sama LIKE doang
	
select 
	first_name, last_name 
from 
	customer
where 
	first_name like 'BAR%'
order by 
	first_name 
	
-- hasilnya nihil (kosong)
	
	
	-- LIKE SIMBOL DAN ESCAPE BELUM --
