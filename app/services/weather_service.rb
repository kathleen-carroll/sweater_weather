class WeatherService
  def self.get_forecast(location_info)
    get_json(location_info)
  end

  private

  def self.conn(location_info)
    latitude = location_info[:results].first[:geometry][:location][:lat]
    longitude = location_info[:results].first[:geometry][:location][:lng]

    Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{latitude}&lon=#{longitude}&appid=#{ENV['WEATHER_API_KEY']}&units=imperial")
  end

  def self.get_json(location_info)
    response = conn(location_info).get
    JSON.parse(response.body, symbolize_names: true)
  end
end
