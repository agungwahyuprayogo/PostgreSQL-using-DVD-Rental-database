/*
terkadang ketika kita update data baru dalam sebuah table, 
kita harus memperbaruinya di table yang 'join' atau saling nyambung foreign key nya

misal ada table 1 sama table 2, 2 table ini saling nyambung dengan foreign key primary key
trus ada kasus data table 1 pengen diubah, otomatis data di table 2 juga kudu 'tau'
nah gimana caranya?

secara basic sintax kaya gini :
UPDATE table1
SET table1.c1 = new_value
FROM table2
WHERE table1.c2 = table2.c2;

langsung buat table baru aja ye
 */

CREATE TABLE product_segment (
    id SERIAL PRIMARY KEY,
    segment VARCHAR NOT NULL,
    discount NUMERIC (4, 2)
);

INSERT INTO 
    product_segment (segment, discount)
VALUES
    ('Grand Luxury', 0.05),
    ('Luxury', 0.06),
    ('Mass', 0.1);

 -- kalo udah buat table baru lagi lalu sambungkan 'key' nya
 CREATE TABLE product(
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    price NUMERIC(10,2),
    net_price NUMERIC(10,2),
    segment_id INT NOT NULL,
    FOREIGN KEY(segment_id) REFERENCES product_segment(id)
);


INSERT INTO 
    product (name, price, segment_id) 
VALUES 
    ('diam', 804.89, 1),
    ('vestibulum aliquet', 228.55, 3),
    ('lacinia erat', 366.45, 2),
    ('scelerisque quam turpis', 145.33, 3),
    ('justo lacinia', 551.77, 2),
    ('ultrices mattis odio', 261.58, 3),
    ('hendrerit', 519.62, 2),
    ('in hac habitasse', 843.31, 1),
    ('orci eget orci', 254.18, 3),
    ('pellentesque', 427.78, 2),
    ('sit amet nunc', 936.29, 1),
    ('sed vestibulum', 910.34, 1),
    ('turpis eget', 208.33, 3),
    ('cursus vestibulum', 985.45, 1),
    ('orci nullam', 841.26, 1),
    ('est quam pharetra', 896.38, 1),
    ('posuere', 575.74, 2),
    ('ligula', 530.64, 2),
    ('convallis', 892.43, 1),
    ('nulla elit ac', 161.71, 3);
    
-- nah net price kan belum di tentuin ditable produc, 
-- kita itung discount make table product segmen. 

UPDATE 
    product p
SET 
    net_price = price - price * discount -- discount dari kolom table tetangga
FROM 
    product_segment s -- ini beda table ya
WHERE 
    p.segment_id = s.id;
    
-- sekarang kita cek harga di kolom net price setelah diubah
   
SELECT * FROM product;

/* jadi beda yah update di satu table doang sama 2 table gabungan
 * kalo table 1 gini :
UPDATE courses 						(update nama_table)
SET published_date = '2020-07-01' 	(set nama_kolom = data baru)
WHERE course_id = 3 				(kondisi dimana)
RETURNING *; 						(menampilkan hasil)

UPDATE product									(update nama_table1)
SET net_price = price - price * discount		(set table 1.kolom = data_baru)
FROM product_segment							(dari table 2)
WHERE product.segment_id = product_segment.id;	(dimana table 1.kolom_gabungan = table 2.kolom_gabungan)
 */