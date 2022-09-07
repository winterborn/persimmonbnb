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
    it "should return a new space page" do
      response = get("/newspace")
      expect(response.status).to eq 200
      expect(response.body).to include "<h1>List a new Space:</h1>"
    end
  end

  context "POST /newspace" do
    it "creates a new space" do
      response = post("/spaces",
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
  # Check this with coaches
    it "logs user in and displays book a space page" do
      response = post("/login", email: "makers@hotmail.com", password: "password123")
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

  context "GET /signup - POST /signup" do
    it "GET /signup" do
      response = get("/signup")
      expect(response.status).to eq(200)
    end

    it "POST /signup" do
      response = post("/signup")
      expect(response.status).to eq(200)

      response = post(
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
end
