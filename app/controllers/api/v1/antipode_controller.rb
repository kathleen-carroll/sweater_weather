class Api::V1::AntipodeController < ApplicationController
  def index
    require "pry"; binding.pry
    params[:location]

    location_info = LocationService.get_coordinates(params[:location])

    latitude = location_info[:results].first[:geometry][:location][:lat]
    longitude = location_info[:results].first[:geometry][:location][:lng]


    conn = Faraday.new(url: "http://amypode.herokuapp.com/api/v1/antipodes?") do |faraday|
      faraday.headers["api_key"] = ENV['AMYPODE_API_KEY']
      faraday.params["lat"] = latitude
      faraday.params["long"] = longitude
    end

    json = JSON.parse(conn.get.body, symbolize_names: true)
    lat = json[:data][:attributes][:lat]
    lng = json[:data][:attributes][:long]

    rev_geo_conn = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{lng}&key=#{ENV['GOOGLE_API_KEY']}")

    geocode_raw = JSON.parse(rev_geo_conn.get.body, symbolize_names: true)
    city_name = geocode_raw[:results].first[:address_components][2][:long_name]
    country = geocode_raw[:results].first[:address_components][3][:long_name]
  end
end
