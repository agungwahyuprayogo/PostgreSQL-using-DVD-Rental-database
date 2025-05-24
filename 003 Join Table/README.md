# PostgreSQL Join Guide

## Table of Contents

- [PostgreSQL JOINS](#postgresql-joins)
- [PostgreSQL TABLE ALIASES](#postgresql-table-aliases)
- [PostgreSQL INNER JOIN](#postgresql-inner-join)
---

---
# PostgreSQL Joins

**Summary**: in this tutorial, you will learn about various kinds of PostgreSQL JOINS including `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `FULL OUTER JOIN`.

PostgreSQL join is used to combine columns from one self-join](postgresql-self-join or more tables based on the values of the common columns between related tables. The common columns are typically the `primary key` columns of the first table and the `foreign key` columns of the second table.

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

## PostgreSQL INNER JOIN

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

## PostgreSQL LEFT JOIN

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

If these values are equal, the LEFT JOIN creates a new row that contains columns of both tables and adds this new row to the result set. (see the row \#1 and \#2 in the result set).

In case the values do not equal, the left join also creates a new row that contains columns from both tables and adds it to the result set. However, it fills the columns of the right table (`basket_b`) with null. (see the row \#3 and \#4 in the result set).

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

## PostgreSQL RIGHT JOIN

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

  a   | fruit_a | b |  fruit_b
------+---------+---+------------
    2 | Orange  | 1 | Orange
    1 | Apple   | 2 | Apple
 null | null    | 3 | Watermelon
 null | null    | 4 | Pear

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

## PostgreSQL FULL OUTER JOIN

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

```
 customer_id |     customer_name     |  staff_name  | amount |        payment_date
-------------+-----------------------+--------------+--------+----------------------------
         416 | Jeffery Pinson        | Jon Stephens |   2.99 | 2007-02-14 21:21:59.996577
         516 | Elmer Noe             | Jon Stephens |   4.99 | 2007-02-14 21:23:39.996577
         239 | Minnie Romero         | Mike Hillyer |   4.99 | 2007-02-14 21:29:00.996577
         592 | Terrance Roush        | Jon Stephens |   6.99 | 2007-02-14 21:41:12.996577
          49 | Joyce Edwards         | Mike Hillyer |   0.99 | 2007-02-14 21:44:52.996577
...
```

## Summary

- Use `INNER JOIN` clauses to select data from two or more related tables and return rows that have matching values in all tables.

---
---
---

