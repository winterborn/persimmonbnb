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
end
