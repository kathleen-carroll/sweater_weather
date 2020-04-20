class Forecast
  attr_reader :id, :location_name, :current_weather, :hourly_weather, :daily_weather

  def initialize(weather_data, location_data)
    @location_name = location_data.first[:long_name] + ", " + location_data[2][:short_name]
    @current_weather = weather_data[:current]
    @hourly_weather = weather_data[:hourly]
    @daily_weather = weather_data[:daily]
  end
end
