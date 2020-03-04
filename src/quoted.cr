require "http/client"
require "json"
require "yaml"

require "kemal"
require "redis"

require "./quoted/*"
require "./quoted/api_client/*"

module Quoted
  def self.cache
    @@cache ||= Cache.new
  end

  Kemal.run
end
