require "user"
require "user_repository"

def reset_users_table
  seed_sql = File.read("spec/test_seeds/seeds_users.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "bnb_test" })
  connection.exec(seed_sql)
end

RSpec.describe UserRepository do
  before(:each) { reset_users_table }

  describe "#all" do
    it "returns an array of all user details" do
      repo = UserRepository.new

      user = repo.all
      expect(user[0].email).to eq "makers@hotmail.com"
      expect(user[0].username).to eq "makers1"
    end
  end

  it "Creates an account" do
    repo = UserRepository.new
    new_user = User.new

    new_user.email = "makers2@hotmail.com"
    new_user.username = "Toby814"

    repo.create(new_user)
    results = repo.all

    expect(results[1].email).to eq "makers2@hotmail.com"
    expect(results[1].username).to eq "Toby814"
  end
end
