require 'rails_helper'
# require 'webmock/rspec'

describe AntipodeService do
  context "instance methods" do
    context "#find_antipode_coords" do
      xit "returns coordinates" do

        antipode_fixture = File.read('spec/fixtures/antipode.json')
# require "pry"; binding.pry
        stub_request(:get, "http://amypode.herokuapp.com/api/v1/antipodes?").to_return(status: 200, body: antipode_fixture)
        # stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GOOGLE_API_KEY']}").
        #  with(
        #    headers: {
        #   'Accept'=>'*/*',
        #   'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        #   'User-Agent'=>'Faraday v1.0.1'
        #    }).
        #  to_return(status: 200, body: "", headers: {})

        response = AntipodeService.find_antipode_coords('hong kong')

        expect(response).to be_a Hash
        expect(response.count).to eq 2

        expect(response).to have_key :lat
        expect(response).to have_key :long
      end
    end
  end
end
