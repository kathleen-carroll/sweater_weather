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

    if day_travel
      forecast.hourly_weather.find do |hour|
        (arrival_time.strftime('%H:%M').to_i == hour[:dt].strftime('%H:%M').to_i) && (arrival_time.strftime('%D') == hour[:dt].strftime('%D'))
      end
    else
      forecast.hourly_weather.find do |hour|
        arrival_time.strftime('%H:%M').to_i == hour[:dt].strftime('%H:%M').to_i
      end
    end
  end

  def arrival_time
    if hour_travel
      hour = @travel_time.split[0].to_i
      min = @travel_time.split[2].to_i
      Time.now + hour.hours + min.minutes
    elsif day_travel
      day = @travel_time.split[0].to_i
      hour = @travel_time.split[2].to_i
      Time.now + day.days + hour.hours
    else
      min = @travel_time.split[0].to_i
      Time.now + min.minutes
    end
  end

  def day_travel
    @travel_time.split.count > 2 && (@travel_time.split[1] == "days" || @travel_time.split[1] == "day")
  end

  def hour_travel
    @travel_time.split.count > 2 && (@travel_time.split[1] == "hours" || @travel_time.split[1] == "hour")
  end
end
