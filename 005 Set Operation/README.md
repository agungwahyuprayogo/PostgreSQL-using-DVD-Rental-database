# PostgreSQL Join Guide
## Table of Contents

- [PostgreSQL UNION](#postgresql-union)
- [PostgreSQL INTERSECT](#postgresql-intersect)
- [PostgreSQL EXCEPT](#postgresql-except)

# PostgreSQL UNION

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `UNION` operator to combine result sets of multiple queries into a single result set.

## Introduction to PostgreSQL UNION operator

The `UNION` operator allows you to combine the result sets of two or more `SELECT` statements into a single result set.

Here’s the basic syntax of the `UNION` operator:

```sql
SELECT select_list
FROM A
UNION
SELECT select_list
FROM B;
```

In this syntax, the queries must conform to the following rules:

- The number and the order of the columns in the select list of both queries must be the same.
- The data types of the columns in select lists of the queries must be compatible.

The `UNION` operator removes all duplicate rows from the combined data set. To retain the duplicate rows, you use the `UNION ALL` instead.

Here’s the syntax of the `UNION ALL` operator:

```sql
SELECT select_list
FROM A
UNION ALL
SELECT select_list
FROM B;
```

The following Venn diagram illustrates how the `UNION` works:

![image](https://github.com/user-attachments/assets/8eea80c3-1bef-45c6-854c-eafc417b6937)

### PostgreSQL UNION with ORDER BY clause

The `UNION` and `UNION ALL` operators may order the rows in the final result set in an unspecified order. For example, it may place rows from the second result set before/after the row from the first result set.

To sort rows in the final result set, you specify the `ORDER BY` clause after the second query:

```sql
SELECT select_list
FROM A
UNION
SELECT select_list
FROM B
ORDER BY sort_expression;
```

Note that if you use the `ORDER BY` clause in the first query, PostgreSQL will issue an error.

## Setting up sample tables

The following statements create two tables `top_rated_films` and `most_popular_films`, and insert data into these tables:

```sql
CREATE TABLE top_rated_films(
  title VARCHAR NOT NULL,
  release_year SMALLINT
);

CREATE TABLE most_popular_films(
  title VARCHAR NOT NULL,
  release_year SMALLINT
);

INSERT INTO top_rated_films(title, release_year)
VALUES
   ('The Shawshank Redemption', 1994),
   ('The Godfather', 1972),
   ('The Dark Knight', 2008),
   ('12 Angry Men', 1957);

INSERT INTO most_popular_films(title, release_year)
VALUES
  ('An American Pickle', 2020),
  ('The Godfather', 1972),
  ('The Dark Knight', 2008),
  ('Greyhound', 2020);
```

The following statement retrieves data from the `top_rated_films` table:

```sql
SELECT * FROM top_rated_films;
```

Output:

| title                     | release_year |
|---------------------------|--------------|
| The Shawshank Redemption  | 1994         |
| The Godfather             | 1972         |
| The Dark Knight           | 2008         |
| 12 Angry Men              | 1957         |

(4 rows)


The following statement retrieves data from the `most_popular_films` table:

```sql
SELECT * FROM most_popular_films;
```

Output:

| title                | release_year |
|----------------------|--------------|
| An American Pickle  | 2020         |
| The Godfather       | 1972         |
| The Dark Knight     | 2008         |
| Greyhound          | 2020         |

(4 rows)


## PostgreSQL UNION examples

Let’s take some examples of using the PostgreSQL `UNION` operator.

### 1) Basic PostgreSQL UNION example

The following statement uses the `UNION` operator to combine data from the queries that retrieve data from the `top_rated_films` and `most_popular_films`:

```sql
SELECT * FROM top_rated_films
UNION
SELECT * FROM most_popular_films;
```

Output:

| title                     | release_year |
|---------------------------|--------------|
| An American Pickle        | 2020         |
| The Dark Knight           | 2008         |
| Greyhound                | 2020         |
| The Shawshank Redemption  | 1994         |
| The Godfather            | 1972         |
| 12 Angry Men             | 1957         |

(6 rows)


The result set includes six rows because the `UNION` operator removes two duplicate rows.

### 2) PostgreSQL UNION ALL example

The following statement uses the `UNION ALL` operator to combine result sets from queries that retrieve data from `top_rated_films` and `most_popular_films` tables:

```sql
SELECT * FROM top_rated_films
UNION ALL
SELECT * FROM most_popular_films;
```

Output:

| title                     | release_year |
|---------------------------|--------------|
| The Shawshank Redemption  | 1994         |
| The Godfather            | 1972         |
| The Dark Knight          | 2008         |
| 12 Angry Men             | 1957         |
| An American Pickle       | 2020         |
| The Godfather            | 1972         |
| The Dark Knight          | 2008         |
| Greyhound                | 2020         |

(8 rows)


The output indicates that the `UNION ALL` operator retains the duplicate rows.

### 3) PostgreSQL UNION ALL with ORDER BY clause example

To sort the result returned by the `UNION` operator, you place the `ORDER BY` clause after the second query:

```sql
SELECT * FROM top_rated_films
UNION ALL
SELECT * FROM most_popular_films
ORDER BY title;
```

Output:

| title                     | release_year |
|---------------------------|--------------|
| 12 Angry Men              | 1957         |
| An American Pickle        | 2020         |
| Greyhound                | 2020         |
| The Dark Knight          | 2008         |
| The Dark Knight          | 2008         |
| The Godfather            | 1972         |
| The Godfather            | 1972         |
| The Shawshank Redemption | 1994         |

(8 rows)


## Summary

- Use the `UNION` to combine result sets of two queries and return distinct rows.
- Use the `UNION ALL` to combine the result sets of two queries but retain the duplicate rows.
- ---
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
# PostgreSQL EXCEPT

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `EXCEPT` operator to return a result set containing the rows in the first query that does not appear in the output of the second query.

## Introduction to the PostgreSQL EXCEPT operator

Like the `UNION` and `INTERSECT` operators, the `EXCEPT` operator returns rows by comparing the result sets of two or more queries.

The `EXCEPT` operator returns distinct rows from the first (left) query that are not in the second (right) query.

The following illustrates the syntax of the `EXCEPT` operator.

```sql
SELECT select_list
FROM A
EXCEPT
SELECT select_list
FROM B;
```

The queries that involve the `EXCEPT` need to follow these rules:

- The number of columns and their orders must be the same in the two queries.
- The data types of the respective columns must be compatible.

The following Venn diagram illustrates the `EXCEPT` operator:

![image](https://github.com/user-attachments/assets/d9016246-3983-484d-89f0-2b6d67f4228f)


If you want to sort the rows in the combined result sets, you need to place the `ORDER BY` clause after the second query:

```sql
SELECT select_list
FROM A
EXCEPT
SELECT select_list
FROM B
ORDER BY sort_expression;
```

## Setting up sample tables

We’ll create the `top_rated_films` and `most_popular_films` tables for demonstration:

```sql
CREATE TABLE top_rated_films(
  title VARCHAR NOT NULL,
  release_year SMALLINT
);

CREATE TABLE most_popular_films(
  title VARCHAR NOT NULL,
  release_year SMALLINT
);

INSERT INTO top_rated_films(title, release_year)
VALUES
   ('The Shawshank Redemption', 1994),
   ('The Godfather', 1972),
   ('The Dark Knight', 2008),
   ('12 Angry Men', 1957);

INSERT INTO most_popular_films(title, release_year)
VALUES
  ('An American Pickle', 2020),
  ('The Godfather', 1972),
  ('The Dark Knight', 2008),
  ('Greyhound', 2020);

SELECT * FROM top_rated_films;
SELECT * FROM most_popular_films;
```

The contents of the `top_rated_films` table:

| title                     | release_year |
|---------------------------|--------------|
| The Shawshank Redemption  | 1994         |
| The Godfather            | 1972         |
| The Dark Knight          | 2008         |
| 12 Angry Men             | 1957         |

(4 rows)


The contents of the `most_popular_films` table:

| title                | release_year |
|----------------------|--------------|
| An American Pickle  | 2020         |
| The Godfather       | 1972         |
| The Dark Knight     | 2008         |
| Greyhound          | 2020         |

(4 rows)


## PostgreSQL EXCEPT operator examples

Let’s take some examples of using the `EXCEPT` operator

### 1) Basic EXCEPT operator example

The following statement uses the `EXCEPT` operator to find the top\-rated films that are not popular:

```sql
SELECT * FROM top_rated_films
EXCEPT
SELECT * FROM most_popular_films;
```

Output:

| title                     | release_year |
|---------------------------|--------------|
| The Shawshank Redemption  | 1994         |
| 12 Angry Men              | 1957         |

(2 rows)


### 2) Using the EXCEPT operator with the ORDER BY clause

The following statement uses the `ORDER BY` clause in the query to sort the result set returned by the `EXCEPT` operator by titles:

```sql
SELECT * FROM top_rated_films
EXCEPT
SELECT * FROM most_popular_films
ORDER BY title;
```

Output:

| title                     | release_year |
|---------------------------|--------------|
| 12 Angry Men              | 1957         |
| The Shawshank Redemption  | 1994         |

(2 rows)


Notice that we placed the `ORDER BY` clause after the second query to sort the films by titles.

## Summary

- Use the PostgreSQL `EXCEPT` operator to combine rows from two result sets and return a result set containing rows from the first result set that do not appear in the second result set.

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
# PostgreSQL INTERSECT 

**Summary**: in this tutorial, you will learn how to use the PostgreSQL `INTERSECT` operator to combine result sets of two or more queries.

## Introduction to PostgreSQL INTERSECT operator

Like the `UNION` and `EXCEPT` operators, the PostgreSQL `INTERSECT` operator combines result sets of two `SELECT` statements into a single result set. The `INTERSECT` operator returns a result set containing rows available in both results sets.

Here is the basic syntax of the `INTERSECT` operator:

```sql
SELECT select_list
FROM A
INTERSECT
SELECT select_list
FROM B;
```

To use the `INTERSECT` operator, the columns that appear in the `SELECT` statements must follow these rules:

- The number of columns and their order in queries must be the same.
- The data types of the columns in the queries must be compatible.

The following diagram illustrates how the `INTERSECT` operator combines the result sets A and B. The final result set is represented by the yellow area where circle A intersects circle B.

![image](https://github.com/user-attachments/assets/4418e5b4-856e-4338-97d2-94539f69f166)

### PostgreSQL INTERSECT with ORDER BY clause

If you want to sort the result set returned by the `INTERSECT` operator, you place the `ORDER BY` after the final query:

```sql
SELECT select_list
FROM A
INTERSECT
SELECT select_list
FROM B
ORDER BY sort_expression;
```

## Setting up sample tables

We’ll create two tables `top_rated_films` and `most_popular_films` for demonstration:

```sql
CREATE TABLE top_rated_films(
  title VARCHAR NOT NULL,
  release_year SMALLINT
);

CREATE TABLE most_popular_films(
  title VARCHAR NOT NULL,
  release_year SMALLINT
);

INSERT INTO top_rated_films(title, release_year)
VALUES
   ('The Shawshank Redemption', 1994),
   ('The Godfather', 1972),
   ('The Dark Knight', 2008),
   ('12 Angry Men', 1957);

INSERT INTO most_popular_films(title, release_year)
VALUES
  ('An American Pickle', 2020),
  ('The Godfather', 1972),
  ('The Dark Knight', 2008),
  ('Greyhound', 2020);

SELECT * FROM top_rated_films;
SELECT * FROM most_popular_films;
```

The contents of the `top_rated_films` table:

| title                     | release_year |
|---------------------------|--------------|
| The Shawshank Redemption  | 1994         |
| The Godfather            | 1972         |
| The Dark Knight          | 2008         |
| 12 Angry Men             | 1957         |

(4 rows)


The contents of the `most_popular_films` table:

| title                | release_year |
|----------------------|--------------|
| An American Pickle  | 2020         |
| The Godfather       | 1972         |
| The Dark Knight     | 2008         |
| Greyhound          | 2020         |

(4 rows)


## PostgreSQL INTERSECT operator examples

Let’s explore some examples of using the `INTERSECT` operator.

### 1) Basic INTERSECT operator example

The following example uses the `INTERSECT` operator to retrieve the popular films that are also top-rated:

```sql
SELECT *
FROM most_popular_films
INTERSECT
SELECT *
FROM top_rated_films;
```

Output:

| title          | release_year |
|---------------|--------------|
| The Godfather | 1972         |
| The Dark Knight | 2008       |

(2 rows)


The result set returns one film that appears on both tables.

### 2) Using the INTERSECT operator with ORDER BY clause example

The following statement uses the `INTERSECT` operator to find the most popular films which are also the top-rated films and sort the films by release year:

```sql
SELECT *
FROM most_popular_films
INTERSECT
SELECT *
FROM top_rated_films
ORDER BY release_year;
```

Output:

| title          | release_year |
|---------------|--------------|
| The Godfather | 1972         |
| The Dark Knight | 2008       |

(2 rows)


## Summary

- Use the PostgreSQL `INTERSECT` operator to combine two result sets and return a single result set containing rows appearing in both.
- Place the `ORDER BY` clause after the second query to sort the rows in the result set returned by the `INTERSECT` operator.
