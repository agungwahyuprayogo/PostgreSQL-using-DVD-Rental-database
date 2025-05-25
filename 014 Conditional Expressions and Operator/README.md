# PostgreSQL Join Guide

## Table of Contents

- [PostgreSQL CASE](#postgresql-case)
- [PostgreSQL COALESCE](#postgresql-coalesce)
- [PostgreSQL ISNULL](#postgresql-isnull)
- [PostgreSQL NULLIF](#postgresql-nullif)

---

# PostgreSQL CASE

**Summary**: in this tutorial, you will learn how to use the **PostgreSQL CASE** conditional expression to form conditional queries.

The PostgreSQL `CASE` expression is the same as `IF/ELSE` statement in other programming languages. It allows you to add if\-else logic to the query to form a powerful query.

Since `CASE` is an expression, you can use it in any place where you would use an expression such as `SELECT`, `WHERE`, `GROUP BY`, and `HAVING` clauses.

The `CASE` expression has two forms:

- General
- Simple

## General PostgreSQL CASE expression

The following illustrates the general form of the `CASE` statement:

```sql
CASE
      WHEN condition_1  THEN result_1
      WHEN condition_2  THEN result_2
      [WHEN ...]
      [ELSE else_result]
END
```

In this syntax, each condition (`condition_1`, `condition_2`…) is a boolean expression that returns either `true` or `false`.

When a condition evaluates to `false`, the `CASE` expression evaluates the next condition from top to bottom until it finds a condition that evaluates to `true`.

If a condition evaluates to `true`, the `CASE` expression returns the corresponding result that follows the condition.

For example, if the `condition_2` evaluates to `true`, the `CASE` expression returns the `result_2`. Also, it immediately stops evaluating the remaining expressions.

If all conditions are `false`, the `CASE` expression returns the result (`else_result`) that follows the `ELSE` keyword. If you omit the `ELSE` clause, the `CASE` expression returns `NULL`.

### 1\) The general CASE example

Let’s take a look at the `film` table from the `sample database`.

![image](https://github.com/user-attachments/assets/ea9bc760-f0a4-406e-9592-96603ec3f830)

Suppose you want to label the films by their lengths based on the following logic:

- If the length is less than 50 minutes, the film is short.
- If the length is greater than 50 minutes and less than or equal to 120 minutes, the film is medium.
- If the length is greater than 120 minutes, the film is long.

To apply this logic, you can use the `CASE` expression in the `SELECT` statement as follows:

```sql
SELECT
  title,
  length,
  CASE WHEN length > 0
  AND length <= 50 THEN 'Short' WHEN length > 50
  AND length <= 120 THEN 'Medium' WHEN length > 120 THEN 'Long' END duration
FROM
  film
ORDER BY
  title;
```

Output:

| title              | length | duration |
|--------------------|--------|----------|
| Academy Dinosaur   | 86     | Medium   |
| Ace Goldfinger     | 48     | Short    |
| Adaptation Holes   | 50     | Short    |
| Affair Prejudice   | 117    | Medium   |
| African Egg        | 130    | Long     |
| Agent Truman       | 169    | Long     |

Note that we placed a `column alias` `duration` after the `CASE` expression.

### 2) Using CASE with an aggregate function example

Suppose that you want to assign price segments to films with the following logic:

- If the rental rate is 0\.99, the film is economic.
- If the rental rate is 1\.99, the film is mass.
- If the rental rate is 4\.99, the film is premium.

And you want to know the number of films that belong to economy, mass, and premium.

In this case, you can use the `CASE` expression to construct the query as follows:

```sql
SELECT
  SUM (
    CASE WHEN rental_rate = 0.99 THEN 1 ELSE 0 END
  ) AS "Economy",
  SUM (
    CASE WHEN rental_rate = 2.99 THEN 1 ELSE 0 END
  ) AS "Mass",
  SUM (
    CASE WHEN rental_rate = 4.99 THEN 1 ELSE 0 END
  ) AS "Premium"
FROM
  film;

```

The result of the query is as follows:

| Economy | Mass | Premium |
|---------|------|---------|
|  341    |  323 |  336    |

(1 row)


In this example, we used the `CASE` expression to return 1 or 0 if the rental rate falls into each price segment. We applied the `SUM` function to calculate the total of films for each price segment.

## Simple PostgreSQL CASE expression

PostgreSQL provides another form of the `CASE` expression called simple form as follows:

```sql
CASE expression
   WHEN value_1 THEN result_1
   WHEN value_2 THEN result_2
   [WHEN ...]
ELSE
   else_result
END
```

The `CASE` first evaluates the `expression` and compares the result with each value( `value_1`, `value_2`, …) in the `WHEN` clauses sequentially until it finds the match.

Once the result of the `expression` equals a value (value1, value2, etc.) in a `WHEN` clause, the `CASE` returns the corresponding result in the `THEN` clause.

If `CASE` does not find any matches, it returns the `else_result` in that follows the `ELSE`, or `NULL` value if the `ELSE` is not available.

### 1\) Simple PostgreSQL CASE expression example

The following statement uses the `CASE` expression to add the rating description to the output:

```sql
SELECT title,
       rating,
       CASE rating
           WHEN 'G' THEN 'General Audiences'
           WHEN 'PG' THEN 'Parental Guidance Suggested'
           WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
           WHEN 'R' THEN 'Restricted'
           WHEN 'NC-17' THEN 'Adults Only'
       END rating_description
FROM film
ORDER BY title;
```

Output:

| title             | rating | rating_description              |
|-------------------|--------|---------------------------------|
| Academy Dinosaur  | PG     | Parental Guidance Suggested     |
| Ace Goldfinger    | G      | General Audiences               |
| Adaptation Holes  | NC-17  | Adults Only                     |
| Affair Prejudice  | G      | General Audiences               |
| African Egg       | G      | General Audiences               |
| Agent Truman      | PG     | Parental Guidance Suggested     |
| Airplane Sierra   | PG-13  | Parents Strongly Cautioned      |
| ...               |        |                                 |

In this example, we used a simple `CASE` expression to compare the rating from the `film` table with some literal values like G, PG, NC17, PG\-13 and return the corresponding rating description.

### 2\) Using simple PostgreSQL CASE expression with aggregate function example

The following statement uses `CASE` expression with the `SUM` function to calculate the number of films in each rating:

```sql
SELECT
  SUM(CASE rating WHEN 'G' THEN 1 ELSE 0 END) "General Audiences",
  SUM(
    CASE rating WHEN 'PG' THEN 1 ELSE 0 END
  ) "Parental Guidance Suggested",
  SUM(
    CASE rating WHEN 'PG-13' THEN 1 ELSE 0 END
  ) "Parents Strongly Cautioned",
  SUM(CASE rating WHEN 'R' THEN 1 ELSE 0 END) "Restricted",
  SUM(
    CASE rating WHEN 'NC-17' THEN 1 ELSE 0 END
  ) "Adults Only"
FROM
  film;

```

Output:

| General Audiences | Parental Guidance Suggested | Parents Strongly Cautioned | Restricted | Adults Only |
|-------------------|-----------------------------|----------------------------|------------|-------------|
| 178               | 194                         | 223                        | 195        | 210         |

(1 row)


In this tutorial, you have learned how to use the PostgreSQL `CASE` expression to form complex queries.

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

# PostgreSQL COALESCE

**Summary**: in this tutorial, you will learn about the PostgreSQL `COALESCE()` function that returns the first non\-null argument.

## PostgreSQL COALESCE function syntax

The `COALESCE()` function accepts a list of arguments and returns the first non\-null argument.

Here’s the basic syntax of the `COALESCE()` function:

```sql
COALESCE (argument_1, argument_2, …);
```

The `COALESCE()` function accepts multiple arguments and returns the first argument that is not null. If all arguments are null, the `COALESCE()` function will return null.

The `COALESCE()` function evaluates arguments from left to right until it finds the first non\-null argument. All the remaining arguments from the first non\-null argument are not evaluated.

The `COALESCE` function provides the same functionality as `NVL` or `IFNULL` function provided by SQL standard. MySQL has the [IFNULL function](https://www.mysqltutorial.org/mysql-control-flow-functions/mysql-ifnull/) whereas Oracle Database offers the [`NVL`](https://www.oracletutorial.com/oracle-comparison-functions/oracle-nvl/) function.

## PostgreSQL COALESCE() Function examples

Let’s take some examples of using the `COALESCE()` function.

### 1) Basic PostgreSQL COALESCE() function examples

The following example uses the `COALESCE()` function to return the first non\-null argument:

```sql
SELECT COALESCE (1, 2);
```

Since both arguments are non\-null, the function returns the first argument:

| coalesce |
|----------|
| 1        |

(1 row)


The following example uses the `COALESCE()` function to return the first non\-null argument:

```sql
SELECT COALESCE (NULL, 2 , 1);
```

Because the first argument is NULL and the second argument is non\-null, the function returns the second argument:

| coalesce |
|----------|
| 2        |

(1 row)


In practice, you often use the `COLAESCE()` function to substitute a default value for null when querying data from nullable columns.

For example, if you want to display the excerpt from a blog post and the excerpt is not provided, you can use the first 150 characters of the content of the post.

To achieve this, you can use the `COALESCE` function as follows:

```sql
SELECT
  COALESCE (
    excerpt,
    LEFT(content, 150)
  )
FROM
  posts;
```

### 2\) Using the COALESCE() function with table data

First, create a table called `items`:

```sql
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  product VARCHAR (100) NOT NULL,
  price NUMERIC NOT NULL,
  discount NUMERIC
);
```

The `items` table has four columns:

- `id`: the primary key that identifies the item in the `items` table.
- `product`: the product name.
- `price`: the price of the product.
- `discount`: the discount on the product.

Second, insert some rows into the `items` table:

```sql
INSERT INTO items (product, price, discount)
VALUES
  ('A', 1000, 10),
  ('B', 1500, 20),
  ('C', 800, 5),
  ('D', 500, NULL);
```

Third, retrieve the net prices of the products from the `items` table:

```sql
SELECT
  product,
  (price - discount) AS net_price
FROM
  items;
```

Output:

| product | net_price |
|---------|----------|
| A       | 990      |
| B       | 1480     |
| C       | 795      |
| D       | null     |

(4 rows)


The output indicates that the net price of the product `D` is null.

The issue is that the `discount` of the product `D` is null. Therefore, the net price is NULL because it involves NULL in the calculation.

With an assumption that if the discount is null, the net price is zero, you can use the `COALESCE()` function in the query as follows:

```sql
SELECT
  product,
  (
    price - COALESCE(discount, 0)
  ) AS net_price
FROM
  items;
```

Output:

| product | net_price |
|---------|----------|
| A       | 990      |
| B       | 1480     |
| C       | 795      |
| D       | 500      |

(4 rows)


Now the net price of the product `D` is `500` because the query uses zero instead of NULL when calculating the net price.

Besides using the `COALESCE()` function, you can use the `CASE` expression to handle the NULL in this example.

For example, the following query uses the `CASE` expression to achieve the same result:

```sql
SELECT
  product,
  (
    price - CASE WHEN discount IS NULL THEN 0 ELSE discount END
  ) AS net_price
FROM
  items;
```

In this query, if the discount is null then use zero (0\) otherwise use the discount value to calculate the net price.

In terms of performance, the `COALESCE()` function and `CASE` expression are the same.

It is recommended to use `COALESCE()` function because it makes the query shorter and easier to read.

## Summary

- Use the `COALESCE()` function to substitute null values in the query.

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

# PostgreSQL ISNULL

SQL Server supports [`ISNULL`](http://www.sqlservertutorial.net/sql-server-system-functions/sql-server-isnull-function/) function that replaces `NULL` with a specified replacement value:

```php
ISNULL(expression, replacement)
```

If the `expression` is NULL, then the `ISNULL` function returns the `replacement`. Otherwise, it returns the result of the `expression`.

PostgreSQL does not have the `ISNULL` function. However, you can use the `COALESCE` function which provides similar functionality.

Note that the `COALESCE` function returns the first non\-null argument, so the following syntax has a similar effect as the `ISNULL` function above:

```sql
COALESCE(expression,replacement)
```

For the `COALESCE` example, check out the [`COALESCE`](postgresql-coalesce) function tutorial.

In addition to `COALESCE` function, you can use the [`CASE`](postgresql-case) expression:

```sql
SELECT
    CASE WHEN expression IS NULL
            THEN replacement
            ELSE expression
    END AS column_alias;
```

Check out the [`CASE`](postgresql-case) expression tutorial for more information.

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

# PostgreSQL NULLIF

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `NULLIF()` function to handle null values.

## Introduction to PostgreSQL NULLIF function

The `NULLIF()` function is one of the most common conditional expressions provided by PostgreSQL.

Here’s the basic syntax of the `NULLIF` function:

```sql
NULLIF(argument_1,argument_2);
```

The `NULLIF` function returns a null value if `argument_1` equals to `argument_2`, otherwise, it returns `argument_1`.

## PostgreSQL NULLIF function examples

Let’s take some examples of using the `NULLIF()` function.

### 1\) Basic PostgreSQL NULLIF examples

The following statements illustrate how to use the `NULLIF()` function:

```sql
SELECT NULLIF (1, 1); -- return NULL
```

Output:

| nullif |
|--------|
| null   |

(1 row)


It returns null because the two arguments are equal.

The following example returns the first argument because the two arguments are not equal:

```sql
SELECT NULLIF (1, 0); -- return 1
```

Output:

| nullif |
|--------|
| 1      |

(1 row)


The following example uses the `NULLIF()` function with two unequal text arguments:

```sql
SELECT NULLIF ('A', 'B');
```

Output:

| nullif |
|--------|
| A      |

(1 row)


### 2\) Using the NULLIF function with table data

First, create a table called `posts`:

```sql
CREATE TABLE posts (
  id serial primary key,
  title VARCHAR (255) NOT NULL,
  excerpt VARCHAR (150),
  body TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP
);
```

Second, insert some sample data into the `posts` table.

```sql
INSERT INTO posts (title, excerpt, body)
VALUES
      ('test post 1','test post excerpt 1','test post body 1'),
      ('test post 2','','test post body 2'),
      ('test post 3', null ,'test post body 3')
RETURNING *;
```

Output:

| id  | title       | excerpt              | body              | created_at                 | updated_at |
|-----|-------------|----------------------|-------------------|----------------------------|------------|
|  1  | test post 1 | test post excerpt 1  | test post body 1  | 2024-02-01 11:28:38.779881 | null       |
|  2  | test post 2 |                      | test post body 2  | 2024-02-01 11:28:38.779881 | null       |
|  3  | test post 3 | null                 | test post body 3  | 2024-02-01 11:28:38.779881 | null       |

(3 rows)


The goal is to retrieve data for displaying them on the post overview page that includes the title and excerpt of each post. To achieve this, you can use the first 40 characters of the post body as the excerpt.

Third, use the `COALESCE function` to handle `NULL` in the `body` column:

```sql
SELECT
  id,
  title,
  COALESCE (
    excerpt,
    LEFT(body, 40)
  )
FROM
  posts;
```

Output:

| id  | title       | coalesce             |
|-----|------------|----------------------|
|  1  | test post 1 | test post excerpt 1  |
|  2  | test post 2 |                      |
|  3  | test post 3 | test post body 3     |

(3 rows)


Unfortunately, there is a mix between null value and ” (empty) in the `excerpt` column. To address this issue, you can use the `NULLIF` function:

```sql
SELECT
  id,
  title,
  COALESCE (
    NULLIF (excerpt, ''),
    LEFT (body, 40)
  )
FROM
  posts;
```

Output:

| id  | title       | coalesce             |
|-----|-------------|----------------------|
|  1  | test post 1 | test post excerpt 1  |
|  2  | test post 2 | test post body 2     |
|  3  | test post 3 | test post body 3     |

(3 rows)


In this statement:

- First, the `NULLIF` function returns a null value if the excerpt is empty or the excerpt otherwise. The result of the `NULLIF` function is used by the `COALESCE` function.
- Second, the `COALESCE` function checks if the first argument, which is provided by the `NULLIF` function, if it is null, then it returns the first 40 characters of the body; otherwise, it returns the excerpt in case the excerpt is not null.

## Using NULLIF() function to prevent division\-by\-zero

Another good example of using the `NULLIF` function is to prevent division\-by\-zero error.

First, create a new table named members:

```sql
CREATE TABLE members (
  id serial PRIMARY KEY,
  first_name VARCHAR (50) NOT NULL,
  last_name VARCHAR (50) NOT NULL,
  gender SMALLINT NOT NULL -- 1: male, 2 female
);
```

Second, insert some rows for testing:

```sql
INSERT INTO members (first_name, last_name, gender)
VALUES
  ('John', 'Doe', 1),
  ('David', 'Dave', 1),
  ('Bush', 'Lily', 2)
RETURNING *;
```

Output:

| id  | first_name | last_name | gender |
|-----|------------|-----------|--------|
|  1  | John       | Doe       | 1      |
|  2  | David      | Dave      | 1      |
|  3  | Bush       | Lily      | 2      |

(3 rows)


Third, calculate the ratio between male and female members:

```sql
SELECT
  (
    SUM (CASE WHEN gender = 1 THEN 1 ELSE 0 END) / SUM (CASE WHEN gender = 2 THEN 1 ELSE 0 END)
  ) * 100 AS "Male/Female ratio"
FROM
  members;
```

In this example, we use the `SUM function` and `CASE` to calculate the total number of male members. Then we divide the total of male members by the total of female members to get the ratio. In this case, it returns 200%:

| Male/Female ratio |
|-------------------|
| 200              |

(1 row)


Fourth, delete a female member:

```sql
DELETE FROM members
WHERE gender = 2;
```

And execute the query to calculate the male/female ratio again:

```sql
SELECT
  (
    SUM (CASE WHEN gender = 1 THEN 1 ELSE 0 END) / SUM (CASE WHEN gender = 2 THEN 1 ELSE 0 END)
  ) * 100 AS "Male/Female ratio"
FROM
  members;
```

We got the following error message:

```
ERROR:  division by zero
```

The reason is that the number of females is zero now. To prevent this division by zero error, you can use the `NULLIF` function as follows:

```sql
SELECT
  (
    SUM (CASE WHEN gender = 1 THEN 1 ELSE 0 END) / NULLIF (
      SUM (CASE WHEN gender = 2 THEN 1 ELSE 0 END),
      0
    )
  ) * 100 AS "Male/Female ratio"
FROM
  members;
```

Output:

| Male/Female ratio |
|-------------------|
| null             |

(1 row)


The `NULLIF` function checks if the number of female members is zero, it returns null. The total of male members is divided by `NULL` will return `NULL` .

## Summary

- Use the `NULLIF()` function to substitute NULL for displaying data and to prevent division by zero.
