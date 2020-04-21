class Direction
  attr_reader :id, :origin, :destination, :travel_time, :forecast 

  def initialize(location_info, duration)
    @origin = location_info[:origin]
    @destination = location_info[:destination]
    @travel_time = duration
    @forecast = WeatherService.get_forecast(location_info[:destination])
  end
end
