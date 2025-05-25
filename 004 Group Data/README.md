# PostgreSQL Join Guide

## Table of Contents

- [PostgreSQL GROUP BY](#postgresql-group-by)
- [PostgreSQL HAVING](#postgresql-having)
- [PostgreSQL GROUPING SETS](#postgresql-grouping-sets)
- [PostgreSQL CUBE](#postgresql-cube)
- [PostgreSQL ROLLUP](#postgresql-roolup)

# PostgreSQL GROUP BY

**Summary**: in this tutorial, you will learn how to use PostgreSQL `GROUP BY` clause to divide rows into groups.

## Introduction to PostgreSQL GROUP BY clause

The `GROUP BY` clause divides the rows returned from the `SELECT` statement into groups.

For each group, you can apply an `Aggregate function` such as `SUM()` to calculate the sum of items or `COUNT()` to get the number of items in the groups.

The following illustrates the basic syntax of the `GROUP BY` clause:

```sql
SELECT
   column_1,
   column_2,
   ...,
   aggregate_function(column_3)
FROM
   table_name
GROUP BY
   column_1,
   column_2,
   ...;

```

In this syntax:

- First, select the columns that you want to group such as `column1` and `column2`, and column that you want to apply an aggregate function (`column3`).
- Second, list the columns that you want to group in the `GROUP BY` clause.

The `GROUP BY` clause divides the rows by the values in the columns specified in the `GROUP BY` clause and calculates a value for each group.

It’s possible to use other clauses of the `SELECT` statement with the `GROUP BY` clause.

PostgreSQL evaluates the `GROUP BY` clause after the `FROM` and `WHERE` clauses and before the `HAVING` `SELECT`, `DISTINCT`, `ORDER BY` and `LIMIT` clauses.

![image](https://github.com/user-attachments/assets/ea97b612-98e3-4bc8-bcdc-b8ce0e941b84)

## PostgreSQL GROUP BY clause examples

Let’s take a look at the `payment` table in the `sample database`.

![image](https://github.com/user-attachments/assets/a785d1ec-0e16-490e-876c-d2c57e158fdf)

### 1) Using PostgreSQL GROUP BY without an aggregate function example

The following example uses the `GROUP BY` clause to retrieve the `customer_id` from the payment table:

```sql
SELECT
  customer_id
FROM
  payment
GROUP BY
  customer_id
ORDER BY
  customer_id;
```

Output:

| customer_id |
|-------------|
| 1           |
| 2           |
| 3           |
| 4           |
| 5           |
| 6           |
| 7           |
| 8           |

Each customer has one or more payments. The `GROUP BY` clause removes duplicate values in the `customer_id` column and returns distinct `customer_ids`. In this example, the `GROUP BY` clause works like the `DISTINCT` operator.

### 2) Using PostgreSQL GROUP BY with SUM() function example

The `GROUP BY` clause is useful when used in conjunction with an `Aggregate Function`.

The following query uses the `GROUP BY` clause to retrieve the total payment paid by each customer:

```sql
SELECT
  customer_id,
  SUM (amount)
FROM
  payment
GROUP BY
  customer_id
ORDER BY
  customer_id;
```

Output:

| customer_id | sum    |
|-------------|--------|
| 1           | 114.70 |
| 2           | 123.74 |
| 3           | 130.76 |
| 4           | 81.78  |
| 5           | 134.65 |
| 6           | 84.75  |
| 7           | 130.72 |

In this example, the `GROUP BY` clause groups the `payments` by the `customer_id`. For each group, it calculates the total payment.

The following statement uses the `ORDER BY` clause with `GROUP BY` clause to sort the groups by total payments:

```sql
SELECT
  customer_id,
  SUM (amount)
FROM
  payment
GROUP BY
  customer_id
ORDER BY
  SUM (amount) DESC;
```

Output:

| customer_id | sum    |
|-------------|--------|
| 148         | 211.55 |
| 526         | 208.58 |
| 178         | 194.61 |
| 137         | 191.62 |
| 144         | 189.60 |

### 3) Using PostgreSQL GROUP BY clause with the JOIN clause

The following statement uses the `GROUP BY` clause to retrieve the total payment for each customer and display the `customer name` and `amount`:

```sql
SELECT
  first_name || ' ' || last_name full_name,
  SUM (amount) amount
FROM
  payment
  INNER JOIN customer USING (customer_id)
GROUP BY
  full_name
ORDER BY
  amount DESC;
```

Output:

| full_name      | amount |
|----------------|--------|
| Eleanor Hunt   | 211.55 |
| Karl Seal      | 208.58 |
| Marion Snyder  | 194.61 |
| Rhonda Kennedy | 191.62 |
| Clara Shaw     | 189.60 |
| ...            | ...    |

In this example, we join the `payment` table with the `customer` table using an [inner join](postgresql-inner-join) to get the customer names and group customers by their names.

### 4) Using PostgreSQL GROUP BY with COUNT() function example

The following example uses the `GROUP BY` clause with the `COUNT()` function to count the number of payments processed by each staff:

```sql
SELECT
	staff_id,
	COUNT (payment_id)
FROM
	payment
GROUP BY
	staff_id;
```

Output:

| staff_id | count |
|----------|-------|
| 1        | 7292  |
| 2        | 7304  |

In this example, the `GROUP BY` clause divides the rows in the `payment` table into groups and groups them by value in the `staff_id` column. For each group, it counts the number of rows using the `COUNT()` function.

### 5) Using PostgreSQL GROUP BY with multiple columns

The following example uses a `GROUP BY` clause to group rows by values in two columns:

```sql
SELECT
  customer_id,
  staff_id,
  SUM(amount)
FROM
  payment
GROUP BY
  staff_id,
  customer_id
ORDER BY
  customer_id;
```

Output:

| customer_id | staff_id | sum    |
|-------------|----------|--------|
| 1           | 2        | 53.85  |
| 1           | 1        | 60.85  |
| 2           | 2        | 67.88  |
| 2           | 1        | 55.86  |
| 3           | 1        | 59.88  |
| ...         | ...      | ...    |

In this example, the `GROUP BY` clause divides the rows in the `payment` table by the values in the `customer_id` and `staff_id` columns. For each group of `(customer_id, staff_id)`, the `SUM()` calculates the total amount.

### 6) Using PostgreSQL GROUP BY clause with a date column

The following example uses the `GROUP BY` clause to group the payments by payment date:

```sql
SELECT
  payment_date::date payment_date,
  SUM(amount) sum
FROM
  payment
GROUP BY
  payment_date::date
ORDER BY
  payment_date DESC;
```

Output:

```
payment_date |   sum
--------------+---------
 2007-05-14   |  514.18
 2007-04-30   | 5723.89
 2007-04-29   | 2717.60
 2007-04-28   | 2622.73
...
```

Since the values in the `payment_date` column are timestamps, we cast them to date values using the cast operator `::`.

## Summary

- Use the PostgreSQL `GROUP BY` clause to divide rows into groups and apply an aggregate function to each group.

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

# PostgreSQL HAVING

**Summary**: in this tutorial, you will learn how to use the **PostgreSQL HAVING** clause to specify a search condition for a group or an aggregate.

## Introduction to PostgreSQL HAVING clause

The `HAVING` clause specifies a search condition for a group. The `HAVING` clause is often used with the `GROUP BY` clause to filter groups based on a specified condition.

The following statement illustrates the basic syntax of the `HAVING` clause:

```sql
SELECT
  column1,
  aggregate_function (column2)
FROM
  table_name
GROUP BY
  column1
HAVING
  condition;
```

In this syntax:

- First, the `GROUP BY` clause groups rows into groups by the values in the `column1`.
- Then, the `HAVING` clause filters the groups based on the `condition`.

If a group satisfies the specified condition, the `HAVING` clause will include it in the result set.

Besides the `GROUP BY` clause, you can also include other clauses such as `JOIN`and `LIMIT`) in the statement that uses the `HAVING` clause.

PostgreSQL evaluates the `HAVING` clause after the `FROM`, `WHERE`, `GROUP BY`, and before the `DISTINCT`, `SELECT`, `ORDER BY` and `LIMIT` clauses:

![image](https://github.com/user-attachments/assets/0e9398e0-ee28-41dd-8827-211157ff9775)

Because PostgreSQL evaluates the `HAVING` clause before the `SELECT` clause, you cannot use the column aliases in the `HAVING` clause.

This restriction arises from the fact that, at the point of `HAVING` clause evaluation, the column aliases specified in the `SELECT` clause are not yet available.

### HAVING vs. WHERE

The `WHERE` clause filters the rows based on a specified condition whereas the `HAVING` clause filter groups of rows according to a specified condition.

In other words, you apply the condition in the `WHERE` clause to the rows while you apply the condition in the `HAVING` clause to the groups of rows.

## PostgreSQL HAVING clause examples

Let’s take a look at the `payment` table in the `sample database`:

![image](https://github.com/user-attachments/assets/a5260bee-bdfd-4f53-8bd3-2991d26a4092)

### 1) Using PostgreSQL HAVING clause with SUM function example

The following query uses the `GROUP BY` clause with the `SUM()` function to find the total payment of each customer:

```sql
SELECT
  customer_id,
  SUM (amount) amount
FROM
  payment
GROUP BY
  customer_id
ORDER BY
  amount DESC;
```

Output:

| customer_id | amount  |
|-------------|---------|
| 148         | 211.55  |
| 526         | 208.58  |
| 178         | 194.61  |
| 137         | 191.62  |
| ...         | ...     |

The following statement adds the `HAVING`clause to select the only customers who have been spending more than `200`:

```sql
SELECT
  customer_id,
  SUM (amount) amount
FROM
  payment
GROUP BY
  customer_id
HAVING
  SUM (amount) > 200
ORDER BY
  amount DESC;
```

Output:

| customer_id | amount  |
|------------|--------|
| 148        | 211.55  |
| 526        | 208.58  |

(2 rows)


### 2) PostgreSQL HAVING clause with COUNT example

See the following `customer` table from the `sample database`:

![image](https://github.com/user-attachments/assets/1dbcaf06-bdb5-4a18-bce4-4ea906bbc0b4)

The following query uses the `GROUP BY` clause to find the number of customers per store:

```sql
SELECT
  store_id,
  COUNT (customer_id)
FROM
  customer
GROUP BY
  store_id
```

Output:

| store_id | count |
|----------|-------|
| 1        | 326   |
| 2        | 273   |

(2 rows)


The following statement adds the `HAVING` clause to select a store that has more than 300 customers:

```sql
SELECT
  store_id,
  COUNT (customer_id)
FROM
  customer
GROUP BY
  store_id
HAVING
  COUNT (customer_id) > 300;
```

Output:

| store_id | count |
|----------|-------|
| 1        | 326   |

(1 row)


## Summary

- Use the `HAVING` clause to specify the filter condition for groups returned by the `GROUP BY` clause.

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


# PostgreSQL GROUPING SETS

---

**Summary**: in this tutorial, you will learn about grouping sets and how to use the PostgreSQL `GROUPING SETS` clause to generate multiple grouping sets in a query.

## Setup a sample table

Let’s get started by creating a new table called `sales` for the demonstration.

```sql
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    brand VARCHAR NOT NULL,
    segment VARCHAR NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (brand, segment)
);

INSERT INTO sales (brand, segment, quantity)
VALUES
    ('ABC', 'Premium', 100),
    ('ABC', 'Basic', 200),
    ('XYZ', 'Premium', 100),
    ('XYZ', 'Basic', 300)
RETURNING *;
```

Output:

| brand | segment  | quantity |
|-------|---------|----------|
| ABC   | Premium | 100      |
| ABC   | Basic   | 200      |
| XYZ   | Premium | 100      |
| XYZ   | Basic   | 300      |

(4 rows)


The `sales` table stores the number of products sold by brand and segment.

## Introduction to PostgreSQL GROUPING SETS

A grouping set is a set of columns by which you group using the `GROUP BY` clause.

A grouping set is denoted by a comma-separated list of columns placed inside parentheses:

```sql
(column1, column2, ...)
```

For example, the following query uses the `GROUP BY` clause to return the number of products sold by brand and segment. In other words, it defines a grouping set of the brand and segment which is denoted by `(brand, segment)`

```sql
SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand,
    segment;
```

Output:

| brand | segment  | sum  |
|-------|---------|-----|
| XYZ   | Basic   | 300  |
| ABC   | Premium | 100  |
| ABC   | Basic   | 200  |
| XYZ   | Premium | 100  |

(4 rows)


The following query finds the number of products sold by a brand. It defines a grouping set `(brand)`:

```sql
SELECT
    brand,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand;
```

Output:

| brand | sum  |
|-------|------|
| ABC   | 300  |
| XYZ   | 400  |

(2 rows)


The following query finds the number of products sold by segment. It defines a grouping set `(segment)`:

```sql
SELECT
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    segment;
```

Output:

| segment | sum  |
|---------|------|
| Basic   | 500  |
| Premium | 200  |

(2 rows)


The following query finds the number of products sold for all brands and segments. It defines an empty grouping set which is denoted by `()`.

```sql
SELECT SUM (quantity) FROM sales;
```

Output:

| sum  |
|------|
| 700  |

(1 row)


Suppose you want to get all the grouping sets using a single query. To achieve this, you can use the `UNION ALL` to combine all the result sets of the queries above.

Because `UNION ALL` requires all result sets to have the same number of columns with compatible data types, you need to adjust the queries by adding `NULL` to the selection list of each as shown below:

```sql
SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand,
    segment

UNION ALL

SELECT
    brand,
    NULL,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand

UNION ALL

SELECT
    NULL,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    segment

UNION ALL

SELECT
    NULL,
    NULL,
    SUM (quantity)
FROM
    sales;
```

Output:

| brand | segment  | sum  |
|-------|---------|-----|
| XYZ   | Basic   | 300  |
| ABC   | Premium | 100  |
| ABC   | Basic   | 200  |
| XYZ   | Premium | 100  |
| ABC   | null    | 300  |
| XYZ   | null    | 400  |
| null  | Basic   | 500  |
| null  | Premium | 200  |
| null  | null    | 700  |

(9 rows)


This query generated a single result set with the aggregates for all grouping sets.

Even though the above query works as you expected, it has two main problems.

- First, it is quite lengthy.
- Second, it has a performance issue because PostgreSQL has to scan the `sales` table separately for each query.

To make it more efficient, PostgreSQL provides the `GROUPING SETS` clause which is the subclause of the [`GROUP BY`](postgresql-group-by) clause.

The `GROUPING SETS` allows you to define multiple grouping sets in the same query.

The general syntax of the `GROUPING SETS` is as follows:

```sql
SELECT
    c1,
    c2,
    aggregate_function(c3)
FROM
    table_name
GROUP BY
    GROUPING SETS (
        (c1, c2),
        (c1),
        (c2),
        ()
);
```

In this syntax, we have four grouping sets `(c1,c2)`, `(c1)`, `(c2)`, and `()`.

To apply this syntax to the above example, you can use `GROUPING SETS` clause instead of the `UNION ALL` clause like this:

```sql
SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    GROUPING SETS (
        (brand, segment),
        (brand),
        (segment),
        ()
    );
```

Output:

| brand | segment  | sum  |
|-------|---------|-----|
| null  | null    | 700  |
| XYZ   | Basic   | 300  |
| ABC   | Premium | 100  |
| ABC   | Basic   | 200  |
| XYZ   | Premium | 100  |
| ABC   | null    | 300  |
| XYZ   | null    | 400  |
| null  | Basic   | 500  |
| null  | Premium | 200  |

(9 rows)


This query is much shorter and more readable. In addition, PostgreSQL will optimize the number of times it scans the `sales` table and will not scan multiple times.

## Grouping function

The `GROUPING()` function accepts an argument which can be a column name or an expression:

```sql
GROUPING( column_name | expression)
```

The `column_name` or `expression` must match with the one specified in the `GROUP BY` clause.

The `GROUPING()` function returns bit 0 if the argument is a member of the current grouping set and 1 otherwise.

See the following example:

```sql
SELECT
	GROUPING(brand) grouping_brand,
	GROUPING(segment) grouping_segment,
	brand,
	segment,
	SUM (quantity)
FROM
	sales
GROUP BY
	GROUPING SETS (
		(brand),
		(segment),
		()
	)
ORDER BY
	brand,
	segment;
```

![image](https://github.com/user-attachments/assets/fdb36e46-bbe6-4b61-b3fd-f3ea81638dcf)

As shown in the screenshot, when the value in the `grouping_brand` is 0, the `sum` column shows the subtotal of the `brand`.

When the value in the `grouping_segment` is zero, the sum column shows the subtotal of the `segment`.

You can use the `GROUPING()` function in the `HAVING` clause to find the subtotal of each brand like this:

```sql
SELECT
	GROUPING(brand) grouping_brand,
	GROUPING(segment) grouping_segment,
	brand,
	segment,
	SUM (quantity)
FROM
	sales
GROUP BY
	GROUPING SETS (
		(brand),
		(segment),
		()
	)
HAVING GROUPING(brand) = 0
ORDER BY
	brand,
	segment;
```

![image](https://github.com/user-attachments/assets/00f88092-acb2-4d66-ac10-30285978cca4)

## Summary

- Use the PostgreSQL `GROUPING SETS` to generate multiple grouping sets.

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

# PostgreSQL CUBE

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `CUBE` to generate multiple grouping sets.

## Introduction to the PostgreSQL CUBE

PostgreSQL `CUBE` is a subclause of the `GROUP BY` clause. The `CUBE` allows you to generate multiple grouping sets.

A grouping set is a set of columns to which you want to group. For more information on the grouping sets, check it out the `GROUPING SETS` tutorial.

The following illustrates the syntax of the `CUBE` subclause:

```sql
SELECT
    c1,
    c2,
    c3,
    aggregate (c4)
FROM
    table_name
GROUP BY
    CUBE (c1, c2, c3);

```

In this syntax:

- First, specify the `CUBE` subclause in the `GROUP BY` clause of the `SELECT` statement.
- Second, in the select list, specify the columns (dimensions or dimension columns) which you want to analyze and `aggregation function` expressions.
- Third, in the `GROUP BY` clause, specify the dimension columns within the parentheses of the `CUBE` subclause.

The query generates all possible grouping sets based on the dimension columns specified in `CUBE`. The `CUBE` subclause is a short way to define multiple grouping sets so the following are equivalent:

```sql
CUBE(c1,c2,c3)

GROUPING SETS (
    (c1,c2,c3),
    (c1,c2),
    (c1,c3),
    (c2,c3),
    (c1),
    (c2),
    (c3),
    ()
 )

```

In general, if the number of columns specified in the `CUBE` is `n`, then you will have 2ncombinations.

PostgreSQL allows you to perform a partial cube to reduce the number of aggregates calculated. The following shows the syntax:

```sql
SELECT
    c1,
    c2,
    c3,
    aggregate (c4)
FROM
    table_name
GROUP BY
    c1,
    CUBE (c1, c2);

```

## PostgreSQL CUBE examples

We will use the `sales` table created in the `GROUPING SETS` tutorial for the demonstration.

![image](https://github.com/user-attachments/assets/e23e465b-3928-4336-aefb-85236824f1ef)

The following query uses the `CUBE` subclause to generate multiple grouping sets:

```sql
SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    CUBE (brand, segment)
ORDER BY
    brand,
    segment;

```

Here is the output:

![image](https://github.com/user-attachments/assets/d4497455-6660-4cbd-8119-fb1c3c1c47bb)

The following query performs a partial cube:

```sql
SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand,
    CUBE (segment)
ORDER BY
    brand,
    segment;

```

![image](https://github.com/user-attachments/assets/c3714a5e-1249-4eee-954e-e65fa59a02f5)

In this tutorial, you have learned how to use the PostgreSQL `CUBE` to generate multiple grouping sets.

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
# PostgreSQL ROLLUP

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `ROLLUP` to generate multiple grouping sets.

## Introduction to the PostgreSQL ROLLUP

The PostgreSQL `ROLLUP` is a subclause of the `GROUP BY` clause that offers a shorthand for defining multiple `grouping sets`. A grouping set is a set of columns by which you group. Check out the `grouping sets` tutorial for detailed information.

Different from the `CUBE` subclause, `ROLLUP` does not generate all possible grouping sets based on the specified columns. It just makes a subset of those.

The `ROLLUP` assumes a hierarchy among the input columns and generates all grouping sets that make sense considering the hierarchy. This is the reason why `ROLLUP` is often used to generate the subtotals and the grand total for reports.

For example, the `CUBE (c1,c2,c3)` makes all eight possible grouping sets:

```sql
(c1, c2, c3)
(c1, c2)
(c2, c3)
(c1,c3)
(c1)
(c2)
(c3)
()

```

However, the `ROLLUP(c1,c2,c3)` generates only four grouping sets, assuming the hierarchy `c1 > c2 > c3` as follows:

```sql
(c1, c2, c3)
(c1, c2)
(c1)
()

```

A common use of  `ROLLUP` is to calculate the aggregations of data by year, month, and date, considering the hierarchy `year > month > date`

The following illustrates the syntax of the PostgreSQL `ROLLUP`:

```sql
SELECT
    c1,
    c2,
    c3,
    aggregate(c4)
FROM
    table_name
GROUP BY
    ROLLUP (c1, c2, c3);

```

It is also possible to do a partial roll up to reduce the number of subtotals generated.

```sql
SELECT
    c1,
    c2,
    c3,
    aggregate(c4)
FROM
    table_name
GROUP BY
    c1,
    ROLLUP (c2, c3);

```

## PostgreSQL ROLLUP examples

If you haven’t created the sales table, you can use the following script:

```sql
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    brand VARCHAR NOT NULL,
    segment VARCHAR NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (brand, segment)
);

INSERT INTO sales (brand, segment, quantity)
VALUES
    ('ABC', 'Premium', 100),
    ('ABC', 'Basic', 200),
    ('XYZ', 'Premium', 100),
    ('XYZ', 'Basic', 300);

```

The following query uses the `ROLLUP` clause to find the number of products sold by brand (subtotal) and by all brands and segments (total).

```sql
SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    ROLLUP (brand, segment)
ORDER BY
    brand,
    segment;

```

![image](https://github.com/user-attachments/assets/ed5d1153-83c2-4555-9784-8093552e1128)

As you can see clearly from the output, the third row shows the sales of the `ABC` brand, the sixth row displays sales of the `XYZ` brand. The last row shows the grand total for all brands and segments. In this example, the hierarchy is `brand > segment`.

If you change the order of brand and segment, the result will be different as follows:

```sql
SELECT
    segment,
    brand,
    SUM (quantity)
FROM
    sales
GROUP BY
    ROLLUP (segment, brand)
ORDER BY
    segment,
    brand;

```

![image](https://github.com/user-attachments/assets/8cd3c6a9-23ae-4836-9485-aeddb94ecda6)

In this case, the hierarchy is the `segment > brand`.

The following statement performs a partial roll\-up:

```sql
SELECT
    segment,
    brand,
    SUM (quantity)
FROM
    sales
GROUP BY
    segment,
    ROLLUP (brand)
ORDER BY
    segment,
    brand;

```

![image](https://github.com/user-attachments/assets/d8509322-85ff-49a2-857a-f428b1ba4574)

See the following `rental` table from the [sample database](../postgresql-getting-started/postgresql-sample-database).

![image](https://github.com/user-attachments/assets/ff5c01cb-eefb-4e3d-a4c7-c0c65c099d9f)

The following statement finds the number of rental per day, month, and year by using the `ROLLUP`:

```sql
SELECT
    EXTRACT (YEAR FROM rental_date) y,
    EXTRACT (MONTH FROM rental_date) M,
    EXTRACT (DAY FROM rental_date) d,
    COUNT (rental_id)
FROM
    rental
GROUP BY
    ROLLUP (
        EXTRACT (YEAR FROM rental_date),
        EXTRACT (MONTH FROM rental_date),
        EXTRACT (DAY FROM rental_date)
    );

```

![image](https://github.com/user-attachments/assets/93dfd659-3f9b-4c18-bf90-cc46dafb72d5)

In this tutorial, you have learned how to use the PostgreSQL `ROLLUP` to generate multiple grouping sets.
