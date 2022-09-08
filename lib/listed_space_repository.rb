require_relative "./listed_space"

class ListedSpaceRepository
  def all
    spaces = []

    sql =
      "SELECT id, space_name, space_description, space_price, start_date, end_date, booked, user_id FROM listed_spaces;"
    result_set = DatabaseConnection.exec_params(sql, [])
    # Result set is an array of hashes.

    # Loop through result_set to create a model object for each record hash.
    result_set.each do |record|
      # Create a new model object with the record data.
      space = ListedSpace.new
      space.id = record["id"].to_i
      space.space_name = record["space_name"]
      space.space_description = (record["space_description"])
      space.space_price = record["space_price"].to_i
      space.start_date = record["start_date"]
      space.end_date = record["end_date"]
      space.booked = record["booked"]
      space.user_id = record["user_id"].to_i

      spaces << space
    end

    return spaces
  end

  def create(listed_space)
    sql =
      "INSERT INTO listed_spaces (space_name, space_description, space_price, start_date, end_date, booked, user_id) VALUES ($1, $2, $3, $4, $5, $6, $7);"
    sql_params = [
      listed_space.space_name,
      listed_space.space_description,
      listed_space.space_price,
      listed_space.start_date,
      listed_space.end_date,
      listed_space.booked,
      listed_space.user_id
    ]
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def find(id)
    sql =
      "SELECT id, space_name, space_description, space_price, start_date, end_date, booked, user_id FROM listed_spaces WHERE id = $1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
    space = ListedSpace.new()
    space.id = record["id"].to_i
    space.space_name = record["space_name"]
    space.space_description = record["space_description"]
    space.space_price = record["space_price"].to_i
    space.start_date = record["start_date"]
    space.end_date = record["end_date"]
    space.booked = record["booked"]
    space.user_id = record["user_id"].to_i
    return space
  end

  def update(listed_spaces)
    sql =
      "UPDATE listed_spaces SET space_name = $1,
                                space_description = $2,
                                space_price = $3,
                                start_date = $4,
                                end_date = $5,
                                booked = $6,
                                user_id = $7"
    sql_params = [
      listed_spaces.space_name,
      listed_spaces.space_description,
      listed_spaces.space_price,
      listed_spaces.start_date,
      listed_spaces.end_date,
      listed_spaces.booked,
      listed_spaces.user_id
    ]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def filter(start_date, end_date)
    spaces = []
    sql =
      "SELECT id, space_name, space_description, space_price, start_date, end_date, booked, user_id 
      FROM listed_spaces 
      WHERE start_date BETWEEN $1 AND $2;"
    sql_params = [start_date, end_date]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    # Loop through result_set to create a model object for each record hash.
    result_set.each do |record|
      # Create a new model object with the record data.
      space = ListedSpace.new
      space.space_name = record["space_name"]
      space.space_description = (record["space_description"])
      space.space_price = record["space_price"].to_i
      space.start_date = record["start_date"]
      space.end_date = record["end_date"]

      spaces << space
    end
    return spaces
  end
end
