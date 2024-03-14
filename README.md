# PostgreSQL-using-DVD-Rental-database

## What is PostgreSQL

![1_mMq3Bem9r8ASAn1YwcTbEw](https://github.com/agungwahyuprayogo/PostgreSQL-using-DVD-Rental-database/assets/101789879/8186ad0d-6e7a-4269-8f38-a35cdc609666)

PostgreSQL is an advanced, enterprise-class, and open-source relational database system. PostgreSQL supports both SQL (relational) and JSON (non-relational) querying. PostgreSQL is a highly stable database backed by more than 20 years of development by the open-source community. PostgreSQL is used as a primary database for many web applications as well as mobile and analytics applications. PostgreSQL’s community pronounces PostgreSQL as /ˈpoʊstɡrɛs ˌkjuː ˈɛl/.

## PostgreSQL Sample Database
We will use the DVD rental database to demonstrate the features of PostgreSQL. The DVD rental database represents the business processes of a DVD rental store. The DVD rental database has many objects, including:
  * 15 tables
  * 1 trigger
  * 7 views
  * 8 functions
  * 1 domain
  * 13 sequences

### DVD Rental ER Model
![dvd-rental-sample-database-diagram](https://github.com/agungwahyuprayogo/PostgreSQL-using-DVD-Rental-database/assets/101789879/1ff7eabf-3ddf-4b28-a776-1d6228fb38e2)
In the diagram, the asterisk (*), which appears in front of the field, indicates the primary key.

### PostgreSQL Sample Database Tables
There are 15 tables in the DVD Rental database:

 * actor – stores actor data including first name and last name.
 * film – stores film data such as title, release year, length, rating, etc.
 * film_actor – stores the relationships between films and actors.
 * category – stores film’s categories data.
 * film_category- stores the relationships between films and categories.
 * store – contains the store data including manager staff and address.
 * inventory – stores inventory data.
 * rental – stores rental data.
 * payment – stores customer’s payments.
 * staff – stores staff data.
 * customer – stores customer data.
 * address – stores address data for staff and customers
 * city – stores city names.
 * country – stores country names.
