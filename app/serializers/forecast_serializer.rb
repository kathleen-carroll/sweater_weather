class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :location_name, :current_weather, :hourly_weather, :daily_weather
end
