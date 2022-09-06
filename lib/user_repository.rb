require_relative "./user.rb"

class UserRepository
  def all
    sql = "SELECT * FROM users;"
    result = DatabaseConnection.exec_params(sql, [])

    users = []

    result =
      result.map do |res|
        user = User.new
        user.id = res["id"].to_i
        user.name = res["name"]
        user.email = res["email"]
        user.password = res["password"]

        users << user
      end
    return users
  end

  def create(user)
    sql = "INSERT INTO users (name, email, password) VALUES ($1, $2, $3);"
    params = [user.name, user.email, user.password]
    result = DatabaseConnection.exec_params(sql, params)
  end
end
