class Api::V1::AntipodeController < ApplicationController
  def index
    coordinates = AntipodeService.find_antipode_coords(params[:location])

    geocoded_location = LocationService.reverse_geocode(coordinates)

    forecast = WeatherService.get_forecast(geocoded_location, params[:location])

    render json: AntipodeSerializer.new(forecast)
  end
end
