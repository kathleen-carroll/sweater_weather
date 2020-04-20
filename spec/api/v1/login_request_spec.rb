require 'rails_helper'

RSpec.describe 'Login Api' do
  it 'sends logged in user info' do
    user = create(:user, email: "whatever@example.com", password: "password")
    test_info = {
      "email": "whatever@example.com",
      "password": "password",
      }

    post '/api/v1/sessions', params: test_info

    expect(response).to be_successful

    user = JSON.parse(response.body)

    expect(user["data"]['attributes'].count).to eq(2)
    expect(user["data"]["type"]).to eq('users')
    expect(user["data"]['attributes']["email"]).to eq(test_info[:email])
  end

  it 'sends registered user info' do
    test_user = create(:user, email: "whatever2@example.com")
    test_info = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
      }

    post '/api/v1/sessions', params: test_info

    expect(response.status).to eq(400)
    expect(response).to_not be_successful

    user = JSON.parse(response.body)

    expect(user.count).to eq(1)
    expect(user["errors"].first).to eq("Email has already been taken")
  end
end
