class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :destination, :origin, :travel_time, :arrival_forecast
end
