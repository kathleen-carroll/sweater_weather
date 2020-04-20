require 'rails_helper'

RSpec.describe 'Forecast Api' do
  it 'sends a list of forecast' do

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    # forecast = JSON.parse(response.body)

    # expect(forecast["data"]['attributes']["current_weather"].count).to eq(9)
  end
end
