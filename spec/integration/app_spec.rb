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
            expect(response.body).to include ('<h1>PersimmonBnB</h1>')
            end
        end

        context "GET /spaces" do
            it "returns a list of all spaces" do
                response = get("/spaces")

                expect(response.status).to eq (200)
                expect(response.body).to include ('<h1>Book a Space</h1>')
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
            expect(
                response.body
            ).to include "<h1>Book a Space</h1>"

            end
        end
    end