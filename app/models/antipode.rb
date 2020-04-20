class Antipode
  attr_reader :id, :forecast, :search_location

  def initialize(weather_data, location_info, original_search)
    @forecast = Forecast.new(weather_data, location_info)
    @search_location = original_search.titleize
  end
end
