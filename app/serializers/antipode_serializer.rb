class AntipodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :search_location

  attribute :forecast do |object|
    {summary: object.forecast.current_weather[:description],
     current_temperature: object.forecast.current_weather[:temp]}
  end

  attribute :location_name do |object|
    object.forecast.location_name
  end

end
