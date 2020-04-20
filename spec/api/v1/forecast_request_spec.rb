require 'rails_helper'

RSpec.describe 'Forecast Api' do
  it 'sends a list of forecast' do

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body)

    expect(forecast["data"]['attributes']["current_weather"].count).to eq(9)
    expect(forecast["data"]['attributes']["hourly_weather"].first.count).to eq(3)
    expect(forecast["data"]['attributes']["hourly_weather"].count).to eq(8)
    expect(forecast["data"]['attributes']["daily_weather"].count).to eq(6)
    expect(forecast["data"]['attributes']["daily_weather"].first.count).to eq(6)
  end
end
