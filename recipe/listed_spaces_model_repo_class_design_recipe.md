Listed Spaces User and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table
   If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

2. Create Test SQL seeds
   Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds\_{table_name}.sql)

-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users RESTART IDENTITY;
TRUNCATE TABLE listed_spaces RESTART IDENTITY;

INSERT INTO users (email, username) values ('makers@hotmail.com', 'makers1')
INSERT INTO users (email, username) values ('hotstuff@gmail.com', 'hotstuff')
INSERT INTO listed_spaces (space_name, space_description, space_price, available_dates, booked, user_id) VALUES ('Cottage', 'A lovely, three bedroom cottage.', 100, '2022-09-05', false, 1);
INSERT INTO listed_spaces (space_name, space_description, space_price, available_dates, booked, user_id) VALUES ('Apartment', 'A high-rise apartment in central London.', 200, '2022-09-05', true, 2);
INSERT INTO listed_spaces (space_name, space_description, space_price, available_dates, booked, user_id) VALUES ('House', 'A house in leafy Richmond.', 600, '2022-09-05', false, 1);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your*database_name < seeds*{table_name}.sql
```

3. Define the class names
   Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```ruby
# EXAMPLE
# Table name: listed_spaces

# Model class
# (in lib/listed_space.rb)
class ListedSpace
end

# Repository class
# (in lib/listed_space_repository.rb)
class ListedSpaceRepository
end
```

4. Implement the Model class
   Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: listed_spaces

# Model class
# (in lib/listed_space.rb)
class ListedSpace
  # Replace the attributes by your own columns.
  attr_accessor :id,
                :space_name,
                :space_description,
                :space_price,
                :available_dates,
                :booked
end
```

You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
   Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE

# Table name: listed_spaces
# Repository class

# (in lib/listed_space_repository.rb)
class ListedSpaceRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query: # SELECT id, name, genre FROM artists;
    # Returns an array of Artist objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query: # SELECT id, name, genre FROM artists WHERE id = $2;
    # Returns a single Artist object.
  end

  # Insert a new listed_space record
  # Takes an ListedSpace object in argument
  def create(listed_space)
    # Executes SQL query:
    # INSERT INTO listed_space (space_name, space_description, space_price, available_dates, booked) VALUES ($1, $2, $3, $4, $5);
    # Does not need to return anything as only creates record
  end

  # Updates an artist record
  # Takes an Artist object with updated fields
  def update(artist)
    # Executes SQL query:
    # UPDATE artists SET name = $1, genre = $2 WHERE id = $3;
    # Returns nothing as only updates record
  end

  # Deletes an artist record
  # Given its id
  def delete(id)
    # Executes SQL query:
    # DELETE FROM artists WHERE id = $1;
    # Does not need to return anything as only deletes record
  end
end
```

6. Write Test Examples
   Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all spaces
repo = ListedSpaceRepository.new
spaces = repo.all
spaces.length # => 3

spaces.space_name # => 'Cottage'
spaces.space_description # => 'A lovely, three bedroom cottage.'
spaces.space_price # => '100'
spaces.available_dates # => '2022-09-05'
spaces.booked # => false
spaces.user_id # => 1

# 2
# Get a single artist
repo = ArtistRepository.new
artists = repo.find(1)

artists.name # => 'Blink-182'
artists.genre # => 'Alternative'

# 3
# Get another single artist
repo = ArtistRepository.new
artists = repo.find(2)

artists.name # => 'Toto'
artists.genre # => 'Pop'

# 4
# Create a new listed_space
repo = ListedSpaceRepository.new

new_space = ListedSpace.new
new_space.space_name # => 'Caravan'
new_space.space_description # => 'Near to the beach.'
new_space.space_price # => '50'
new_space.available_dates # => '2022-09-10'
new_space.booked # => false

repo.create(listed_space) # => nil

spaces = repo.all

last_space = spaces.last
new_space.space_name # => 'Caravan'
new_space.space_description # => 'Near to the beach.'
new_space.space_price # => '50'
new_space.available_dates # => '2022-09-10'
new_space.booked # => false

# 5
# Delete an artist
repo = ArtistRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_artists = repo.all
all_artists.length # => 1
all_artists.first.id # => '2'

# 6
# Updates an artist when given an id
repo = ArtistRepository.new

artist = repo.find(1)

artist.name = "Something else"
artist.genre = "New genre"

repo.update(artist)

updated_artist.name.to eq "Something else"
updated_artist.genre.to eq "New genre"
```

Encode this example as a test.

7. Reload the SQL seeds before each test run
   Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
seed_sql = File.read('spec/seeds_students.sql')
connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
connection.exec(seed_sql)
end

describe StudentRepository do
before(:each) do
reset_students_table
end

# (your tests will go here).

end 8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
