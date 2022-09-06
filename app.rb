# file: app.rb

require_relative "lib/database_connection"
require "sinatra/base"
require "sinatra/reloader"
require_relative "lib/listed_space_repository"
require_relative "lib/user_repository"

DatabaseConnection.connect("bnb_test")

class Application < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
      also_reload "lib/listed_space_repository"
      also_reload "lib/user_repository"
    end

    enable :sessions

    get "/" do
      return erb(:index)
    end

    get "/spaces" do
      repo = ListedSpaceRepository.new
      @spaces = repo.all
      return erb(:spaces)
    end

    get "/newspace" do
      return erb(:newspace)
    end

    post "/spaces" do
      repo = ListedSpaceRepository.new
      new_space = ListedSpace.new
      new_space.space_name = params[:space_name]
      new_space.space_description = params[:space_description]
      new_space.space_price = params[:space_price]
      new_space.start_date = params[:start_date]
      new_space.end_date = params[:end_date]
  
      new_space = repo.create(new_space)
      @spaces = repo.all
      last_added_space = @spaces.last
      return erb(:spaces)
    end

    get "/login" do
      return erb(:login)
    end

    post "/login" do
      repo = UserRepository.new

      email = params[:email]
      password = params[:password]
      user = repo.find_by_email(email)

      if user == false
        # If user name doesn't exist according to #find_by_email
        return erb(:login_failure)
      elsif user.password == password && user.email == email
        # If user name exists, save user ID to current session
        session[:user_id] = user.id


        # Check this with coaches
        return redirect('/spaces')




      elsif user.password != password && user.email == email
        return erb(:login_failure)
      end
      # else
      #   fail "HELP!"
      # end
    end
end
