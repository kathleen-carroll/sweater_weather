class Forecast
  attr_reader :id, :location_name, :current_weather, :hourly_weather, :daily_weather

  def initialize(weather_data, location_data)
    @location_name = location_data.first[:long_name] + ", " + location_data[2][:short_name]
    @current_weather = get_current_weather(weather_data[:current])
    @hourly_weather = get_hourly_weather(weather_data[:hourly])
    @daily_weather = get_daily_weather(weather_data[:daily])
  end

  def get_current_weather(raw_data)
    {dt: Time.at(raw_data[:dt]),
     sunrise: Time.at(raw_data[:sunrise]),
     sunset: Time.at(raw_data[:sunset]),
     temp: raw_data[:temp],
     feels_like: raw_data[:feels_like],
     humidity: raw_data[:humidity],
     visibility: raw_data[:visibility],
     uvi: raw_data[:uvi],
     description: raw_data[:weather].first[:description]}
  end

  def get_hourly_weather(raw_data)
    raw_data.map do |raw_hour|
      {dt: Time.at(raw_hour[:dt]),
       temp: raw_hour[:temp],
       description: raw_hour[:weather].first[:description]}
    end
  end

  def get_daily_weather(raw_data)
    raw_data.map do |raw_day|
      {dt: Time.at(raw_day[:dt]),
       high_temp: raw_day[:temp][:max],
       low_temp: raw_day[:temp][:min],
       snow: raw_day[:snow],
       rain: raw_day[:rain],
       description: raw_day[:weather].first[:description]}
    end
  end
end
