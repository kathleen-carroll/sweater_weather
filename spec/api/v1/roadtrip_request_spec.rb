require 'rails_helper'

RSpec.describe 'Road Trip Api' do
  it 'sends direction info' do
    test_info = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": ENV['GOOGLE_API_KEY']
      }

    post '/api/v1/road_trip', params: test_info

    expect(response).to be_successful

    directions = JSON.parse(response.body)

    expect(directions["data"]['attributes'].count).to eq(4)
    expect(directions["data"]["type"]).to eq('road_trip')
    expect(directions["data"]['attributes']["origin"]).to eq(test_info[:origin])
    expect(directions["data"]['attributes']["arrival_forecast"]).to_not eq(nil)
  end

  xit 'sends error if not valid api key' do
    test_info = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": ENV['']
      }

    post '/api/v1/road_trip', params: test_info

    expect(response.status).to eq(401)
    expect(response).to_not be_successful

    directions = JSON.parse(response.body)

    expect(directions.count).to eq(1)
    expect(directions["errors"].first).to eq("Unauthorized")
  end

end
