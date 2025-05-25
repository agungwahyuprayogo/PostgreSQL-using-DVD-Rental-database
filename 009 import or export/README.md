# PostgreSQL Join Guide

## Table of Contents
- [Import CSV File Into PostgreSQL Table](#import-csv-file-into-postgresql-table)

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
