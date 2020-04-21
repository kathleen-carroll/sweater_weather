class Api::V1::RoadTripController < ApplicationController
  def create
    direction_info = DirectionService.get_directions(params)
    # require "pry"; binding.pry
    # # Time.now + 1.hours + 48.minutes
    render json: RoadTripSerializer.new(direction_info)
  end
end
