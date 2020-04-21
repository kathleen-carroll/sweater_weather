class Api::V1::BackgroundsController < ApplicationController
  def index
    # require "pry"; binding.pry
    # get_place_id = Faraday.new(url: "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{params[:location]}&inputtype=textquery&key=#{ENV["GOOGLE_API_KEY"]}").get
    # place_id = JSON.parse(get_place_id.body, symbolize_names: true)[:candidates].first[:place_id]
    # response = Faraday.new(url: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{place_id}&key=#{ENV["GOOGLE_API_KEY"]}").get
    # response.body
# require "pry"; binding.pry

    image = ImageService.get_background_image(params[:location])

    # photos_raw = Faraday.new(url: "https://api.unsplash.com/search/photos?page=1&query=#{params[:location]}&client_id=#{ENV['UNSPLASH_API_KEY']}").get
    # photos_json= JSON.parse(photos_raw.body, symbolize_name: true)
    # photo_url = photos_json["results"].first["urls"]["raw"]

    render json: BackgroundsSerializer.new(image)
  end
end
