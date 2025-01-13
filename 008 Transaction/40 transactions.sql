/* apa itu transaksi basis data?
adalah suatu unit kerja yang terdiri dari satu atau lebih operasi

contoh klasiknya adalah transaksi dalam transfer bank.
transaksi yang lengkap harus memastikan adanya saldo antara rekening pengirim dan penerima

jika si pengirim mengirim uang sejumlah X, maka penerima juga harus menerima sejumlah X
tidak lebih dan tidak kurang

transaksi di PostgreSQL bersifat ACID
* Atomicity, menjamin transaksi selesai dengan cara semua atau tidak sama sekali
* Consistency, memastikan perubahan data valid dan mematuhi proses yang sudah di tetapkan
* Isolation, menentukan integritas suatu transaksi terlihat oleh transaksi lainya
* Durability, memastikan bahwa transaksi yang sudah terjadi tersimpan secara permanen dalam basis data

menyiapkan table demo */

create table accounts (
	id int generated by default as identity,
	name varchar(100) not null,
	balance dec(15,2) not null check(balance >= 0),
	primary key(id)
);

-- MULAI TRANSAKSI 
/* saat lu mengeksekusi query, postgreSQL secara implisit membungkusnya dalam bentuk transaksi
misal lu mau nambah transaksi baru kaya nambah anggota dalam table accounts */

insert into accounts (name, balance)
values ('Bob', 10000);

begin transaction -- nanti muncul pop up di kanan atas, already a transaction progress

BEGIN;

INSERT INTO accounts(name,balance)
VALUES('Alice',10000);

SELECT 
    id,
    name,
    balance
FROM 
    accounts;
    
-- DO TRANSACTIONS
commit work

SELECT 
    id,
    name,
    balance
FROM 
    accounts;
    
-- start a transaction
BEGIN;

-- insert a new row into the accounts table
INSERT INTO accounts(name,balance)
VALUES('Alice',10000);

-- commit the change (or roll it back later)
COMMIT;

ROLLBACK;

-- start a transaction
BEGIN;

UPDATE accounts
SET balance = balance - 1000
WHERE id =  1;

-- rollback the changes
ROLLBACK;

SELECT * FROM accounts;

--tapi gw ga paham sama ini sumpah
--maksudnya kaga liat perubahan, cuman liat di bar kanan doang
--
--Gunakan BEGINpernyataan untuk memulai transaksi secara eksplisit
--Gunakan COMMITpernyataan tersebut untuk menerapkan perubahan secara permanen pada basis data.
--Gunakan ROLLBACKpernyataan untuk membatalkan perubahan yang dibuat pada database selama transaksi.

-- ntah lah cuy untuk saat ini ga bisa liat perubahan dan manfaatnya , mungkin suatu saat nanti