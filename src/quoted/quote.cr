module Quoted
  class Quote
    property body : String
    property author : String
    property large_image_url : String
    property medium_image_url : String
    property tag : String

    def self.random
      quote = ApiClient::FavQs.new.qotd

      available_tags = quote["quote"]["tags"]
      chosen_tag = available_tags.size > 0 ? available_tags.as_a.first : DEFAULT_IMAGE_QUERY

      images_cache_key = "images-#{chosen_tag}"
      images = Quoted.cache.get(images_cache_key)
      if images.nil?
        images = ApiClient::Pixabay.new.search(
          q: chosen_tag,
          min_width: IMAGE_MIN_WIDTH,
          min_height: IMAGE_MIN_HEIGHT
        )
        Quoted.cache.set(images_cache_key, images.to_json, 60 * 10)
      else
        images = JSON.parse(images)
      end

      image_hit = images["hits"].as_a.sample(1)[0]

      new(
        body: quote["quote"]["body"].as_s,
        author: quote["quote"]["author"].as_s,
        large_image_url: image_hit["largeImageURL"].as_s,
        medium_image_url: image_hit["webformatURL"].as_s,
        tag: chosen_tag.to_s
      )
    end

    def initialize(@body, @author, @large_image_url, @medium_image_url, @tag)
    end

    private DEFAULT_IMAGE_QUERY = "quote"
    private IMAGE_MIN_WIDTH = 2000
    private IMAGE_MIN_HEIGHT = 1100

    private def self.get_images(tag)
      redis_client.new
    end

    private def self.redis_client
      @@redis_client ||= Redis.new
    end
  end
end
