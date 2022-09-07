# Booking Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

_In this template, we'll use an example table `bookings`_

```
# EXAMPLE

Columns:
id | space_id | space_name | booking_start | booking_end | user_id | user_name | user_email
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE bookings RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO bookings (space_id, space_name, booking_start, booking_end, user_id, user_name, user_email) VALUES (1, "Cottage", "2022-09-06", "2022-09-08", 1, "Brit", "makers@hotmail.com");
INSERT INTO bookings (space_id, space_name, booking_start, booking_end, user_id, user_name, user_email) VALUES (2, "Apartment", "2022-09-10", "2022-09-14", 2, "Nas", "hotstuff@gmail.com");
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: bookings

# Model class
# (in lib/booking.rb)
class Booking
end

# Repository class
# (in lib/booking_repository.rb)
class BookingRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: bookings

# Model class
# (in lib/booking.rb)

class Booking
  attr_accessor :id,
                :space_id,
                :space_name,
                :booking_start,
                :booking_end,
                :user_id,
                :user_name,
                :user_email,

```

_You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed._

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: bookings

# Repository class
# (in lib/booking_repository.rb)

class BookingRepository
  # Selecting all records
  # No arguments
  def all
    # SELECT * FROM bookings;
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM bookings WHERE id = $1;

    # Returns a single booking object.
  end

  def find_by_space(space_id)
    # Executes the SQL query:
    # SELECT * FROM bookings WHERE space_id = $1;

    # Returns any bookings with the matching space_id
  end

  def find_by_user(user_id)
    # Executes the SQL query:
    # SELECT * FROM bookings WHERE user_id = $1;

    # Returns any bookings with the matching user_id
  end

  # Add more methods below for each operation you'd like to implement.

  def create(booking)
  end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all bookings
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/booking_repository_spec.rb

def reset_bookings_table
  seed_sql = File.read("spec/seeds_bookings.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "bookings" })
  connection.exec(seed_sql)
end

describe bookingRepository do
  before(:each) { reset_bookings_table }

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
