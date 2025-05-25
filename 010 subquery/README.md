# PostgreSQL Join Guide
## Table of Contents

- [PostgreSQL Subquery](#postgresql-subquery)
- [PostgreSQL Correlated Subquery](#postgresql-correlated-subquery)
- [PostgreSQL ANY Operator](#postgresql-any-operator)
- [PostgreSQL ALL Operator](#postgresql-all-operator)
- [PostgreSQL EXISTS Operator](#postgresql-exists-operator)

# PostgreSQL Subquery

**Summary**: in this tutorial, you will learn how to use the **PostgreSQL subquery** that allows you to construct complex queries.

## Introduction to PostgreSQL subquery

A subquery is a `query nested within another query`. A subquery is also known as an inner query or nested query.

A subquery can be useful for retrieving data that will be used by the main query as a condition for further data selection.

The basic syntax of the subquery is as follows:

```sql
SELECT
  select_list
FROM
  table1
WHERE
  columnA operator (
    SELECT
      columnB
    FROM
      table2
    WHERE
      condition
  );
```

In this syntax, the subquery is enclosed within parentheses and is executed first:

```sql
SELECT
  columnB
FROM
  table2
WHERE
  condition
```

The main query will use the result of the subquery to filter data in the `WHERE` clause.

## PostgreSQL subquery examples

Let’s take some examples of using subqueries.

### 1) Basic PostgreSQL subquery example

First, retrieve the country id of the `United States` from the `country` table:

```sql
SELECT
  country_id
FROM
  country
WHERE
  country = 'United States';
```

It returns the following output:

| country_id |
|------------|
| 103        |

(1 row)


Second, retrieve cities from the `city` table where `country_id` is `103`:

```sql
SELECT
  city
FROM
  city
WHERE
  country_id = 103
ORDER BY
  city;
```

Output:

| city                       |
|----------------------------|
| Akron                      |
| Arlington                  |
| Augusta-Richmond County    |
| Aurora                     |
| Bellevue                   |
| Brockton                   |
| Cape Coral                 |
| Citrus Heights             |
| ...                        |

Instead of executing two queries, you can combine them into one, making the first query as a subquery and the second query as the main query as follows:

```sql
SELECT
  city
FROM
  city
WHERE
  country_id = (
    SELECT
      country_id
    FROM
      country
    WHERE
      country = 'United States'
  )
ORDER BY
  city;
```

In this query, the following is the subquery:

```sql
SELECT
  country_id
FROM
  country
WHERE
  country = 'United States';
```

PostgreSQL executes the subquery first to get the country id and uses it for the `WHERE` clause to retrieve the cities.

### 2) Using a subquery with the IN operator

A subquery can return zero or more rows. If the query returns more than one row, you can use it with the [IN](postgresql-in 'PostgreSQL IN') operator. For example:

First, retrieve `film_id` of the film with the category `Action`:

```sql
SELECT
  film_id
FROM
  film_category
  INNER JOIN category USING(category_id)
WHERE
  name = 'Action';
```

Output:

| film_id |
|---------|
| 19      |
| 21      |
| 29      |
| 38      |
| 56      |
| ...     |

Second, use the query above as a subquery to retrieve the film title from the `film` table:

```sql
SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id IN (
    SELECT
      film_id
    FROM
      film_category
      INNER JOIN category USING(category_id)
    WHERE
      name = 'Action'
  )
ORDER BY
  film_id;
```

Output:

| film_id | title               |
|---------|---------------------|
| 19      | Amadeus Holy        |
| 21      | American Circus     |
| 29      | Antitrust Tomatoes  |
| 38      | Ark Ridgemont       |
| 56      | Barefoot Manchurian |
| ...     | ...                 |

## Summary

- A subquery is a query nested inside another query
- A subquery is also known as an inner query or nested query.

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

# PostgreSQL Correlated Subquery

**Summary**: in this tutorial, you will learn about PostgreSQL correlated subquery to perform a query that depends on the values of the current row being processed.

## Introduction to PostgreSQL correlated subquery

In PostgreSQL, a correlated subquery is a `subquery` that references the columns from the outer query.

Unlike a regular subquery, PostgreSQL evaluates the correlated subquery once for each row processed by the outer query.

Since PostgreSQL reevaluates the correlated subquery for every row in the outer query, this may lead to performance issues, especially when dealing with large datasets.

A correlated subquery can be useful when you need to perform a query that depends on the values of the current being processed.

## PostgreSQL correlated subquery example

We’ll use the `film` table from the `sample database` for the demonstration:

![image](https://github.com/user-attachments/assets/253b3ebe-6933-4ed2-9eaf-316f31ad0c11)

The following example uses a correlated subquery to find the films with higher lengths than average for their respective ratings:

```sql
SELECT film_id, title, length, rating
FROM film f
WHERE length > (
    SELECT AVG(length)
    FROM film
    WHERE rating = f.rating
);
```

Output:

| film_id | title               | length | rating |
|---------|---------------------|--------|--------|
| 133     | Chamber Italian     | 117    | NC-17  |
| 4       | Affair Prejudice    | 117    | G      |
| 5       | African Egg         | 130    | G      |
| 6       | Agent Truman        | 169    | PG     |
| ...     | ...                 | ...    | ...    |

How it works.

The outer query retrieves id, title, length, and rating from the `film` table that has the alias `f`:

```sql
SELECT film_id, title, length, rating
FROM film f
WHERE length > (...)
```

For each row processed by the outer query, the correlated subquery calculates the average `length` of films that have the same `rating` as the current row (`f.rating`).

The `WHERE` clause (`WHERE length > (...)`) checks if the length of the current film is greater than the average.

The correlated subquery calculates the `average` length for films with the same rating as the current row in the outer query:

```sql
SELECT AVG(length)
FROM film
WHERE rating = f.rating
```

The `WHERE` clause ensures that the correlated subquery considers only films with the same rating as the current row in the outer query. The condition `rating = f.rating` creates the correlation.

As a result, the outer query returns rows where the `length` of the film is greater than the average `length` for films with the same `rating`.

## Summary

- Use a correlated subquery to perform a query that depends on the values of the current row being processed.

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


# PostgreSQL ANY Operator

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `ANY` operator to compare a scalar value with a set of values returned by a subquery.

## Introduction to PostgreSQL ANY operator

The PostgreSQL `ANY` operator compares a value with a set of values returned by a `subquery). It is commonly used in combination with comparison operators such as \=, \<, \>, \<\=, \>\=, and \<\>.

Here’s the basic syntax of  the `ANY` operator:

```sql
expression operator ANY(subquery)
```

In this syntax:

- `expression` is a value that you want to compare.
- `operator` is a comparison operator including \=, \<, \>, \<\=, \>\=, and \<\>.
- `subquery` is a subquery that returns a set of values to compare against. It must return exactly one column.

The `ANY` operator returns `true` if the comparison returns `true` for at least one of the values in the set, and `false` otherwise.

If the subquery returns an empty set, the result of `ANY` comparison is always `false`.

Besides the subquery, you can use any construct that returns a set of values such as an `ARRAY`.

Note that `SOME` is a synonym for `ANY`, which means that you can use them interchangeably.

## PostgreSQL ANY operator examples

Let’s take some examples of using the `ANY` operator.

### Setting up a sample table

First, create a table called `employees` and `managers`, and insert some data into it:

```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

CREATE TABLE managers(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO employees (first_name, last_name, salary)
VALUES
('Bob', 'Williams', 45000.00),
('Charlie', 'Davis', 55000.00),
('David', 'Jones', 50000.00),
('Emma', 'Brown', 48000.00),
('Frank', 'Miller', 52000.00),
('Grace', 'Wilson', 49000.00),
('Harry', 'Taylor', 53000.00),
('Ivy', 'Moore', 47000.00),
('Jack', 'Anderson', 56000.00),
('Kate', 'Hill',  44000.00),
('Liam', 'Clark', 59000.00),
('Mia', 'Parker', 42000.00);

INSERT INTO managers(first_name, last_name, salary)
VALUES
('John', 'Doe',  60000.00),
('Jane', 'Smith', 55000.00),
('Alice', 'Johnson',  58000.00);
```

Second, retrieve the data from the `employees` table:

```sql
SELECT * FROM employees;
```

Output:

| id  | first_name | last_name | salary  |
|-----|------------|-----------|---------|
|  1  | Bob        | Williams  | 45000.00 |
|  2  | Charlie    | Davis     | 55000.00 |
|  3  | David      | Jones     | 50000.00 |
|  4  | Emma       | Brown     | 48000.00 |
|  5  | Frank      | Miller    | 52000.00 |
|  6  | Grace      | Wilson    | 49000.00 |
|  7  | Harry      | Taylor    | 53000.00 |
|  8  | Ivy        | Moore     | 47000.00 |
|  9  | Jack       | Anderson  | 56000.00 |
| 10  | Kate       | Hill      | 44000.00 |
| 11  | Liam       | Clark     | 59000.00 |
| 12  | Mia        | Parker    | 42000.00 |

(12 rows)


Third, retrieve the data from the `managers` table:

```sql
SELECT * FROM managers;
```

Output:

| id  | first_name | last_name | type    | salary   |
|-----|------------|-----------|---------|----------|
|  1  | John       | Doe       | manager | 60000.00 |
|  2  | Jane       | Smith     | manager | 55000.00 |
|  3  | Alice      | Johnson   | manager | 58000.00 |

(3 rows)


### 1) Using ANY operator with the \= operator example

The following statement uses the ANY operator to find employees who have the salary the same as manager:

```sql
SELECT
  *
FROM
  employees
WHERE
  salary = ANY (
    SELECT
      salary
    FROM
      managers
  );

```

It returns one row:

| id  | first_name | last_name | salary   |
|-----|------------|-----------|----------|
|  2  | Charlie    | Davis     | 55000.00 |

(1 row)


How it works.

First, execute the subquery in the `ANY` operator that returns the salary of managers:

```sql
SELECT salary FROM managers;
```

Output:

| salary   |
|----------|
| 60000.00 |
| 55000.00 |
| 58000.00 |

(3 rows)


Second, compare the salary of each row in the `employees` table with the values returned by the subquery and include the row that has a salary equal to the one in the set (`60K`, `55K`, and `58K`).

### 2) Using ANY operator with > operator example

The following example uses the `ANY` operator to find employees who have salaries greater than the manager’s salaries:

```sql
SELECT
  *
FROM
  employees
WHERE
  salary > ANY (
    SELECT
      salary
    FROM
      managers
  );
```

Output:

| id  | first_name | last_name | salary   |
|-----|------------|-----------|----------|
|  9  | Jack       | Anderson  | 56000.00 |
| 11  | Liam       | Clark     | 59000.00 |

(2 rows)


The output indicates that the two employees have a higher salary than the manager’s.

- Jack has a salary of 56K which is greater than 55K.
- Liam has a salary of 59K which is greater than 55K and 58K.

### 3\) Using ANY operator with \< operator example

The following example uses the `ANY` operator to find employees who have salaries less than the manager’s salaries:

```sql
SELECT
  *
FROM
  employees
WHERE
  salary < ANY (
    SELECT
      salary
    FROM
      managers
  );
```

Output:

| id  | first_name | last_name | salary   |
|-----|------------|-----------|----------|
|  1  | Bob        | Williams  | 45000.00 |
|  2  | Charlie    | Davis     | 55000.00 |
|  3  | David      | Jones     | 50000.00 |
|  4  | Emma       | Brown     | 48000.00 |
|  5  | Frank      | Miller    | 52000.00 |
|  6  | Grace      | Wilson    | 49000.00 |
|  7  | Harry      | Taylor    | 53000.00 |
|  8  | Ivy        | Moore     | 47000.00 |
|  9  | Jack       | Anderson  | 56000.00 |
| 10  | Kate       | Hill      | 44000.00 |
| 12  | Mia        | Parker    | 42000.00 |


(12 rows)


It returns all the rows with the `employee` type because they have a value in the `salary` column less than any value in the set (55K, 58K, and 60K).

## Summary

- Use the PostgreSQL `ANY` operator to compare a value to a set of values returned by a subquery.


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


# PostgreSQL ALL Operator


**Summary**: in this tutorial, you will learn how to use the PostgreSQL `ALL` operator to compare a value with a list of values returned by a subquery.

## Overview of the PostgreSQL ALL operator

The PostgreSQL `ALL` operator allows you to compare a value with all values in a set returned by a `subquery`.

Here’s the basic syntax of the `ALL` operator:

```sql
expression operator ALL(subquery)
```

In this syntax:

- The `ALL` operator must be preceded by a comparison operator such as equal (\=), not equal (\<\>), greater than (\>), greater than or equal to (\>\=), less than (\<), and less than or equal to (\<\=).
- The `ALL` operator must be followed by a subquery which also must be surrounded by the parentheses.

If the subquery returns a non\-empty result set, the `ALL` operator works as follows:

- `value > ALL (subquery)` returns true if the value is greater than the biggest value returned by the subquery.
- `value >= ALL (subquery)` returns true if the value is greater than or equal to the biggest value returned by the subquery.
- `value < ALL (subquery)` returns true if the value is less than the smallest value returned by the subquery.
- `value <= ALL (subquery)` returns true if the value is less than or equal to the smallest value returned by the subquery.
- `value = ALL (subquery)` returns true if the value equals every value returned by the subquery.
- `value != ALL (subquery)` returns true if the value does not equal any value returned by the subquery.

If the subquery returns no row, then the `ALL` operator always evaluates to true.

## PostgreSQL ALL operator examples

Let’s explore some examples of using the PostgreSQL `ALL` operator.

### Setting up a sample table

```sql
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

CREATE TABLE managers(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO employees (first_name, last_name, salary)
VALUES
('Bob', 'Williams', 75000.00),
('Charlie', 'Davis', 55000.00),
('David', 'Jones', 50000.00),
('Emma', 'Brown', 48000.00),
('Frank', 'Miller', 52000.00),
('Grace', 'Wilson', 49000.00),
('Harry', 'Taylor', 53000.00),
('Ivy', 'Moore', 47000.00),
('Jack', 'Anderson', 56000.00),
('Kate', 'Hill',  44000.00),
('Liam', 'Clark', 59000.00),
('Mia', 'Parker', 42000.00);

INSERT INTO managers(first_name, last_name, salary)
VALUES
('John', 'Doe',  60000.00),
('Jane', 'Smith', 55000.00),
('Alice', 'Johnson',  58000.00);
```

### 1\) Using the ALL operator with the greater than operator (\>) example

The following example uses the `ALL` operator for employees who have salaries greater than all managers

```sql
SELECT
  *
FROM
  employees
WHERE
  salary > ALL(
    select
      salary
    from
      managers
  );
```

Output:

| id  | first_name | last_name | salary   |
|-----|------------|-----------|----------|
|  1  | Bob        | Williams  | 75000.00 |

(1 row)


The query returns one row with a salary of 75K greater than the highest salary of all managers (60K).

### 2\) Using the ALL operator with the less than operator (\<) example

The following example uses the `ALL` operator for employees who have salaries less than all managers:

```sql
SELECT
  *
FROM
  employees
WHERE
  salary < ALL(
    select
      salary
    from
      managers
  )
ORDER BY salary DESC;
```

Output:

| id  | first_name | last_name | salary   |
|-----|------------|-----------|----------|
|  7  | Harry      | Taylor    | 53000.00 |
|  5  | Frank      | Miller    | 52000.00 |
|  3  | David      | Jones     | 50000.00 |
|  6  | Grace      | Wilson    | 49000.00 |
|  4  | Emma       | Brown     | 48000.00 |
|  8  | Ivy        | Moore     | 47000.00 |
| 10  | Kate       | Hill      | 44000.00 |
| 12  | Mia        | Parker    | 42000.00 |

(8 rows)


It returns all the employees whose salaries are less than the lowest salary of all managers which is 55K.

## Summary

- Use the PostgreSQL `ALL` operator to compare a value with all values in a set of values returned by a subquery.

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

# PostgreSQL EXISTS Operator

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `EXISTS` operator to test for the existence of rows in a subquery.

## Introduction to PostgreSQL EXISTS operator

The `EXISTS` operator is a boolean operator that checks the existence of rows in a `subquery`.

Here’s the basic syntax of the `EXISTS` operator:

```sql
EXISTS (subquery)
```

Typically, you use the `EXISTS` operator in the `WHERE` clause of a `SELECT` statement:

```sql
SELECT
  select_list
FROM
  table1
WHERE
  EXISTS(
    SELECT
      select_list
    FROM
      table2
    WHERE
      condition
  );
```

If the subquery returns at least one row, the `EXISTS` operator returns `true`. If the subquery returns no row, the `EXISTS` returns `false`.

Note that if the subquery returns `NULL`, the `EXISTS` operator returns `true`.

The result of `EXISTS` operator depends on whether any row is returned by the subquery, and not on the row contents. Therefore, columns that appear in the `select_list` of the subquery are not important.

For this reason, the common coding convention is to write `EXISTS` in the following form:

```sql
SELECT
  select_list
FROM
  table1
WHERE
  EXISTS(
    SELECT
      1
    FROM
      table2
    WHERE
      condition
  );
```

To negate the `EXISTS` operator, you use the `NOT EXISTS` operator:

```sql
NOT EXISTS (subquery)
```

The `NOT EXISTS` operator returns `true` if the subquery returns no row or `false` if the subquery returns at least one row.

In practice, you often use the `EXISTS` operator in conjunction with the `correlated subqueries`.

## PostgreSQL EXISTS examples

We will use the following `customer` and `payment` tables in the `sample database` for the demonstration:

![image](https://github.com/user-attachments/assets/82408b47-13d4-440e-af21-d2e2caf796b5)

### 1\) Basic EXISTS operator example

The following example uses the `EXISTS` operator to check if the payment value is zero exists in the `payment` table:

```sql
SELECT
  EXISTS(
    SELECT
      1
    FROM
      payment
    WHERE
      amount = 0
  );
```

Output:

| exists |
|--------|
| t      |

(1 row)


### 2) Using the EXISTS operator to check the existence of a row

The following example uses the `EXISTS` operator to find customers who have paid at least one rental with an amount greater than 11:

```sql
SELECT
  first_name,
  last_name
FROM
  customer c
WHERE
  EXISTS (
    SELECT
      1
    FROM
      payment p
    WHERE
      p.customer_id = c.customer_id
      AND amount > 11
  )
ORDER BY
  first_name,
  last_name;
```

The query returns the following output:

| first_name | last_name  |
|------------|-----------|
| Karen      | Jackson   |
| Kent       | Arsenault |
| Nicholas   | Barfield  |
| Rosemary   | Schmidt   |
| Tanya      | Gilbert   |
| Terrance   | Roush     |
| Vanessa    | Sims      |
| Victoria   | Gibson    |

(8 rows)


In this example, for each customer in the `customer` table, the subquery checks the `payment` table to find if that customer made at least one payment (`p.customer_id = c.customer_id`) and the amount is greater than 11 ( `amount > 11`)

### 2) NOT EXISTS example

The following example uses the `NOT EXISTS` operator to find customers who have not made any payment more than 11\.

```sql
SELECT
  first_name,
  last_name
FROM
  customer c
WHERE
  NOT EXISTS (
    SELECT
      1
    FROM
      payment p
    WHERE
      p.customer_id = c.customer_id
      AND amount > 11
  )
ORDER BY
  first_name,
  last_name;
```

Here is the output:

| first_name | last_name  |
|------------|-----------|
| Aaron      | Selby     |
| Adam       | Gooch     |
| Adrian     | Clary     |
| Agnes      | Bishop    |
| Alan       | Kahn      |
| ...        | ...       |


### 3) EXISTS and NULL example

The following example returns all rows from the `customers` table because the subquery in the `EXISTS` operator returns `NULL`:

```sql
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  EXISTS(
    SELECT NULL
  )
ORDER BY
  first_name,
  last_name;
```

Output:

| first_name | last_name  |
|------------|-----------|
| Aaron      | Selby     |
| Adam       | Gooch     |
| Adrian     | Clary     |
| Agnes      | Bishop    |
| ...        | ...       |

## Summary

- Use the PostgreSQL `EXISTS` to check the existence of rows in a subquery.
