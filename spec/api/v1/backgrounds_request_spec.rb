require 'rails_helper'

RSpec.describe 'Background Api' do
  it 'sends a background with image url' do

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    background = JSON.parse(response.body)

    expect(background["data"]['attributes']["search"]).to eq("denver,co")
    expect(background["data"]['attributes'].count).to eq(2)
    expect(background["data"]['attributes']["search"]).to_not eq(nil)
  end
end
