require 'rails_helper'

RSpec.describe 'Road Trip Api' do
  it 'sends direction info' do
    user = create(:user)
    test_info = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": user.api_key
      }

    post '/api/v1/road_trip', params: test_info

    expect(response).to be_successful

    directions = JSON.parse(response.body)

    expect(directions["data"]['attributes'].count).to eq(4)
    expect(directions["data"]["type"]).to eq('road_trip')
    expect(directions["data"]['attributes']["origin"]).to eq(test_info[:origin])
    expect(directions["data"]['attributes']["arrival_forecast"]).to_not eq(nil)
  end

  it 'sends direction info for short trip' do
    user = create(:user)
    test_info = {
      "origin": "Denver,CO",
      "destination": "Boulder,CO",
      "api_key": user.api_key
      }

    post '/api/v1/road_trip', params: test_info

    expect(response).to be_successful

    directions = JSON.parse(response.body)

    expect(directions["data"]['attributes'].count).to eq(4)
    expect(directions["data"]["type"]).to eq('road_trip')
    expect(directions["data"]['attributes']["origin"]).to eq(test_info[:origin])
    expect(directions["data"]['attributes']["arrival_forecast"]).to_not eq(nil)
  end

  it 'sends direction info for long trip' do
    user = create(:user)
    test_info = {
      "origin": "Denver,CO",
      "destination": "New Orleans, LA",
      "api_key": user.api_key
      }

    post '/api/v1/road_trip', params: test_info

    expect(response).to be_successful

    directions = JSON.parse(response.body)

    expect(directions["data"]['attributes'].count).to eq(4)
    expect(directions["data"]["type"]).to eq('road_trip')
    expect(directions["data"]['attributes']["origin"]).to eq(test_info[:origin])
    expect(directions["data"]['attributes']["arrival_forecast"]).to_not eq(nil)
  end

  it 'sends direction info for longer trip' do
    user = create(:user)
    test_info = {
      "origin": "Denver,CO",
      "destination": "New York City, NY",
      "api_key": user.api_key
      }

    post '/api/v1/road_trip', params: test_info

    expect(response).to be_successful

    directions = JSON.parse(response.body)
# require "pry"; binding.pry
    expect(directions["data"]['attributes'].count).to eq(4)
    expect(directions["data"]["type"]).to eq('road_trip')
    expect(directions["data"]['attributes']["origin"]).to eq(test_info[:origin])
    expect(directions["data"]['attributes']["arrival_forecast"]).to_not eq(nil)
  end

  it 'sends direction info for invalid trip' do
    user = create(:user)
    test_info = {
      "origin": "Denver,CO",
      "destination": "",
      "api_key": user.api_key
      }

    post '/api/v1/road_trip', params: test_info

    expect(response).to_not be_successful

    directions = JSON.parse(response.body)

    expect(directions.count).to eq(1)
    expect(directions["errors"]).to eq("Invalid origin or destination")
  end

  it 'sends error if not valid api key' do
    user = create(:user)
    test_info = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": ''
      }

    post '/api/v1/road_trip', params: test_info

    expect(response.status).to eq(401)
    expect(response).to_not be_successful

    directions = JSON.parse(response.body)

    expect(directions.count).to eq(1)
    expect(directions["errors"]).to eq("Unauthorized")
  end

end
