FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    password { Faker::Color.color_name }
  end
end
