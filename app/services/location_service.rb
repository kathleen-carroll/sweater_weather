class LocationService
  def self.get_coordinates(location)
    get_json(location)
  end

  private

  def self.conn(location)
    Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV["GOOGLE_API_KEY"]}")
  end

  def self.get_json(location)
    response = conn(location).get
    JSON.parse(response.body, symbolize_names: true)
  end
end
