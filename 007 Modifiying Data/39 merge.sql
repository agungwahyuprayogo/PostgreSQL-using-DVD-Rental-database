/* oke kali ini kita bakal bahas 'MERGE'
'MERGE' sendiri lanjutan dari kemarin yang gunain 'on conflict' sebagai 'ide'

nah kali ini ada query yg bisa dibilang lumayan rumit, tapi kalo paham ya ga susah2 amat
jadi kalo kemarin upsert kan cuman bisa update dan insert doang nih
kalo merge bisa buat update, insert bahkan delete

di sebelumnya kan kudu gini :
insert ...
on conflict 

nah kalo buat merge kek gini :

MERGE INTO target_table
USING source_query
ON merge_condition
WHEN MATCH [AND condition] THEN {merge_update | merge_delete | DO NOTHING }
WHEN NOT MATCHED [AND condition] THEN { merge_insert | DO NOTHING };

1. target_table, ya sesuai namanya, table mana yg ingin di insert / update / delete datanya
2. source query, table sumber, atau table yang pengen kita copy datanya ke table target
3. merge_condition, kalo ini nyesuain, nanti liat contohnya aja langsung
4. when match, kalo data sesuai kondisi, bakal ngapain, misal do nothing
5. when not matched, kalo data ga sesuai, ngapain gitu

dah langsung ke praktek aja biar ga pusing */

-- buat table sumber biar mudah mahaminnya

create table sumber (
	sumber_id serial primary key, -- serial ngisi otomatis, gausah isi manual gpp
	name varchar(255) not null, -- ga boleh kosong, karakter maks 255 karakter
	email varchar(255) not null unique, -- email bisa diisi 255 karakter, ga boleh kosong dan harus unik, dalam artian ga boleh sama kaya email yg lain
	active boolean not null default true -- status kerja, aktif apa ga nya, default aktif
);

create table target (
	target_id serial primary key,
	name varchar(255) not null,
	email varchar(255) not null unique,
	active boolean not null default true
);
-- sengaja sama karena kita belajar pengen copy, kalo ada kasus kaya gini, sesuaikan aja

-- buat data dulu di table sumber
insert into sumber (name, email)
values 
	('Agung Wahyu Prayogo', 'agungwhypryg@gmail.com'),
	('Edo Subastian', 'edosubs8508@gmail.com')
returning*

-- saatnya nyoba merge
merge into target t						-- merge ke table target
using sumber s on s.email = t.email		-- dari table sumber, on email
when not matched then 					-- kalo ga sama (email, table target kan kosong. berarti ga sama) maka :
	insert (name, email)				-- masukan nama dan email
	values (s.name, s.email)			-- dari value 
	
select * from target t 
-- dan ternyata data di table target berubah ngikutin sumber

-- kita tambahin baru lagi di table sumber
insert into sumber (name, email)
values 
	('Ratangga Samuel', 'ratanggasamuel@gmail.com')

-- awkoaok email palsu cok, kudu jujur gwej
update sumber 
set name = 'Agoenk Wahjoe Prajogo'
where sumber_id = 2 
-- agung ada 2 karena email yg satu palsu, makanya namanya digituin 

select * from sumber s order by sumber_id 
-- edosubastian tadi berubah jadi agoenk

-- ini mungkin keliatan ribet, tapi kalo datanya ribuan bisa bantu banget
-- copy semua data di sumber lalu salin di table target
merge into target t					-- merge ke target
using sumber s on s.email = t.email	-- dari table sumber, patokan email
when not matched then 				-- kalo ga sama, 
	insert (name, email)			-- maka masukan data nama dan email
	values (s.name, s.email)		-- sumbernya dari table sumber kolom nama dan email
when matched then					-- kalo sama
	update set						-- update aja data yg ada
	name = s.name,					-- kolom nama ngikutin table sumber kolom nama
	email = s.name					-- kolom email juga sama

select * from target t order by target_id 

-- sekarang nyoba update, insert, delete, langsung
-- masukin data orang baru dulu
insert into sumber (name, email)
values 
	('Ashyfa Febrita Zahra', 'bithachindo@gmail.com')
-- lupa mulu anjir mau returning *		

select * from sumber s 
-- si bitha dah masuk

-- tapi ganti ae lah anjir masa bita, 
-- tar dikira aneh2 sama dia dan lainya

update sumber 
set name = 'Dasha Taran',
	email = 'dashataran@gmail.com'
where sumber_id = 4

select * from sumber s 
-- jadi dasha

-- sekarang hapus akun palsu gwej yg edo
update sumber 
set active = false
where sumber_id = 2
returning *
-- skrg dah ga aktiv yg edo

-- biar percaya, kita cek semua, liat perbedaan yg true dan false
select * from sumber s 
-- terlihat kalo edo udah ga aktiv tanda nya ga ada tanda 'v'

-- nah saatnya nyoba insert, update sekaligus delete
merge into target t
using sumber s on t.email = s.email
when not matched then 
	insert (name, email)
	values (s.name, s.email)
when matched and s.active = false then 
	delete 
when matched and s.active = true then 
	update set 
		name = s.name,
		email = s.email
-- kalo data dikit make query ini pusing, tapi kalo datanya ratusan ribu worth it
		
