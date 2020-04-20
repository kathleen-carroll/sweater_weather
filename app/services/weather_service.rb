class WeatherService
  def self.get_forecast(location_info, search_term = nil)
    location = LocationService.get_coordinates(location_info)
    raw_data = get_json(location)

    if search_term.nil?
      get_forecast_object(raw_data, location)
    else
      get_antipode_object(raw_data, location, search_term)
    end
  end

  # def self.get_antipode(location_info, search_term)
  #   require "pry"; binding.pry
  #   location = LocationService.get_coordinates(location_info)
  # end

  private

  def self.conn(location_info)
    latitude = location_info[:results].first[:geometry][:location][:lat]
    longitude = location_info[:results].first[:geometry][:location][:lng]

    Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{latitude}&lon=#{longitude}&appid=#{ENV['WEATHER_API_KEY']}&units=imperial")
  end

  def self.get_json(location_info)
    response = conn(location_info).get
    raw_data = JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_forecast_object(raw_data, location_info)
    # response = conn(location_info).get
    # raw_data = JSON.parse(response.body, symbolize_names: true)

    Forecast.new(raw_data, location_info[:results].first[:address_components])
  end

  def self.get_antipode_object(raw_data, location_info, search_term)
    # response = conn(location_info).get
    # raw_data = JSON.parse(response.body, symbolize_names: true)

    # require "pry"; binding.pry
    Antipode.new(raw_data, location_info[:results].first[:address_components], search_term)
  end
end
