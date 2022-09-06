require "listed_space"
require "listed_space_repository"

def reset_listed_space_table
  seed_sql = File.read("spec/test_seeds/seeds_spaces.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "bnb_test" })
  connection.exec(seed_sql)
end

RSpec.describe ListedSpaceRepository do
  before(:each) { reset_listed_space_table }

  context "#all method" do
    it "gets all listed_spaces" do
      repo = ListedSpaceRepository.new
      spaces = repo.all

      expect(spaces.length).to eq 3
      expect(spaces.first.space_name).to eq "Cottage"
      expect(
        spaces.first.space_description
      ).to eq "A lovely, three bedroom cottage."
      expect(spaces.first.space_price).to eq 100
      expect(spaces.first.start_date).to eq "2022-09-05"
      expect(spaces.first.end_date).to eq "2022-09-10"
      expect(spaces.first.booked).to eq "f"
      expect(spaces.first.user_id).to eq 1
    end
  end

  context "#create method" do
    it "creates a new listed_space" do
      repo = ListedSpaceRepository.new
      new_space = ListedSpace.new

      new_space.space_name = "Caravan"
      new_space.space_description = "Near to the beach."
      new_space.space_price = 50
      new_space.start_date = "2022-09-10"
      new_space.end_date = "2022-09-26"
      new_space.booked = "f"
      new_space.user_id = 1

      repo.create(new_space) # => nil

      all_spaces = repo.all
      expect(all_spaces).to include (
                have_attributes(
                  space_name: new_space.space_name = "Caravan",
                  space_description:
                    new_space.space_description = "Near to the beach.",
                  space_price: new_space.space_price = 50,
                  start_date: new_space.start_date = "2022-09-10",
                  end_date: new_space.end_date = "2022-09-26",
                  booked: new_space.booked = "f",
                  user_id: new_space.user_id = 1
                )
              )
    end
  end
end
