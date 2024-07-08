/* setelah belajar delete where bla bla bla
sekarang kita belajar delete yang kesambung sama 2 table

secara syntax make query kaya gini : 
DELETE FROM nama_table1
USING nama_table2
WHERE kondisi
RETURNING (kolom | *) ;

kita siapkan tablenya dulu aja
 */

create table member (
	id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	phone varchar(15) not null
);

create table denylist (
	phone varchar(15) primary key
)

insert into member(first_name, last_name, phone)
values ('John','Doe','(408)-523-9874'),
       ('Jane','Doe','(408)-511-9876'),
       ('Lily','Bush','(408)-124-9221');

insert into denylist(phone)
values ('(408)-523-9874'),
       ('(408)-511-9876');
       
select * from member m 

select * from denylist d 

-- basic ngapus data yang gabung 2 table
delete from member
using denylist
where member.phone = denylist.phone

select * from member 

-- kalo cara hapus sekaligus banyak bisa make ini 
delete from member 
where phone in (
    select
      phone 
    from
      denylist
);

-- karena nomer lily ga ada di deynlist, nomernya dia masih ada di member
select * from member 
