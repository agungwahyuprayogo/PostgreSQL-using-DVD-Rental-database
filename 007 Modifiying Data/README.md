# PostgreSQL Join Guide

## Table of Contents
- [PostgreSQL INSERT](#postgresql-insert)
- [PostgreSQL INSERT Multiple Rows](#postgresql-insert-multiple-rows)
- [PostgreSQL UPDATE](#postgresql-update)
- [PostgreSQL UPDATE Join](#postgresql-update-join)
- [PostgreSQL DELETE](#postgresql-delete)
- [PostgreSQL DELETE JOIN](#postgresql-delete-join)
- [PostgreSQL UPSERT](#postgresql-upsert)
- [PostgreSQL MERGE](#postgresql-merge)

--- 

# PostgreSQL INSERT

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `INSERT` statement to insert a new row into a table.

## Introduction to PostgreSQL INSERT statement

The PostgreSQL `INSERT` statement allows you to insert a new row into a table.

Here’s the basic syntax of the `INSERT` statement:

```sql
INSERT INTO table1(column1, column2, …)
VALUES (value1, value2, …);
```

In this syntax:

- First, specify the name of the table (`table1`) that you want to insert data after the `INSERT INTO` keywords and a list of comma\-separated columns (`colum1, column2, ....`).
- Second, supply a list of comma\-separated values in parentheses `(value1, value2, ...)` after the `VALUES` keyword. The column and value lists must be in the same order.

The `INSERT` statement returns a command tag with the following form:

```sql
INSERT oid count
```

In this syntax:

- The `OID` is an object identifier. PostgreSQL used the `OID` internally as a `primary key` for its system tables. Typically, the `INSERT` statement returns `OID` with a value of 0\.
- The `count` is the number of rows that the `INSERT` statement inserted successfully.

If you insert a new row into a table successfully, the return will typically look like:

```
INSERT 0 1
```

### RETURNING clause

The `INSERT` statement has an optional `RETURNING` clause that returns the information of the inserted row.

If you want to return the entire inserted row, you use an asterisk (`*`) after the `RETURNING` keyword:

```sql
INSERT INTO table1(column1, column2, …)
VALUES (value1, value2, …)
RETURNING *;
```

If you want to return some information about the inserted row, you can specify one or more columns after the `RETURNING` clause.

For example, the following statement returns the `id` of the inserted row:

```sql
INSERT INTO table1(column1, column2, …)
VALUES (value1, value2, …)
RETURNING id;
```

To rename the returned value, you use the `AS` keyword followed by the name of the output. For example:

```sql
INSERT INTO table1(column1, column2, …)
VALUES (value1, value2, …)
RETURNING output_expression AS output_name;
```

To insert multiple rows into a table simultaneously, you can use the `INSERT` multiple rows statement.

## PostgreSQL INSERT statement examples

The following statement creates a new table called `links` for the demonstration:

```sql
CREATE TABLE links (
  id SERIAL PRIMARY KEY,
  url VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR (255),
  last_update DATE
);
```

Note that you will learn how to create a new table in the subsequent tutorial. In this tutorial, you need to execute it to create a new table.

### 1) Basic PostgreSQL INSERT statement example

The following example uses the `INSERT` statement to insert a new row into the `links` table:

```sql
INSERT INTO links (url, name)
VALUES('https://neon.tech/postgresql','PostgreSQL Tutorial');
```

The statement returns the following output:

```sql
INSERT 0 1
```

To insert character data, you enclose it in single quotes (‘) for example `'PostgreSQL Tutorial'`.

If you omit the not null columns in the `INSERT` statement, PostgreSQL will issue an error. But if you omit the null column, PostgreSQL will use the column default value for insertion.

In this example, the `description` is a nullable column because it doesn’t have a `NOT NULL` constraint. Therefore, PostgreSQL uses `NULL` to insert into the `description` column.

PostgreSQL automatically generates a sequential number for the `serial column` so you do not have to supply a value for the serial column in the `INSERT` statement.

The following `SELECT` statement shows the contents of the `links` table:

```sql
SELECT	* FROM links;
```

Output:

| id | url                           | name                | description | last_update |
|----|-------------------------------|---------------------|-------------|-------------|
|  1 | https://neon.tech/postgresql  | PostgreSQL Tutorial | null        | null        |

---

### 2) Inserting character string that contains a single quote

If you want to insert a string that contains a single quote (`'`) such as `O'Reilly Media`, you have to use an additional single quote (`'`) to escape it. For example:

```sql
INSERT INTO links (url, name)
VALUES('http://www.oreilly.com','O''Reilly Media');
```

Output:

```
INSERT 0 1
```

The following statement verifies the insert:

```sql
SELECT * FROM links;
```

Output:

| id | url                          | name             | description | last_update |
|----|------------------------------|-----------------|-------------|-------------|
|  1 | https://neon.tech/postgresql | PostgreSQL Tutorial | null    | null        |
|  2 | http://www.oreilly.com       | O'Reilly Media  | null       | null        |

(2 rows)


### 3) Inserting a date value

To insert a date into a `DATE` column, you use the date in the format `'YYYY-MM-DD'`.

For example, the following statement inserts a new row with a specified date into the `links` table:

```sql
INSERT INTO links (url, name, last_update)
VALUES('https://www.google.com','Google','2013-06-01');
```

Output:

```
INSERT 0 1
```

The following statement retrieves all data from the links table to verify the insert:

| id | url                          | name                 | description | last_update  |
|----|------------------------------|---------------------|-------------|--------------|
|  1 | https://neon.tech/postgresql | PostgreSQL Tutorial | null        | null         |
|  2 | http://www.oreilly.com       | O'Reilly Media      | null        | null         |
|  3 | https://www.google.com       | Google              | null        | 2013-06-01   |

(3 rows)


### 4) Getting the last inserted ID

To get the last inserted ID from the inserted row, you use the `RETURNING` clause of the `INSERT`statement.

For example, the following statement inserts a new row into the `links` table and returns the last inserted id:

```sql
INSERT INTO links (url, name)
VALUES('https://www.postgresql.org','PostgreSQL')
RETURNING id;
```

Output:

| id  |
|-----|
|  4  |


(1 row)


## Summary

- Use PostgreSQL `INSERT` statement to insert a new row into a table.
- Use the `RETURNING` clause to get the inserted rows.

---
---
---
---
---
---
---
---
---
---

---
# PostgreSQL INSERT Multiple Rows

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `INSERT` statement to insert multiple rows into a table.

## Inserting multiple rows into a table

To insert multiple rows into a table using a single `INSERT` statement, you use the following syntax:

```sql
INSERT INTO table_name (column_list)
VALUES
    (value_list_1),
    (value_list_2),
    ...
    (value_list_n);
```

In this syntax:

- First, specify the name of the table that you want to insert data after the `INSERT INTO` keywords.
- Second, list the required columns or all columns of the table in parentheses that follow the table name.
- Third, supply a comma\-separated list of rows after the `VALUES` keyword.

To insert multiple rows and return the inserted rows, you add the `RETURNING` clause as follows:

```sql
INSERT INTO table_name (column_list)
VALUES
    (value_list_1),
    (value_list_2),
    ...
    (value_list_n)
RETURNING * | output_expression;
```

Inserting multiple rows at once has advantages over inserting one row at a time:

- **Performance:** Inserting multiple rows in a single statement is often more efficient than multiple individual inserts because it reduces the number of round\-trips between the application and the PostgreSQL server.
- **Atomicity:** The entire `INSERT` statement is atomic, meaning that either all rows are inserted, or none are. This ensures data consistency.

## Inserting multiple rows into a table examples

Let's take some examples of inserting multiple rows into a table.

### Setting up a sample table

The following statement creates a new table called `contacts` that has four columns `id`, `first_name`, `last_name`, and `email`:

```sql
CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(384) NOT NULL UNIQUE
);
```

### 1) Basic inserting multiple rows example

The following statement uses the `INSERT` statement to insert three rows into the `contacts` table:

```sql
INSERT INTO contacts (first_name, last_name, email)
VALUES
    ('John', 'Doe', 'john.doe@example.com'),
    ('Jane', 'Smith', 'jane.smith@example.com'),
    ('Bob', 'Johnson', 'bob.johnson@example.com');
```

PostgreSQL returns the following message:

```
INSERT 0 3
```

To verify the inserts, you use the following statement:

```sql
SELECT * FROM contacts;
```

Output:

| id | first_name | last_name | email                   |
|----|------------|-----------|-------------------------|
|  1 | John       | Doe       | john.doe@example.com    |
|  2 | Jane       | Smith     | jane.smith@example.com  |
|  3 | Bob        | Johnson   | bob.johnson@example.com |

(3 rows)


### 2) Inserting multiple rows and returning inserted rows

The following statement uses the `INSERT` statement to insert two rows into the `contacts` table and returns the inserted rows:

```sql
INSERT INTO contacts (first_name, last_name, email)
VALUES
    ('Alice', 'Johnson', 'alice.johnson@example.com'),
    ('Charlie', 'Brown', 'charlie.brown@example.com')
RETURNING *;
```

Output:

| id | first_name | last_name | email                       |
|----|------------|-----------|----------------------------|
|  4 | Alice      | Johnson   | alice.johnson@example.com   |
|  5 | Charlie    | Brown     | charlie.brown@example.com   |

(2 rows)


```
INSERT 0 2
```

If you just want to return the inserted id list, you can specify the `id` column in the `RETURNING` clause like this:

```sql
INSERT INTO contacts (first_name, last_name, email)
VALUES
    ('Eva', 'Williams', 'eva.williams@example.com'),
    ('Michael', 'Miller', 'michael.miller@example.com'),
    ('Sophie', 'Davis', 'sophie.davis@example.com')
RETURNING id;
```

Output:

| id  |
|-----|
|  6  |
|  7  |
|  8  |

(3 rows)



```
INSERT 0 3
```

## Summary

- Specify multiple value lists in the `INSERT` statement to insert multiple rows into a table.
- Use `RETURNING` clause to return the inserted rows.

---
---
---
---
---
---
---
---
---
---

---
# PostgreSQL UPDATE

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `UPDATE` statement to update existing data in a table.

## Introduction to the PostgreSQL UPDATE statement

The PostgreSQL `UPDATE` statement allows you to update data in one or more columns of one or more rows in a table.

Here’s the basic syntax of the `UPDATE` statement:

```sql
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition;
```

In this syntax:

- First, specify the name of the table that you want to update data after the `UPDATE` keyword.
- Second, specify columns and their new values after `SET` keyword. The columns that do not appear in the `SET` clause retain their original values.
- Third, determine which rows to update in the condition of the `WHERE` clause.

The `WHERE` clause is optional. If you omit the `WHERE` clause, the `UPDATE` statement will update all rows in the table.

When the `UPDATE` statement is executed successfully, it returns the following command tag:

```
UPDATE count
```

The `count` is the number of rows updated including rows whose values did not change.

### Returning updated rows

The `UPDATE` statement has an optional `RETURNING` clause that returns the updated rows:

```sql
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition
RETURNING * | output_expression AS output_name;
```

## PostgreSQL UPDATE examples

Let’s take some examples of using the PostgreSQL `UPDATE` statement.

### Setting up a sample table

The following statements create a table called `courses` and `insert` data into it:

```sql
CREATE TABLE courses(
  course_id serial PRIMARY KEY,
  course_name VARCHAR(255) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  description VARCHAR(500),
  published_date date
);


INSERT INTO courses( course_name, price, description, published_date)
VALUES
('PostgreSQL for Developers', 299.99, 'A complete PostgreSQL for Developers', '2020-07-13'),
('PostgreSQL Admininstration', 349.99, 'A PostgreSQL Guide for DBA', NULL),
('PostgreSQL High Performance', 549.99, NULL, NULL),
('PostgreSQL Bootcamp', 777.99, 'Learn PostgreSQL via Bootcamp', '2013-07-11'),
('Mastering PostgreSQL', 999.98, 'Mastering PostgreSQL in 21 Days', '2012-06-30');

SELECT * FROM courses;

```

Output:

| course_id | course_name                 | price  | description                          | published_date |
|-----------|-----------------------------|--------|--------------------------------------|----------------|
| 1         | PostgreSQL for Developers   | 299.99 | A complete PostgreSQL for Developers | 2020-07-13     |
| 2         | PostgreSQL Administration   | 349.99 | A PostgreSQL Guide for DBA           | null           |
| 3         | PostgreSQL High Performance | 549.99 | null                                 | null           |
| 4         | PostgreSQL Bootcamp         | 777.99 | Learn PostgreSQL via Bootcamp        | 2013-07-11     |
| 5         | Mastering PostgreSQL        | 999.98 | Mastering PostgreSQL in 21 Days      | 2012-06-30     |

(5 rows)


### 1) Basic PostgreSQL UPDATE example

The following statement uses the `UPDATE` statement to update the course with id 3 by changing the `published_date` to `'2020-08-01'`.

```sql
UPDATE courses
SET published_date = '2020-08-01'
WHERE course_id = 3;
```

The statement returns the following message indicating that one row has been updated:

```
UPDATE 1
```

The following statement retrieves the course with id 3 to verify the update:

```sql
SELECT course_id, course_name, published_date
FROM courses
WHERE course_id = 3;
```

Output:

| course_id | course_name                 | published_date |
|-----------|-----------------------------|---------------|
| 3         | PostgreSQL High Performance | 2020-08-01    |

(1 row)


### 2) Updating a row and returning the updated row

The following statement uses the `UPDATE` statement update `published_date` of the course id 2 to `2020-07-01` and returns the updated course.

```sql
UPDATE courses
SET published_date = '2020-07-01'
WHERE course_id = 2
RETURNING *;
```

Output:

| course_id | course_name               | price  | description               | published_date |
|-----------|---------------------------|--------|---------------------------|---------------|
| 2         | PostgreSQL Administration | 349.99 | A PostgreSQL Guide for DBA | 2020-07-01    |

(1 row)


### 3) Updating a column with an expression

The following statement uses an `UPDATE` statement to increase the price of all the courses 5%:

```sql
UPDATE courses
SET price = price * 1.05;
```

Because we don’t use a WHERE clause, the UPDATE statement updates all the rows in the `courses` table.

Output:

```
UPDATE 5
```

The following statement retrieves data from the `courses` table to verify the update:

```sql
SELECT * FROM courses;
```

Output:

```sql
SELECT
  course_name,
  price
FROM
  courses;
```

Output:

| course_name                 | price   |
|-----------------------------|---------|
| PostgreSQL for Developers   | 314.99  |
| PostgreSQL Bootcamp         | 816.89  |
| Mastering PostgreSQL        | 1049.98 |
| PostgreSQL High Performance | 577.49  |
| PostgreSQL Administration   | 367.49  |

(5 rows)


## Summary

- Use the `UPDATE` statement to update data in one or more columns of a table.
- Specify a condition in a WHERE clause to determine which rows to update data.
- Use the `RETURNING` clause to return the updated rows from the `UPDATE` statement

---
---
---
---
---
---
---
---
---
---

# PostgreSQL UPDATE Join

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `UPDATE` join syntax to update data in a table based on values in another table.

## Introduction to the PostgreSQL UPDATE join syntax

Sometimes, you need to update data in a table based on values in another table. In this case, you can use the PostgreSQL `UPDATE` join.

Here’s the basic syntax of the `UPDATE` join statement:

```sql
UPDATE table1
SET table1.c1 = new_value
FROM table2
WHERE table1.c2 = table2.c2;
```

To join a table (table1) with another table (table2\) in the `UPDATE` statement, you specify the joined table (table2) in the `FROM` clause and provide the join condition in the `WHERE` clause. The `FROM` clause must appear immediately after the `SET` clause.

For each row of the table `table1`, the `UPDATE` statement examines every row of the table `table2`.

If the values in the `c2` column of table `table1` equals the values in the `c2` column of table `table2`, the `UPDATE` statement updates the value in the `c1` column of the table `table1` the new value (`new_value`).

## PostgreSQL UPDATE JOIN example

Let’s take a look at an example to understand how the PostgreSQL `UPDATE` join works. We will use the following database tables for the demonstration:

![image](https://github.com/user-attachments/assets/05f08f82-afc8-4505-919b-13993c4137eb)

First, create a new table called `product_segment` that stores the product segments such as grand luxury, luxury, and mass.

The `product_segment` table has the `discount` column that stores the discount percentage based on a specific segment. For example, products with the grand luxury segment have `5%` discount while luxury and mass products have `6%` and `10%` discounts respectively.

```sql
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

```

Second, create another table named `product` that stores the product data. The `product` table has the `foreign key column` `segment_id` that links to the `id` of the `segment` table.

```sql
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
```

Third, suppose you have to calculate the net price of every product based on the discount of the product segment. To do this, you can apply the `UPDATE` join statement as follows:

```sql
UPDATE product
SET net_price = price - price * discount
FROM product_segment
WHERE product.segment_id = product_segment.id;
```

You can utilize the table aliases to make the query shorter like this:

```sql
UPDATE
    product p
SET
    net_price = price - price * discount
FROM
    product_segment s
WHERE
    p.segment_id = s.id;
```

This statement joins the `product` table to the `product_segment` table. If there is a match in both tables, it gets a discount from the `product_segment` table, calculates the net price based on the following formula, and updates the `net_price` column.

```
net_price = price - price * discount;
```

The following `SELECT`statement retrieves the data of the `product` table to verify the update:

```sql
SELECT * FROM product;
```

![image](https://github.com/user-attachments/assets/c8ee80c1-05a9-45d6-b0f3-aad08822f61e)

The output indicates that the `net_price` column has been updated with the correct values.

## Summary

- Use the PostgreSQL `UPDATE` join statement to update data in a table based on values in another table.

---
---
---
---
---
---
---
---
---
---


# PostgreSQL DELETE


**Summary**: in this tutorial, you will learn how to use the **PostgreSQL DELETE** statement to delete data from a table.

## Introduction to PostgreSQL DELETE statement

The PostgreSQL `DELETE` statement allows you to delete one or more rows from a table.

The following shows the basic syntax of the `DELETE` statement:

```sql
DELETE FROM table_name
WHERE condition;
```

In this syntax:

- First, specify the name (`table_name`) of the table from which you want to delete data after the `DELETE FROM` keywords.
- Second, specify a condition in the `WHERE` clause to determine which rows to delete.

The `WHERE` clause is optional. If you omit the `WHERE` clause, the `DELETE` statement will delete all rows in the table.

The `DELETE` statement returns the number of rows deleted. It returns zero if the `DELETE` statement did not delete any row.

To return the deleted row(s) to the client, you use the `RETURNING` clause as follows:

```sql
DELETE FROM table_name
WHERE condition
RETURNING (select_list | *)
```

The asterisk (`*`) allows you to return all columns of the deleted row(s). If you want to return the values in a specific column, you can also specify them after the `RETURNING` keyword.

For example, the following statement deletes rows from a table and returns the values of the id of the deleted rows:

```sql
DELETE FROM table_name
WHERE condition
RETURNING id;
```

If you delete data from a table based on data from another table, you can use the `DELETE JOIN` statement.

To delete data that have a `foreign key` relationship, you use the `ON DELETE CASCADE` option.

Note that the `DELETE` statement removes data from a table but doesn’t modify the structure of the table. If you want to change the structure of a table such as removing a column, you should use the `ALTER TABLE` statement instead.

## PostgreSQL DELETE statement examples

Let’s explore some examples of using the `DELETE` statement.

### Setting up a sample table

The following statements create a new table called `todos` and `insert` some sample data:

```sql
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
```

Output:

| id  | title                                      | completed |
|-----|--------------------------------------------|-----------|
|  1  | Learn basic SQL syntax                     | t         |
|  2  | Practice writing SELECT queries            | f         |
|  3  | Study PostgreSQL data types                | t         |
|  4  | Create and modify tables                   | f         |
|  5  | Explore advanced SQL concepts              | t         |
|  6  | Understand indexes and optimization        | f         |
|  7  | Backup and restore databases               | t         |
|  8  | Implement transactions                     | f         |
|  9  | Master PostgreSQL security features        | t         |
| 10  | Build a sample application with PostgreSQL | f         |

(10 rows)


### 1) Using PostgreSQL DELETE to delete one row from the table

The following statement uses the `DELETE` statement to delete one row with the id 1 from the `todos` table:

```sql
DELETE FROM todos
WHERE id = 1;
```

The statement returns 1 indicating that one row has been deleted:

```
DELETE 1
```

The following statement uses the `DELETE` statement to delete the row with id 100:

```sql
DELETE FROM todos
WHERE id = 100;
```

Since the row with the id 100 does not exist, the `DELETE` statement returns 0:

```
DELETE 0
```

### 2) Using PostgreSQL DELETE to delete a row and return the deleted row

The following statement uses the `DELETE` statement to delete the row with id 2 and return the deleted row to the client:

```sql
DELETE FROM todos
WHERE id = 2
RETURNING *;
```

PostgreSQL returns the following deleted row:

| id  | title                            | completed |
|-----|----------------------------------|-----------|
|  2  | Practice writing SELECT queries | f         |

(1 row)


### 3) Using PostgreSQL DELETE to delete multiple rows from the table

The following statement uses the `DELETE` statement to delete all rows from the `todos` table with the value in the value in the completed column `true` and return deleted rows:

```sql
DELETE FROM todos
WHERE completed = true
RETURNING *;
```

Output:

| id  | title                                | completed |
|-----|--------------------------------------|-----------|
|  3  | Study PostgreSQL data types          | t         |
|  5  | Explore advanced SQL concepts        | t         |
|  7  | Backup and restore databases         | t         |
|  9  | Master PostgreSQL security features  | t         |

(4 rows)


```
DELETE 4
```

It deleted four rows from the `todos` table.

### 4) Using PostgreSQL DELETE to delete all rows from the table

The following statement uses the `DELETE` statement without a `WHERE` clause to delete all rows from the `todos` table:

```sql
DELETE FROM todos;
```

Output:

```
DELETE 4
```

The `todos` table now is empty.

## Summary

- Use the `DELETE FROM` statement to delete one or more rows from a table.
- Use the `WHERE` clause to specify which rows to be deleted.
- Use the `RETURNING` clause to return the deleted rows.

---
---
---
---
---
---
---
---
---
---

# PostgreSQL DELETE JOIN

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `DELETE` statement to emulate delete join operations.

## Introduction to PostgreSQL DELETE statement with USING clause

PostgreSQL does not support the [`DELETE JOIN` statement like MySQL](https://www.mysqltutorial.org/mysql-basics/mysql-delete-join/). Instead, it offers the `USING` clause in the `DELETE` statement that provides similar functionality to the `DELETE JOIN`.

Here’s the syntax of the `DELETE USING` statement:

```sql
DELETE FROM table1
USING table2
WHERE condition
RETURNING returning_columns;
```

In this syntax:

- First, specify the name of the table (`table1`) from which you want to delete data after the `DELETE FROM` keywords
- Second, provide a table (`table2`) to join with the main table after the `USING` keyword.
- Third, define a condition in the `WHERE` clause for joining two tables.
- Finally, return the deleted rows in the `RETURNING` clause. The `RETURNING` clause is optional.

For example, the following statement uses the `DELETE` statement with the `USING` clause to delete data from `t1` that has the same id as `t2`:

```sql
DELETE FROM t1
USING t2
WHERE t1.id = t2.id
```

## PostgreSQL DELETE JOIN examples

Let’s explore some examples of using the `DELETE USING` statement.

### Setting up sample tables

The following statements create `member` and `denylist` tables and insert some sample data into them:

```sql
CREATE TABLE member(
   id SERIAL PRIMARY KEY,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   phone VARCHAR(15) NOT NULL
);


CREATE TABLE denylist(
    phone VARCHAR(15) PRIMARY KEY
);


INSERT INTO member(first_name, last_name, phone)
VALUES ('John','Doe','(408)-523-9874'),
       ('Jane','Doe','(408)-511-9876'),
       ('Lily','Bush','(408)-124-9221');


INSERT INTO denylist(phone)
VALUES ('(408)-523-9874'),
       ('(408)-511-9876');

SELECT * FROM member;

SELECT * FROM denylist;
```

The member table:

| id  | first_name | last_name | phone          |
|-----|------------|-----------|----------------|
|  1  | John       | Doe       | (408)-523-9874 |
|  2  | Jane       | Doe       | (408)-511-9876 |
|  3  | Lily       | Bush      | (408)-124-9221 |

(3 rows)


The denylist table:

| phone          |
|----------------|
| (408)-523-9874 |
| (408)-511-9876 |

(2 rows)


### 1) Basic PostgreSQL delete join example

The following statement deletes rows in the `members` table with the phone number exists in the `denylist` table:

```sql
DELETE FROM member
USING denylist
WHERE member.phone = denylist.phone;
```

Output:

```
DELETE 2
```

The output indicates that the `DELETE` statement has deleted two rows from the `member` table.

Verify the deletion by retrieving data from the `contacts` table:

```sql
SELECT * FROM member;
```

Output:

| id  | first_name | last_name | phone          |
|-----|------------|-----------|----------------|
|  3  | Lily       | Bush      | (408)-124-9221 |

(1 row)


### 2) Delete join using a subquery example

The `USING` clause is not a part of the SQL standard, meaning that it may not be available in other database systems.

If you intend to ensure compatibility with various database products, you should avoid using the `USING` clause in the `DELETE` statement. Instead, you may consider using a `subquery`.

The following statement uses the `DELETE` statement to delete all rows from the member table whose phones are in the `denylist` table:

```sql
DELETE FROM member
WHERE phone IN (
    SELECT
      phone
    FROM
      denylist
);
```

In this example:

- First, the subquery returns a list of phones from the `denylist` table.
- Second, the `DELETE` statement deletes rows in the member table whose values in the phone column are in the list of phones returned by the subquery.

## Summary

- Use the `DELETE USING` statement or a subquery to emulate the `DELETE JOIN` operation.

---
---
---
---
---
---
---
---
---
---


# PostgreSQL UPSERT

**Summary**: in this tutorial, you will learn how to use the PostgreSQL upsert feature to insert a new row into a table if the row does not exist, or update an existing row if it already exists.

## Introduction to the PostgreSQL UPSERT Statement

Upsert is a combination of `update` and `insert`. The upsert allows you to update an existing row or insert a new one if it doesn’t exist.

PostgreSQL does not have the `UPSERT` statement but it supports the upsert operation via the `INSERT...ON CONFLICT` statement.

If you use PostgreSQL 15 or later, you can use the `MERGE` statement which is equivalent to the `UPSERT` statement.

Here’s the basic syntax of the `INSERT...ON CONFLICT` statement:

```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...)
ON CONFLICT (conflict_column)
DO NOTHING | DO UPDATE SET column1 = value1, column2 = value2, ...;
```

In this syntax:

- `table_name`: This is the name of the table into which you want to insert data.
- `(column1, column2, ...)`: The list of columns you want to insert values into the table.
- `VALUES(value1, value2, ...)`: The values you want to insert into the specified columns `(column1, column2, ...)`.
- `ON CONFLICT (conflict_column):` This clause specifies the conflict target, which is the `unique constraint` or `unique index` that may cause a conflict.
- `DO NOTHING`: This instructs PostgreSQL to do nothing when a conflict occurs.
- `DO UPDATE`: This performs an update if a conflict occurs.
- `SET column = value1, column = value2, ...`: This list of the columns to be updated and their corresponding values in case of conflict.

How the `INSERT ... ON CONFLICT` statement works.

First, the `ON CONFLICT` clause identifies the conflict target which is usually a unique constraint (or a unique index). If the data that you insert violates the constraint, a conflict occurs.

Second, the `DO UPDATE` instructs PostgreSQL to update existing rows or do nothing rather than aborting the entire operation when a conflict occurs.

Third, the `SET` clause defines the columns and values to update. You can use new values or reference the values you attempted to insert using the `EXCLUDED` keyword.

## PostgreSQL UPSERT examples

The following statements create the `inventory` table and insert data into it:

```sql
CREATE TABLE inventory(
   id INT PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   price DECIMAL(10,2) NOT NULL,
   quantity INT NOT NULL
);

INSERT INTO inventory(id, name, price, quantity)
VALUES
	(1, 'A', 15.99, 100),
	(2, 'B', 25.49, 50),
	(3, 'C', 19.95, 75)
RETURNING *;
```

Output:

| id  | name | price  | quantity |
|-----|------|--------|----------|
|  1  | A    | 15.99  | 100      |
|  2  | B    | 25.49  | 50       |
|  3  | C    | 19.95  | 75       |

(3 rows)


```
INSERT 0 3
```

The `inventory` table contains information about various products, including their names, prices, and quantities in stock.

Suppose you’ve received an updated list of products with new prices, and now you need to update the inventory accordingly.

In this case, the upsert operation can be handy to handle the following situations:

- **Updating existing products**. If a product already exists in the `inventory` table, you want to update its price and quantity with the new information.
- **Insert new products**. If a product is not in the `inventory` table, you want to insert it into the table.

### 1\) Basic PostgreSQL INSERT … ON CONFLICT statement example

The following example uses the `INSERT ... ON CONFLICT` statement to insert a new row into the `inventory` table:

```sql
INSERT INTO inventory (id, name, price, quantity)
VALUES (1, 'A', 16.99, 120)
ON CONFLICT(id)
DO UPDATE SET
  price = EXCLUDED.price,
  quantity = EXCLUDED.quantity;
```

Output:

```
INSERT 0 1
```

In this example, we attempt to insert a new row into the `inventory` table.

However, the `inventory` table already has a row with id 1, therefore, a conflict occurs.

The `DO UPDATE` changes the price and quantity of the product to the new values being inserted. The `EXCLUDED` allows you to access the new values.

The following statement verifies the update:

```sql
SELECT * FROM inventory
WHERE id = 1;
```

Output:

| id  | name | price  | quantity |
|-----|------|--------|----------|
|  1  | A    | 16.99  | 120      |

(1 row)


### 2) Inserting data example

The following example uses the `INSERT ... ON CONFLICT` statement to insert a new row into the `inventory` table:

```sql
INSERT INTO inventory (id, name, price, quantity)
VALUES (4, 'D', 29.99, 20)
ON CONFLICT(id)
DO UPDATE SET
  price = EXCLUDED.price,
  quantity = EXCLUDED.quantity;
```

Output:

```
INSERT 0 1
```

In this case, the statement `inserts` a new row into the `inventory` table because the product id 4 does not exist in the `inventory` table.

The following statement verifies the insert:

```sql
SELECT * FROM inventory
ORDER BY id;
```

Output:

| id  | name | price  | quantity |
|-----|------|--------|----------|
|  1  | A    | 16.99  | 120      |
|  2  | B    | 25.49  | 50       |
|  3  | C    | 19.95  | 75       |
|  4  | D    | 29.99  | 20       |

(4 rows)


## Summary

- Use the PostgreSQL upsert to update data if it already exists or insert the data if it does not.
- Use the `INSERT...ON CONFLICT` statement for upsert.

---
---
---
---
---
---
---
---
---
---


# PostgreSQL MERGE

**Summary**: In this tutorial, you will learn how to use the PostgreSQL `MERGE` statement to conditionally insert, update, and delete rows of a table.

## Introduction to the PostgreSQL MERGE statement

Have you ever needed to update a table but weren't sure whether to insert new records or update existing ones? PostgreSQL's `MERGE` command solves this common problem. Think of `MERGE` as a smart helper that can look at your data and decide whether to add new records, update existing ones, or even delete records, all in a single command.

## Basic Concepts

Before we dive into `MERGE`, let's understand some basic terms:

- **Target Table**: The table you want to modify
- **Source Table**: The table containing your new or updated data
- **Match Condition**: The rule that determines if records match between your tables

## Basic MERGE Syntax

Here's the basic structure of a `MERGE` command:

```sql
MERGE INTO target_table
USING source_table
ON match_condition
WHEN MATCHED AND condition THEN
    UPDATE SET column1 = value1, column2 = value2
WHEN MATCHED AND NOT condition THEN
    DELETE
WHEN NOT MATCHED THEN
    INSERT (column1, column2) VALUES (value1, value2)
RETURNING merge_action(), target_table.*;
```

This `MERGE` statement performs three conditional actions on `target_table` based on rows from `source_table`:

1. **Update rows**: If a match is found (`ON match_condition`) and `condition` is true, it updates `column1` and `column2` in `target_table`.
2. **Delete rows**: If a match is found but `condition` is false, it deletes the matching rows in `target_table`.
3. **Insert rows**: If no match is found, it inserts new rows into `target_table` using values from `source_table`.
4. The `RETURNING` clause provides details of the operation (`merge_action()`) and the affected rows.

## Key Features in PostgreSQL 17

The new RETURNING clause support in PostgreSQL 17 offers several advantages:

1. **Action Tracking**: The `merge_action()` function tells you exactly what happened to each row
2. **Complete Row Access**: You can return both old and new values for affected rows
3. **Immediate Feedback**: No need for separate queries to verify the results

## Setting Up Our Example

Let's create a sample database tracking a company's products and their inventory status:

```sql
-- Create the main products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name TEXT UNIQUE,
    price DECIMAL(10,2),
    stock INTEGER,
    status TEXT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert some initial data
INSERT INTO products (name, price, stock, status) VALUES
    ('Laptop', 999.99, 50, 'active'),
    ('Keyboard', 79.99, 100, 'active'),
    ('Mouse', 29.99, 200, 'active');

-- Create a table for our updates
CREATE TABLE product_updates (
    name TEXT,
    price DECIMAL(10,2),
    stock INTEGER,
    status TEXT
);

-- Insert mixed update data (new products, updates, and discontinuations)
INSERT INTO product_updates VALUES
    ('Laptop', 1099.99, 75, 'active'),      -- Update: price and stock change
    ('Monitor', 299.99, 30, 'active'),      -- Insert: new product
    ('Keyboard', NULL, 0, 'discontinued'),  -- Delete: mark as discontinued
    ('Headphones', 89.99, 50, 'active');    -- Insert: another new product
```

## Using MERGE with RETURNING

Now let's see how PostgreSQL 17's enhanced `MERGE` command can handle all three operations (`INSERT`, `UPDATE`, `DELETE`) while providing detailed feedback through the `RETURNING` clause:

```sql
MERGE INTO products p
USING product_updates u
ON p.name = u.name
WHEN MATCHED AND u.status = 'discontinued' THEN
    DELETE
WHEN MATCHED AND u.status = 'active' THEN
    UPDATE SET
        price = COALESCE(u.price, p.price),
        stock = u.stock,
        status = u.status,
        last_updated = CURRENT_TIMESTAMP
WHEN NOT MATCHED AND u.status = 'active' THEN
    INSERT (name, price, stock, status)
    VALUES (u.name, u.price, u.stock, u.status)
RETURNING
    merge_action() as action,
    p.product_id,
    p.name,
    p.price,
    p.stock,
    p.status,
    p.last_updated;
```

## Understanding the Output

The `RETURNING` clause will provide detailed information about each operation:

| action | product_id | name       | price   | stock | status  | last_updated               |
|--------|------------|------------|--------|-------|---------|----------------------------|
| UPDATE | 1         | Laptop     | 1099.99 | 75    | active  | 2024-12-04 17:41:58.226807 |
| INSERT | 4         | Monitor    | 299.99  | 30    | active  | 2024-12-04 17:41:58.226807 |
| DELETE | 2         | Keyboard   | 79.99   | 100   | active  | 2024-12-04 17:41:47.816064 |
| INSERT | 5         | Headphones | 89.99   | 50    | active  | 2024-12-04 17:41:58.226807 |

(4 rows)


Let's break down what happened:

1. **`UPDATE`**: The Laptop's price and stock were updated
2. **`DELETE`**: The Keyboard is deleted from the products table
3. **`INSERT`**: New Monitor and Headphones products were added

We can confirm the changes by querying the products table:

```sql
SELECT * FROM products
ORDER BY product_id;
```

| product_id | name       | price   | stock | status  | last_updated               |
|------------|------------|--------|-------|---------|----------------------------|
| 1         | Laptop     | 1099.99 | 75    | active  | 2024-12-04 17:41:58.226807 |
| 3         | Mouse      | 29.99   | 200   | active  | 2024-12-04 17:41:47.816064 |
| 4         | Monitor    | 299.99  | 30    | active  | 2024-12-04 17:41:58.226807 |
| 5         | Headphones | 89.99   | 50    | active  | 2024-12-04 17:41:58.226807 |

(4 rows)


## Advanced Usage with Conditions

You can add more complex conditions to your `MERGE` statement:

```sql
MERGE INTO products p
USING (
    SELECT
        name,
        price,
        stock,
        status,
        CASE
            WHEN price IS NULL AND status = 'discontinued' THEN 'DELETE'
            WHEN stock = 0 THEN 'OUT_OF_STOCK'
            ELSE status
        END as action_type
    FROM product_updates
) u
ON p.name = u.name
WHEN MATCHED AND u.action_type = 'DELETE' THEN
    DELETE
WHEN MATCHED AND u.action_type = 'OUT_OF_STOCK' THEN
    UPDATE SET
        status = 'inactive',
        stock = 0,
        last_updated = CURRENT_TIMESTAMP
WHEN MATCHED THEN
    UPDATE SET
        price = COALESCE(u.price, p.price),
        stock = u.stock,
        status = u.status,
        last_updated = CURRENT_TIMESTAMP
WHEN NOT MATCHED AND u.action_type != 'DELETE' THEN
    INSERT (name, price, stock, status)
    VALUES (u.name, u.price, u.stock, u.status)
RETURNING
    merge_action() as action,
    p.*,
    u.action_type;
```

## Best Practices

1. **Handle Source Data Carefully**:

   - Validate input data before the `MERGE`
   - Use subqueries to transform or clean data
   - Consider using CTEs for complex data preparation

2. **Leverage RETURNING for Validation**:
   - Include the `merge_action()` for operation tracking
   - Consider returning both old and new values for logging purposes and validation

## Common Pitfalls to Avoid

1. **Ambiguous Matches**: Ensure your `ON` clause creates unique matches
2. **NULL Handling**: Use `COALESCE` or `IS NOT DISTINCT FROM` for `NULL` values
3. **Missing Conditions**: Always handle all possible cases in your `WHEN` clauses

## Conclusion

PostgreSQL 17's enhanced `MERGE` command with `RETURNING` clause support provides a powerful tool for data synchronization and maintenance. The ability to perform multiple operations in a single statement while getting immediate feedback makes it an invaluable feature for modern applications.

## Frequently Asked Questions (FAQ)

### <DefinitionList>
#### What is the purpose of the `MERGE` statement in PostgreSQL?
: The `MERGE` statement allows you to conditionally `INSERT`, `UPDATE`, or `DELETE` rows in a target table based on the presence of matching records in a source table. This consolidates multiple operations into a single, efficient command.

#### When was the `MERGE` statement introduced in PostgreSQL?
: The `MERGE` statement was officially introduced in PostgreSQL version 15, released in October 2022.

#### How does the `MERGE` statement determine which operation to perform?
: The `MERGE` statement uses a specified `ON` condition to match rows between the source and target tables. Based on whether a match is found (`MATCHED`) or not (`NOT MATCHED`), and any additional conditions, it executes the corresponding `INSERT`, `UPDATE`, `DELETE`, or `DO NOTHING` actions.

#### Can I use the `MERGE` statement with views in PostgreSQL?
: Yes, starting from PostgreSQL 17, the `MERGE` command can be used with updatable views. For `MERGE` to work with views, the views must be consistent:
: Trigger-updatable views need `INSTEAD OF` triggers for all actions.
: Auto-updatable views cannot have any triggers.
: Mixing types of views or using rule-updatable views is not allowed.

#### What privileges are required to execute a `MERGE` statement?
: To execute a `MERGE` statement, you need:
: `SELECT` privilege on the source table or query.
: Appropriate privileges on the target table:
: `INSERT` privilege for insert actions.
: `UPDATE` privilege for update actions.
: `DELETE` privilege for delete actions.

#### Is the `MERGE` statement atomic in PostgreSQL?
: Yes, the `MERGE` statement in PostgreSQL is atomic. This means all specified actions (`INSERT`, `UPDATE`, `DELETE`) are performed as a single unit. If an error occurs during execution, the entire operation is rolled back, ensuring data integrity.

####  Can I use the `RETURNING` clause with the `MERGE` statement?
: Yes, starting from PostgreSQL 17, the `MERGE` statement supports the `RETURNING` clause. This allows you to retrieve information about the rows affected by the `MERGE` operation, including the specific action performed (`INSERT`, `UPDATE`, or `DELETE`) on each row.

#### How does the `MERGE` statement handle concurrent data modifications?
: The `MERGE` statement ensures data consistency during concurrent operations by acquiring the necessary locks on the target table. This prevents other transactions from modifying the same rows simultaneously, thereby avoiding conflicts.

#### Are there any performance considerations when using the `MERGE` statement?
: While the `MERGE` statement simplifies complex operations into a single command, it's essential to ensure that the `ON` condition is well-optimized, typically by indexing the columns involved. Proper indexing can significantly enhance performance.

#### Can I perform different actions based on additional conditions within the `MERGE` statement?
: Yes, the `MERGE` statement allows for multiple `WHEN` clauses with additional conditions. This enables you to specify different actions (`INSERT`, `UPDATE`, `DELETE`, or `DO NOTHING`) based on various criteria, providing fine-grained control over the operation.
</DefinitionList>
