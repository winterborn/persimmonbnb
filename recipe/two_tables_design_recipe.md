# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).


```

As a User;
So that I can be a host and/or a guest
I want to sign up for MakersBnB.

As a User;
So that I can list a new space,
I want to create a new space on MakersBnB.

As a User;
So that I can list multiple spaces,
I want to list all created spaces.

As a User;
So that I can give details to my space,
I want to add a name to my space.

As a User;
So that I can give details to my space,
I want to add a short description to my space.

As a User;
So that I can give details to my space,
I want to add a price per night to my space.

```
Nouns:

Users, username, email, listed_spaces, space_name, space_description, space_price, available_dates, booked
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record       | Properties                                                           |
| ------------ | -------------------------------------------------------------------- |
| users        | username, email                                                      |
| listed_space | space_name , space_description, space_price, available_dates, booked |

1. Name of the first table (always plural): `users`

   Column names: `username`, `email`

2. Name of the second table (always plural): `listed_spaces`

   Column names: `space_name , space_description, space_price, available_dates, booked`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: users
id: SERIAL
username: text
email: text

Table: listed_spaces
id: SERIAL
space_name: text
space_description: text
space_price: int
available_dates: date
booked: boolean

```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one users have many listed_spaces? Yes
2. Can one listed_spaces have many users? No

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```
# EXAMPLE

1. Can one user have many listed_spaces? YES
2. Can one listed_space have many users? NO

-> Therefore,
-> An user HAS MANY listed_spaces
-> An listed_spaces BELONGS TO an user

-> Therefore, the foreign key is on the listed_spaces table.
```

_If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table)._

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text, email text, password text
);

bnb
bnb_test

-- Then the table with the foreign key first.
CREATE TABLE listed_spaces (
  id SERIAL PRIMARY KEY,
  space_name text, space_description text, space_price int,
  start_date date, end_date date, booked boolean,
-- The foreign key name is always {other_table_singular}_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 bnb_test < seeds_users.sql;
```
