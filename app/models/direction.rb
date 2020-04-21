class Direction
  attr_reader :id, :origin, :destination, :travel_time, :arrival_forecast

  def initialize(location_info, duration)
    @origin = location_info[:origin]
    @destination = location_info[:destination]
    @travel_time = duration
    @arrival_forecast = get_future_forecast
  end

  def get_future_forecast
    forecast = WeatherService.get_forecast(@destination)

    forecast.hourly_weather.find do |hour|
      arrival_time.strftime('%H:%M').to_i == hour[:dt].strftime('%H:%M').to_i
    end
  end

  def arrival_time
    if @travel_time.split.count > 2
      hour = @travel_time.split[0].to_i
      min = @travel_time.split[2].to_i
      Time.now + hour.hours + min.minutes
    else
      min = @travel_time.split[0].to_i
      Time.now + min.minutes
    end
  end
end
