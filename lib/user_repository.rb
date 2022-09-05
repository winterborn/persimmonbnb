require_relative './user.rb'

class UserRepository

    def all
        sql = "SELECT * FROM users;"
        result = DatabaseConnection.exec_params(sql, [])

        users = []

        result = result.map do |res|
            user = User.new
            user.id = res["id"].to_i
            user.email = res["email"]
            user.username = res["username"]

        users << user
    end
        return users
    end    
    
    def create(user)
        sql = 'INSERT INTO users (email, username) VALUES ($1, $2);'
        params = [user.email, user.username]
        result = DatabaseConnection.exec_params(sql, params) 
    end

end