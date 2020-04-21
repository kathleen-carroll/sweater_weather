require 'rails_helper'

RSpec.describe 'Registration Api' do
  it 'sends registered user info' do
    test_info = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
      }

    post '/api/v1/users', params: test_info

    expect(response).to be_successful

    user = JSON.parse(response.body)

    expect(user["data"]['attributes'].count).to eq(2)
    expect(user["data"]["type"]).to eq('users')
    expect(user["data"]['attributes']["email"]).to eq(test_info[:email])
    expect(user["data"]['attributes']["api_key"].length).to eq(32)
  end

  it 'sends registered user info' do
    test_user = create(:user, email: "whatever@example.com")
    test_info = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
      }

    post '/api/v1/users', params: test_info

    expect(response.status).to eq(400)
    expect(response).to_not be_successful

    user = JSON.parse(response.body)

    expect(user.count).to eq(1)
    expect(user["errors"].first).to eq("Email has already been taken")
  end
end
