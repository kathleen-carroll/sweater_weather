class AntipodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :location_name

  attribute :forecast do |object|
    {summary: object.current_weather[:description],
     current_temperature: object.current_weather[:temp]}
  end

  attribute :type do |object|
    "antipode"
  end

  attribute :search_location do |object|
    # require "pry"; binding.pry
  end

end
