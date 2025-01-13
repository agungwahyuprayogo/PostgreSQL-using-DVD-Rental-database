# Panduan PostgreSQL Filtering Data

## Daftar Isi
- [PostgreSQL WHERE](#postgresql-where)
- [PostgreSQL Column Aliases](#postgresql-column-aliases)
- [PostgreSQL ORDER BY](#postgresql-order-by)
- [PostgreSQL SELECT DISTINCT](#postgresql-select-distinct)

# PostgreSQL WHERE

## Introduction to PostgreSQL WHERE clause
The `SELECT` statement returns all rows from one or more columns in a table. To retrieve rows that satisfy a specified condition, you use a `WHERE` clause.

The syntax of the PostgreSQL `WHERE` clause is as follows:

```
SELECT
  select_list
FROM
  table_name
WHERE
  condition
ORDER BY
  sort_expression;
```

In this syntax, you place the `WHERE` clause right after the `FROM` clause of the `SELECT` statement.

The `WHERE` clause uses the `condition` to filter the rows returned from the `SELECT` clause.

The `condition` is a boolean expression that evaluates to true, false, or unknown.

The query returns only rows that satisfy the `condition` in the `WHERE` clause. In other words, the query will include only rows that cause the `condition` to evaluate to true in the result set.

PostgreSQL evaluates the `WHERE` clause after the `FROM` clause but before the `SELECT` and `ORDER BY` clause:

![image](https://github.com/user-attachments/assets/4ece4fb0-f4b4-4bf3-ad90-3908a4cf1ce6)

If you use column aliases in the `SELECT` clause, you cannot use them in the `WHERE` clause.

Besides the `SELECT` statement, you can use the `WHERE` clause in the `UPDATE` and `DELETE` statement to specify rows to update and delete.

To form the condition in the `WHERE` clause, you use comparison and logical operators:

| Operator | Description |
|----------|----------|
| = | Equal |
| > | Greater than |
| < | Less than |
| >= | Greater than or equal |
| <= | Less than or equal |
| <> or != | Not Equal |
| AND | Logical Operator AND |
| OR | Logical Operator OR |
| IN | Return true if a value matches any value in a list |
| BEETWEEN | Return true if a value is between a range of values |
| LIKE | Return true if a value matches a pattern |
| IS NULL | Return true if a value is NULL |
| NOT | Negate the result of other operators |
