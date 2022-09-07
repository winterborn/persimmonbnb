require_relative "./user.rb"
require_relative "./user_repository.rb"

class UserRepository
  def initialize
    @users = []
  end

  def all
    sql = "SELECT * FROM users;"
    result = DatabaseConnection.exec_params(sql, [])

    result =
      result.map do |res|
        user = User.new
        user.id = res["id"].to_i
        user.name = res["name"]
        user.email = res["email"]
        user.password = res["password"]

        @users << user
      end
    return @users
  end

  def create(user)
    sql = "INSERT INTO users (name, email, password) VALUES ($1, $2, $3);"
    params = [user.name, user.email, user.password]
    result = DatabaseConnection.exec_params(sql, params)
  end

  def find_by_email(email)
    sql = "SELECT id, name, email, password FROM users WHERE email = $1;"
    result_set = DatabaseConnection.exec_params(sql, [email])

    # calls '#all method' to populate global @users array with test users.
    all
    return false unless @users.any? { |user| user.email == email }
    
    user = User.new
    user.id = result_set[0]["id"].to_i
    user.name = result_set[0]["name"]
    user.email = result_set[0]["email"]
    user.password = result_set[0]["password"]

    return user
  end
end
