class Api::V1::BackgroundsController < ApplicationController
  def index

    image = ImageService.get_background_image(params[:location])

    render json: BackgroundsSerializer.new(image)
  end
end
