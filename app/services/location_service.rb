class LocationService
  def self.get_coordinates(location)
    get_address_json(location)
  end

  def self.reverse_geocode(coordinates)
    json = get_latlong_json(coordinates[:lat], coordinates[:long])

    json[:results].first[:address_components][2][:long_name] + ", " + json[:results].first[:address_components][3][:long_name]
  end

  private

  def self.conn
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
end
