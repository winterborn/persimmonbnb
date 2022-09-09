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
      expect(user[0].name).to eq "Brit"
      expect(user[0].email).to eq "makers@hotmail.com"
      expect(user[0].password).to eq "password123"
    end
  end

  it "Creates an account" do
    repo = UserRepository.new
    new_user = User.new

    new_user.name = "Phil"
    new_user.email = "phil@gmail.com"
    new_user.password = "password456"

    repo.create(new_user)
    results = repo.all

    expect(results[2].name).to eq "Phil"
    expect(results[2].email).to eq "phil@gmail.com"
    expect(results[2].password).to eq "password456"
  end

  context "#find_by_email(email) method" do
    it "gets and returns a specific user given email" do
      repo = UserRepository.new
      user = repo.find_by_email("makers@hotmail.com")
      expect(user.id).to eq 1
      expect(user.name).to eq "Brit"
      expect(user.email).to eq "makers@hotmail.com"
      expect(user.password).to eq "password123"

      user = repo.find_by_email("hotstuff@gmail.com")
      expect(user.id).to eq 2
      expect(user.name).to eq "Nas"
      expect(user.email).to eq "hotstuff@gmail.com"
      expect(user.password).to eq "taximan99"
    end

    it "returns false when given email not present in database" do
      repo = UserRepository.new
      user = repo.find_by_email("roi@outlook.com")
      expect(user).to eq false
    end
  end
end
