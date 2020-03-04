module Quoted
  class Settings
    YAML.mapping(
      redis_database: String,
      public_folder: String,
    )
  end

  def self.settings
    @@settings ||= Settings.from_yaml(
      File.open("config/settings/#{env.id}.yml")
    )
  end
end
