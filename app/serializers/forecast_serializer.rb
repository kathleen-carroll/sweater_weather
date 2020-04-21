class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :location_name, :current_weather

  attribute :hourly_weather do |object|
    object.hourly_weather[0..7]
  end

  attribute :daily_weather do |object|
    object.daily_weather[0..5]
  end
end
