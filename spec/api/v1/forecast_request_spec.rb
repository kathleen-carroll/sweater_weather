require 'rails_helper'

RSpec.describe 'Forecast Api' do
  it 'sends a list of forecast' do
    # num = 3
    # create(:forecast)

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    forecast = JSON.parse(response.body)

    expect(forecast["data"].count).to eq(num)
  end
end
