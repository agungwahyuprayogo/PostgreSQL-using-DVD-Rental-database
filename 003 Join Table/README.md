# PostgreSQL Join Guide

## Table of Contents

- [PostgreSQL JOINS](#postgresql-joins)
- [PostgreSQL TABLE ALIASES](#postgresql-table-aliases)
- [PostgreSQL INNER JOIN](#postgresql-inner-join)
- [PostgreSQL LEFT JOIN](#postgresql-left-join)
- [PostgreSQL RIGHT JOIN](#postgresql-right-join)
- [PostgreSQL SELF JOIN](#postgresql-self-join)
- [PostgreSQL FULL OUTER JOIN](#postgresql-full-outer-join)
- [PostgreSQL CROSS JOIN](#postgresql-cross-join)
- [PostgreSQL NATURAL JOIN](#postgresql-natural-join)
---

---
# PostgreSQL Joins

**Summary**: in this tutorial, you will learn about various kinds of PostgreSQL JOINS including `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `FULL OUTER JOIN`.

PostgreSQL join is used to combine columns from one `self join` or more tables based on the values of the common columns between related tables. The common columns are typically the `primary key` columns of the first table and the `foreign key` columns of the second table.

PostgreSQL supports `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN`, `CROSS JOIN`, `NATURAL JOIN`, and a special kind of join called SELF JOIN.

## Setting up Sample Tables

Suppose you have two tables called `basket_a` and `basket_b` that store fruits:

```sql
CREATE TABLE basket_a (
    a INT PRIMARY KEY,
    fruit_a VARCHAR (100) NOT NULL
);

CREATE TABLE basket_b (
    b INT PRIMARY KEY,
    fruit_b VARCHAR (100) NOT NULL
);

INSERT INTO basket_a (a, fruit_a)
VALUES
    (1, 'Apple'),
    (2, 'Orange'),
    (3, 'Banana'),
    (4, 'Cucumber');

INSERT INTO basket_b (b, fruit_b)
VALUES
    (1, 'Orange'),
    (2, 'Apple'),
    (3, 'Watermelon'),
    (4, 'Pear');
```

The tables have some common fruits such as `apple` and `orange`.

The following statement returns data from the `basket_a` table:

```sql
SELECT * FROM basket_a;
```

Output:


| a  | fruit_a  |
|----|----------|
| 1  | Apple    |
| 2  | Orange   |
| 3  | Banana   |
| 4  | Cucumber |

(4 rows)


The following statement returns data from the `basket_b` table:

```sql
SELECT * FROM basket_b;
```

Output:

| b   | fruit_b    |
|-----|------------|
| 1   | Orange     |
| 2   | Apple      |
| 3   | Watermelon |
| 4   | Pear       |
| ... | ...        |

(4 rows)

---

## Inner Join

The following statement joins the first table (`basket_a`) with the second table (`basket_b`) by matching the values in the `fruit_a` and `fruit_b` columns:

```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
INNER JOIN basket_b
    ON fruit_a = fruit_b;
```

Output:

| a  | fruit_a | b  | fruit_b |
|----|---------|----|---------|
| 1  | Apple   | 2  | Apple   |
| 2  | Orange  | 1  | Orange  |

(2 rows)

The `INNER JOIN` examines each row in the first table (`basket_a`). It compares the value in the `fruit_a` column with the value in the `fruit_b` column of each row in the second table (`basket_b`). If these values are equal, the inner join creates a new row that contains columns from both tables and adds this new row to the result set.

The following diagram illustrates the `INNER JOIN`:

![image](https://github.com/user-attachments/assets/ec3326ff-3dbd-48e0-aa48-16572fc0973f)

---

## Left Join

The following statement uses the `LEFT JOIN` clause to join the `basket_a` table with the `basket_b` table. In the left join context, the first table is called the left table and the second table is called the right table.

```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
LEFT JOIN basket_b
   ON fruit_a = fruit_b;
```

Output:


| a  | fruit_a  | b    | fruit_b |
|----|----------|------|---------|
| 1  | Apple    | 2    | Apple   |
| 2  | Orange   | 1    | Orange  |
| 3  | Banana   | null | null    |
| 4  | Cucumber | null | null    |

(4 rows)

The left join starts selecting data from the left table. It compares values in the `fruit_a` column with the values in the `fruit_b` column in the `basket_b` table.

If these values are equal, the LEFT JOIN creates a new row that contains columns of both tables and adds this new row to the result set. (see the row #1 and #2 in the result set).

In case the values do not equal, the left join also creates a new row that contains columns from both tables and adds it to the result set. However, it fills the columns of the right table (`basket_b`) with null. (see the row #3 and #4 in the result set).

The following diagram illustrates the left join:

![image](https://github.com/user-attachments/assets/cd1ee5de-31b6-4d02-a468-fc6dc853125c)

To select rows from the left table that do not have matching rows in the right table, you use the left join with a `WHERE` clause. For example:

```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
LEFT JOIN basket_b
    ON fruit_a = fruit_b
WHERE b IS NULL;
```

The output is:

| a  | fruit_a  | b    | fruit_b |
|----|----------|------|---------|
| 3  | Banana   | null | null    |
| 4  | Cucumber | null | null    |

(2 rows)

Note that the `LEFT JOIN` is the same as the `LEFT OUTER JOIN` so you can use them interchangeably.

**Left Anti-Join:** The following diagram illustrates the left join that returns rows from the left table that do not have matching rows from the right table:

![image](https://github.com/user-attachments/assets/de5c5bbf-8851-436d-87a5-5201dafb0fb3)

---

## Right Join

The `RIGHT JOIN` is a reversed version of the left join. The `RIGHT JOIN` starts selecting data from the right table. It compares each value in the `fruit_b` column of every row in the right table with each value in the `fruit_a` column of every row in the `fruit_a` table.

If these values are equal, the right join creates a new row that contains columns from both tables.

In case these values are not equal, the right join also creates a new row that contains columns from both tables. However, it fills the columns in the left table with `NULL`.

The following statement uses the right join to join the `basket_a` table with the `basket_b` table:

```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
RIGHT JOIN basket_b ON fruit_a = fruit_b;
```

Here is the output:

| a    | fruit_a  | b    | fruit_b    |
|------|----------|------|------------|
| 2    | Orange   | 1    | Orange     |
| 1    | Apple    | 2    | Apple      |
| null | null     | 3    | Watermelon |
| null | null     | 4    | Pear       |

(4 rows)


The following Venn diagram illustrates the right join:

![image](https://github.com/user-attachments/assets/5d43ba7a-f7f3-466c-b66d-1c630230044b)

Similarly, you can get rows from the right table that do not have matching rows from the left table by adding a `WHERE` clause as follows:

```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
RIGHT JOIN basket_b
   ON fruit_a = fruit_b
WHERE a IS NULL;
```

Output:

| a    | fruit_a | b  | fruit_b    |
|------|---------|----|------------|
| null | null    | 3  | Watermelon |
| null | null    | 4  | Pear       |

(2 rows)


The `RIGHT JOIN` and `RIGHT OUTER JOIN` are the same therefore you can use them interchangeably.

The following diagram illustrates the right join that returns rows from the right table that do not have matching rows in the left table:

![image](https://github.com/user-attachments/assets/fff671d0-0c6c-4b15-a9eb-70d0f692f4e2)

## Full Outer Join

The `FULL OUTER JOIN` or `FULL JOIN` returns a result set that contains all rows from both left and right tables, with the matching rows from both sides if available. In case there is no match, the columns of the table will be filled with `NULL`.

```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
FULL OUTER JOIN basket_b
    ON fruit_a = fruit_b;
```

Output:

| a    | fruit_a  | b    | fruit_b    |
|------|----------|------|------------|
| 1    | Apple    | 2    | Apple      |
| 2    | Orange   | 1    | Orange     |
| 3    | Banana   | null | null       |
| 4    | Cucumber | null | null       |
| null | null     | 3    | Watermelon |
| null | null     | 4    | Pear       |

(6 rows)

The following diagram illustrates the `FULL OUTER JOIN`:

![image](https://github.com/user-attachments/assets/9b990af8-e841-4dd5-a6e6-f1450fc4a26f)

To return rows in a table that do not have matching rows in the other, you use the full join with a `WHERE` clause like this:

```sql
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
FULL JOIN basket_b
   ON fruit_a = fruit_b
WHERE a IS NULL OR b IS NULL;
```

Here is the result:

| a    | fruit_a  | b    | fruit_b    |
|------|----------|------|------------|
| 3    | Banana   | null | null       |
| 4    | Cucumber | null | null       |
| null | null     | 3    | Watermelon |
| null | null     | 4    | Pear       |

(4 rows)


The following Venn diagram illustrates the full outer join that returns rows from a table that do not have the corresponding rows in the other table:

![image](https://github.com/user-attachments/assets/9ee23d54-0e4d-47da-b60b-c988f9e21fc9)

The following picture shows all the PostgreSQL joins that we discussed so far with the detailed syntax:

![image](https://github.com/user-attachments/assets/1cff1cc2-7a97-4feb-92ec-8a1524287864)

In this tutorial, you have learned how to use various kinds of PostgreSQL joins to combine data from multiple related tables.

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


# PostgreSQL TABLE ALIASES

**Summary**: in this tutorial, you will learn about the PostgreSQL table aliases and their practical applications.

## Introduction to the PostgreSQL table aliases

A table alias is a feature in SQL that allows you to assign a temporary name to a table during the execution of a query.

The following illustrates the syntax of defining a table alias:

```sql
table_name AS alias_name
```

In this syntax:

- `table_name`: Specify the name of the table that you want to give an alias.
- `alias_name`: Provide the alias for the table.

Like column aliases, the `AS` keyword is optional, meaning that you can omit it like this:

```sql
table_name alias_name
```

## PostgreSQL table alias examples

Let’s take some examples of using table aliases.

### 1) Basic PostgreSQL table alias example

The following example uses a table alias to retrieve five titles from the `film` table:

```sql
SELECT
      f.title
FROM
      film AS f
ORDER BY
      f.title
LIMIT 5;
```

Output:

| Title               |
|---------------------|
| Academy Dinosaur    |
| Ace Goldfinger      |
| Adaptation Holes    |
| Affair Prejudice    | 
| African Egg         |

(5 rows)


In this example, we assign the `film` table an alias `f` and use the table alias to fully qualify the `title` column.

Since the `AS` keyword is optional, you can remove it as follows:

```sql
SELECT
     f.title
FROM
     film f
ORDER BY
     f.title
LIMIT 5;
```
---

### 2) Using table aliases in join clauses

Typically, you use table aliases in a query that has a join clause to retrieve data from multiple related tables that share the same column name.

If you use the same column name that comes from multiple tables in the same query without fully qualifying them, you will get an error.

To avoid this error, you can qualify the columns using the following syntax:

```sql
table_name.column_name
```

If the table has an alias, you can qualify its column using the alias:

```sql
alias.column_name
```

For example, the following query uses an `INNER JOIN` clause to retrieve data from the `customer` and `payment` tables:

```sql
SELECT
  c.customer_id,
  c.first_name,
  p.amount,
  p.payment_date
FROM
  customer c
INNER JOIN
  payment p ON p.customer_id = c.customer_id
ORDER BY
  p.payment_date DESC;
```

Output:

| customer_id | first_name | amount | payment_date               |
|-------------|------------|--------|----------------------------|
| 94          | Norma      | 4.99   | 2007-05-14 13:44:29.996577 |
| 264         | Gwendolyn  | 2.99   | 2007-05-14 13:44:29.996577 |
| 263         | Hilda      | 0.99   | 2007-05-14 13:44:29.996577 |
| 252         | Mattie     | 4.99   | 2007-05-14 13:44:29.996577 |

Note that you’ll learn about `INNER JOIN` in the upcoming tutorial.

---

### 3) Using table aliases in self-join

When you join a table to itself (a.k.a self-join), you need to use table aliases. This is because referencing the same table multiple times within a query will result in an error.

The following example shows how to reference the `film` table twice in the same query using the table aliases:

```
SELECT
    f1.title,
    f2.title,
    f1.length
FROM
    film f1
INNER JOIN film f2
    ON f1.film_id <> f2.film_id AND
       f1.length = f2.length;
```

Output:

| title              | title                   | length |
|--------------------|-------------------------|--------|
| Chamber Italian    | Resurrection Silverado  | 117    |
| Chamber Italian    | Magic Mallrats          | 117    |
| Chamber Italian    | Graffiti Love           | 117    |
| Chamber Italian    | Affair Prejudice        | 117    |
| Grosse Wonderful   | Hurricane Affair        | 49     |
| Grosse Wonderful   | Hook Chariots           | 49     |
| Grosse Wonderful   | Heavenly Gun            | 49     |
| Grosse Wonderful   | Doors President         | 49     |


Note that you’ll learn about self-join in the upcoming tutorial.

## Summary

- Use PostgreSQL table aliases to assign a temporary name to a table during the execution of a query.


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


# PostgreSQL INNER JOIN

**Summary**: in this tutorial, you will learn how to select data from multiple tables using the **PostgreSQL INNER JOIN** clause.

## Introduction to PostgreSQL INNER JOIN clause

In a relational database, data is typically distributed across multiple tables. To retrieve comprehensive data, you often need to query it from multiple tables.

In this tutorial, we are focusing on how to retrieve data from multiple tables using the `INNER JOIN` clause.

Here is the generic syntax for the `INNER JOIN` clause that joins two tables:

```sql
SELECT
  select_list
FROM
  table1
INNER JOIN table2
  ON table1.column_name = table2.column_name;
```

In this syntax:

- First, specify the columns from both tables in the select list of the `SELECT` clause.
- Second, specify the main table (`table1`) from which you want to select data in the `FROM` clause.
- Third, specify the second table (`table2`) you want to join using the `INNER JOIN` keyword.
- Finally, define a condition for the join. This condition indicates which column (`column_name`) in each table should have matching values for the join.

To make the query shorter, you can use table aliases:

```sql
SELECT
  select_list
FROM
  table1 t1
INNER JOIN table2 t2
    ON t1.column_name = t2.column_name;
```

In this syntax, we first assign `t1` and `t2` as the table aliases for `table1` and `table2`. Then, we use the table aliases to qualify the columns of each table.

If the columns for matching share the same name, you can use the `USING` syntax:

```sql
SELECT
  select_list
FROM
  table1 t1
INNER JOIN table2 t2 USING(column_name);
```

### How the INNER JOIN works

For each row in the `table1`, the inner join compares the value in the `column_name` with the value in the corresponding column of every row in the `table2`.

When these values are equal, the inner join creates a new row that includes all columns from both tables and adds this row to the result set.

Conversely, if these values are not equal, the inner join disregards the current pair and proceeds to the next row, repeating the matching process.

The following Venn diagram illustrates how `INNER JOIN` clause works.

![image](https://github.com/user-attachments/assets/0d9c1fbd-2212-4cbd-9225-45fb01d94018)

## PostgreSQL INNER JOIN examples

Let’s take some examples of using the `INNER JOIN` clause.

---

### 1) Using PostgreSQL INNER JOIN to join two tables

Let’s take a look at the `customer`and `payment` tables in the sample database.

![image](https://github.com/user-attachments/assets/cf900ebc-70d8-4154-b5c3-38ffcb6de824)

In this schema, whenever a customer makes a payment, a new row is inserted into the `payment` table. While each customer may have zero or many payments, each payment belongs to one and only one customer. The `customer_id` column serves as the link establishing the relationship between the two tables.

The following statement uses the `INNER JOIN` clause to select data from both tables:

```sql
SELECT
  customer.customer_id,
  customer.first_name,
  customer.last_name,
  payment.amount,
  payment.payment_date
FROM
  customer
  INNER JOIN payment ON payment.customer_id = customer.customer_id
ORDER BY
  payment.payment_date;
```

Output:

| customer_id | first_name | last_name | amount | payment_date              |
|------------|-----------|-----------|--------|---------------------------|
| 416        | Jeffery   | Pinson    | 2.99   | 2007-02-14 21:21:59.996577 |
| 516        | Elmer     | Noe       | 4.99   | 2007-02-14 21:23:39.996577 |
| 239        | Minnie    | Romero    | 4.99   | 2007-02-14 21:29:00.996577 |
| 592        | Terrance  | Roush     | 6.99   | 2007-02-14 21:41:12.996577 |
| 49         | Joyce     | Edwards   | 0.99   | 2007-02-14 21:44:52.996577 |


To make the query shorter, you can use the table aliases:

```sql
SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  p.amount,
  p.payment_date
FROM
  customer c
  INNER JOIN payment p ON p.customer_id = c.customer_id
ORDER BY
  p.payment_date;
```

Since both tables have the same `customer_id` column, you can use the `USING` syntax:

```sql
SELECT
  customer_id,
  first_name,
  last_name,
  amount,
  payment_date
FROM
  customer
  INNER JOIN payment USING(customer_id)
ORDER BY
  payment_date;
```

### 2) Using PostgreSQL INNER JOIN to join three tables

The following diagram below illustrates the relationship between three tables: `staff`, `payment`, and `customer`:

![image](https://github.com/user-attachments/assets/6b654007-cd1b-462e-a627-1bc0b8a64cd8)

Each staff member can handle zero or multiple payments, with each payment being processed by one and only one staff member.

Similarly, each customer can make zero or multiple payments, and each payment is associated with a single customer.

The following example uses `INNER JOIN` clauses to retrieve data from three tables

```sql
SELECT
  c.customer_id,
  c.first_name || ' ' || c.last_name customer_name,
  s.first_name || ' ' || s.last_name staff_name,
  p.amount,
  p.payment_date
FROM
  customer c
  INNER JOIN payment p USING (customer_id)
  INNER JOIN staff s using(staff_id)
ORDER BY
  payment_date;
```

Output:

| customer_id | customer_name     | staff_name   | amount | payment_date              |
|------------|------------------|-------------|--------|---------------------------|
| 416        | Jeffery Pinson   | Jon Stephens | 2.99   | 2007-02-14 21:21:59.996577 |
| 516        | Elmer Noe        | Jon Stephens | 4.99   | 2007-02-14 21:23:39.996577 |
| 239        | Minnie Romero    | Mike Hillyer | 4.99   | 2007-02-14 21:29:00.996577 |
| 592        | Terrance Roush   | Jon Stephens | 6.99   | 2007-02-14 21:41:12.996577 |
| 49         | Joyce Edwards    | Mike Hillyer | 0.99   | 2007-02-14 21:44:52.996577 |

## Summary

- Use `INNER JOIN` clauses to select data from two or more related tables and return rows that have matching values in all tables.

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


# PostgreSQL LEFT JOIN

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `LEFT JOIN` clause to select data from multiple tables.

## Introduction to PostgreSQL LEFT JOIN clause

The `LEFT JOIN` clause joins a left table with the right table and returns the rows from the left table that may or may not have corresponding rows in the right table.

The `LEFT JOIN` can be useful for selecting rows from one table that do not have matching rows in another.

Here’s the basic syntax of the `LEFT JOIN` clause:

```sqlsql
SELECT
  select_list
FROM
  table1
LEFT JOIN table2
  ON table1.column_name = table2.column_name;
```

In this syntax:

- First, specify the columns from both tables in the select list (`select_list`) of the `SELECT` clause.
- Second, specify the left table (`table1`) from which you want to select data in the `FROM` clause.
- Third, specify the right table (`table2`) you want to join using the `LEFT JOIN` keyword.
- Finally, define a condition for the join (`table1.column_name = table2.column_name`), which indicates the column (`column_name`) in each table should have matching values.

### How the LEFT JOIN works

The `LEFT JOIN` clause starts selecting data from the left table (`table1`). For each row in the left table, it compares the value in the `column_name` with the value of the corresponding column from every row in the right table.

When these values are equal, the left join clause generates a new row including the columns that appear in the `select_list` and appends it to the result set.

If these values are not equal, the `LEFT JOIN` clause creates a new row that includes the columns specified in the `SELECT` clause. Additionally, it populates the columns that come from the right table with NULL.

Note that `LEFT JOIN` is also referred to as `LEFT OUTER JOIN`.

If the columns for joining two tables have the same name, you can use the `USING` syntax:

```sql
SELECT
  select_list
FROM
  table1
  LEFT JOIN table2 USING (column_name);
```

The following Venn diagram illustrates how the `LEFT JOIN` clause works:

![image](https://github.com/user-attachments/assets/311e6d16-90a9-4f01-96ce-9cad03cfa7f9)


--- 

## PostgreSQL LEFT JOIN examples

Let’s look at the following `film` and `inventory` tables from the sample database.

![image](https://github.com/user-attachments/assets/7c6dbac8-095b-4f44-a9bd-6bd795c00b1e)

Each row in the `film` table may correspond to zero or multiple rows in the `inventory` table.

Conversely, each row in the `inventory` table has one and only one row in the `film` table.

The linkage between the `film` and `inventory` tables is established through the `film_id` column.

### 1) Basic PostgreSQL LEFT JOIN examples

The following statement uses the `LEFT JOIN` clause to join `film` table with the `inventory` table:

```sql
SELECT
  film.film_id,
  film.title,
  inventory.inventory_id
FROM
  film
  LEFT JOIN inventory ON inventory.film_id = film.film_id
ORDER BY
  film.title;
```

![image](https://github.com/user-attachments/assets/2e918d52-e267-471c-833c-45cc67182117)

When a row from the `film` table does not have a matching row in the `inventory` table, the value of the `inventory_id` column of this row is `NULL`.

The following statement uses table aliases and `LEFT JOIN` clause to join the `film` and `inventory` tables:

```sql
SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  film f
  LEFT JOIN inventory i ON i.film_id = f.film_id
ORDER BY
  i.inventory_id;
```

Because the `film` and `inventory` tables share the same `film_id` column, you can use the `USING` syntax:

```sql
SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  film f
  LEFT JOIN inventory i USING (film_id)
ORDER BY
  i.inventory_id;
```

### 2) Using PostgreSQL LEFT JOIN with WHERE clause

The following uses the `LEFT JOIN` clause to join the `inventory` and `film` tables. It includes a [`WHERE`](postgresql-where) clause that identifies the films that are not present in the inventory:

```sql
SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  film f
  LEFT JOIN inventory i USING (film_id)
WHERE
  i.film_id IS NULL
ORDER BY
  f.title;
```

Output:


| film_id | title                | inventory_id |
|---------|----------------------|--------------|
| 14      | Alice Fantasia       | null         |
| 33      | Apollo Teen          | null         |
| 36      | Argonauts Town       | null         |
| 38      | Ark Ridgemont        | null         |
| 41      | Arsenic Independence | null         |
...

## Summary

- Use the PostgreSQL `LEFT JOIN` clause to select rows from one table that may or may not have corresponding rows in other tables.

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

# PostgreSQL RIGHT JOIN

**Summary**: in this tutorial, you will how to use PostgreSQL `RIGHT JOIN` to join two tables and return rows from the right table that may or may not have matching rows in the left table.

## Introduction to PostgreSQL RIGHT JOIN clause

The `RIGHT JOIN` clause joins a right table with a left table and returns the rows from the right table that may or may not have matching rows in the left table.

The `RIGHT JOIN` can be useful when you want to find rows in the right table that do not have matching rows in the left table.

Here’s the basic syntax of the `RIGHT JOIN` clause:

```sql
SELECT
  select_list
FROM
  table1
RIGHT JOIN table2
  ON table1.column_name = table2.column_name;
```

In this syntax:

- First, specify the columns from both tables in the `select_list` in the `SELECT` clause.
- Second, provide the left table (`table1`) from which you want to select data in the `FROM` clause.
- Third, specify the right table (`table2`) that you want to join with the left table in the `RIGHT JOIN` clause.
- Finally, define a condition for joining two tables (`table1.column_name = table2.column_name`), which indicates the `column_name` in each table should have matching rows.

### How the RIGHT JOIN works

The `RIGHT JOIN` starts retrieving data from the right table (`table2`).

For each row in the right table (`table2`), the `RIGHT JOIN` checks if the value in the `column_name` is equal to the value of the corresponding column in every row of the left table (`table1`).

When these values are equal, the `RIGHT JOIN` creates a new row that includes columns specified in the `select_list` and appends it to the result set.

If these values are not equal, the `RIGHT JOIN` generates a new row that includes columns specified in the `select_list`, populates the columns on the left with `NULL`, and appends the new row to the result set.

In other words, the `RIGHT JOIN` returns all rows from the right table whether or not they have corresponding rows in the left table.

The following Venn diagram illustrates how the `RIGHT JOIN` works:

![image](https://github.com/user-attachments/assets/7b03bc7c-5c11-4c5e-a57b-5fe949deb6c5)

Note that the `RIGHT OUTER JOIN` is the same as `RIGHT JOIN`. The `OUTER` keyword is optional

---

### The USING syntax

When the columns for joining have the same name, you can use the `USING` syntax:

```sql
SELECT
  select_list
FROM
  table1
RIGHT JOIN table2 USING (column_name);
```

## PostgreSQL RIGHT JOIN examples

We’ll use the `film` and `inventory` tables from the sample database

### 1) Basic PostgreSQL RIGHT JOIN examples

The following example uses the `RIGHT JOIN` clause to retrieve all rows from the film table that may or may not have corresponding rows in the inventory table:

```sql
SELECT
  film.film_id,
  film.title,
  inventory.inventory_id
FROM
  inventory
RIGHT JOIN film
  ON film.film_id = inventory.film_id
ORDER BY
  film.title;
```

Output:

![image](https://github.com/user-attachments/assets/cfdd08db-abac-4b3e-a219-25e0f9f8e4ae)

You can rewrite the above query using table aliases:

```
SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  inventory i
RIGHT JOIN film f
  ON f.film_id = i.film_id
ORDER BY
  f.title;
```

Since the film and inventory table has the `film_id` column, you can use the `USING` syntax:

```sql
SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  inventory i
RIGHT JOIN film f USING(film_id)
ORDER BY
  f.title;
```

### 2) PostgreSQL RIGHT JOIN with a WHERE clause

The following query uses a `RIGHT JOIN` clause with a `WHERE` clause to retrieve the films that have no inventory:

```sql
SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  inventory i
RIGHT JOIN film f USING(film_id)
WHERE i.inventory_id IS NULL
ORDER BY
  f.title;
```

Output:


| film_id | title                | inventory_id |
|---------|----------------------|--------------|
| 14      | Alice Fantasia       | null         |
| 33      | Apollo Teen          | null         |
| 36      | Argonauts Town       | null         |
| 38      | Ark Ridgemont        | null         |
| 41      | Arsenic Independence | null         |
...


## Summary

- Use the PostgreSQL `RIGHT JOIN` clause to join a right table with a left table and return rows from the right table that may or may not have corresponding rows in the left table.
- The `RIGHT JOIN` is also known as `RIGHT OUTER JOIN`.

---
---
---
---
---
---
---
---
---


# PostgreSQL SELF JOIN

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `self join` technique to compare rows within the same table.

## Introduction to PostgreSQL self-join

A `self join` is a regular join that joins a table to itself. In practice, you typically use a self-join to query hierarchical data or to compare rows within the same table.

To form a `self join`, you specify the same table twice with different table aliases and provide the join predicate after the `ON` keyword.

The following query uses an `INNER JOIN` that joins the table to itself:

```sql
SELECT select_list
FROM table_name t1
INNER JOIN table_name t2 ON join_predicate;
```

In this syntax, the `table_name` is joined to itself using the `INNER JOIN` clause.

Alternatively, you can use the `LEFT JOIN` or `RIGHT JOIN` clause to join the table to itself like this:

```sql
SELECT select_list
FROM table_name t1
LEFT JOIN table_name t2 ON join_predicate;
```

## PostgreSQL self-join examples

Let’s take some examples of using `self join`.

### 1) Querying hierarchical data example

Let’s set up a sample table for the demonstration.

Suppose, you have the following organizational structure:

![image](https://github.com/user-attachments/assets/d538c9b5-e361-4dfe-b789-565c00e16487)

The following statements create the `employee` table and insert some sample data into the table.

```sql
CREATE TABLE employee (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR (255) NOT NULL,
  last_name VARCHAR (255) NOT NULL,
  manager_id INT,
  FOREIGN KEY (manager_id) REFERENCES employee (employee_id) ON DELETE CASCADE
);

INSERT INTO employee (employee_id, first_name, last_name, manager_id)
VALUES
  (1, 'Windy', 'Hays', NULL),
  (2, 'Ava', 'Christensen', 1),
  (3, 'Hassan', 'Conner', 1),
  (4, 'Anna', 'Reeves', 2),
  (5, 'Sau', 'Norman', 2),
  (6, 'Kelsie', 'Hays', 3),
  (7, 'Tory', 'Goff', 3),
  (8, 'Salley', 'Lester', 3);

SELECT * FROM employee;
```

Output:

| employee_id | first_name | last_name    | manager_id |
|------------|------------|-------------|------------|
| 1          | Windy      | Hays        | null       |
| 2          | Ava        | Christensen | 1          |
| 3          | Hassan     | Conner      | 1          |
| 4          | Anna       | Reeves      | 2          |
| 5          | Sau        | Norman      | 2          |
| 6          | Kelsie     | Hays        | 3          |
| 7          | Tory       | Goff        | 3          |
| 8          | Salley     | Lester      | 3          |

(8 rows)

In this `employee` table, the `manager_id` column references the `employee_id` column.

The `manager_id` column indicates the direct relationship, showing the manager to whom the employee reports.

If the `manager_id` column contains NULL, which signifies that the respective employee does not report to anyone, essentially holding the top managerial position.

The following query uses the self-join to find who reports to whom:

```sql
SELECT
  e.first_name || ' ' || e.last_name employee,
  m.first_name || ' ' || m.last_name manager
FROM
  employee e
  INNER JOIN employee m ON m.employee_id = e.manager_id
ORDER BY
  manager;
```

Output:

| employee        | manager        |
|----------------|-----------------|
| Sau Norman     | Ava Christensen |
| Anna Reeves    | Ava Christensen |
| Salley Lester  | Hassan Conner   |
| Kelsie Hays    | Hassan Conner   |
| Tory Goff      | Hassan Conner   |
| Ava Christensen| Windy Hays      |
| Hassan Conner  | Windy Hays      |

(7 rows)


This query references the `employees` table twice, one as the employee and the other as the manager. It uses table aliases `e` for the employee and `m` for the manager.

The join predicate finds the employee/manager pair by matching values in the `employee_id` and `manager_id` columns.

Notice that the top manager does not appear on the output.

To include the top manager in the result set, you use the [`LEFT JOIN`](postgresql-left-join) instead of [`INNER JOIN`](postgresql-inner-join) clause as shown in the following query:

```sql
SELECT
  e.first_name || ' ' || e.last_name employee,
  m.first_name || ' ' || m.last_name manager
FROM
  employee e
  LEFT JOIN employee m ON m.employee_id = e.manager_id
ORDER BY
  manager;
```

Output:


| employee       | manager         |
|----------------|-----------------|
| Anna Reeves    | Ava Christensen |
| Sau Norman     | Ava Christensen |
| Salley Lester  | Hassan Conner   |
| Kelsie Hays    | Hassan Conner   |
| Tory Goff      | Hassan Conner   |
| Hassan Conner  | Windy Hays      |
| Ava Christensen| Windy Hays      |
| Windy Hays     | null            |

(8 rows)


### 2) Comparing the rows with the same table

See the following `film` table from the DVD rental database:

![image](https://github.com/user-attachments/assets/996ee6ec-32dd-4b16-b32f-51fbaf58afe4)

The following query finds all pairs of films that have the same length,

```sql
SELECT
  f1.title,
  f2.title,
  f1.length
FROM
  film f1
  INNER JOIN film f2 ON f1.film_id > f2.film_id
  AND f1.length = f2.length;
```

Output:


| title              | title                  | length |
|--------------------|-----------------------|--------|
| Chamber Italian   | Affair Prejudice       | 117    |
| Grosse Wonderful  | Doors President        | 49     |
| Bright Encounters | Bedazzled Married      | 73     |
| Date Speed       | Crow Grease             | 104    |
| Annie Identity   | Academy Dinosaur       | 86     |
| Anything Savannah| Alone Trip             | 82     |
| Apache Divine    | Anaconda Confessions   | 92     |
| Arabia Dogma     | Airplane Sierra        | 62     |
| Dying Maker      | Antitrust Tomatoes     | 168    |


The join predicate matches two different films (`f1.film_id > f2.film_id`) that have the same length (`f1.length = f2.length`)

## Summary

- A PostgreSQL self-join is a regular join that joins a table to itself using the `INNER JOIN` or `LEFT JOIN`.
- Self-joins are very useful for querying hierarchical data or comparing rows within the same table.

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


# PostgreSQL FULL OUTER JOIN

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `FULL OUTER JOIN` to query data from two tables.

## Introduction to the PostgreSQL FULL OUTER JOIN clause

The `FULL OUTER JOIN` combine data from two tables and returns all rows from both tables, including matching and non-matching rows from both sides.

In other words, the `FULL OUTER JOIN` combines the results of both the `LEFT JOIN` and the `RIGHT JOIN`.

Here’s the basic syntax of `FULL OUTER JOIN` clause:

```sql
SELECT select_list
FROM table1
FULL OUTER JOIN table2
   ON table1.column_name = table2.column_name;
```

In this syntax:

- First, specify the columns from `table1` and `table2` in the `select_list`.
- Second, specify the `table1` that you want to retrieve data in the `FROM` clause.
- Third, specify the `table2` that you want to join with the `table1` in the `FULL OUTER JOIN` clause.
- Finally, define a condition for joining two tables.

The `FULL OUTER JOIN` is also known as `FULL JOIN`. The `OUTER` keyword is optional.

### How the FULL OUTER JOIN works

**Step 1. Initialize the result set:**

- The `FULL OUTER JOIN` starts with an empty result set.

**Step 2. Match rows:**

- First, identify rows in `table1` and `table2` where the values in the specified `column_name` match.
- Then, include these matching rows in the result set.

**Step 3. Include non-matching rows from the `table1` and `table2`:**

- First, include rows from `table1` that do not have a match in `table2`. For the columns from `table2` in these rows, include NULLs.
- Second, include rows from `table2` that do not have a match in `table1`. For the columns from `table1` in these rows, include NULLs.

**Step 4. Return the result set:**

- Return the final result set will contain all rows from both tables, with matching rows and non-matching rows from both `table1` and `table2`.
- If a row has a match on both sides, combine the values into a single row.
- If there is no match on one side, the columns from the non-matching side will have NULLs.

The following Venn diagram illustrates the `FULL OUTER JOIN` operation:

![image](https://github.com/user-attachments/assets/24ea8645-4335-419e-8f93-418df198075d)

## Setting up sample tables

First, create two new tables for the demonstration: `employees` and `departments`:

```sql
CREATE TABLE departments (
  department_id serial PRIMARY KEY,
  department_name VARCHAR (255) NOT NULL
);
CREATE TABLE employees (
  employee_id serial PRIMARY KEY,
  employee_name VARCHAR (255),
  department_id INTEGER
);
```

Each department has zero or many employees and each employee belongs to zero or one department.

Second, insert some sample data into the `departments` and `employees` tables.

```sql
INSERT INTO departments (department_name)
VALUES
  ('Sales'),
  ('Marketing'),
  ('HR'),
  ('IT'),
  ('Production');
INSERT INTO employees (employee_name, department_id)
VALUES
  ('Bette Nicholson', 1),
  ('Christian Gable', 1),
  ('Joe Swank', 2),
  ('Fred Costner', 3),
  ('Sandra Kilmer', 4),
  ('Julia Mcqueen', NULL);

```

Third, query data from the `departments` and `employees` tables:

```sql
SELECT * FROM departments;
```

Output:

| department_id | department_name |
|--------------|----------------|
| 1            | Sales          |
| 2            | Marketing      |
| 3            | HR             |
| 4            | IT             |
| 5            | Production     |
...

```sql
SELECT * FROM employees;
```

Output:

| employee_id | employee_name   | department_id |
|-------------|-----------------|---------------|
| 1           | Bette Nicholson | 1             |
| 2           | Christian Gable | 1             |
| 3           | Joe Swank       | 2             |
| 4           | Fred Costner    | 3             |
| 5           | Sandra Kilmer   | 4             |
| 6           | Julia Mcqueen   | null          |

## PostgreSQL FULL OUTER JOIN examples

Let’s take some examples of using the `FULL OUTER JOIN` clause.

### 1) Basic FULL OUTER JOIN examaple

The following query uses the `FULL OUTER JOIN` to query data from both `employees` and `departments` tables:

```sql
SELECT
  employee_name,
  department_name
FROM
  employees e
FULL OUTER JOIN departments d
  ON d.department_id = e.department_id;
```

Output:

| employee_name   | department_name |
|----------------|----------------|
| Bette Nicholson | Sales          |
| Christian Gable | Sales          |
| Joe Swank       | Marketing      |
| Fred Costner    | HR             |
| Sandra Kilmer   | IT             |
| Julia Mcqueen   | null           |
| null           | Production      |

The result set includes every employee who belongs to a department and every department which have an employee.

Additionally, it includes every employee who does not belong to a department and every department that does not have an employee.

### 2) Using FULL OUTER JOIN with WHERE clause example

The following example use the `FULL OUTER JOIN` with a `WHERE` clause to find the department that does not have any employees:

```sql
SELECT
  employee_name,
  department_name
FROM
  employees e
FULL OUTER JOIN departments d
  ON d.department_id = e.department_id
WHERE
  employee_name IS NULL;

```

Output:

| employee_name | department_name |
|--------------|------------------|
| null         | Production       |

The result shows that the `Production` department does not have any employees.

The following example use the `FULL OUTER JOIN` cluase with a `WHERE` clause to find employees who do not belong to any department:

```sql
SELECT
  employee_name,
  department_name
FROM
  employees e
FULL OUTER JOIN departments d
  ON d.department_id = e.department_id
WHERE
  department_name IS NULL;
```

Output:

| employee_name  | department_name |
|----------------|-----------------|
| Julia Mcqueen  | null            |

The output shows that `Juila Mcqueen` does not belong to any department.

## Summary

- Use the PostgreSQL `FULL OUTER JOIN` clause to combine data from both tables, ensuring that matching rows are included from both the left and right tables, as well as unmatched rows from either table.

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

---
# PostgreSQL Cross Join

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `CROSS JOIN` to produce a cartesian product of rows from the joined tables.

## Introduction to the PostgreSQL CROSS JOIN clause

In PostgreSQL, a cross-join allows you to join two tables by combining each row from the first table with every row from the second table, resulting in a complete combination of all rows.

In the set theory, we can say that a cross-join produces the cartesian product of rows in two tables.

Unlike other join clauses such as `LEFT JOIN` or `INNER JOIN`, the `CROSS JOIN` clause does not have a join predicate.

Suppose you have to perform a `CROSS JOIN` of `table1` and `table2`.

If `table1` has `n` rows and `table2` has `m` rows, the `CROSS JOIN` will return a result set that has `nxm` rows.

For example, the `table1` has `1,000` rows and `table2` has `1,000` rows, the result set will have `1,000 x 1,000` = `1,000,000` rows.

Because a `CROSS JOIN` may generate a large result set, you should use it carefully to avoid performance issues.

Here’s the basic syntax of the `CROSS JOIN` syntax:

```sql
SELECT
  select_list
FROM
  table1
CROSS JOIN table2;
```

The following statement is equivalent to the above statement:

```sql
SELECT
  select_list
FROM
  table1,table2;
```

Alternatively, you can use an `INNER JOIN` clause with a condition that always evaluates to true to simulate a cross-join:

```sql
SELECT
  select_list
FROM
  table1
  INNER JOIN table2 ON true;
```

## PostgreSQL CROSS JOIN example

The following CREATE TABLE statements create `T1` and `T2` tables and insert sample data demonstration.

```sql
DROP TABLE IF EXISTS T1;

CREATE TABLE
  T1 (LABEL CHAR(1) PRIMARY KEY);

DROP TABLE IF EXISTS T2;

CREATE TABLE
  T2 (score INT PRIMARY KEY);

INSERT INTO
  T1 (LABEL)
VALUES
  ('A'),
  ('B');

INSERT INTO
  T2 (score)
VALUES
  (1),
  (2),
  (3);
```

The following statement uses the `CROSS JOIN` operator to join `T1` table with `T2` table:

```sql
SELECT *
FROM T1
CROSS JOIN T2;
```

| label | score |
|-------|------|
| A     | 1    |
| B     | 1    |
| A     | 2    |
| B     | 2    |
| A     | 3    |
| B     | 3    |

The following picture illustrates how the `CROSS JOIN` works when joining the `T1` table with the `T2` table:

![image](https://github.com/user-attachments/assets/edd119ed-0395-45f7-b66f-d6d53b3f4681)

## Some practical examples of using CROSS JOIN

In practice, you can find the `CROSS JOIN` useful when you need to combine data from two tables without specific matching conditions. For example:

### 1) Scheduling

Suppose you have a table for `employees` and `shifts`, and you want to create a schedule that lists all possible combinations of employees and shifts to explore various staffing scenarios:

```
SELECT *
FROM employees
CROSS JOIN shift;
```

### 2) Inventory management

In an inventory management system, you have tables for `warehouses` and `products`. A `CROSS JOIN` can help you analyze the availability of each product in every warehouse:

```sql
SELECT *
FROM products
CROSS JOIN warehouses;
```

## Summary

- Use the PostgreSQL `CROSS JOIN` clause to make a cartesian product of rows in two tables.

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
# PostgreSQL NATURAL JOIN

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `NATURAL JOIN` to query data from two tables.

## Introduction to PostgreSQL NATURAL JOIN clause

A natural join is a join that creates an implicit join based on the same column names in the joined tables.

The following shows the syntax of the PostgreSQL NATURAL JOIN clause:

```sql
SELECT select_list
FROM table1
NATURAL [INNER, LEFT, RIGHT] JOIN table2;
```

In this syntax:

- First, specify columns from the tables from which you want to retrieve data in the `select_list` in the `SELECT` clause.
- Second, provide the main table (`table1`) from which you want to retrieve data.
- Third, specify the table (`table2`) that you want to join with the main table, in the `NATURAL JOIN` clause.

A natural join can be an inner join, left join, or right join. If you do not specify an explicit join, PostgreSQL will use the `INNER JOIN` by default.

The convenience of the `NATURAL JOIN` is that it does not require you to specify the condition in the join clause because it uses an implicit condition based on the equality of the common columns.

The equivalent of the `NATURAL JOIN` clause will be like this:

```sql
SELECT select_list
FROM table1
[INNER, LEFT, RIGHT] JOIN table2
   ON table1.column_name = table2.column_name;
```

### Inner Join

The following statements are equivalent:

```
SELECT select_list
FROM table1
NATURAL INNER JOIN table2;
```

And

```
SELECT select_list
FROM table1
INNER JOIN table2 USING (column_name);
```

### Left Join

The following statements are equivalent:

```
SELECT select_list
FROM table1
NATURAL LEFT JOIN table2;
```

And

```
SELECT select_list
FROM table1
LEFT JOIN table2 USING (column_name);
```

### Right join

The following statements are equivalent:

```
SELECT select_list
FROM table1
NATURAL RIGHT JOIN table2;
```

And

```
SELECT select_list
FROM table1
RIGHT JOIN table2 USING (column_name);
```

## Setting up sample tables

The following statements create `categories` and `products` tables, and insert sample data for the demonstration:

```
CREATE TABLE categories (
  category_id SERIAL PRIMARY KEY,
  category_name VARCHAR (255) NOT NULL
);

CREATE TABLE products (
  product_id serial PRIMARY KEY,
  product_name VARCHAR (255) NOT NULL,
  category_id INT NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

INSERT INTO categories (category_name)
VALUES
  ('Smartphone'),
  ('Laptop'),
  ('Tablet'),
  ('VR')
RETURNING *;

INSERT INTO products (product_name, category_id)
VALUES
  ('iPhone', 1),
  ('Samsung Galaxy', 1),
  ('HP Elite', 2),
  ('Lenovo Thinkpad', 2),
  ('iPad', 3),
  ('Kindle Fire', 3)
RETURNING *;
```

The `products` table has the following data:

| product_id | product_name    | category_id |
|------------|-----------------|-------------|
| 1          | iPhone          | 1           |
| 2          | Samsung Galaxy  | 1           |
| 3          | HP Elite        | 2           |
| 4          | Lenovo Thinkpad | 2           |
| 5          | iPad            | 3           |
| 6          | Kindle Fire     | 3           |

The `categories` table has the following data:

| category_id | category_name |
|-------------|---------------|
| 1           | Smartphone    |
| 2           | Laptop        |
| 3           | Tablet        |
| 4           | VR            |

## PostgreSQL NATURAL JOIN examples

Let’s explore some examples of using the `NATURAL JOIN` statement.

### 1) Basic PostgreSQL NATURAL JOIN example

The following statement uses the `NATURAL JOIN` clause to join the `products` table with the `categories` table:

```
SELECT *
FROM products
NATURAL JOIN categories;
```

This statement performs an inner join using the `category_id` column.

Output:

| category_id | product_id | product_name   | category_name |
|------------|------------|---------------|---------------|
| 1          | 1          | iPhone        | Smartphone    |
| 1          | 2          | Samsung Galaxy | Smartphone   |
| 2          | 3          | HP Elite      | Laptop        |
| 2          | 4          | Lenovo Thinkpad | Laptop      |
| 3          | 5          | iPad         | Tablet        |
| 3          | 6          | Kindle Fire  | Tablet        |

The statement is equivalent to the following statement that uses the `INNER JOIN` clause:

```
SELECT	*
FROM products
INNER JOIN categories USING (category_id);
```

### 2) Using PostgreSQL NATURAL JOIN to perform a LEFT JOIN

The following example uses the `NATURAL JOIN` clause to perform a `LEFT JOIN` without specifying the matching column:

```
SELECT *
FROM categories
NATURAL LEFT JOIN products;
```

Output:

| category_id | category_name | product_id | product_name   |
|------------|---------------|------------|---------------|
| 1          | Smartphone    | 1          | iPhone        |
| 1          | Smartphone    | 2          | Samsung Galaxy |
| 2          | Laptop        | 3          | HP Elite      |
| 2          | Laptop        | 4          | Lenovo Thinkpad |
| 3          | Tablet        | 5          | iPad         |
| 3          | Tablet        | 6          | Kindle Fire  |
| 4          | VR            | null       | null         |

### 3) Example of using NATURAL JOIN that causes an unexpected result

In practice, you should avoid using the `NATURAL JOIN` whenever possible because sometimes it may cause an unexpected result.

Consider the following `city` and `country` tables from the sample database:

![image](https://github.com/user-attachments/assets/bef94191-0e85-4af5-9204-d7c733621e1d)

![image](https://github.com/user-attachments/assets/2dcdc601-7460-4c82-bd67-92ba6227f25b)

Both tables have the same `country_id` column so you can use the `NATURAL JOIN` to join these tables as follows:

```
SELECT *
FROM city
NATURAL JOIN country;
```

The query returns an empty result set.

The reason is that both tables have another common column called `last_update`. When the `NATURAL JOIN` clause uses the `last_update` column, it does not find any matches.

## Summary

- Use the PostgreSQL `NATURAL JOIN` clause to query data from two or more tables that have common columns.
