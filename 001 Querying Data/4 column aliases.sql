select c.first_name, c.last_name from customer c 

select c.first_name, c.last_name as nama_akhir from customer c 

select c.first_name nama_depan, c.last_name nama_belakang from customer c 

--------------------------------------------------------------------------
SELECT
    first_name || ' ' || last_name as full_name
FROM
    customer;

SELECT
    first_name || ' ' || last_name nama_lengkap
FROM
    customer;

SELECT
    first_name || ' ' || last_name "nama komplit" -- ada spasi
FROM
    customer;

