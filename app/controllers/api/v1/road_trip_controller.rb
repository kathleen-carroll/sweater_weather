class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])  && params[:origin] != "" && params[:destination] != ""
      direction_info = DirectionService.get_directions(params)
      render json: RoadTripSerializer.new(direction_info)
    elsif params[:origin] == "" || params[:destination] == ""
      render json: {errors: "Invalid origin or destination"}, status: 400
    else
      render json: {errors: "Unauthorized"}, status: 401
    end
  end
end
