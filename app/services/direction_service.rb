class DirectionService
  def self.get_directions(location_info)
    duration = get_duration(location_info)
    Direction.new(location_info, duration)
  end

  private

  def self.conn(params)
    Faraday.new("https://maps.googleapis.com/maps/api/directions/json?origin=#{params[:origin]}&destination=#{params[:destination]}&key=#{ENV['GOOGLE_API_KEY']}")
  end

  def self.get_duration(params)
    raw_directions = JSON.parse(conn(params).get.body, symbolize_names: true)
    raw_directions[:routes].first[:legs].first[:duration][:text]
  end
end
