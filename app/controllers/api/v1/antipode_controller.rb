class Api::V1::AntipodeController < ApplicationController
  def index

    json = AntipodeService.find_antipode_coords(params[:location])

    lat = json[:data][:attributes][:lat]
    lng = json[:data][:attributes][:long]

    # rev_geo_conn = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{lng}&key=#{ENV['GOOGLE_API_KEY']}")
    #
    # geocode_raw = JSON.parse(rev_geo_conn.get.body, symbolize_names: true)
    geocode_raw = LocationService.reverse_geocode(lat, lng)
    city_name = geocode_raw[:results].first[:address_components][2][:long_name]
    country = geocode_raw[:results].first[:address_components][3][:long_name]

    forecast = WeatherService.get_forecast(city_name + ", " + country, params[:location])

    render json: AntipodeSerializer.new(forecast)
  end
end
