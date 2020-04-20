require 'rails_helper'

RSpec.describe 'Antipode Api' do
  it 'sends an anitpode city with forecast' do

    get '/api/v1/antipode?location=hong+kong'

    expect(response).to be_successful

    antipode = JSON.parse(response.body)

    expect(antipode["data"]['attributes']["forecast"].count).to eq(2)
    expect(antipode["data"]["type"]).to eq('antipode')
    expect(antipode["data"]['attributes']["search_location"]).to eq("Hong Kong")
  end
end
