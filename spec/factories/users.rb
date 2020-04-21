FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    password { Faker::Color.color_name }
    api_key {Faker::Alphanumeric.alphanumeric(number: 32)}
  end
end
