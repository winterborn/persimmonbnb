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

      expect(spaces.length).to eq 20
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

  context "#find method" do
    it "finds entry 1" do
      repo = ListedSpaceRepository.new
      listing = repo.find(1)
      expect(listing.id).to eq 1
      expect(listing.space_name).to eq "Cottage"
      expect(listing.space_description).to eq "A lovely, three bedroom cottage."
      expect(listing.space_price).to eq 100
      expect(listing.start_date).to eq "2022-09-05"
      expect(listing.end_date).to eq "2022-09-10"
      expect(listing.booked).to eq "f"
    end

    it "finds entry 3" do
      repo = ListedSpaceRepository.new
      listing = repo.find(3)
      expect(listing.id).to eq 3
      expect(listing.space_name).to eq "House"
      expect(listing.space_description).to eq "A house in leafy Richmond."
      expect(listing.space_price).to eq 600
      expect(listing.start_date).to eq "2022-09-12"
      expect(listing.end_date).to eq "2022-09-30"
      expect(listing.booked).to eq "f"
    end
  end

  context "#update method" do
    it "updates a listing given a id with new values" do
      repo = ListedSpaceRepository.new
      # find first listing, sets space_name to "Electric"
      changed_listing = repo.find(1)
      changed_listing.space_name = "Electric"

      repo.update(changed_listing)

      # find updated listing
      updated_listing = repo.find(1)

      expect(updated_listing.space_name).to eq "Electric"
      expect(
        updated_listing.space_description
      ).to eq "A lovely, three bedroom cottage."
    end
  end

  context "#filter method" do
    it "filters available listings based on available dates" do
      repo = ListedSpaceRepository.new

      filtered = repo.filter("2022-09-05", "2022-09-10")

      # expect(filtered[0].id).to eq 1
      expect(filtered[0].space_name).to eq "Cottage"
      expect(
        filtered[0].space_description
      ).to eq "A lovely, three bedroom cottage."
      expect(filtered[0].space_price).to eq 100
      expect(filtered[0].start_date).to eq "2022-09-05"
      expect(filtered[0].end_date).to eq "2022-09-10"
      # expect(filtered[0][6]).to eq "f"
    end
  end
end
