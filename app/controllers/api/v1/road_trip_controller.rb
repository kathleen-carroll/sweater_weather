class Api::V1::RoadTripController < ApplicationController
  def create
    direction_info = DirectionService.get_directions(params)

    if User.find_by(api_key: params[:api_key])
      render json: RoadTripSerializer.new(direction_info)
    else
      render json: {errors: "Unauthorized"}, status: 401
    end
  end
end
