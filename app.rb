# file: app.rb

require_relative "lib/database_connection"
require "sinatra/base"
require "sinatra/reloader"
require_relative "lib/listed_space_repository"

DatabaseConnection.connect("bnb_test")

class Application < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
      also_reload "lib/listed_space_repository"
    end

    get "/" do
      return erb(:index)
    end

    get "/spaces" do
      repo = ListedSpaceRepository.new
      @spaces = repo.all
      return erb(:spaces)
    end
end