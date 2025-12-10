/* Dalam dunia database, 
 * NULL berarti informasi yang hilang atau tidak berlaku. 
 * NULL bukanlah suatu nilai, oleh karena itu, 
 * Anda tidak dapat membandingkannya dengan nilai lain seperti angka atau string.
 * 
 * Perbandingan NULL dengan suatu nilai akan selalu menghasilkan NULL. 
 * Selain itu, NULL tidak sama dengan NULL sehingga ekspresi berikut mengembalikan NULL:
 * 
 * */

-- ngetest aja

select null = null as result

select true = null as result

select null = false as result

-- OPERATOR IS NULL
/* operator ini buat ngecek apakah ada null dalam suatu variable
 * operator is null ga bisa make symbol kaya = atau <>, tapi tetep gunain is null 
 */

select address, address2 from address a where address2 is null

-- kebalikanya dari null, is not null atau kosong
-- ini bisa kejadian kalo emang bener2 ga bisa diisi
-- misal punya nya cuman satu rumah doang
-- kaga ada rumah kedua
select address, address2 from address a where address2 is not null 


/* Ringkasan

Dalam database, NULL berarti informasi yang hilang atau tidak berlaku.

Operator IS NULL mengembalikan nilai benar 
jika suatu nilai NULL atau salah jika sebaliknya.

Gunakan operator IS NOT NULL yang mengembalikan nilai benar 
jika suatu nilai bukan NULL atau salah jika sebaliknya.
 * 
 */*/
