class AntipodeService

  def self.find_antipode_coords(search_term)
    # require "pry"; binding.pry
    get_antipode(search_term)[:data][:attributes]

    # lat = json[:data][:attributes][:lat]
    # lng = json[:data][:attributes][:long]
  end

  private

  def self.get_antipode(search_term)
    location_info = LocationService.get_coordinates(search_term)

    latitude = location_info[:results].first[:geometry][:location][:lat]
    longitude = location_info[:results].first[:geometry][:location][:lng]

    get_json(latitude, longitude)
  end

  def self.conn(latitude,longitude)
    Faraday.new(url: "http://amypode.herokuapp.com/api/v1/antipodes?") do |faraday|
      faraday.headers["api_key"] = ENV['AMYPODE_API_KEY']
      faraday.params["lat"] = latitude
      faraday.params["long"] = longitude
    end
  end

  def self.get_json(latitude, longitude)
    JSON.parse(conn(latitude, longitude).get.body, symbolize_names: true)
  end

end
