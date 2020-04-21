class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :destination, :origin, :travel_time

  attribute :arrival_forecast do |object|
    if object.travel_time.split.count > 2
      hour = object.travel_time.split[0].to_i
      min = object.travel_time.split[2].to_i
      arrival_time = Time.now + hour.hours + min.minutes
    else
      min = object.travel_time.split[0].to_i
      arrival_time = Time.now + min.minutes
    end

    forecast = object.forecast.hourly_weather.find do |hour|
      arrival_time.strftime('%H:%M').to_i == hour[:dt].strftime('%H:%M').to_i
    end
  end
end
