class ImageService
  def self.get_background_image(search_term)
    get_image(search_term)
  end

  private

  def self.conn(search_term)
    Faraday.new(url: "https://api.unsplash.com/search/photos?page=1&query=#{search_term}&client_id=#{ENV['UNSPLASH_API_KEY']}").get

  end

  def self.get_image(search_term)
    photos_raw = JSON.parse(conn(search_term).body, symbolize_name: true)
    Image.new(photos_raw, search_term)
  end
end
