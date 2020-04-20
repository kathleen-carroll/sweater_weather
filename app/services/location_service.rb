class LocationService
  def self.get_coordinates(location)
    get_address_json(location)
  end

  def self.reverse_geocode(lat, long)
    # require "pry"; binding.pry
    get_latlong_json(lat, long)
  end

  private

  def self.conn
    # Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV["GOOGLE_API_KEY"]}")
    Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?key=#{ENV["GOOGLE_API_KEY"]}")
  end

  def self.get_address_json(location)
    response = conn.get do |params|
      params.params["address"] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_latlong_json(lat, long)
    response = conn.get do |params|
      params.params["latlng"] = "#{lat},#{long}"
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  # rev_geo_conn = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{lng}&key=#{ENV['GOOGLE_API_KEY']}")
  #
  # geocode_raw = JSON.parse(rev_geo_conn.get.body, symbolize_names: true)
end
