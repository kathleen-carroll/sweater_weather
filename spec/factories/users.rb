FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    password { Faker::Color.color_name }
    api_key {Faker::Alphanumeric.alphanumeric(number: 36)}
  end
end
