/* kali ini kita balajar hapus data dalam table
 * 
 * mirip dengan update 
 * update nama table 
 * lalu kondisi make where
 * 
 * kalo di delete kurang lebih sama
 * 
 * delete nama_table
 * where_kodisi
 * 
 * kita buat table baru aja kali ya langsung praktek
 */

CREATE TABLE todos (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    completed BOOLEAN NOT NULL DEFAULT false
);

INSERT INTO todos (title, completed) VALUES
    ('Learn basic SQL syntax', true),
    ('Practice writing SELECT queries', false),
    ('Study PostgreSQL data types', true),
    ('Create and modify tables', false),
    ('Explore advanced SQL concepts', true),
    ('Understand indexes and optimization', false),
    ('Backup and restore databases', true),
    ('Implement transactions', false),
    ('Master PostgreSQL security features', true),
    ('Build a sample application with PostgreSQL', false);

SELECT * FROM todos;

-- nyoba hapus satu baris data
DELETE FROM todos
WHERE id = 1;
-- ada pop up di bawah 'update rows 1'

-- nyoba hapus yang ga ada di data
DELETE FROM todos
WHERE id = 100;
-- karena ga ada id = 100, 'update rows 0', jadi ga ada yang keubah sama sekali

-- ngeliat baris yg dihapus, seperti biasa make returning
DELETE FROM todos
WHERE id = 2
RETURNING *;

select * from todos
-- keliatan id 1 dan 2 ke hapus

-- sekarang hapus yg completed = true
DELETE FROM todos
WHERE completed = true
RETURNING *;
-- yang kehapus id 3 5 7 dan 9
-- sisa 4 6 8 10 

-- kalo diatas kan make where nih, kalo ga make where otomatis ke hapus semua
delete from todos
-- langsung muncul pop up 'update rows 4'

-- kalo select all dah ilang semua
