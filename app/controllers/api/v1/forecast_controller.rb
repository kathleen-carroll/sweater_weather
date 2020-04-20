class Api::V1::ForecastController < ApplicationController
  def index
    # require "pry"; binding.pry
    conn = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=Denver+CO&key=AIzaSyC4fZSWD6IDowFSDQl7cEv1T16_NtH_sgk")
    response = conn.get
    location_info = JSON.parse(response.body, symbolize_names: true)

    latitude = location_info[:results].first[:geometry][:location][:lat]
    longitude = location_info[:results].first[:geometry][:location][:lng]

    weather_conn = Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{latitude}&lon=#{longitude}&appid=#{ENV['WEATHER_API_KEY']}&units=imperial")
    weather_response = weather_conn.get
    weather_info = JSON.parse(weather_response.body, symbolize_names: true)
    # require "pry"; binding.pry
    # Time.at(weather_info[:current][:dt])
    # Time.at(weather_info[:current][:dt]).in_time_zone(weather_info[:timezone])
  end
end
