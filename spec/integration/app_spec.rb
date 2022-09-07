# file: spec/integration/application_spec.rb

require "spec_helper"
require "rack/test"
require_relative "../../app"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /" do
    it "returns 200 OK and index page" do
      response = get("/")

      expect(response.status).to eq (200)
      expect(response.body).to include ("<h1>PersimmonBnB</h1>")
    end
  end

  context "GET /spaces" do
    it "returns a list of all spaces" do
      response = get("/spaces")
      expect(response.status).to eq (200)
      expect(response.body).to include ("<h1>Book a Space</h1>")
    end
  end

  context "GET /newspace" do
    it "should redirect to login page if not logged-in" do
      response = get("/login")
      expect(response.status).to eq 200
      expect(response.body).to include ("<h1>PersimmonBnB | Log In</h1>")
    end

    it "returns 'list a space page' when logged in" do
      # post login request
      response = post("/login", email: "makers@hotmail.com", password: "password123")

      # now that user is logged in, should allow user to access new space page.
      response = get("/newspace")
        expect(response.status).to eq 200
        expect(response.body).to include ("<h1>List a new Space:</h1>")
    end
  end

  context "POST /newspace" do
    it "creates a new space" do
      response =
        post(
          "/spaces",
          space_name: "Shed",
          space_description: "A spacious shed.",
          space_price: 1000,
          start_date: "2022-10-01",
          end_date: "2022-10-31",
          user_id: 1
        )
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>Book a Space</h1>"
    end
  end

  context "GET /login" do
    it "should return a log-in page" do
      response = get("/login")
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>PersimmonBnB | Log In</h1>"
    end
  end

  context "POST /login" do
    it "logs user in and displays book a space page" do
      response =
        post("/login", email: "makers@hotmail.com", password: "password123")
      expect(response.status).to eq 302
      expect(response.headers["Location"]).to include("/spaces")
    end

    it "returns login failure page when user password is incorrect" do
      response =
        post("/login", email: "makers@hotmail.com", password: "password777")
      expect(response.status).to eq 200
      expect(response.body).to include("Log-In Unsuccessful!")
    end

    it "returns login failure page when user email not found" do
      response =
        post("/login", email: "roi@outlook.com", password: "password777")
      expect(response.status).to eq 200
      expect(response.body).to include("Log-In Unsuccessful!")
    end
  end

  context "GET /signup" do
    it "GET /signup" do
      response = get("/signup")
      expect(response.status).to eq(200)
    end
  end

  context "POST /signup" do
    it "POST /signup" do
      response = post("/signup")
      expect(response.status).to eq(200)

      response =
        post(
          "/signup",
          name: "Ben Solo",
          email: "bensolo@gmail.com",
          password: "falcon123"
        )

      repo = UserRepository.new
      users = repo.all

      expect(users[-1].name).to eq("Ben Solo")
      expect(users[-1].email).to eq("bensolo@gmail.com")
      expect(users[-1].password).to eq("falcon123")
    end
  end

  # context "Filter" do
  #   it "GET /filter" do
  #     response = get("/filter")
  #     expect(response.status).to eq(200)
  #   end

  #   xit "POST /filter" do
  #     response = post("/filter")
  #     expect(response.status).to eq(200)

  #     response = post(
  #       "/filter",
  #       start_date: "2022-09-05",
  #       end_date: "2022-09-10"
  #     )

  #     repo = ListedSpaceRepository.new
  #     filtered = repo.filter("2022-09-05", "2022-09-10")

  #     expect(filtered[0][0]).to eq "Cottage"
  #     expect(filtered[0][1]).to eq "A lovely, three bedroom cottage."
  #     expect(filtered[0][2]).to eq 100
  #     expect(filtered[0][3]).to eq "2022-09-05"
  #     expect(filtered[0][4]).to eq "2022-09-10"
  #   end
  # end
end