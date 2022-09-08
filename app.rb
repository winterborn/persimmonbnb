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

  get "/newspace" do
    users_repo = UserRepository.new
    # If any user in users.all id == current session id, return newspace.erb
    if users_repo.all.any? { |user| user.id == session[:user_id].to_i }
      return erb(:newspace)
    else
      return erb(:login)
    end
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
      # If user doesn't exist according to #find_by_email
      return erb(:login_failure)
    elsif user.password == password && user.email == email
      # If user exists, save user.id to current session, save user.name to current session
      session[:user_id] = user.id
      session[:user_name] = user.name
      return redirect("/spaces")
    elsif user.password != password && user.email == email
      return erb(:login_failure)
    end
  end

  get "/signup" do
    return erb(:signup)
  end

  post "/signup" do
    repo = UserRepository.new
    new_user = User.new
    new_user.name = params[:name]
    new_user.email = params[:email]
    new_user.password = params[:password]
    repo.create(new_user)

    users = repo.all
    @last_added_user = users.last
    return erb(:confirmation)
  end
end
