# PostgreSQL Join Guide

## Table of Contents
- [Import CSV File Into PostgreSQL Table](#import-csv-file-into-postgresql-table)
- [Export PostgreSQL Table to CSV File](#export-postgresql-table-to-csv-file)

---

# Import CSV File Into PostgreSQL Table

**Summary**: in this tutorial, we will show you various ways to import a CSV file into a PostgreSQL table.

First, `create a new table` named `persons` with the following columns:

- `id`: the person id
- `first_name`: first name
- `last_name:` last name
- `dob` date of birth
- `email`: the email address

```sql
CREATE TABLE persons (
  id SERIAL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  dob DATE,
  email VARCHAR(255),
  PRIMARY KEY (id)
);
```

![image](https://github.com/user-attachments/assets/a284edf7-3e32-4002-89f4-2f1cca63310f)

Second, prepare a CSV data file with the following format:

![image](https://github.com/user-attachments/assets/48deb183-e35d-4a54-a1a2-d9842eb8b6e8)

![image](https://github.com/user-attachments/assets/dcc4f2c8-b435-4fd2-834f-c741b74e934b)

The path of the CSV file is as follows: `C:\sampledb\persons.csv`

[Download the persons.csv file](https://github.com/agungwahyuprayogo/PostgreSQL-using-DVD-Rental-database/blob/main/009%20import%20or%20export/persons.csv)

## Import a CSV file into a table using COPY statement

To import this CSV file into the `persons` table, you use `COPY` statement as follows:

```sql
COPY persons(first_name, last_name, dob, email)
FROM 'C:\sampledb\persons.csv'
DELIMITER ','
CSV HEADER;
```

PostgreSQL gives back the following message:

```
COPY 2
```

It means that two rows have been copied. Let’s check the `persons` table.

```sql
SELECT * FROM persons;
```

![image](https://github.com/user-attachments/assets/d873bb0d-e5c6-4faa-9aaa-5caa2659cf53)

It works as expected.

Let’s dive into the COPY statement in more detail.

First, you specify the table with column names after the `COPY` keyword. The order of the columns must be the same as the ones in the CSV file. In case the CSV file contains all columns of the table, you don’t need to specify them explicitly, for example:

```sql
COPY sample_table_name
FROM 'C:\sampledb\sample_data.csv'
DELIMITER ','
CSV HEADER;
```

Second, you put the CSV file path after the `FROM` keyword. Because CSV file format is used, you need to specify `DELIMITER` as well as `CSV` clauses.

Third, specify the `HEADER` keyword to indicate that the CSV file contains a header. When the `COPY` command imports data, it ignores the header of the file.

Notice that the file must be read directly by the PostgreSQL server, not by the client application. Therefore, it must be accessible by the PostgreSQL server machine. Also, you need to have superuser access to execute the `COPY` statement successfully.

## Import CSV file into a table using pgAdmin

In case you need to import a CSV file from your computer into a table on the PostgreSQL database server, you can use the pgAdmin.

The following statement `truncates the` `persons` table so that you can re-import the data.

```sql
TRUNCATE TABLE persons
RESTART IDENTITY;
```

First, right\-click the `persons` table and select the **Import/Export…** menu item:

![image](https://github.com/user-attachments/assets/926c3b8c-cdb5-4e18-b966-5d83b2f9eabe)

Second, (1\) switch to import, (2\) browse to the import file, (3\) select the format as CSV, (4\) select the delimiter as comma (`,`):

![image](https://github.com/user-attachments/assets/e3279ef5-5b09-4249-998d-b2a22c5cf829)

Third, click the columns tab, uncheck the id column, and click the OK button:

![image](https://github.com/user-attachments/assets/66953ef1-06b3-4d68-9b5a-34ed3dca487a)

Finally, wait for the import process to complete. The following shows the dialog that informs you of the progress of the import:

![image](https://github.com/user-attachments/assets/d2270492-d6fb-404d-a7b9-e9d40c0a28c2)

In this tutorial, you have learned how to import data from a CSV file into a table on the PostgreSQL database server using the `COPY` statement and pgAdmin tool.

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

# Export PostgreSQL Table to CSV File

**Summary**: in this tutorial, you will learn various techniques to export data from PostgreSQL tables to CSV files.

In the previous tutorial, we showed you how to import data from a CSV file into a table. We will use the same `persons` table for importing data from a CSV file.

![image](https://github.com/user-attachments/assets/2efdaf47-1d9c-4f7b-a766-8416ae35d4d9)

The following statement retrieves the data from the `persons` table.

```sql
SELECT * FROM persons;
```

Output:

| id  | first_name | last_name | dob        | email                   |
|-----|------------|-----------|------------|-------------------------|
|  1  | John       | Doe       | 1995-01-05 | john.doe@example.com    |
|  2  | Jane       | Doe       | 1995-02-05 | jane.doe@example.com    |

## Export data from a table to CSV using the COPY statement

The `COPY` statement allows you to export data from a table to a CSV file.

For example, if you want to export the data of the `persons` table to a CSV file named `persons_db.csv` in the `C:\temp` folder, you can use the following statement:

```sql
COPY persons TO 'C:\temp\persons_db.csv' DELIMITER ',' CSV HEADER;
```

Output:

```
COPY 2
```

The output indicates that the command exported two rows.

In this example, the COPY statement exports all data from all columns of the `persons` table to the `persons_db.csv` file.

![image](https://github.com/user-attachments/assets/6251e651-cb2d-4d0e-9736-3f03e75c10d4)

Sometimes, you may want to export data from some columns of a table to a CSV file. To achieve this, you can specify the column names together with the table name after `COPY` keyword.

For example, the following statement exports data from the `first_name`, `last_name`, and `email` columns of the `persons` table to `person_partial_db.csv`

```sql
COPY persons(first_name,last_name,email)
TO 'C:\temp\persons_partial_db.csv' DELIMITER ',' CSV HEADER;
```

![image](https://github.com/user-attachments/assets/33fdc32a-14ac-41a1-9529-c1b5a3cf1e23)

If you don't want to export the header, which contains the column names of the table, you can remove the `HEADER` flag in the `COPY` statement.

For example, the following statement exports only data from the `email` column of the `persons` table to a CSV file:

```sql
COPY persons(email)
TO 'C:\temp\persons_email_db.csv' DELIMITER ',' CSV;
```

![image](https://github.com/user-attachments/assets/499a9a57-1a90-43b7-9506-5fd84853dcae)

Notice that the CSV file name that you specify in the `COPY` command must be written directly by the server.

It means that the CSV file must reside on the database server machine, not your local machine. The CSV file also needs to be writable by the user that the PostgreSQL server runs as.

## Export data from a table to a CSV file using the \\copy command

If you have access to a remote PostgreSQL database server, but you don't have sufficient privileges to write to a file on it, you can use the PostgreSQL built\-in command `\copy`.

The `\copy` command runs the `COPY` statement behind the scenes. However, instead of the server writing the CSV file, psql writes the CSV file and transfers data from the server to your local file system.

To use `\copy` command, you need to have sufficient privileges to your local machine. It does not require PostgreSQL superuser privileges.

For example, if you want to export all data from the `persons` table into `persons_client.csv` file, you can execute the `\copy` command from the psql client as follows:

```sql
\copy (SELECT * FROM persons) to 'C:\temp\persons_client.csv' with csv
```

In this tutorial, we have shown you how to use `COPY` statement and `\copy` command to export data from a table to CSV files.

