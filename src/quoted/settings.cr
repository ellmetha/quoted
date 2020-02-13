require "yaml"

module Quoted
  class Settings
    YAML.mapping(
      public_folder: String,
    )
  end

  def self.settings
    @@settings ||= Settings.from_yaml(
      File.open("config/settings/#{ENV["KEMAL_ENV"]? || "development"}.yml")
    )
  end
end
