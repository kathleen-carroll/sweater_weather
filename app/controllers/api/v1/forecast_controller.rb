class Api::V1::ForecastController < ApplicationController
  def index
    location_info = LocationService.get_coordinates(params[:location])

    weather_info = WeatherService.get_forecast(location_info)
require "pry"; binding.pry

    # require "pry"; binding.pry
    # Time.at(weather_info[:current][:dt])
    # Time.at(weather_info[:current][:dt]).in_time_zone(weather_info[:timezone])
  end
end
