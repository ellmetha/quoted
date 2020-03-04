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

  def self.env
    @@env ||= Env.new
  end

  def self.secrets
    @@secrets ||= Secrets.from_yaml(File.open("config/secrets/#{env.id}.yml"))
  end

  def self.settings
    @@settings ||= Settings.from_yaml(
      File.open("config/settings/#{env.id}.yml")
    )
  end

  Kemal.run
end
