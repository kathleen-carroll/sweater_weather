class Image
  attr_reader :url, :search, :id

  def initialize(image_json, search_term)
    @url = image_json["results"].first["urls"]["raw"]
    @search = search_term
  end
end
