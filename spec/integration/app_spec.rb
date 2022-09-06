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
    end