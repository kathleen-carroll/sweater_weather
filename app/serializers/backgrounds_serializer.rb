class BackgroundsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :search, :url
end
